


//de.nulldesign.nd2d.display.Scene2D

package de.nulldesign.nd2d.display
{
    import flash.display3D.Context3D;
    import de.nulldesign.nd2d.utils.StatsObject;
    import flash.geom.Vector3D;
    import flash.geom.Matrix3D;
    import flash.display.Stage;

    public class Scene2D extends Node2D 
    {

        internal var br:Number = 0;
        internal var bg:Number = 0;
        internal var bb:Number = 0;
        private var _backGroundColor:Number = 0;
        protected var sceneGUICamera:Camera2D = new Camera2D(1, 1);
        protected var sceneGUILayer:Node2D = new Node2D();

        public function Scene2D()
        {
            mouseEnabled = true;
        }

        public function get backGroundColor():Number
        {
            return (this._backGroundColor);
        }

        public function set backGroundColor(_arg_1:Number):void
        {
            this._backGroundColor = _arg_1;
            this.br = ((this.backGroundColor >> 16) / 0xFF);
            this.bg = (((this.backGroundColor >> 8) & 0xFF) / 0xFF);
            this.bb = ((this.backGroundColor & 0xFF) / 0xFF);
        }

        override public function handleDeviceLoss():void
        {
            super.handleDeviceLoss();
            this.sceneGUILayer.handleDeviceLoss();
        }

        override internal function drawNode(_arg_1:Context3D, _arg_2:Camera2D, _arg_3:Boolean, _arg_4:StatsObject):void
        {
            var _local_5:Node2D;
            for each (_local_5 in children)
            {
                _local_5.drawNode(_arg_1, _arg_2, false, _arg_4);
            };
            if (this.sceneGUICamera.sceneWidth != _arg_2.sceneWidth)
            {
                this.sceneGUICamera.resizeCameraStage(_arg_2.sceneWidth, _arg_2.sceneHeight);
            };
            this.sceneGUILayer.drawNode(_arg_1, this.sceneGUICamera, false, _arg_4);
        }

        override internal function processMouseEvent(_arg_1:Vector3D, _arg_2:String, _arg_3:Matrix3D, _arg_4:Boolean, _arg_5:int):Node2D
        {
            var _local_6:Node2D = super.processMouseEvent(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            var _local_7:Node2D = this.sceneGUILayer.processMouseEvent(_arg_1, _arg_2, this.sceneGUICamera.getViewProjectionMatrix(), _arg_4, _arg_5);
            return ((_local_7) ? _local_7 : _local_6);
        }

        override internal function setStageAndCamRef(_arg_1:Stage, _arg_2:Camera2D):void
        {
            super.setStageAndCamRef(_arg_1, _arg_2);
            if (camera)
            {
                _width = camera.sceneWidth;
                _height = camera.sceneHeight;
            };
        }

        override protected function hitTest():Boolean
        {
            return ((((_mouseX >= 0) && (_mouseX <= _width)) && (_mouseY >= 0)) && (_mouseY <= _height));
        }


    }
}//package de.nulldesign.nd2d.display

