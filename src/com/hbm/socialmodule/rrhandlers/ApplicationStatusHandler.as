


//com.hbm.socialmodule.rrhandlers.ApplicationStatusHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class ApplicationStatusHandler extends AbstractRRHandler implements RRHandler 
    {

        public function ApplicationStatusHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest(_arg_1:String):void
        {
            MethodName = "saveVKontakteAppStatusRequest";
            var _local_2:Object = {"status":_arg_1};
            _local_2 = AddAuthorisationData(_local_2);
            serverHandler.SendRequest(_local_2, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.saveVKontakteAppStatusResponse;
            if (_local_2 != null)
            {
                if (_local_2.result == "ok")
                {
                    dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_2.result));
                }
                else
                {
                    DisptchError(_local_2.result);
                };
            }
            else
            {
                DisptchError("Unknown header");
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }


    }
}//package com.hbm.socialmodule.rrhandlers

