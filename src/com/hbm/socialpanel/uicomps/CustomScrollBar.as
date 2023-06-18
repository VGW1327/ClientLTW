


//com.hbm.socialpanel.uicomps.CustomScrollBar

package com.hbm.socialpanel.uicomps
{
    import flash.display.MovieClip;
    import flash.geom.Rectangle;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.events.*;

    public class CustomScrollBar 
    {

        private var host_mc:MovieClip;
        private var call_back:Function;
        private var drag_mc:MovieClip;
        private var track_mc:MovieClip;
        private var scroll_rect:Rectangle;
        private var upper_limit:Number;
        private var range:Number;

        public function CustomScrollBar(_arg_1:MovieClip, _arg_2:Function)
        {
            this.host_mc = _arg_1;
            this.call_back = _arg_2;
            this.drag_mc = this.host_mc.drag_mc;
            this.drag_mc.buttonMode = true;
            this.drag_mc.mouseChildren = false;
            this.drag_mc.addEventListener(MouseEvent.MOUSE_DOWN, this.press_drag);
            this.track_mc = this.host_mc.track_mc;
            this.track_mc.buttonMode = true;
            this.track_mc.mouseChildren = false;
            this.set_limits();
        }

        private function press_drag(_arg_1:MouseEvent):void
        {
            this.drag_mc.stage.addEventListener(MouseEvent.MOUSE_UP, this.release_drag, false, 0, true);
            this.drag_mc.startDrag(false, this.scroll_rect);
            this.drag_mc.addEventListener(Event.ENTER_FRAME, this.drag);
        }

        private function release_drag(_arg_1:MouseEvent):void
        {
            this.drag_mc.removeEventListener(Event.ENTER_FRAME, this.drag);
            this.drag_mc.stage.removeEventListener(MouseEvent.MOUSE_UP, this.release_drag);
            this.drag_mc.stopDrag();
        }

        private function set_limits():void
        {
            this.scroll_rect = new Rectangle(this.track_mc.x, this.track_mc.y, 0, (this.track_mc.height - this.drag_mc.height));
            this.upper_limit = this.track_mc.y;
            this.range = (this.track_mc.height - this.drag_mc.height);
        }

        private function drag(_arg_1:Event):void
        {
            var _local_2:Number = ((this.drag_mc.y - this.track_mc.y) / this.range);
            this.call_back(_local_2);
        }


    }
}//package com.hbm.socialpanel.uicomps

