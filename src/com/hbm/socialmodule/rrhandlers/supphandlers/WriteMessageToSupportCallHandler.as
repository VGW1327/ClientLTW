


//com.hbm.socialmodule.rrhandlers.supphandlers.WriteMessageToSupportCallHandler

package com.hbm.socialmodule.rrhandlers.supphandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    import com.hbm.socialmodule.connection.crypto.Base64;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class WriteMessageToSupportCallHandler extends AbstractRRHandler implements RRHandler 
    {

        public function WriteMessageToSupportCallHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest(_arg_1:String, _arg_2:String):void
        {
            MethodName = "writeSupportCallMessageRequest";
            var _local_3:ByteArray = new ByteArray();
            _local_3.endian = Endian.LITTLE_ENDIAN;
            _local_3.writeUTFBytes(_arg_1);
            var _local_4:String = Base64.encode(_local_3);
            var _local_5:Object = {
                "supportCallId":_arg_2,
                "supportMessage":{"messageBase64":_local_4}
            };
            _local_5 = AddAuthorisationData(_local_5);
            serverHandler.SendRequest(_local_5, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.writeSupportCallMessageResponse;
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
}//package com.hbm.socialmodule.rrhandlers.supphandlers

