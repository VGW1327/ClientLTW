


//com.hbm.socialpanel.support.SupportServiceWindow

package com.hbm.socialpanel.support
{
    import support.SupportCallsWindowSkin;
    import flash.display.DisplayObjectContainer;
    import com.hbm.socialpanel.uicomps.CustomScrollBar;
    import flash.display.Sprite;
    import com.hbm.socialmodule.support.SupportCall;
    import com.hbm.socialmodule.support.SupportServiceData;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.geom.Rectangle;
    import com.hbm.socialmodule.support.SupportServiceEvent;
    import com.hbm.socialpanel.Utilities;
    import flash.display.MovieClip;

    public class SupportServiceWindow extends SupportCallsWindowSkin 
    {

        private var _parent:DisplayObjectContainer;
        private var _reportWindow:BugReportWindow;
        private var _messagesWindow:SupportMessagesPanel;
        private var _scroller:CustomScrollBar;
        private var _rowContainer:Sprite;
        private var _requestedCall:SupportCall;
        private var _supportServiceData:SupportServiceData;
        private var _isShowing:Boolean;

        public function SupportServiceWindow(parent:DisplayObjectContainer, supportData:SupportServiceData, x:int, y:int)
        {
            super();
            this._supportServiceData = supportData;
            this._parent = parent;
            this._reportWindow = new BugReportWindow();
            this._messagesWindow = new SupportMessagesPanel(this._supportServiceData);
            _makeNew._textLabel.text = "Написать";
            _cancelButton._textLabel.text = "Отмена";
            this.y = x;
            this.x = y;
            _cancelButton.addEventListener(MouseEvent.CLICK, this.OnCancel);
            _makeNew.addEventListener(MouseEvent.CLICK, this.OnNewReport);
            _makeNew.gotoAndStop(1);
            _makeNew.addEventListener(MouseEvent.MOUSE_OVER, function (_arg_1:Event):void
            {
                OnOverButton(_makeNew);
            });
            _makeNew.addEventListener(MouseEvent.MOUSE_OUT, function (_arg_1:Event):void
            {
                OnOutOfButton(_makeNew);
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
            this._supportServiceData.addEventListener(ResponseEvent.SUPPORT_CALL_LIST, this.OnCallListReceived);
            this._supportServiceData.addEventListener(ResponseEvent.SUPPORT_MSGS, this.OnCallMessages);
            this._reportWindow._sendButton.addEventListener(MouseEvent.CLICK, this.SendNewBugReport);
            _scrollContainer.scrollRect = new Rectangle(0, 0, 500, 235);
            _scrollTrack.visible = false;
            this._scroller = new CustomScrollBar(_scrollTrack, this.ScrollHandler);
            this._rowContainer = new Sprite();
            this._rowContainer.x = 0;
            this._rowContainer.y = 0;
            _scrollContainer.addChild(this._rowContainer);
            this._isShowing = false;
        }

        public function OpenWindow():void
        {
            this._parent.addChild(this);
            this._supportServiceData.GetSupportCallList();
            this._isShowing = true;
        }

        private function OnCancel(_arg_1:MouseEvent):void
        {
            this._parent.removeChild(this);
            this._isShowing = false;
        }

        private function OnNewReport(_arg_1:MouseEvent):void
        {
            this._reportWindow.y = (y - 20);
            this._reportWindow.x = (x + ((width - this._reportWindow.width) / 2));
            this._reportWindow._themeField.text = "";
            this._reportWindow._describeField.text = "";
            this._parent.addChild(this._reportWindow);
        }

        private function OnCallListReceived(_arg_1:ResponseEvent):void
        {
            var _local_5:SupportCall;
            var _local_6:Sprite;
            var _local_2:int = this._rowContainer.numChildren;
            while (_local_2--)
            {
                this._rowContainer.removeChildAt(_local_2);
            };
            var _local_3:Array = this._supportServiceData.CallList;
            var _local_4:int;
            for each (_local_5 in _local_3)
            {
                _local_6 = this.CreateRow(_local_5);
                _local_6.x = 0;
                _local_6.y = _local_4;
                _local_4 = (_local_4 + (_local_6.height + 2));
                this._rowContainer.addChild(_local_6);
            };
            _scrollTrack.visible = (_scrollContainer.scrollRect.height < this._rowContainer.height);
            _scrollTrack.drag_mc.y = 0;
            _scrollContainer.scrollRect.y = 0;
        }

        private function OpenMessagesWindow(_arg_1:SupportCall):void
        {
            this._messagesWindow.y = (y - 20);
            this._messagesWindow.x = (x + ((width - this._messagesWindow.width) / 2));
            this._messagesWindow.SetCall(_arg_1);
            this._parent.addChild(this._messagesWindow);
        }

        private function OnCallMessages(_arg_1:ResponseEvent):void
        {
            this._messagesWindow.SetCall(this._requestedCall);
        }

        protected function CreateRow(_arg_1:SupportCall):Sprite
        {
            var _local_2:SupportCallRow = new SupportCallRow(_arg_1);
            _local_2.addEventListener(SupportServiceEvent.MESSAGES_REQUESTED, this.OnRequestMessages);
            return (_local_2);
        }

        private function OnRequestMessages(_arg_1:SupportServiceEvent):void
        {
            this._requestedCall = _arg_1.call;
            this._supportServiceData.GetSupportCallMessages(_arg_1.call);
            this.OpenMessagesWindow(_arg_1.call);
        }

        private function SendNewBugReport(_arg_1:Event):void
        {
            var _local_2:RegExp = / /g;
            var _local_3:String = this._reportWindow._themeField.text;
            var _local_4:String = this._reportWindow._describeField.text;
            _local_3 = _local_3.replace(_local_2, "");
            _local_4 = _local_4.replace(_local_2, "");
            if (((!(_local_3 == "")) && (!(_local_4 == ""))))
            {
                this._supportServiceData.SendSupportCall(this._reportWindow._themeField.text, this._reportWindow._describeField.text);
                this._parent.removeChild(this);
                this._isShowing = false;
            }
            else
            {
                Utilities.ShowMessageDialog("Ошибка", 'Поля "Тема" и "Описание" не должны быть пустыми.', 150, 150, this);
            };
        }

        private function OnOverButton(_arg_1:MovieClip):void
        {
            _arg_1.gotoAndStop(2);
        }

        private function OnOutOfButton(_arg_1:MovieClip):void
        {
            _arg_1.gotoAndStop(1);
        }

        private function ScrollHandler(_arg_1:Number):void
        {
            var _local_2:Rectangle = _scrollContainer.scrollRect;
            _local_2.y = ((this._rowContainer.height - _local_2.height) * _arg_1);
            _scrollContainer.scrollRect = _local_2;
        }

        public function get isShowing():Boolean
        {
            return (this._isShowing);
        }


    }
}//package com.hbm.socialpanel.support

