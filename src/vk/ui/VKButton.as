


//vk.ui.VKButton

package vk.ui
{
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.display.DisplayObjectContainer;

    public class VKButton extends SimpleButton 
    {

        private var _overText:TextField;
        private var _upText:TextField;
        private var _buttonType:Number = 1;
        private var _label:String = "";
        private var _overTextFormat:TextFormat;
        private var _upTextFormat:TextFormat;

        public function VKButton(_arg_1:String, _arg_2:Number=1)
        {
            this._buttonType = _arg_2;
            this._label = _arg_1;
            this.init();
            this.updateButton();
        }

        public function set label(_arg_1:String):void
        {
            _label = _arg_1;
            updateButton();
        }

        private function init():void
        {
            _upTextFormat = new TextFormat();
            _overTextFormat = new TextFormat();
            switch (_buttonType)
            {
                case 2:
                    _upTextFormat.color = 0x222222;
                    _overTextFormat.color = 0x606060;
                    break;
                case 1:
                default:
                    _upTextFormat.color = 0xF3F3F3;
                    _overTextFormat.color = 14344680;
            };
            _upTextFormat.font = "Verdana";
            _upTextFormat.size = 11;
            _upText = new TextField();
            _upText.wordWrap = false;
            _upText.autoSize = TextFieldAutoSize.LEFT;
            _upText.defaultTextFormat = _upTextFormat;
            _overTextFormat.font = "Verdana";
            _overTextFormat.size = 11;
            _overText = new TextField();
            _overText.wordWrap = false;
            _overText.autoSize = TextFieldAutoSize.LEFT;
            _overText.defaultTextFormat = _overTextFormat;
            useHandCursor = true;
        }

        private function updateButton():void
        {
            var _local_1:uint;
            switch (_buttonType)
            {
                case 2:
                    _local_1 = 0xDEDEDE;
                    break;
                default:
                    _local_1 = 3564430;
            };
            _upText.text = (_overText.text = _label);
            upState = new VKButtonDisplayState(_local_1, (_upText.textWidth + 24), 24);
            overState = new VKButtonDisplayState(_local_1, (_upText.textWidth + 24), 24);
            downState = (hitTestState = overState);
            _upText.x = 10;
            _upText.y = (Math.round(((upState.height - _upText.textHeight) / 2)) - 3);
            _overText.x = _upText.x;
            _overText.y = _upText.y;
            (upState as DisplayObjectContainer).addChild(_upText);
            (overState as DisplayObjectContainer).addChild(_overText);
        }


    }
}//package vk.ui

