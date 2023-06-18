


//de.nulldesign.nd2d.display.Node2D

package de.nulldesign.nd2d.display
{
    import flash.events.EventDispatcher;
    import flash.geom.Matrix3D;
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.utils.NodeBlendMode;
    import de.nulldesign.nd2d.materials.BlendModePresets;
    import flash.geom.Vector3D;
    import flash.events.Event;
    import flash.display.Stage;
    import flash.geom.ColorTransform;
    import flash.geom.Point;
    import flash.events.TouchEvent;
    import flash.events.MouseEvent;
    import flash.display3D.Context3D;
    import de.nulldesign.nd2d.utils.StatsObject;
    import __AS3__.vec.*;

    public class Node2D extends EventDispatcher 
    {

        public var localModelMatrix:Matrix3D = new Matrix3D();
        public var worldModelMatrix:Matrix3D = new Matrix3D();
        public var invalidateMatrix:Boolean = true;
        public var invalidateVisibility:Boolean = true;
        public var invalidateColors:Boolean = true;
        public var hasPremultipliedAlphaTexture:Boolean = true;
        public var children:Vector.<Node2D> = new Vector.<Node2D>();
        public var parent:Node2D;
        public var vx:Number;
        public var vy:Number;
        public var tag:int = 0;
        public var blendMode:NodeBlendMode = BlendModePresets.NORMAL_PREMULTIPLIED_ALPHA;
        public var mouseEnabled:Boolean = false;
        public var boundingSphereRadius:Number;
        protected var timeSinceStartInSeconds:Number = 0;
        protected var camera:Camera2D;
        private var localMouse:Vector3D;
        private var localMouseMatrix:Matrix3D = new Matrix3D();
        internal var mouseInNode:Boolean = false;
        internal var mouseEvents:Vector.<Event>;
        protected var _stage:Stage;
        protected var _width:Number;
        protected var _height:Number;
        protected var _visible:Boolean = true;
        protected var _alpha:Number = 1;
        public var combinedColorTransform:ColorTransform = new ColorTransform();
        protected var _colorTransform:ColorTransform = new ColorTransform();
        protected var _tint:uint = 0xFFFFFF;
        protected var _scaleX:Number = 1;
        protected var _scaleY:Number = 1;
        protected var _x:Number = 0;
        protected var _y:Number = 0;
        protected var _z:Number = 0;
        protected var _position:Vector3D = new Vector3D(0, 0, 0);
        protected var _pivot:Point = new Point(0, 0);
        protected var _rotationX:Number = 0;
        protected var _rotationY:Number = 0;
        protected var _rotationZ:Number = 0;
        protected var _mouseX:Number = 0;
        protected var _mouseY:Number = 0;


        public function get stage():Stage
        {
            return (this._stage);
        }

        public function get width():Number
        {
            return (Math.abs((this._width * this._scaleX)));
        }

        public function set width(_arg_1:Number):void
        {
            this.scaleX = (_arg_1 / this._width);
        }

        public function get height():Number
        {
            return (Math.abs((this._height * this._scaleY)));
        }

        public function set height(_arg_1:Number):void
        {
            this.scaleY = (_arg_1 / this._height);
        }

        public function get visible():Boolean
        {
            return (this._visible);
        }

        public function set visible(_arg_1:Boolean):void
        {
            if (this._visible != _arg_1)
            {
                this._visible = _arg_1;
                this.invalidateVisibility = true;
            };
        }

        public function set alpha(_arg_1:Number):void
        {
            if (this._alpha != _arg_1)
            {
                this._alpha = _arg_1;
                this.invalidateColors = true;
                this.visible = (this._alpha > 0);
            };
        }

        public function get alpha():Number
        {
            return (this._alpha);
        }

        public function get colorTransform():ColorTransform
        {
            return (this._colorTransform);
        }

        public function set colorTransform(_arg_1:ColorTransform):void
        {
            if (this._colorTransform != _arg_1)
            {
                this._colorTransform = _arg_1;
                this.invalidateColors = true;
            };
        }

        public function get tint():uint
        {
            return (this._tint);
        }

        public function set tint(_arg_1:uint):void
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            if (this._tint != _arg_1)
            {
                this._tint = _arg_1;
                _local_2 = ((this._tint >> 16) / 0xFF);
                _local_3 = (((this._tint >> 8) & 0xFF) / 0xFF);
                _local_4 = ((this._tint & 0xFF) / 0xFF);
                this._colorTransform.redMultiplier = _local_2;
                this._colorTransform.greenMultiplier = _local_3;
                this._colorTransform.blueMultiplier = _local_4;
                this._colorTransform.alphaMultiplier = 1;
                this._colorTransform.redOffset = 0;
                this._colorTransform.greenOffset = 0;
                this._colorTransform.blueOffset = 0;
                this._colorTransform.alphaOffset = 0;
                this.invalidateColors = true;
            };
        }

        public function set scaleX(_arg_1:Number):void
        {
            if (this._scaleX != _arg_1)
            {
                this._scaleX = _arg_1;
                this.invalidateMatrix = true;
            };
        }

        public function get scaleX():Number
        {
            return (this._scaleX);
        }

        public function set scaleY(_arg_1:Number):void
        {
            if (this._scaleY != _arg_1)
            {
                this._scaleY = _arg_1;
                this.invalidateMatrix = true;
            };
        }

        public function get scaleY():Number
        {
            return (this._scaleY);
        }

        public function set x(_arg_1:Number):void
        {
            if (this._x != _arg_1)
            {
                this._position.x = (this._x = _arg_1);
                this.invalidateMatrix = true;
            };
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function set y(_arg_1:Number):void
        {
            if (this._y != _arg_1)
            {
                this._position.y = (this._y = _arg_1);
                this.invalidateMatrix = true;
            };
        }

        public function get y():Number
        {
            return (this._y);
        }

        public function set z(_arg_1:Number):void
        {
            if (this._z != _arg_1)
            {
                this._position.z = (this._z = _arg_1);
                this.invalidateMatrix = true;
            };
        }

        public function get z():Number
        {
            return (this._z);
        }

        public function get position():Vector3D
        {
            return (this._position);
        }

        public function set position(_arg_1:Vector3D):void
        {
            if ((((!(this._x == _arg_1.x)) || (!(this._y == _arg_1.y))) || (!(this._z == _arg_1.z))))
            {
                this._position.x = (this._x = _arg_1.x);
                this._position.y = (this._y = _arg_1.y);
                this._position.z = (this._z = _arg_1.z);
                this.invalidateMatrix = true;
            };
        }

        public function get pivot():Point
        {
            return (this._pivot);
        }

        public function set pivot(_arg_1:Point):void
        {
            if (((!(this._pivot.x == _arg_1.x)) || (!(this._pivot.y == _arg_1.y))))
            {
                this._pivot.x = _arg_1.x;
                this._pivot.y = _arg_1.y;
                this.invalidateMatrix = true;
            };
        }

        public function set rotation(_arg_1:Number):void
        {
            if (this._rotationZ != _arg_1)
            {
                this._rotationZ = _arg_1;
                this.invalidateMatrix = true;
            };
        }

        public function get rotation():Number
        {
            return (this._rotationZ);
        }

        public function set rotationX(_arg_1:Number):void
        {
            if (this._rotationX != _arg_1)
            {
                this._rotationX = _arg_1;
                this.invalidateMatrix = true;
            };
        }

        public function get rotationX():Number
        {
            return (this._rotationX);
        }

        public function set rotationY(_arg_1:Number):void
        {
            if (this._rotationY != _arg_1)
            {
                this._rotationY = _arg_1;
                this.invalidateMatrix = true;
            };
        }

        public function get rotationY():Number
        {
            return (this._rotationY);
        }

        public function set rotationZ(_arg_1:Number):void
        {
            if (this._rotationZ != _arg_1)
            {
                this._rotationZ = _arg_1;
                this.invalidateMatrix = true;
            };
        }

        public function get rotationZ():Number
        {
            return (this._rotationZ);
        }

        public function get mouseX():Number
        {
            return (this._mouseX);
        }

        public function get mouseY():Number
        {
            return (this._mouseY);
        }

        public function get numTris():uint
        {
            return (0);
        }

        public function get drawCalls():uint
        {
            return (0);
        }

        public function get numChildren():uint
        {
            return (this.children.length);
        }

        public function updateLocalMatrix():void
        {
            this.invalidateMatrix = false;
            this.localModelMatrix.identity();
            this.localModelMatrix.appendTranslation(-(this._pivot.x), -(this._pivot.y), 0);
            this.localModelMatrix.appendScale(this._scaleX, this._scaleY, 1);
            this.localModelMatrix.appendRotation(this._rotationZ, Vector3D.Z_AXIS);
            this.localModelMatrix.appendRotation(this._rotationY, Vector3D.Y_AXIS);
            this.localModelMatrix.appendRotation(this._rotationX, Vector3D.X_AXIS);
            this.localModelMatrix.appendTranslation(this._x, this._y, this._z);
        }

        public function updateWorldMatrix():void
        {
            this.worldModelMatrix.identity();
            this.worldModelMatrix.append(this.localModelMatrix);
            if (this.parent)
            {
                this.worldModelMatrix.append(this.parent.worldModelMatrix);
            };
        }

        public function updateColors():void
        {
            var _local_1:Node2D;
            this.invalidateColors = false;
            if (this.hasPremultipliedAlphaTexture)
            {
                this.combinedColorTransform.redMultiplier = (this._colorTransform.redMultiplier * this._alpha);
                this.combinedColorTransform.greenMultiplier = (this._colorTransform.greenMultiplier * this._alpha);
                this.combinedColorTransform.blueMultiplier = (this._colorTransform.blueMultiplier * this._alpha);
                this.combinedColorTransform.alphaMultiplier = (this._colorTransform.alphaMultiplier * this._alpha);
            }
            else
            {
                this.combinedColorTransform.redMultiplier = this._colorTransform.redMultiplier;
                this.combinedColorTransform.greenMultiplier = this._colorTransform.greenMultiplier;
                this.combinedColorTransform.blueMultiplier = this._colorTransform.blueMultiplier;
                this.combinedColorTransform.alphaMultiplier = (this._colorTransform.alphaMultiplier * this._alpha);
            };
            this.combinedColorTransform.redOffset = this._colorTransform.redOffset;
            this.combinedColorTransform.greenOffset = this._colorTransform.greenOffset;
            this.combinedColorTransform.blueOffset = this._colorTransform.blueOffset;
            this.combinedColorTransform.alphaOffset = this._colorTransform.alphaOffset;
            if (this.parent)
            {
                this.combinedColorTransform.concat(this.parent.combinedColorTransform);
            };
            for each (_local_1 in this.children)
            {
                _local_1.updateColors();
            };
        }

        internal function processMouseEvent(_arg_1:Vector3D, _arg_2:String, _arg_3:Matrix3D, _arg_4:Boolean, _arg_5:int):Node2D
        {
            var _local_7:Node2D;
            var _local_9:Boolean;
            var _local_10:Boolean;
            this.mouseEvents = new Vector.<Event>();
            var _local_6:Node2D;
            if (((this.mouseEnabled) && (_arg_2)))
            {
                this.localMouseMatrix.identity();
                this.localMouseMatrix.append(this.worldModelMatrix);
                this.localMouseMatrix.append(_arg_3);
                this.localMouseMatrix.invert();
                this.localMouse = this.localMouseMatrix.transformVector(_arg_1);
                this.localMouse.w = (1 / this.localMouse.w);
                this.localMouse.x = (this.localMouse.x / this.localMouse.w);
                this.localMouse.y = (this.localMouse.y / this.localMouse.w);
                this.localMouse.z = (this.localMouse.z / this.localMouse.w);
                this._mouseX = this.localMouse.x;
                this._mouseY = this.localMouse.y;
                _local_9 = this.mouseInNode;
                _local_10 = this.hitTest();
                if (_local_10)
                {
                    if (!_local_9)
                    {
                        if (_arg_4)
                        {
                            this.mouseEvents.push(new TouchEvent(TouchEvent.TOUCH_OVER, false, false, _arg_5, false, this.localMouse.x, this.localMouse.y));
                        }
                        else
                        {
                            this.mouseEvents.push(new MouseEvent(MouseEvent.MOUSE_OVER, false, false, this.localMouse.x, this.localMouse.y, null, false, false, false, (_arg_2 == MouseEvent.MOUSE_DOWN), 0));
                        };
                    };
                    if (_arg_4)
                    {
                        this.mouseEvents.push(new TouchEvent(_arg_2, false, false, _arg_5, false, this.localMouse.x, this.localMouse.y));
                    }
                    else
                    {
                        this.mouseEvents.push(new MouseEvent(_arg_2, false, false, this.localMouse.x, this.localMouse.y, null, false, false, false, (_arg_2 == MouseEvent.MOUSE_DOWN), 0));
                    };
                    _local_6 = this;
                }
                else
                {
                    if (_local_9)
                    {
                        if (_arg_4)
                        {
                            dispatchEvent(new TouchEvent(TouchEvent.TOUCH_OUT, false, false, _arg_5, false, this.localMouse.x, this.localMouse.y));
                        }
                        else
                        {
                            dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT, false, false, this.localMouse.x, this.localMouse.y, null, false, false, false, (_arg_2 == MouseEvent.MOUSE_DOWN), 0));
                        };
                    };
                };
            };
            var _local_8:Number = (this.children.length - 1);
            while (_local_8 >= 0)
            {
                _local_7 = this.children[_local_8].processMouseEvent(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
                if (_local_7)
                {
                    _local_6 = _local_7;
                    break;
                };
                _local_8--;
            };
            if (_local_6 != this)
            {
                this.mouseInNode = false;
            };
            return (_local_6);
        }

        protected function hitTest():Boolean
        {
            if (((isNaN(this._width)) || (isNaN(this._height))))
            {
                return (false);
            };
            var _local_1:Number = (this._width >> 1);
            var _local_2:Number = (this._height >> 1);
            return ((((this._mouseX >= -(_local_1)) && (this._mouseX <= _local_1)) && (this._mouseY >= -(_local_2))) && (this._mouseY <= _local_2));
        }

        internal function setStageAndCamRef(_arg_1:Stage, _arg_2:Camera2D):void
        {
            var _local_3:Node2D;
            if (this._stage != _arg_1)
            {
                this.camera = _arg_2;
                if (_arg_1)
                {
                    this._stage = _arg_1;
                    dispatchEvent(new Event(Event.ADDED_TO_STAGE));
                }
                else
                {
                    dispatchEvent(new Event(Event.REMOVED_FROM_STAGE));
                    this._stage = _arg_1;
                };
                for each (_local_3 in this.children)
                {
                    _local_3.setStageAndCamRef(_arg_1, _arg_2);
                };
            };
        }

        internal function stepNode(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Node2D;
            this.timeSinceStartInSeconds = _arg_2;
            this.step(_arg_1);
            for each (_local_3 in this.children)
            {
                _local_3.stepNode(_arg_1, _arg_2);
            };
        }

        public function handleDeviceLoss():void
        {
            var _local_1:Node2D;
            for each (_local_1 in this.children)
            {
                _local_1.handleDeviceLoss();
            };
        }

        internal function drawNode(_arg_1:Context3D, _arg_2:Camera2D, _arg_3:Boolean, _arg_4:StatsObject):void
        {
            var _local_6:Node2D;
            var _local_5:Boolean;
            if (!this._visible)
            {
                return;
            };
            if (this.invalidateColors)
            {
                this.updateColors();
            };
            if (this.invalidateMatrix)
            {
                this.updateLocalMatrix();
                _local_5 = true;
            };
            if (((_arg_3) || (_local_5)))
            {
                this.updateWorldMatrix();
                _local_5 = true;
            };
            this.draw(_arg_1, _arg_2);
            _arg_4.totalDrawCalls = (_arg_4.totalDrawCalls + this.drawCalls);
            _arg_4.totalTris = (_arg_4.totalTris + this.numTris);
            for each (_local_6 in this.children)
            {
                _local_6.drawNode(_arg_1, _arg_2, _local_5, _arg_4);
            };
        }

        protected function draw(_arg_1:Context3D, _arg_2:Camera2D):void
        {
        }

        protected function step(_arg_1:Number):void
        {
        }

        public function setChildIndex(_arg_1:Node2D, _arg_2:int):void
        {
            var _local_3:Node2D = this.getChildAt(_arg_2);
            if (_local_3 != null)
            {
                this.swapChildren(_arg_1, _local_3);
            };
        }

        public function addChild(_arg_1:Node2D):Node2D
        {
            return (this.addChildAt(_arg_1, this.children.length));
        }

        public function addChildAt(_arg_1:Node2D, _arg_2:uint):Node2D
        {
            var _local_3:int = this.getChildIndex(_arg_1);
            if (_local_3 != -1)
            {
                this.removeChildAt(_local_3);
            };
            _arg_1.parent = this;
            _arg_1.setStageAndCamRef(this._stage, this.camera);
            this.children.splice(_arg_2, 0, _arg_1);
            return (_arg_1);
        }

        public function removeChild(_arg_1:Node2D):void
        {
            var _local_2:int = this.children.indexOf(_arg_1);
            if (_local_2 >= 0)
            {
                this.removeChildAt(_local_2);
            };
        }

        public function removeChildAt(_arg_1:uint):void
        {
            if (_arg_1 < this.children.length)
            {
                this.children[_arg_1].parent = null;
                this.children[_arg_1].setStageAndCamRef(null, null);
                this.children.splice(_arg_1, 1);
            };
        }

        public function getChildAt(_arg_1:uint):Node2D
        {
            if (_arg_1 < this.children.length)
            {
                return (this.children[_arg_1]);
            };
            return (null);
        }

        public function getChildIndex(_arg_1:Node2D):int
        {
            return (this.children.indexOf(_arg_1));
        }

        public function swapChildren(_arg_1:Node2D, _arg_2:Node2D):void
        {
            var _local_3:uint = this.getChildIndex(_arg_1);
            var _local_4:uint = this.getChildIndex(_arg_2);
            this.children[_local_3] = _arg_2;
            this.children[_local_4] = _arg_1;
        }

        public function removeAllChildren():void
        {
            while (this.children.length > 0)
            {
                this.removeChildAt(0);
            };
        }

        public function getChildByTag(_arg_1:int):Node2D
        {
            var _local_2:Node2D;
            for each (_local_2 in this.children)
            {
                if (_local_2.tag == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function localToGlobal(_arg_1:Point):Point
        {
            var _local_2:Matrix3D = new Matrix3D();
            _local_2.append(this.worldModelMatrix);
            _local_2.append(this.camera.getViewProjectionMatrix());
            var _local_3:Vector3D = _local_2.transformVector(new Vector3D(_arg_1.x, _arg_1.y, 0));
            return (new Point((((_local_3.x + 1) * 0.5) * this.camera.sceneWidth), (((-(_local_3.y) + 1) * 0.5) * this.camera.sceneHeight)));
        }

        public function globalToLocal(_arg_1:Point):Point
        {
            var _local_2:Matrix3D = new Matrix3D();
            _local_2.append(this.worldModelMatrix);
            _local_2.append(this.camera.getViewProjectionMatrix());
            _local_2.invert();
            var _local_3:Vector3D = new Vector3D((((_arg_1.x / this.camera.sceneWidth) * 2) - 1), -(((_arg_1.y / this.camera.sceneHeight) * 2) - 1), 0, 1);
            var _local_4:Vector3D = _local_2.transformVector(_local_3);
            _local_4.w = (1 / _local_4.w);
            _local_4.x = (_local_4.x / _local_4.w);
            _local_4.y = (_local_4.y / _local_4.w);
            return (new Point(_local_4.x, _local_4.y));
        }

        public function dispose():void
        {
            var _local_1:Node2D;
            for each (_local_1 in this.children)
            {
                _local_1.dispose();
            };
        }


    }
}//package de.nulldesign.nd2d.display

