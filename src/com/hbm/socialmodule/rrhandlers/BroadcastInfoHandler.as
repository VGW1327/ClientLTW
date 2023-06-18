


//com.hbm.socialmodule.rrhandlers.BroadcastInfoHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import flash.utils.ByteArray;
    import com.hbm.socialmodule.connection.crypto.Base64;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class BroadcastInfoHandler extends AbstractRRHandler implements RRHandler 
    {

        public function BroadcastInfoHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest():void
        {
            MethodName = "getInformationAdvtRequest";
            var _local_1:Object = AddAuthorisationData(new Object());
            serverHandler.SendRequest(_local_1, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_3:String;
            var _local_4:ByteArray;
            var _local_5:String;
            var _local_6:Object;
            var _local_2:Object = _arg_1.getInformationAdvtResponse;
            if (_local_2 != null)
            {
                if (_local_2.result == "ok")
                {
                    _local_3 = _local_2.title;
                    _local_4 = Base64.decode(_local_2.textBase64Encoded);
                    _local_4.position = 0;
                    _local_5 = _local_4.readUTFBytes(_local_4.bytesAvailable);
                    _local_6 = {
                        "title":_local_3,
                        "text":_local_5
                    };
                    cache = _local_6;
                    dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_6));
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

