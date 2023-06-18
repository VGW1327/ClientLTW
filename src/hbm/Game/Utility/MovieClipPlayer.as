


//hbm.Game.Utility.MovieClipPlayer

package hbm.Game.Utility
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.utils.getTimer;
    import flash.events.Event;

    public class MovieClipPlayer extends Sprite 
    {

        private var _frameRate:uint = 30;
        private var _startTime:uint;
        private var _movieClip:MovieClip;

        public function MovieClipPlayer(_arg_1:MovieClip=null, _arg_2:Boolean=false)
        {
            this.SetMovieClip(_arg_1, _arg_2);
        }

        public function SetMovieClip(_arg_1:MovieClip, _arg_2:Boolean=false):void
        {
            if (this._movieClip == _arg_1)
            {
                return;
            };
            if (this._movieClip)
            {
                this._movieClip.gotoAndStop(0);
                if (contains(this._movieClip))
                {
                    removeChild(this._movieClip);
                };
            };
            this._movieClip = _arg_1;
            if (this._movieClip)
            {
                this._movieClip.gotoAndStop(0);
                addChild(this._movieClip);
                if (_arg_2)
                {
                    this.Play();
                };
            };
        }

        public function Play(_arg_1:uint=30):void
        {
            this._frameRate = _arg_1;
            this._startTime = getTimer();
            if (!hasEventListener(Event.ENTER_FRAME))
            {
                addEventListener(Event.ENTER_FRAME, this.OnEnterFrame, false, 0, true);
            };
        }

        public function Stop():void
        {
            removeEventListener(Event.ENTER_FRAME, this.OnEnterFrame);
        }

        protected function OnEnterFrame(_arg_1:Event):void
        {
            if (((this._movieClip) && ((!(root)) || (!(visible)))))
            {
                return;
            };
            var _local_2:uint = ((((getTimer() - this._startTime) / 1000) * this._frameRate) % this._movieClip.totalFrames);
            this._movieClip.gotoAndStop(_local_2);
        }


    }
}//package hbm.Game.Utility

