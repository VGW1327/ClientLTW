


//com.hbm.socialpanel.support.BugReportWindow

package com.hbm.socialpanel.support
{
    import support.BugRepMenu;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.BitmapData;
    import mx.graphics.codec.JPEGEncoder;
    import flash.utils.ByteArray;
    import flash.display.MovieClip;

    public class BugReportWindow extends BugRepMenu 
    {

        public function BugReportWindow()
        {
            super();
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
            _sendButton.addEventListener(MouseEvent.CLICK, this.Exit);
            _cancelButton.addEventListener(MouseEvent.CLICK, this.Exit);
            _themeField.addEventListener(Event.CHANGE, this.OnTextChanged);
            _describeField.addEventListener(Event.CHANGE, this.OnTextChanged);
            _sendButton.visible = false;
        }

        public function GetScreen():ByteArray
        {
            var _local_1:BitmapData = new BitmapData(stage.width, stage.height);
            _local_1.draw(stage);
            var _local_2:JPEGEncoder = new JPEGEncoder();
            return (_local_2.encode(_local_1));
        }

        private function OnOverButton(_arg_1:MovieClip):void
        {
            _arg_1.gotoAndStop(2);
        }

        private function OnOutOfButton(_arg_1:MovieClip):void
        {
            _arg_1.gotoAndStop(1);
        }

        private function OnTextChanged(_arg_1:Event):void
        {
            _sendButton.visible = ((!(_themeField.text == "")) && (!(_describeField.text == "")));
        }

        private function Exit(_arg_1:Event):void
        {
            parent.removeChild(this);
        }


    }
}//package com.hbm.socialpanel.support

