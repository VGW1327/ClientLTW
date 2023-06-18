


//com.hbm.socialpanel.support.SupportMessagesPanel

package com.hbm.socialpanel.support
{
    import support.SupportMessagesPanelSkin;
    import com.hbm.socialmodule.support.SupportCall;
    import com.hbm.socialmodule.support.SupportServiceData;
    import flash.display.Sprite;
    import com.hbm.socialpanel.uicomps.CustomScrollBar;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import com.hbm.socialmodule.support.SupportCallMessage;
    import support.SupportMessageSkin;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.display.MovieClip;

    public class SupportMessagesPanel extends SupportMessagesPanelSkin 
    {

        private var _supportCall:SupportCall;
        private var _data:SupportServiceData;
        private var _messagePane:Sprite;
        private var _scroller:CustomScrollBar;

        public function SupportMessagesPanel(_arg_1:SupportServiceData)
        {
            this._data = _arg_1;
            this.Init();
        }

        private function Init():void
        {
            _sendButton._textLabel.text = "Отправить";
            _cancelButton._textLabel.text = "Отмена";
            _sendButton.gotoAndStop(1);
            _sendButton.addEventListener(MouseEvent.MOUSE_OVER, function (_arg_1:Event):void
            {
                OnOverButton(_sendButton);
            });
            _sendButton.addEventListener(MouseEvent.MOUSE_OUT, function (_arg_1:Event):void
            {
                OnOutOfButton(_sendButton);
            });
            _cancelButton.gotoAndStop(1);
            _cancelButton.addEventListener(MouseEvent.MOUSE_OVER, function (_arg_1:Event):void
            {
                OnOverButton(_cancelButton);
            });
            _cancelButton.addEventListener(MouseEvent.MOUSE_OUT, function (_arg_1:Event):void
            {
                OnOutOfButton(_cancelButton);
            });
            _sendButton.addEventListener(MouseEvent.CLICK, this.OnMessageSent);
            _cancelButton.addEventListener(MouseEvent.CLICK, this.OnClose);
            _messageField.addEventListener(Event.CHANGE, this.OnTextChanged);
            _scrollPane.scrollRect = new Rectangle(0, 0, 400, 165);
            this._scroller = new CustomScrollBar(_scrollTrack, this.ScrollHandler);
            this._messagePane = new Sprite();
            _scrollPane.addChild(this._messagePane);
        }

        protected function RenderMessages():void
        {
            var _local_4:SupportCallMessage;
            var _local_5:SupportMessageSkin;
            var _local_6:TextField;
            var _local_1:int;
            var _local_2:SupportMessageSkin = new SupportMessageSkin();
            var _local_3:TextField = _local_2._messageField;
            _local_3.autoSize = TextFieldAutoSize.RIGHT;
            _local_3.wordWrap = true;
            _local_3.text = this._supportCall.text;
            _local_2._timeField.text = this._supportCall.date;
            _local_2._titleField.text = "Сообщение:";
            _local_2.x = 0;
            _local_2.y = _local_1;
            this._messagePane.addChild(_local_2);
            _local_1 = (_local_1 + (_local_2.height + 4));
            for each (_local_4 in this._supportCall.messages)
            {
                _local_5 = new SupportMessageSkin();
                _local_6 = _local_5._messageField;
                _local_6.autoSize = TextFieldAutoSize.RIGHT;
                _local_6.wordWrap = true;
                _local_6.text = _local_4.message;
                _local_5._titleField.text = _local_4.user;
                _local_5._timeField.text = _local_4.date;
                _local_5.x = 0;
                _local_5.y = _local_1;
                this._messagePane.addChild(_local_5);
                _local_1 = (_local_1 + (_local_5.height + 4));
            };
        }

        public function SetCall(_arg_1:SupportCall):void
        {
            this._supportCall = _arg_1;
            var _local_2:int = this._messagePane.numChildren;
            while (_local_2--)
            {
                this._messagePane.removeChildAt(_local_2);
            };
            _topicLabel.text = this._supportCall.theme;
            _sendButton.visible = false;
            _messageField.text = "";
            this.RenderMessages();
            _scrollTrack.visible = (_scrollPane.scrollRect.height < this._messagePane.height);
        }

        private function OnOverButton(_arg_1:MovieClip):void
        {
            _arg_1.gotoAndStop(2);
        }

        private function OnOutOfButton(_arg_1:MovieClip):void
        {
            _arg_1.gotoAndStop(1);
        }

        private function OnMessageSent(_arg_1:Event):void
        {
            var _local_2:String = _messageField.text;
            this._data.SendSupportCallMessage(this._supportCall.id, _local_2);
            parent.removeChild(this);
        }

        private function OnClose(_arg_1:MouseEvent):void
        {
            _scrollTrack.drag_mc.y = 0;
            this.ScrollHandler(0);
            parent.removeChild(this);
        }

        private function OnTextChanged(_arg_1:Event):void
        {
            _sendButton.visible = (!(_messageField.text == ""));
        }

        private function ScrollHandler(_arg_1:Number):void
        {
            var _local_2:Rectangle = _scrollPane.scrollRect;
            _local_2.y = ((this._messagePane.height - _local_2.height) * _arg_1);
            _scrollPane.scrollRect = _local_2;
        }


    }
}//package com.hbm.socialpanel.support

