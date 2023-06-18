


//hbm.Game.Utility.HelpArrow

package hbm.Game.Utility
{
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.geom.Vector3D;
    import hbm.Application.ClientApplication;
    import flash.events.Event;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Game.Character.Character;
    import caurina.transitions.Tweener;

    public class HelpArrow extends MovieClipPlayer 
    {

        public static const S_ROTATE:Number = 0;
        public static const SW_ROTATE:Number = 45;
        public static const W_ROTATE:Number = 90;
        public static const NW_ROTATE:Number = 135;
        public static const N_ROTATE:Number = 180;
        public static const NE_ROTATE:Number = -135;
        public static const E_ROTATE:Number = -90;
        public static const SE_ROTATE:Number = -45;
        private static const OFFSET_SCREEN_ARROW:Number = 180;
        private static const QUAD_OFFSET_SCREEN_ARROW:Number = (200 * 200);//40000

        private var _target:DisplayObject;
        private var _firstRectTarget:Rectangle;
        private var _attachToPoint:Boolean = false;
        private var _completeHide:Boolean;

        private var _point:Point = new Point();
        private const _defaultDirArrow:Vector3D = new Vector3D(0, 1, 0);
        private const _arrowInterface:FLHelpArrow = new FLHelpArrow();
        private const _arrowInterface2:FLHelpArrow2 = new FLHelpArrow2();
        private const _arrowMoveToPoint:FLHelpArrowMove = new FLHelpArrowMove();

        public function HelpArrow()
        {
            mouseEnabled = (mouseChildren = false);
        }

        public function get Target():DisplayObject
        {
            return (this._target);
        }

        public function AttachToCameraPoint(_arg_1:Number, _arg_2:Number, _arg_3:Boolean=false):void
        {
            var _local_4:int;
            this._point.x = _arg_1;
            this._point.y = _arg_2;
            this._completeHide = _arg_3;
            this._attachToPoint = true;
            SetMovieClip(this._arrowMoveToPoint);
            if (parent != ClientApplication.Instance)
            {
                Play();
                _local_4 = ClientApplication.Instance.GetIndexForArrowMap();
                ClientApplication.Instance.addChildAt(this, _local_4);
            };
        }

        public function Attach(_arg_1:DisplayObject, _arg_2:Number=0, _arg_3:uint=1, _arg_4:Boolean=false):void
        {
            if (((!(_arg_1)) || (!(_arg_1.parent))))
            {
                return;
            };
            this._target = _arg_1;
            this._attachToPoint = false;
            if (_arg_4)
            {
                this._firstRectTarget = this._target.getBounds(this._target);
            }
            else
            {
                this._firstRectTarget = null;
            };
            rotation = _arg_2;
            SetMovieClip(((_arg_3 == 1) ? this._arrowInterface : this._arrowInterface2));
            if (parent != ClientApplication.Instance.stage)
            {
                Play();
                ClientApplication.Instance.stage.addChild(this);
            };
        }

        public function Detach():void
        {
            this._target = null;
            this._attachToPoint = false;
            Stop();
            if (parent)
            {
                parent.removeChild(this);
            };
        }

        override protected function OnEnterFrame(_arg_1:Event):void
        {
            if (this._attachToPoint)
            {
                this.UpdateArrowToPoint();
            }
            else
            {
                if (((this._target) && (this._target.root)))
                {
                    this.UpdateArrowToObject();
                }
                else
                {
                    this.Detach();
                };
            };
            super.OnEnterFrame(_arg_1);
        }

        private function UpdateArrowToObject():void
        {
            var _local_2:Rectangle;
            var _local_1:Rectangle = this._target.getBounds(ClientApplication.Instance.stage);
            if (this._firstRectTarget)
            {
                _local_2 = this._target.getBounds(this._target);
                if (!_local_2.equals(this._firstRectTarget))
                {
                    _local_1.left = (_local_1.left + (this._firstRectTarget.left - _local_2.left));
                    _local_1.top = (_local_1.top + (this._firstRectTarget.top - _local_2.top));
                    _local_1.right = (_local_1.right + (this._firstRectTarget.right - _local_2.right));
                    _local_1.bottom = (_local_1.bottom + (this._firstRectTarget.bottom - _local_2.bottom));
                };
            };
            switch (rotation)
            {
                case S_ROTATE:
                    x = (_local_1.left + (_local_1.width / 2));
                    y = _local_1.top;
                    return;
                case SW_ROTATE:
                    x = (_local_1.left + _local_1.width);
                    y = _local_1.top;
                    return;
                case W_ROTATE:
                    x = (_local_1.left + _local_1.width);
                    y = (_local_1.top + (_local_1.height / 2));
                    return;
                case NW_ROTATE:
                    x = (_local_1.left + _local_1.width);
                    y = (_local_1.top + _local_1.height);
                    return;
                case N_ROTATE:
                    x = (_local_1.left + (_local_1.width / 2));
                    y = (_local_1.top + _local_1.height);
                    return;
                case NE_ROTATE:
                    x = _local_1.left;
                    y = (_local_1.top + _local_1.height);
                    return;
                case E_ROTATE:
                    x = _local_1.left;
                    y = (_local_1.top + (_local_1.height / 2));
                    return;
                case SE_ROTATE:
                    x = _local_1.left;
                    y = _local_1.top;
                    return;
                default:
                    x = (_local_1.left + (_local_1.width / 2));
                    y = (_local_1.top + (_local_1.height / 2));
            };
        }

        private function UpdateArrowToPoint():void
        {
            var _local_3:Point;
            var _local_5:Number;
            var _local_1:Point = RenderSystem.Instance.MainCamera.TopLeftPoint;
            x = (this._point.x - _local_1.x);
            y = (this._point.y - _local_1.y);
            var _local_2:Character = CharacterStorage.Instance.LocalPlayerCharacter;
            if (!_local_2)
            {
                return;
            };
            _local_3 = _local_2.GetNamePos().clone();
            _local_3.y = (_local_3.y - 40);
            var _local_4:Vector3D = new Vector3D((x - _local_3.x), (y - _local_3.y));
            if (_local_4.lengthSquared > QUAD_OFFSET_SCREEN_ARROW)
            {
                _local_4.normalize();
                _local_5 = ((Vector3D.angleBetween(this._defaultDirArrow, _local_4) / Math.PI) * 180);
                rotation = ((_local_4.x < 0) ? _local_5 : -(_local_5));
                x = (_local_3.x + (_local_4.x * OFFSET_SCREEN_ARROW));
                y = (_local_3.y + (_local_4.y * OFFSET_SCREEN_ARROW));
            }
            else
            {
                rotation = S_ROTATE;
                if (((this._completeHide) && (!(Tweener.isTweening(this)))))
                {
                    Tweener.addTween(this, {
                        "alpha":0,
                        "time":1,
                        "transition":"easeInOutCubic",
                        "onComplete":this.OnCompleteTween
                    });
                };
            };
        }

        private function OnCompleteTween():void
        {
            dispatchEvent(new Event(Event.COMPLETE));
            this.Detach();
            alpha = 1;
        }


    }
}//package hbm.Game.Utility

