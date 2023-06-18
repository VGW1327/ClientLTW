


//hbm.Game.GUI.Tools.BlinkingIcon

package hbm.Game.GUI.Tools
{
    import flash.display.DisplayObject;
    import caurina.transitions.Tweener;

    public class BlinkingIcon 
    {

        private var _target:DisplayObject;
        private var _started:Boolean;

        public function BlinkingIcon(_arg_1:DisplayObject)
        {
            this._target = _arg_1;
        }

        public function Start():void
        {
            if (!this._started)
            {
                this.Run();
                this._started = true;
            };
        }

        protected function Run():void
        {
            this._target.alpha = 1;
            Tweener.addTween(this._target, {
                "alpha":0.3,
                "time":1,
                "transition":"easeInOutCubic",
                "onComplete":this.Run
            });
        }

        public function Stop():void
        {
            Tweener.removeTweens(this._target);
            this._target.alpha = 1;
            this._started = false;
        }


    }
}//package hbm.Game.GUI.Tools

