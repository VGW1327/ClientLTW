


//de.nulldesign.nd2d.display.Camera2D

package de.nulldesign.nd2d.display
{
    import flash.geom.Matrix3D;
    import de.nulldesign.nd2d.utils.VectorUtil;
    import flash.geom.Vector3D;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class Camera2D 
    {

        protected var renderMatrixOrtho:Matrix3D = new Matrix3D();
        protected var renderMatrixPerspective:Matrix3D = new Matrix3D();
        protected var perspectiveProjectionMatrix:Matrix3D = new Matrix3D();
        protected var orthoProjectionMatrix:Matrix3D = new Matrix3D();
        protected var viewMatrix:Matrix3D = new Matrix3D();
        protected var _sceneWidth:Number;
        protected var _sceneHeight:Number;
        protected var invalidated:Boolean = true;
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _zoom:Number = 1;
        private var _rotation:Number = 0;

        public function Camera2D(_arg_1:Number, _arg_2:Number)
        {
            this.resizeCameraStage(_arg_1, _arg_2);
        }

        public function resizeCameraStage(_arg_1:Number, _arg_2:Number):void
        {
            this._sceneWidth = _arg_1;
            this._sceneHeight = _arg_2;
            this.invalidated = true;
            this.orthoProjectionMatrix = this.makeOrtographicMatrix(0, _arg_1, 0, _arg_2);
            var _local_3:Number = 60;
            var _local_4:Number = Math.tan(VectorUtil.deg2rad((_local_3 * 0.5)));
            var _local_5:Matrix3D = this.makeProjectionMatrix(0.1, 2000, _local_3, (_arg_1 / _arg_2));
            var _local_6:Vector3D = new Vector3D(0, 0, 0);
            var _local_7:Vector3D = new Vector3D(0, 0, (-(this._sceneHeight * 0.5) / _local_4));
            var _local_8:Matrix3D = this.lookAt(_local_6, _local_7);
            _local_8.append(_local_5);
            this.perspectiveProjectionMatrix = _local_8;
        }

        protected function lookAt(_arg_1:Vector3D, _arg_2:Vector3D):Matrix3D
        {
            var _local_3:Vector3D = new Vector3D();
            _local_3.x = Math.sin(0);
            _local_3.y = -(Math.cos(0));
            _local_3.z = 0;
            var _local_4:Vector3D = new Vector3D();
            _local_4.x = (_arg_1.x - _arg_2.x);
            _local_4.y = (_arg_1.y - _arg_2.y);
            _local_4.z = (_arg_1.z - _arg_2.z);
            _local_4.normalize();
            var _local_5:Vector3D = _local_3.crossProduct(_local_4);
            _local_5.normalize();
            _local_3 = _local_5.crossProduct(_local_4);
            _local_3.normalize();
            var _local_6:Vector.<Number> = new Vector.<Number>();
            _local_6.push(-(_local_5.x), -(_local_5.y), -(_local_5.z), 0, _local_3.x, _local_3.y, _local_3.z, 0, -(_local_4.x), -(_local_4.y), -(_local_4.z), 0, 0, 0, 0, 1);
            var _local_7:Matrix3D = new Matrix3D(_local_6);
            _local_7.prependTranslation(-(_arg_2.x), -(_arg_2.y), -(_arg_2.z));
            return (_local_7);
        }

        protected function makeProjectionMatrix(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Matrix3D
        {
            var _local_5:Number = (_arg_1 * Math.tan((_arg_3 * (Math.PI / 360))));
            var _local_6:Number = (_local_5 * _arg_4);
            return (this.makeFrustumMatrix(-(_local_6), _local_6, -(_local_5), _local_5, _arg_1, _arg_2));
        }

        protected function makeFrustumMatrix(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number):Matrix3D
        {
            return (new Matrix3D(Vector.<Number>([((2 * _arg_5) / (_arg_2 - _arg_1)), 0, ((_arg_2 + _arg_1) / (_arg_2 - _arg_1)), 0, 0, ((2 * _arg_5) / (_arg_3 - _arg_4)), ((_arg_3 + _arg_4) / (_arg_3 - _arg_4)), 0, 0, 0, (_arg_6 / (_arg_5 - _arg_6)), -1, 0, 0, ((_arg_5 * _arg_6) / (_arg_5 - _arg_6)), 0])));
        }

        protected function makeOrtographicMatrix(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number=0, _arg_6:Number=1):Matrix3D
        {
            return (new Matrix3D(Vector.<Number>([(2 / (_arg_2 - _arg_1)), 0, 0, 0, 0, (2 / (_arg_3 - _arg_4)), 0, 0, 0, 0, (1 / (_arg_6 - _arg_5)), 0, 0, 0, (_arg_5 / (_arg_5 - _arg_6)), 1])));
        }

        public function getViewProjectionMatrix(_arg_1:Boolean=true):Matrix3D
        {
            if (this.invalidated)
            {
                this.invalidated = false;
                this.viewMatrix.identity();
                this.viewMatrix.appendTranslation(((-(this.sceneWidth) / 2) - this.x), ((-(this.sceneHeight) / 2) - this.y), 0);
                this.viewMatrix.appendScale(this.zoom, this.zoom, 1);
                this.viewMatrix.appendRotation(this._rotation, Vector3D.Z_AXIS);
                this.renderMatrixOrtho.identity();
                this.renderMatrixOrtho.append(this.viewMatrix);
                this.renderMatrixPerspective.identity();
                this.renderMatrixPerspective.append(this.viewMatrix);
                this.renderMatrixOrtho.append(this.orthoProjectionMatrix);
                this.renderMatrixPerspective.append(this.perspectiveProjectionMatrix);
            };
            return ((_arg_1) ? this.renderMatrixOrtho : this.renderMatrixPerspective);
        }

        public function reset():void
        {
            this.x = (this.y = (this.rotation = 0));
            this.zoom = 1;
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function set x(_arg_1:Number):void
        {
            this.invalidated = true;
            this._x = _arg_1;
        }

        public function get y():Number
        {
            return (this._y);
        }

        public function set y(_arg_1:Number):void
        {
            this.invalidated = true;
            this._y = _arg_1;
        }

        public function get zoom():Number
        {
            return (this._zoom);
        }

        public function set zoom(_arg_1:Number):void
        {
            this.invalidated = true;
            this._zoom = _arg_1;
        }

        public function get rotation():Number
        {
            return (this._rotation);
        }

        public function set rotation(_arg_1:Number):void
        {
            this.invalidated = true;
            this._rotation = _arg_1;
        }

        public function get sceneWidth():Number
        {
            return (this._sceneWidth);
        }

        public function get sceneHeight():Number
        {
            return (this._sceneHeight);
        }


    }
}//package de.nulldesign.nd2d.display

