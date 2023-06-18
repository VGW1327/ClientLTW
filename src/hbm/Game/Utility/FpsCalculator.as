


//hbm.Game.Utility.FpsCalculator

package hbm.Game.Utility
{
    public class FpsCalculator 
    {

        private var _currentFps:uint = 0;
        private var _frameCounter:uint = 0;
        private var _lastFrameTickTime:uint = 0;


        public function Update(_arg_1:uint):void
        {
            this._frameCounter++;
            var _local_2:uint = (_arg_1 - this._lastFrameTickTime);
            if (_local_2 < 1000)
            {
                return;
            };
            this._currentFps = uint((Number(this._frameCounter) / (Number(_local_2) / 1000)));
            this._frameCounter = 0;
            this._lastFrameTickTime = _arg_1;
        }

        public function get Fps():uint
        {
            return (this._currentFps);
        }


    }
}//package hbm.Game.Utility

