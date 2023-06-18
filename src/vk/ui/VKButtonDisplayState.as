


//vk.ui.VKButtonDisplayState

package vk.ui
{
    import flash.display.Sprite;
    import flash.display.Shape;

    internal class VKButtonDisplayState extends Sprite 
    {

        private var bgColor:uint;

        public function VKButtonDisplayState(_arg_1:uint, _arg_2:uint, _arg_3:uint)
        {
            this.bgColor = _arg_1;
            draw(_arg_2, _arg_3);
        }

        private function draw(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Shape = new Shape();
            _local_3.graphics.beginFill(bgColor);
            _local_3.graphics.drawRoundRect(0, 0, _arg_1, _arg_2, 5);
            _local_3.graphics.endFill();
            addChild(_local_3);
        }


    }
}//package vk.ui

