


//de.nulldesign.nd2d.display.World2D

package de.nulldesign.nd2d.display
{
    import flash.display.Sprite;
    import flash.display3D.Context3D;
    import flash.geom.Rectangle;
    import flash.geom.Vector3D;
    import de.nulldesign.nd2d.utils.StatsObject;
    import flash.events.Event;
    import flash.events.ErrorEvent;
    import flash.events.MouseEvent;
    import flash.ui.Multitouch;
    import flash.ui.MultitouchInputMode;
    import flash.events.TouchEvent;
    import flash.display3D.Context3DTriangleFace;
    import flash.display3D.Context3DCompareMode;
    import flash.utils.getTimer;
    import de.nulldesign.nd2d.materials.shader.ShaderCache;

    public class World2D extends Sprite 
    {

        public static var isHardwareAccelerated:Boolean;

        protected var camera:Camera2D = new Camera2D(1, 1);
        protected var context3D:Context3D;
        protected var stageID:uint;
        protected var scene:Scene2D;
        protected var frameRate:uint;
        protected var isPaused:Boolean = false;
        protected var bounds:Rectangle;
        protected var lastFramesTime:Number = 0;
        protected var enableErrorChecking:Boolean = false;
        protected var renderMode:String;
        protected var mousePosition:Vector3D = new Vector3D(0, 0, 0);
        protected var antialiasing:uint = 2;
        protected var deviceInitialized:Boolean = false;
        protected var deviceWasLost:Boolean = false;
        protected var statsObject:StatsObject = new StatsObject();
        internal var topMostMouseNode:Node2D;

        public function World2D(_arg_1:String, _arg_2:uint=60, _arg_3:Rectangle=null, _arg_4:uint=0)
        {
            this.renderMode = _arg_1;
            this.frameRate = _arg_2;
            this.bounds = _arg_3;
            this.stageID = _arg_4;
            addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
        }

        protected function addedToStage(_arg_1:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
            stage.addEventListener(Event.RESIZE, this.resizeStage);
            stage.frameRate = this.frameRate;
            stage.stage3Ds[this.stageID].addEventListener(Event.CONTEXT3D_CREATE, this.context3DCreated);
            stage.stage3Ds[this.stageID].addEventListener(ErrorEvent.ERROR, this.context3DError);
            stage.stage3Ds[this.stageID].requestContext3D(this.renderMode);
            stage.addEventListener(MouseEvent.CLICK, this.mouseEventHandler);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseEventHandler);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseEventHandler);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.mouseEventHandler);
            Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
            stage.addEventListener(TouchEvent.TOUCH_TAP, this.touchEventHandler);
            stage.addEventListener(TouchEvent.TOUCH_BEGIN, this.touchEventHandler);
            stage.addEventListener(TouchEvent.TOUCH_MOVE, this.touchEventHandler);
            stage.addEventListener(TouchEvent.TOUCH_END, this.touchEventHandler);
        }

        protected function context3DError(_arg_1:ErrorEvent):void
        {
            throw (new Error("The SWF is not embedded properly. The 3D context can't be created. Wrong WMODE? Set it to 'direct'."));
        }

        protected function context3DCreated(_arg_1:Event):void
        {
            this.context3D = stage.stage3Ds[this.stageID].context3D;
            this.context3D.enableErrorChecking = this.enableErrorChecking;
            this.context3D.setCulling(Context3DTriangleFace.NONE);
            this.context3D.setDepthTest(false, Context3DCompareMode.ALWAYS);
            isHardwareAccelerated = (this.context3D.driverInfo.toLowerCase().indexOf("software") == -1);
            this.resizeStage();
            if (this.deviceInitialized)
            {
                this.deviceWasLost = true;
            };
            this.deviceInitialized = true;
            if (this.scene)
            {
                this.scene.setStageAndCamRef(stage, this.camera);
            };
            dispatchEvent(new Event(Event.INIT));
        }

        protected function touchEventHandler(_arg_1:TouchEvent):void
        {
            var _local_2:String;
            var _local_3:Node2D;
            var _local_4:Event;
            if (((((this.scene) && (this.scene.mouseEnabled)) && (stage)) && (this.camera)))
            {
                _local_2 = _arg_1.type;
                this.mousePosition.x = ((((stage.mouseX - 0) / this.camera.sceneWidth) * 2) - 1);
                this.mousePosition.y = -((((stage.mouseY - 0) / this.camera.sceneHeight) * 2) - 1);
                this.mousePosition.z = 0;
                this.mousePosition.w = 1;
                _local_3 = this.scene.processMouseEvent(this.mousePosition, _local_2, this.camera.getViewProjectionMatrix(), true, _arg_1.touchPointID);
                if (_local_3)
                {
                    for each (_local_4 in _local_3.mouseEvents)
                    {
                        if (((this.topMostMouseNode) && (_local_4.type == TouchEvent.TOUCH_OVER)))
                        {
                            this.topMostMouseNode.mouseInNode = false;
                            this.topMostMouseNode.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_OUT, false, false, -1, false, this.topMostMouseNode.mouseX, this.topMostMouseNode.mouseY));
                            _local_3.mouseInNode = true;
                        };
                        _local_3.dispatchEvent(_local_4);
                    };
                    this.topMostMouseNode = _local_3;
                };
            };
        }

        protected function mouseEventHandler(_arg_1:MouseEvent):void
        {
            var _local_2:String;
            var _local_3:Node2D;
            var _local_4:Event;
            if (((((this.scene) && (this.scene.mouseEnabled)) && (stage)) && (this.camera)))
            {
                _local_2 = _arg_1.type;
                this.mousePosition.x = ((((stage.mouseX - 0) / this.camera.sceneWidth) * 2) - 1);
                this.mousePosition.y = -((((stage.mouseY - 0) / this.camera.sceneHeight) * 2) - 1);
                this.mousePosition.z = 0;
                this.mousePosition.w = 1;
                _local_3 = this.scene.processMouseEvent(this.mousePosition, _local_2, this.camera.getViewProjectionMatrix(), false, 0);
                if (_local_3)
                {
                    for each (_local_4 in _local_3.mouseEvents)
                    {
                        if (((this.topMostMouseNode) && (_local_4.type == MouseEvent.MOUSE_OVER)))
                        {
                            this.topMostMouseNode.mouseInNode = false;
                            this.topMostMouseNode.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT, false, false, this.topMostMouseNode.mouseX, this.topMostMouseNode.mouseY));
                            _local_3.mouseInNode = true;
                        };
                        _local_3.dispatchEvent(_local_4);
                    };
                    this.topMostMouseNode = _local_3;
                };
            };
        }

        protected function resizeStage(_arg_1:Event=null):void
        {
            if (!this.context3D)
            {
                return;
            };
            var _local_2:Rectangle = ((this.bounds) ? this.bounds : new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
            stage.stage3Ds[this.stageID].x = _local_2.x;
            stage.stage3Ds[this.stageID].y = _local_2.y;
            this.context3D.configureBackBuffer(_local_2.width, _local_2.height, this.antialiasing, false);
            this.camera.resizeCameraStage(_local_2.width, _local_2.height);
        }

        protected function mainLoop(_arg_1:Event):void
        {
            var _local_2:Number = (getTimer() * 0.001);
            var _local_3:Number = (_local_2 - this.lastFramesTime);
            if (((this.scene) && (this.context3D)))
            {
                this.context3D.clear(this.scene.br, this.scene.bg, this.scene.bb, 1);
                if (!this.isPaused)
                {
                    this.scene.stepNode(_local_3, _local_2);
                };
                if (this.deviceWasLost)
                {
                    ShaderCache.getInstance().handleDeviceLoss();
                    this.scene.handleDeviceLoss();
                    this.deviceWasLost = false;
                };
                this.statsObject.totalDrawCalls = 0;
                this.statsObject.totalTris = 0;
                this.scene.drawNode(this.context3D, this.camera, false, this.statsObject);
                this.context3D.present();
            };
            this.lastFramesTime = _local_2;
        }

        public function setActiveScene(_arg_1:Scene2D):void
        {
            if (this.scene)
            {
                this.scene.setStageAndCamRef(null, null);
            };
            this.scene = _arg_1;
            if (this.scene)
            {
                this.scene.setStageAndCamRef(stage, this.camera);
            };
        }

        public function start():void
        {
            this.wakeUp();
        }

        public function pause():void
        {
            this.isPaused = true;
        }

        public function resume():void
        {
            this.isPaused = false;
        }

        public function sleep():void
        {
            removeEventListener(Event.ENTER_FRAME, this.mainLoop);
            if (this.context3D)
            {
                this.context3D.clear(this.scene.br, this.scene.bg, this.scene.bb, 1);
                this.context3D.present();
            };
        }

        public function wakeUp():void
        {
            removeEventListener(Event.ENTER_FRAME, this.mainLoop);
            addEventListener(Event.ENTER_FRAME, this.mainLoop);
        }

        public function dispose():void
        {
            this.sleep();
            stage.removeEventListener(Event.RESIZE, this.resizeStage);
            var _local_1:int;
            while (_local_1 < stage.stage3Ds.length)
            {
                stage.stage3Ds[_local_1].removeEventListener(Event.CONTEXT3D_CREATE, this.context3DCreated);
                stage.stage3Ds[_local_1].removeEventListener(ErrorEvent.ERROR, this.context3DError);
                _local_1++;
            };
            stage.removeEventListener(MouseEvent.CLICK, this.mouseEventHandler);
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseEventHandler);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseEventHandler);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.mouseEventHandler);
            stage.removeEventListener(TouchEvent.TOUCH_TAP, this.touchEventHandler);
            stage.removeEventListener(TouchEvent.TOUCH_BEGIN, this.touchEventHandler);
            stage.removeEventListener(TouchEvent.TOUCH_MOVE, this.touchEventHandler);
            stage.removeEventListener(TouchEvent.TOUCH_END, this.touchEventHandler);
            if (this.context3D)
            {
                this.context3D.dispose();
            };
            if (this.scene)
            {
                this.scene.dispose();
            };
        }


    }
}//package de.nulldesign.nd2d.display

