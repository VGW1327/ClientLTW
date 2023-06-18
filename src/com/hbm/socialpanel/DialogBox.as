


//com.hbm.socialpanel.DialogBox

package com.hbm.socialpanel
{
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class DialogBox extends DialogBoxGraphic 
    {

        public static const CONFIRM_BOX:int = 0;
        public static const MESSAGE_BOX:int = 1;
        public static const OK:String = "ok";
        public static const CANCEL:String = "cancel";

        public function DialogBox(_arg_1:String, _arg_2:String, _arg_3:int)
        {
            _titleLabel.text = _arg_1;
            _titleLabel.selectable = false;
            _messageLabel.text = _arg_2;
            _messageLabel.selectable = false;
            _leftButton.gotoAndStop(1);
            _leftButton._textLabel.text = "OK";
            _leftButton._textLabel.selectable = false;
            _leftButton.buttonMode = true;
            _leftButton.addEventListener(MouseEvent.MOUSE_OVER, this.OnMouseOverLeftButton);
            _leftButton.addEventListener(MouseEvent.MOUSE_OUT, this.OnMouseOutLeftButton);
            _leftButton.addEventListener(MouseEvent.CLICK, this.OnLeftButtonClick);
            _rightButton.gotoAndStop(1);
            _rightButton._textLabel.text = "Отмена";
            _rightButton._textLabel.selectable = false;
            _rightButton.buttonMode = true;
            _rightButton.addEventListener(MouseEvent.MOUSE_OVER, this.OnMouseOverRightButton);
            _rightButton.addEventListener(MouseEvent.MOUSE_OUT, this.OnMouseOutRightButton);
            _rightButton.addEventListener(MouseEvent.CLICK, this.OnRightButtonClick);
            switch (_arg_3)
            {
                case CONFIRM_BOX:
                    return;
                case MESSAGE_BOX:
                    _leftButton.x = ((this.width - _leftButton.width) / 2);
                    _rightButton.visible = false;
            };
        }

        private function OnLeftButtonClick(_arg_1:Event):void
        {
            dispatchEvent(new Event(DialogBox.OK));
        }

        private function OnRightButtonClick(_arg_1:Event):void
        {
            dispatchEvent(new Event(DialogBox.CANCEL));
        }

        private function OnMouseOverLeftButton(_arg_1:MouseEvent):void
        {
            _leftButton.gotoAndStop(2);
        }

        private function OnMouseOutLeftButton(_arg_1:MouseEvent):void
        {
            _leftButton.gotoAndStop(1);
        }

        private function OnMouseOverRightButton(_arg_1:MouseEvent):void
        {
            _rightButton.gotoAndStop(2);
        }

        private function OnMouseOutRightButton(_arg_1:MouseEvent):void
        {
            _rightButton.gotoAndStop(1);
        }


    }
}//package com.hbm.socialpanel

