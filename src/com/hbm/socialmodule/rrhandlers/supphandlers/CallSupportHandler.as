


//com.hbm.socialmodule.rrhandlers.supphandlers.CallSupportHandler

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

    public class CallSupportHandler extends AbstractRRHandler implements RRHandler 
    {

        public function CallSupportHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest(_arg_1:String, _arg_2:String, _arg_3:ByteArray, _arg_4:String):void
        {
            var _local_6:String;
            var _local_8:String;
            var _local_5:ByteArray = new ByteArray();
            _local_5.endian = Endian.LITTLE_ENDIAN;
            _local_5.writeUTFBytes(_arg_2);
            _local_6 = Base64.encode(_local_5);
            MethodName = "createSupportCallRequest";
            var _local_7:Object = {"supportCall":{
                    "theme":_arg_1,
                    "messageBase64":_local_6
                }};
            if (_arg_3 != null)
            {
                _local_8 = Base64.encode(_arg_3);
                _local_7.supportCall.file = {
                    "name":_arg_4,
                    "data":_local_8
                };
            };
            _local_7 = AddAuthorisationData(_local_7);
            serverHandler.SendRequest(_local_7, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.createSupportCallResponse;
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

