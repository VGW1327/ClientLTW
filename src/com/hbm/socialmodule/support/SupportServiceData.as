


//com.hbm.socialmodule.support.SupportServiceData

package com.hbm.socialmodule.support
{
    import flash.events.EventDispatcher;
    import com.hbm.socialmodule.connection.Connector;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.rrhandlers.supphandlers.CallSupportHandler;
    import com.hbm.socialmodule.rrhandlers.supphandlers.GetSupportCallListHandler;
    import com.hbm.socialmodule.rrhandlers.supphandlers.GetSupportCallMessagesHandler;
    import com.hbm.socialmodule.rrhandlers.supphandlers.WriteMessageToSupportCallHandler;
    import flash.events.Event;
    import flash.events.ErrorEvent;
    import flash.utils.ByteArray;
    import com.hbm.socialmodule.connection.ResponseEvent;

    public class SupportServiceData extends EventDispatcher 
    {

        private var _server:Connector;
        private var _apiHandler:NetworkAPIHandler;
        private var _callsCount:int;
        private var _callList:Array;
        private var _requestedCall:SupportCall;
        private var _callSupportHandler:CallSupportHandler;
        private var _getSupportCallListHandler:GetSupportCallListHandler;
        private var _getSupportCallMessagesHandler:GetSupportCallMessagesHandler;
        private var _writeMessageToSupportCallHandler:WriteMessageToSupportCallHandler;

        public function SupportServiceData(_arg_1:Connector, _arg_2:NetworkAPIHandler)
        {
            this._server = _arg_1;
            this._apiHandler = _arg_2;
            this.InitRRHandlers();
            this._getSupportCallListHandler.addEventListener(Event.COMPLETE, this.OnCallListReceived);
            this._getSupportCallMessagesHandler.addEventListener(Event.COMPLETE, this.OnCallMessagesReceived);
        }

        private function InitRRHandlers():void
        {
            this._callSupportHandler = new CallSupportHandler(this._server, this._apiHandler);
            this._getSupportCallListHandler = new GetSupportCallListHandler(this._server, this._apiHandler);
            this._getSupportCallListHandler.addEventListener(Event.COMPLETE, this.OnCallListReceived);
            this._getSupportCallMessagesHandler = new GetSupportCallMessagesHandler(this._server, this._apiHandler);
            this._getSupportCallMessagesHandler.addEventListener(Event.COMPLETE, this.OnCallMessagesReceived);
            this._writeMessageToSupportCallHandler = new WriteMessageToSupportCallHandler(this._server, this._apiHandler);
            this._callSupportHandler.addEventListener(ErrorEvent.ERROR, this.OnRRHandlerError);
            this._writeMessageToSupportCallHandler.addEventListener(ErrorEvent.ERROR, this.OnRRHandlerError);
            this._getSupportCallListHandler.addEventListener(ErrorEvent.ERROR, this.OnRRHandlerError);
            this._getSupportCallMessagesHandler.addEventListener(ErrorEvent.ERROR, this.OnRRHandlerError);
        }

        public function SendSupportCall(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:ByteArray=null):void
        {
            this._callSupportHandler.SendRequest(_arg_1, _arg_2, _arg_4, _arg_3);
        }

        public function GetSupportCallList():void
        {
            this._getSupportCallListHandler.SendRequest();
        }

        public function GetSupportCallMessages(_arg_1:SupportCall):void
        {
            this._requestedCall = _arg_1;
            this._getSupportCallMessagesHandler.SendRequest(_arg_1.id);
        }

        public function SendSupportCallMessage(_arg_1:String, _arg_2:String):void
        {
            this._writeMessageToSupportCallHandler.SendRequest(_arg_2, _arg_1);
        }

        private function OnCallListReceived(_arg_1:ResponseEvent):void
        {
            this._callList = (_arg_1.data as Array);
            dispatchEvent(new ResponseEvent(ResponseEvent.SUPPORT_CALL_LIST, this._callList));
        }

        private function OnCallMessagesReceived(_arg_1:ResponseEvent):void
        {
            this._requestedCall.messages = (_arg_1.data as Array);
            dispatchEvent(new ResponseEvent(ResponseEvent.SUPPORT_MSGS, this._requestedCall));
        }

        protected function OnRRHandlerError(_arg_1:ErrorEvent):void
        {
            dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, _arg_1.text));
        }

        public function get CallList():Array
        {
            return (this._callList);
        }

        public function get callsCount():int
        {
            return (this._callsCount);
        }


    }
}//package com.hbm.socialmodule.support

