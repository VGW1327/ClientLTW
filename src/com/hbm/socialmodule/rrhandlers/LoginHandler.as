


//com.hbm.socialmodule.rrhandlers.LoginHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class LoginHandler extends AbstractRRHandler implements RRHandler 
    {

        public function LoginHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest():void
        {
            MethodName = "loginRequest";
            var _local_1:Object = AddAuthorisationData(new Object());
            serverHandler.SendRequest(_local_1, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.loginResponse;
            var _local_3:Boolean = CheckServerResponseValidity(_local_2);
            if (_local_3)
            {
                dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_2.result));
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }


    }
}//package com.hbm.socialmodule.rrhandlers

