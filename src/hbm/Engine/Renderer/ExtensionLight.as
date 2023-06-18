


//hbm.Engine.Renderer.ExtensionLight

package hbm.Engine.Renderer
{
    import mx.core.BitmapAsset;
    import flash.geom.Point;
    import hbm.Game.Utility.AsWingUtil;
    import hbm.Game.Character.CharacterStorage;
    import caurina.transitions.Tweener;

    public class ExtensionLight 
    {

        private var _first:BitmapAsset;
        private var _second:BitmapAsset;
        private var _radius:Number;
        private var _pos:Point = new Point();

        public function ExtensionLight(_arg_1:Number)
        {
            this._radius = _arg_1;
            this._first = AsWingUtil.AdditionalData.GetBitmapAsset("AdditionalData_Item_GradientWight2");
            this._second = AsWingUtil.AdditionalData.GetBitmapAsset("AdditionalData_Item_GradientWight2");
            this._first.smoothing = (this._second.smoothing = true);
            this._first.width = (this._second.width = (this._radius * 2));
            this._first.height = (this._second.height = (this._radius * 2));
            this._first.alpha = (this._second.alpha = 0);
        }

        public function SetAbsolutePosition(_arg_1:Number, _arg_2:Number):void
        {
            this._pos.x = _arg_1;
            this._pos.y = _arg_2;
        }

        public function SetLocationPosition(_arg_1:int, _arg_2:int):void
        {
            this.SetAbsolutePosition((_arg_1 * CharacterStorage.CELL_SIZE), (_arg_2 * CharacterStorage.CELL_SIZE));
        }

        public function UpdateCameraPosition():void
        {
            var _local_1:Camera;
            _local_1 = RenderSystem.Instance.MainCamera;
            var _local_2:Number = ((this._pos.x - _local_1.TopLeftPoint.x) - this._radius);
            var _local_3:Number = (((RenderSystem.Instance.MainCamera.MaxHeight - this._pos.y) - _local_1.TopLeftPoint.y) - this._radius);
            this._first.x = (this._second.x = _local_2);
            this._first.x = (this._second.x = _local_2);
            this._first.y = (this._second.y = _local_3);
        }

        public function get IsVisible():Boolean
        {
            return ((!(this._first.parent == null)) && (!(this._second.parent == null)));
        }

        public function Show(_arg_1:Array):void
        {
            if (this.IsVisible)
            {
                this.UpdateCameraPosition();
                return;
            };
            _arg_1[0].addChild(this._first);
            _arg_1[1].addChild(this._second);
            Tweener.addTween(this._first, {
                "alpha":1,
                "time":(1 - this._first.alpha),
                "transition":"easeInOutCubic"
            });
            Tweener.addTween(this._second, {
                "alpha":1,
                "time":(1 - this._second.alpha),
                "transition":"easeInOutCubic"
            });
        }

        public function Hide():void
        {
            if (this.IsVisible)
            {
                this.UpdateCameraPosition();
                if (!Tweener.isTweening(this._first))
                {
                    var removeLight:Function = function ():void
                    {
                        _first.parent.removeChild(_first);
                        _second.parent.removeChild(_second);
                    };
                    Tweener.addTween(this._first, {
                        "alpha":0,
                        "time":this._first.alpha,
                        "transition":"easeInOutCubic",
                        "onComplete":removeLight
                    });
                    Tweener.addTween(this._second, {
                        "alpha":0,
                        "time":this._second.alpha,
                        "transition":"easeInOutCubic"
                    });
                };
            };
        }

        public function get Position():Point
        {
            return (this._pos);
        }


    }
}//package hbm.Engine.Renderer

