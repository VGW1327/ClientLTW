


//hbm.Engine.Renderer.Camera

package hbm.Engine.Renderer
{
    import flash.geom.Point;

    public class Camera 
    {

        private var _maxWidth:uint = 0x0800;
        private var _maxHeight:uint = 0x0800;
        private var _isTopLeftUpdated:Boolean = false;
        private var _position:Point = new Point(0x0200, 384);
        private var _topLeftPoint:Point = new Point(0, 0);


        private function UpdateTopLeftPoint():void
        {
            this._isTopLeftUpdated = true;
            var _local_1:uint = uint((RenderSystem.Instance.ScreenWidth / 2));
            var _local_2:uint = uint((RenderSystem.Instance.ScreenHeight / 2));
            this._topLeftPoint.x = (this._position.x - _local_1);
            this._topLeftPoint.y = (this._maxHeight - (this._position.y + _local_2));
        }

        public function get TopLeftPoint():Point
        {
            if (!this._isTopLeftUpdated)
            {
                this.UpdateTopLeftPoint();
            };
            return (this._topLeftPoint);
        }

        public function get Position():Point
        {
            return (this._position);
        }

        public function set Position(_arg_1:Point):void
        {
            this._position = _arg_1;
            this._isTopLeftUpdated = false;
            this.FixCameraPosition();
        }

        public function get MaxHeight():uint
        {
            return (this._maxHeight);
        }

        public function set MaxHeight(_arg_1:uint):void
        {
            this._maxHeight = _arg_1;
            this._isTopLeftUpdated = false;
            this.FixCameraPosition();
        }

        public function get MaxWidth():uint
        {
            return (this._maxWidth);
        }

        public function set MaxWidth(_arg_1:uint):void
        {
            this._maxWidth = _arg_1;
            this._isTopLeftUpdated = false;
            this.FixCameraPosition();
        }

        public function FixCameraPosition():void
        {
            var _local_1:uint = uint((RenderSystem.Instance.ScreenWidth / 2));
            var _local_2:uint = uint((RenderSystem.Instance.ScreenHeight / 2));
            var _local_3:uint = this._maxWidth;
            var _local_4:uint = this._maxHeight;
            if (this._position.x < _local_1)
            {
                this._isTopLeftUpdated = false;
                this._position.x = _local_1;
            };
            if (this._position.y < _local_2)
            {
                this._isTopLeftUpdated = false;
                this._position.y = _local_2;
            };
            if ((this._position.x + _local_1) > _local_3)
            {
                this._isTopLeftUpdated = false;
                this._position.x = (_local_3 - _local_1);
            };
            if ((this._position.y + _local_2) > _local_4)
            {
                this._isTopLeftUpdated = false;
                this._position.y = (_local_4 - _local_2);
            };
        }


    }
}//package hbm.Engine.Renderer

