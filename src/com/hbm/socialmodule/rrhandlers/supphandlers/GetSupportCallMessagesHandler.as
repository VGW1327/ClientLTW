


//com.hbm.socialmodule.rrhandlers.supphandlers.GetSupportCallMessagesHandler

package com.hbm.socialmodule.rrhandlers.supphandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import flash.utils.ByteArray;
    import com.hbm.socialmodule.connection.crypto.Base64;
    import flash.utils.Endian;
    import com.hbm.socialmodule.support.SupportCallMessage;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class GetSupportCallMessagesHandler extends AbstractRRHandler implements RRHandler 
    {

        public function GetSupportCallMessagesHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest(_arg_1:String):void
        {
            MethodName = "getSupportMessagesRequest";
            var _local_2:Object = {"supportCallId":_arg_1};
            _local_2 = AddAuthorisationData(_local_2);
            serverHandler.SendRequest(_local_2, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:ByteArray;
            var _local_7:ByteArray;
            var _local_2:Array = [];
            var _local_3:Object = _arg_1.getSupportMessagesResponse;
            if (_local_3)
            {
                if (_local_3.result == "ok")
                {
                    _local_4 = _local_3.supportMessage;
                    if ((_local_4 is Array))
                    {
                        for each (_local_5 in _local_4)
                        {
                            _local_6 = Base64.decode(_local_5.messageBase64);
                            _local_6.position = 0;
                            _local_6.endian = Endian.LITTLE_ENDIAN;
                            _local_2.push(new SupportCallMessage(_local_5.messageId, _local_5.date, _local_5.fromLogin, _local_6.readUTFBytes(_local_6.length)));
                        };
                    }
                    else
                    {
                        _local_7 = Base64.decode(_local_4.messageBase64);
                        _local_7.position = 0;
                        _local_7.endian = Endian.LITTLE_ENDIAN;
                        _local_2.push(new SupportCallMessage(_local_4.messageId, _local_4.date, _local_4.fromLogin, _local_7.readUTFBytes(_local_7.length)));
                    };
                    cache = _local_2;
                    dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_2));
                }
                else
                {
                    DisptchError(_local_3.result);
                };
            }
            else
            {
                DisptchError("Unknown header");
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }


    }
}//package com.hbm.socialmodule.rrhandlers.supphandlers

