


//com.hbm.socialmodule.rrhandlers.GetUserVariableHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;
    import com.hbm.socialmodule.rrhandlers.abstracts.*;

    public class GetUserVariableHandler extends AbstractRRHandler implements RRHandler 
    {

        public function GetUserVariableHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest(_arg_1:String):void
        {
            MethodName = "getUserVariableRequest";
            var _local_2:Object = {"name":_arg_1};
            _local_2 = AddAuthorisationData(_local_2);
            serverHandler.SendRequest(_local_2, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.getUserVariableResponse;
            if (CheckServerResponseValidity(_local_2))
            {
                cache = _local_2.value;
                dispatchEvent(new ResponseEvent(Event.COMPLETE, cache));
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }


    }
}//package com.hbm.socialmodule.rrhandlers

