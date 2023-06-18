


//com.hbm.socialmodule.rrhandlers.supphandlers.GetSupportCallListHandler

package com.hbm.socialmodule.rrhandlers.supphandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import flash.utils.ByteArray;
    import com.hbm.socialmodule.connection.crypto.Base64;
    import flash.utils.Endian;
    import com.hbm.socialmodule.support.SupportCall;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class GetSupportCallListHandler extends AbstractRRHandler implements RRHandler 
    {

        private var _callsCount:uint;

        public function GetSupportCallListHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest():void
        {
            MethodName = "getSupportCallsRequest";
            var _local_1:Object = AddAuthorisationData(new Object());
            serverHandler.SendRequest(_local_1, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_4:Object;
            var _local_5:ByteArray;
            var _local_6:Object;
            var _local_2:Array = [];
            var _local_3:Object = _arg_1.getSupportCallsResponse;
            if (_local_3)
            {
                if (_local_3.result == "ok")
                {
                    this._callsCount = _local_3.totalSupportCalls;
                    _local_4 = _local_3.supportCall;
                    if ((_local_4 is Array))
                    {
                        for each (_local_6 in _local_4)
                        {
                            _local_5 = Base64.decode(_local_6.messageBase64);
                            _local_5.position = 0;
                            _local_5.endian = Endian.LITTLE_ENDIAN;
                            _local_2.push(new SupportCall(_local_6.supportCallId, _local_6.date, _local_6.theme, _local_5.readUTFBytes(_local_5.length), _local_6.messagesCount, (_local_6.processed == "true"), (_local_6.readed == "true")));
                        };
                    }
                    else
                    {
                        _local_5 = Base64.decode(_local_4.messageBase64);
                        _local_5.position = 0;
                        _local_5.endian = Endian.LITTLE_ENDIAN;
                        _local_2[0] = new SupportCall(_local_4.supportCallId, _local_4.date, _local_4.theme, _local_5.readUTFBytes(_local_5.length), _local_4.messagesCount, (_local_4.processed == "true"), (_local_4.readed == "true"));
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

        public function get callsCount():uint
        {
            return (this._callsCount);
        }


    }
}//package com.hbm.socialmodule.rrhandlers.supphandlers

