


//hbm.Engine.Renderer.Snow

package hbm.Engine.Renderer
{
    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.events.Event;

    public class Snow extends Sprite 
    {

        [Embed(source="_SNOW_DATA.png")] private const SNOW_DATA:Class;

        private var flakes:Array;
        private var w:int;
        private var h:int;
        private var container:DisplayObjectContainer;

        public function Snow(_arg_1:DisplayObjectContainer)
        {
            var _local_3:MovieClip;
            super();
            this.flakes = [];
            this.container = _arg_1;
            this.container.visible = false;
            this.container.mouseEnabled = (this.container.mouseChildren = false);
            var _local_2:int;
            while (_local_2 < 60)
            {
                _local_3 = new MovieClip();
                _local_3.speed = ((Math.random() * 3) + 3);
                _local_3.alpha = ((Math.random() * 0.5) + 0.5);
                _local_3.scaleY = (_local_3.scaleX = ((Math.random() * 0.5) + 0.5));
                _local_3.addChild(new this.SNOW_DATA());
                this.flakes.push(_local_3);
                this.container.addChild(_local_3);
                _local_2++;
            };
        }

        public function start(_arg_1:uint, _arg_2:uint):void
        {
            var _local_4:MovieClip;
            this.w = _arg_1;
            this.h = _arg_2;
            var _local_3:int;
            while (_local_3 < 60)
            {
                _local_4 = (this.flakes[_local_3] as MovieClip);
                _local_4.x = (_arg_1 * Math.random());
                _local_4.y = (_arg_2 * Math.random());
                _local_3++;
            };
            addEventListener(Event.ENTER_FRAME, this.onFrame);
            this.container.visible = true;
        }

        private function onFrame(_arg_1:Event):void
        {
            var _local_3:MovieClip;
            var _local_2:int;
            while (_local_2 < 60)
            {
                _local_3 = (this.flakes[_local_2] as MovieClip);
                _local_3.y = (_local_3.y + _local_3.speed);
                if (_local_3.y > this.h)
                {
                    _local_3.x = (Math.random() * this.w);
                    _local_3.y = -11;
                };
                _local_2++;
            };
        }

        public function stop():void
        {
            removeEventListener(Event.ENTER_FRAME, this.onFrame);
            this.container.visible = false;
        }


    }
}//package hbm.Engine.Renderer

