


//hbm.Engine.Renderer.RenderSystem

package hbm.Engine.Renderer
{
    import net.hires.debug.Stats;
    import flash.display.BitmapData;
    import de.nulldesign.nd2d.display.Scene2D;
    import de.nulldesign.nd2d.display.World2D;
    import hbm.Application.ClientApplication;

    public class RenderSystem 
    {

        private static var _singleton:RenderSystem;
        private static var _isSingletonLock:Boolean = false;
        private static var _performanceInfo:Stats = new Stats();

        private var _screenWidth:uint = 800;
        private var _screenHeight:uint = 600;
        private var _isDrawBloom:Boolean = true;
        private var _camera:Camera;
        private var _objectStorage:Array;
        private var _backBuffer:BitmapData;
        private var _bloomFilter:BloomFilter;
        private var _mainScene:Scene2D;
        private var _world2DRender:World2D;
        private var _snow:Snow;

        public function RenderSystem()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access. Use RenderSystem.Instance."));
            };
            this._camera = new Camera();
            this._objectStorage = new Array();
            this._bloomFilter = new BloomFilter();
            this._screenWidth = ClientApplication.Instance.GameStageWidth;
            this.CreateBitmapData();
        }

        public static function get Instance():RenderSystem
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (RenderSystem)();
                _isSingletonLock = false;
            };
            return (_singleton);
        }


        public function get MainCamera():Camera
        {
            return (this._camera);
        }

        private function CreateBitmapData():void
        {
            if (this._backBuffer != null)
            {
                this._backBuffer.dispose();
            };
            this._backBuffer = new BitmapData(this._screenWidth, this._screenHeight);
        }

        public function get BackBuffer():BitmapData
        {
            return (this._backBuffer);
        }

        public function get ScreenWidth():uint
        {
            return (this._screenWidth);
        }

        public function get ScreenHeight():uint
        {
            return (this._screenHeight);
        }

        public function UpdateScreenSize(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            this._screenWidth = _arg_3;
            this._screenHeight = _arg_4;
            this.CreateBitmapData();
        }

        public function AddRenderObject(_arg_1:RenderObject):void
        {
            this._objectStorage.push(_arg_1);
        }

        public function RemoveRenderObject(_arg_1:RenderObject):void
        {
            var _local_2:int = this._objectStorage.indexOf(_arg_1);
            if (_local_2 != -1)
            {
                this._objectStorage.splice(_local_2, 1);
            };
        }

        public function ClearRenderObjects():void
        {
            this._objectStorage = new Array();
        }

        public function Update(_arg_1:Number):void
        {
            var _local_2:RenderObject;
            this._objectStorage.sortOn("Priority", Array.NUMERIC);
            this._backBuffer.lock();
            for each (_local_2 in this._objectStorage)
            {
                if (_local_2 != null)
                {
                    if (((_local_2.IsVisible) && (_local_2.Priority < 100000)))
                    {
                        _local_2.Draw(this._camera, this._backBuffer);
                    };
                };
            };
            if (this.IsDrawBloom)
            {
                this._bloomFilter.Process(this._backBuffer);
            };
            for each (_local_2 in this._objectStorage)
            {
                if (_local_2 != null)
                {
                    if (((_local_2.IsVisible) && (_local_2.Priority >= 100000)))
                    {
                        if (_local_2.Priority == 100000)
                        {
                            if (this.IsDrawBloom)
                            {
                                _local_2.Draw(this._camera, this._backBuffer);
                            };
                        }
                        else
                        {
                            _local_2.Draw(this._camera, this._backBuffer);
                        };
                    };
                };
            };
            this._backBuffer.unlock();
        }

        public function get IsDrawBloom():Boolean
        {
            return (this._isDrawBloom);
        }

        public function set IsDrawBloom(_arg_1:Boolean):void
        {
            this._isDrawBloom = _arg_1;
        }


    }
}//package hbm.Engine.Renderer

