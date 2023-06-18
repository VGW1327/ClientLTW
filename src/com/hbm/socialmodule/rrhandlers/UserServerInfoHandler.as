


//com.hbm.socialmodule.rrhandlers.UserServerInfoHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;
    import com.hbm.socialmodule.utils.Utilities;

    public class UserServerInfoHandler extends AbstractRRHandler implements RRHandler 
    {

        public function UserServerInfoHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest():void
        {
            MethodName = "getAccountInfoRequest";
            var _local_1:Object = {
                "needOnlyDisplayName":"false",
                "needAvatar":"false",
                "needChar":"false"
            };
            _local_1 = AddAuthorisationData(_local_1);
            serverHandler.SendRequest(_local_1, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_4:Object;
            var _local_2:Object = _arg_1.getAccountInfoResponse;
            var _local_3:Boolean = CheckServerResponseValidity(_local_2);
            if (_local_3)
            {
                _local_4 = this.ParseAnswer(_local_2);
                cache = _local_4;
                dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_4));
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }

        private function ParseAnswer(_arg_1:Object):Object
        {
            var _local_2:Object = {};
            var _local_3:String = _arg_1.additionalData;
            if (_local_3 != null)
            {
                _local_2 = Utilities.parseServerAdditionalData(_local_3);
                _local_2.displayName = _arg_1.displayName;
                _local_2.tahoeId = _arg_1.id;
            }
            else
            {
                DisptchError("Parsing server user info: data not found.");
            };
            return (_local_2);
        }


    }
}//package com.hbm.socialmodule.rrhandlers

