


//com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler

package com.hbm.socialmodule.rrhandlers.abstracts
{
    import flash.events.EventDispatcher;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.socialapi.ExtVarsAdapter;
    import flash.events.ErrorEvent;
    import com.hbm.socialmodule.data.SocialNetworkState;
    import com.hbm.socialmodule.utils.Utilities;

    public class AbstractRRHandler extends EventDispatcher 
    {

        private var _serverHandler:RRLoader;
        private var _apiHandler:NetworkAPIHandler;
        private var _apiVars:ExtVarsAdapter;
        private var _cache:Object;
        private var _method:String;

        public function AbstractRRHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            this._serverHandler = _arg_1;
            this._apiHandler = _arg_2;
            this._apiVars = _arg_2.GetExternalVars();
        }

        protected function get serverHandler():RRLoader
        {
            return (this._serverHandler);
        }

        protected function get apiHandler():NetworkAPIHandler
        {
            return (this._apiHandler);
        }

        protected function get apiVars():ExtVarsAdapter
        {
            return (this._apiVars);
        }

        protected function get cache():Object
        {
            return (this._cache);
        }

        protected function set cache(_arg_1:Object):void
        {
            this._cache = _arg_1;
        }

        protected function DisptchError(_arg_1:String):void
        {
            dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, _arg_1));
        }

        public function get MethodName():String
        {
            return (this._method);
        }

        public function set MethodName(_arg_1:String):void
        {
            this._method = _arg_1;
        }

        protected function AddAuthorisationData(_arg_1:Object):Object
        {
            var _local_2:String = (SocialNetworkState.Instance.ServerIdPrefix + this.apiVars.viewerId);
            _arg_1.loginHash = Utilities.B64Md5(_local_2);
            _arg_1.passHash = this._apiVars.authenticationKey;
            if (this._apiVars.sessionKey)
            {
                _arg_1.session = this._apiVars.sessionKey;
            };
            return (_arg_1);
        }

        protected function CheckServerResponseValidity(_arg_1:Object):Boolean
        {
            if (_arg_1)
            {
                if (_arg_1.result == "ok")
                {
                    return (true);
                };
                this.DisptchError(_arg_1.result);
            }
            else
            {
                this.DisptchError("Unknown header.");
            };
            return (false);
        }

        public function NotifyError(_arg_1:Error):void
        {
            this.DisptchError(_arg_1.message);
        }

        public function get Cache():Object
        {
            return (this.cache);
        }


    }
}//package com.hbm.socialmodule.rrhandlers.abstracts

