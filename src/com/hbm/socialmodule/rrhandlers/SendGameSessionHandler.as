


//com.hbm.socialmodule.rrhandlers.SendGameSessionHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class SendGameSessionHandler extends AbstractRRHandler implements RRHandler 
    {

        public function SendGameSessionHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest(_arg_1:uint, _arg_2:String):void
        {
            MethodName = "saveGameSessionRequest";
            var _local_3:Object = {
                "playingTime":_arg_1,
                "data":_arg_2
            };
            _local_3 = AddAuthorisationData(_local_3);
            serverHandler.SendRequest(_local_3, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.saveGameSessionResponse7;
            if (_local_2)
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
                DisptchError("Unknown header.");
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }


    }
}//package com.hbm.socialmodule.rrhandlers

