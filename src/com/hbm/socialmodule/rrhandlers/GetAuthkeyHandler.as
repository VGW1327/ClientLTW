


//com.hbm.socialmodule.rrhandlers.GetAuthkeyHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class GetAuthkeyHandler extends AbstractRRHandler implements RRHandler 
    {

        public function GetAuthkeyHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest(_arg_1:String):void
        {
            MethodName = "getOKAuthKeyRequest";
            var _local_2:Object = {"session":_arg_1};
            _local_2 = AddAuthorisationData(_local_2);
            serverHandler.SendRequest(_local_2, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.getOKAuthKeyResponse;
            var _local_3:Boolean = CheckServerResponseValidity(_local_2);
            if (_local_3)
            {
                dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_2.authKey));
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }


    }
}//package com.hbm.socialmodule.rrhandlers

