


//hbm.Game.Renderer.CharacterAnimationState

package hbm.Game.Renderer
{
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.events.*;

    public class CharacterAnimationState extends EventDispatcher 
    {

        public static const ON_COMPLETED:String = "OnCompleted";

        private var _isLooped:Boolean;
        private var _isPaused:Boolean;
        private var _frameRate:Number;
        private var _animationTime:Number;
        private var _animationSpeed:Number;
        private var _lastAnimationTime:Number;
        private var _currentAnimationIndex:int;
        private var _animationFrames:Array;

        public function CharacterAnimationState()
        {
            this._isLooped = true;
            this._isPaused = true;
            this._frameRate = 30;
            this._animationTime = 0;
            this._animationSpeed = 1;
            this._lastAnimationTime = 0;
            this._currentAnimationIndex = 0;
            this._animationFrames = new Array();
        }

        public function get CurrentAnimationIndex():int
        {
            return (this._currentAnimationIndex);
        }

        public function set CurrentAnimationIndex(_arg_1:int):void
        {
            if (((_arg_1 < 0) || (_arg_1 >= this._animationFrames.length)))
            {
                return;
            };
            this._currentAnimationIndex = _arg_1;
        }

        public function AddAnimationFrame(_arg_1:CharacterAnimationFrame):void
        {
            this._animationFrames.push(_arg_1);
        }

        public function GetAnimationFrame(_arg_1:uint):CharacterAnimationFrame
        {
            if (_arg_1 >= this._animationFrames.length)
            {
                return (null);
            };
            return (this._animationFrames[_arg_1]);
        }

        public function get NumAnimationFrames():uint
        {
            return (this._animationFrames.length);
        }

        public function Stop():void
        {
            this._isPaused = true;
            this._animationTime = 0;
            this._lastAnimationTime = 0;
            this._currentAnimationIndex = 0;
        }

        public function Pause():void
        {
            this._isPaused = true;
        }

        public function Resume():void
        {
            this.Play(this._isLooped);
        }

        public function Play(_arg_1:Boolean=true):void
        {
            this._isPaused = false;
            this._isLooped = _arg_1;
        }

        public function get CurrentAnimationFrame():CharacterAnimationFrame
        {
            if (this._currentAnimationIndex >= this.NumAnimationFrames)
            {
                return (null);
            };
            return (this._animationFrames[this._currentAnimationIndex]);
        }

        public function Update(_arg_1:Number):void
        {
            if (this._isPaused)
            {
                return;
            };
            var _local_2:int = this._currentAnimationIndex;
            this._currentAnimationIndex = int(this._animationTime);
            var _local_3:int = this.NumAnimationFrames;
            var _local_4:Number = (this._animationTime - this._lastAnimationTime);
            if (_local_4 < 0)
            {
                if (this._isLooped)
                {
                    _local_4 = ((Number(_local_3) - this._lastAnimationTime) + this._animationTime);
                }
                else
                {
                    _local_4 = (Number(_local_3) - this._lastAnimationTime);
                };
            };
            if (_local_2 != this._currentAnimationIndex)
            {
                this._lastAnimationTime = this._animationTime;
            };
            if (this._currentAnimationIndex >= _local_3)
            {
                if (this._isLooped)
                {
                    this._animationTime = (this._animationTime - Number(_local_3));
                    this._currentAnimationIndex = int(this._animationTime);
                }
                else
                {
                    this._isPaused = true;
                    this._currentAnimationIndex = (_local_3 - 1);
                    this._animationTime = Number(this._currentAnimationIndex);
                    this.CallDelegateList();
                };
            }
            else
            {
                this._animationTime = (this._animationTime + ((_arg_1 * this._animationSpeed) * this._frameRate));
            };
        }

        private function CallDelegateList():void
        {
            dispatchEvent(new Event(ON_COMPLETED));
        }

        public function get AnimationSpeed():Number
        {
            return (this._animationSpeed);
        }

        public function set AnimationSpeed(_arg_1:Number):void
        {
            this._animationSpeed = _arg_1;
        }

        public function Clone():CharacterAnimationState
        {
            var _local_1:CharacterAnimationState = new CharacterAnimationState();
            _local_1._frameRate = this._frameRate;
            _local_1._animationSpeed = this._animationSpeed;
            _local_1._animationFrames = this._animationFrames;
            return (_local_1);
        }


    }
}//package hbm.Game.Renderer

