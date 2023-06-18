


//hbm.Game.Renderer.Background

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderObject;
    import br.com.stimuli.loading.BulkLoader;
    import flash.system.LoaderContext;
    import flash.utils.Dictionary;
    import hbm.Application.ClientApplication;
    import hbm.Application.ClientConfig;
    import flash.system.SecurityDomain;
    import flash.system.ApplicationDomain;
    import flash.system.ImageDecodingPolicy;
    import flash.display.BitmapData;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.utils.ByteArray;
    import hbm.Engine.Collision.MapCollisionManager;
    import flash.events.Event;
    import flash.display.Bitmap;
    import flash.display.Loader;
    import hbm.Engine.Renderer.Camera;

    public class Background extends RenderObject 
    {

        private var _dataLoader:BulkLoader;
        private var _lastBaseName:String = "";
        private var _loaderContext:LoaderContext;
        private var _newImageFormatLoaderContext:LoaderContext;
        private var _newImageFormatCounter:uint = 0;
        private var _lastLocationImagesWidth:uint = 16;
        private var _lastLocationImagesHeight:uint = 12;
        private var _lastBackgroundTileWidth:uint = 0x0100;
        private var _lastBackgroundTileHeight:uint = 0x0100;
        private var _staticObjectList:Array = new Array();
        private var _bitmapBufferData:Array = new Array();
        private var _bitmapLoaderData:Array = new Array();
        private var _loadedMapList:Dictionary = new Dictionary();

        public function Background()
        {
            Priority = 0;
            var _local_1:ClientConfig = ClientApplication.Instance.Config;
            var _local_2:* = ((_local_1.CurrentPlatformId == ClientConfig.STANDALONE) ? SecurityDomain.currentDomain : null);
            this._newImageFormatLoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, _local_2);
            this._newImageFormatLoaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
        }

        private function GetCellBitmapData(_arg_1:uint, _arg_2:uint):BitmapData
        {
            if (((((_arg_1 < 0) || (_arg_2 < 0)) || (_arg_1 >= this._lastLocationImagesWidth)) || (_arg_2 >= this._lastLocationImagesHeight)))
            {
                return (null);
            };
            var _local_3:uint = (_arg_1 + (_arg_2 * this._lastLocationImagesWidth));
            return (this._bitmapBufferData[_local_3]);
        }

        private function ClearLoadedData():void
        {
            var _local_1:StaticObject;
            var _local_2:BitmapData;
            this._loaderContext = null;
            for each (_local_1 in this._staticObjectList)
            {
                if (_local_1 != null)
                {
                    RenderSystem.Instance.RemoveRenderObject(_local_1);
                    _local_1.Release();
                };
            };
            for each (_local_2 in this._bitmapBufferData)
            {
                if (_local_2 != null)
                {
                    _local_2.dispose();
                };
            };
            this._newImageFormatCounter = 0;
            this._bitmapLoaderData = new Array();
            this._staticObjectList = new Array();
            this._bitmapBufferData = new Array();
        }

        private function DrawStaticObject(_arg_1:BitmapData, _arg_2:Point, _arg_3:Rectangle):void
        {
            var _local_10:int;
            var _local_11:uint;
            var _local_12:int;
            var _local_13:BitmapData;
            var _local_14:Rectangle;
            var _local_15:Rectangle;
            var _local_16:Point;
            var _local_17:Rectangle;
            var _local_4:uint = uint((_arg_2.x / this._lastBackgroundTileWidth));
            var _local_5:uint = uint((_arg_2.y / this._lastBackgroundTileHeight));
            var _local_6:uint = uint((((_arg_2.x + _arg_3.width) / this._lastBackgroundTileWidth) + 1));
            var _local_7:uint = uint((((_arg_2.y + _arg_3.height) / this._lastBackgroundTileHeight) + 1));
            if (_local_4 < 0)
            {
                _local_4 = 0;
            };
            if (_local_5 < 0)
            {
                _local_5 = 0;
            };
            if (_local_6 >= this._lastLocationImagesWidth)
            {
                _local_6 = (this._lastLocationImagesWidth - 1);
            };
            if (_local_7 >= this._lastLocationImagesHeight)
            {
                _local_7 = (this._lastLocationImagesHeight - 1);
            };
            var _local_8:Rectangle = new Rectangle(_arg_2.x, _arg_2.y, _arg_3.width, _arg_3.height);
            var _local_9:uint = _local_5;
            while (_local_9 <= _local_7)
            {
                _local_10 = (_local_9 * this._lastBackgroundTileHeight);
                _local_11 = _local_4;
                while (_local_11 <= _local_6)
                {
                    _local_12 = (_local_11 * this._lastBackgroundTileWidth);
                    _local_13 = this.GetCellBitmapData(_local_11, _local_9);
                    _local_14 = new Rectangle(_local_12, _local_10, this._lastBackgroundTileWidth, this._lastBackgroundTileHeight);
                    _local_15 = _local_8.intersection(_local_14);
                    _local_16 = new Point((_local_15.x - _local_8.x), (_local_15.y - _local_8.y));
                    _local_17 = new Rectangle((_local_15.x - _local_12), (_local_15.y - _local_10), _local_15.width, _local_15.height);
                    if (((_local_17.width > 0) && (_local_17.height > 0)))
                    {
                        _arg_1.copyPixels(_local_13, _local_17, _local_16, _arg_1, _local_16, false);
                    };
                    _local_11++;
                };
                _local_9++;
            };
        }

        private function LoadCollisionData():void
        {
            var _local_1:Class;
            var _local_2:String;
            var _local_3:Class;
            var _local_4:ByteArray;
            if (MapCollisionManager.Instance.GetMapCollisionByName(this._lastBaseName) == null)
            {
                _local_1 = (this._loaderContext.applicationDomain.getDefinition(this._lastBaseName) as Class);
                if (_local_1 == null)
                {
                    return;
                };
                _local_2 = (this._lastBaseName + "_Collision");
                _local_3 = (this._loaderContext.applicationDomain.getDefinition(_local_2) as Class);
                if (_local_3 == null)
                {
                    return;
                };
                _local_4 = new (_local_3)();
                if (_local_4 == null)
                {
                    return;
                };
                MapCollisionManager.Instance.SetCollisionData(this._lastBaseName, _local_4);
            };
            MapCollisionManager.Instance.SelectCurrentMap(this._lastBaseName);
        }

        private function LoadStaticObjects():void
        {
            var _local_5:Object;
            var _local_6:Point;
            var _local_7:Rectangle;
            var _local_8:String;
            var _local_9:String;
            var _local_10:Class;
            var _local_11:Point;
            var _local_12:ByteArray;
            var _local_13:uint;
            var _local_14:uint;
            var _local_15:ByteArray;
            var _local_16:uint;
            var _local_17:uint;
            var _local_18:BitmapData;
            var _local_19:StaticObject;
            var _local_20:int;
            var _local_21:uint;
            var _local_1:Class = (this._loaderContext.applicationDomain.getDefinition(this._lastBaseName) as Class);
            if (_local_1 == null)
            {
                return;
            };
            var _local_2:uint = uint((RenderSystem.Instance.MainCamera.MaxWidth / 2));
            var _local_3:uint = uint((RenderSystem.Instance.MainCamera.MaxHeight / 2));
            var _local_4:Array = (_local_1.ObjectList as Array);
            for each (_local_5 in _local_4)
            {
                _local_6 = _local_5["offset"];
                _local_7 = _local_5["rect"];
                _local_8 = _local_5["name"];
                if (!(((_local_6 == null) || (_local_7 == null)) || (_local_8 == null)))
                {
                    _local_9 = ((this._lastBaseName + "_Item_") + _local_8);
                    _local_10 = (this._loaderContext.applicationDomain.getDefinition(_local_9) as Class);
                    if (_local_10 != null)
                    {
                        _local_11 = new Point(((_local_2 + _local_6.x) - (_local_7.width / 2)), ((_local_3 + _local_6.y) - (_local_7.height / 2)));
                        _local_12 = new (_local_10)();
                        _local_12.position = 0;
                        _local_13 = _local_12.length;
                        _local_14 = 0;
                        _local_15 = new ByteArray();
                        _local_16 = (_local_7.width * _local_7.height);
                        _local_17 = 0;
                        while (_local_17 < _local_13)
                        {
                            _local_20 = _local_12.readByte();
                            _local_21 = 0;
                            while (_local_21 < 8)
                            {
                                if (_local_14 >= _local_16) break;
                                if ((_local_20 & (1 << _local_21)) > 0)
                                {
                                    _local_15.writeInt(3372220415);
                                }
                                else
                                {
                                    _local_15.writeInt(0);
                                };
                                _local_21++;
                            };
                            _local_17++;
                        };
                        _local_15.position = 0;
                        _local_18 = new BitmapData(_local_7.width, _local_7.height, true, 0);
                        _local_18.setPixels(_local_7, _local_15);
                        this.DrawStaticObject(_local_18, _local_11, _local_7);
                        _local_19 = new StaticObject(_local_8, _local_6, _local_7, _local_18);
                        this._staticObjectList.push(_local_19);
                        RenderSystem.Instance.AddRenderObject(_local_19);
                        _local_19.Position = _local_11;
                        _local_19.Priority = (_local_11.y + _local_7.width);
                    };
                };
            };
        }

        public function LoadLocationData(_arg_1:Object):Boolean
        {
            var _local_2:String;
            _local_2 = _arg_1["GraphicsName"];
            var _local_3:int = int(_arg_1["NumImages"]);
            var _local_4:int = int(_arg_1["NumCellsWidth"]);
            this.ClearLoadedData();
            this._lastBaseName = _local_2;
            this._dataLoader = BulkLoader.getLoader("main-site");
            this._dataLoader.logLevel = BulkLoader.LOG_SILENT;
            var _local_5:uint = uint((_local_3 / _local_4));
            this._lastLocationImagesWidth = _local_4;
            this._lastLocationImagesHeight = _local_5;
            this._bitmapBufferData = new Array(_local_3);
            var _local_6:LoaderContext = (this._loadedMapList[_local_2] as LoaderContext);
            if (_local_6 != null)
            {
                this._loaderContext = _local_6;
                return (true);
            };
            this._dataLoader.addEventListener(BulkLoader.COMPLETE, this.OnAllItemsLoaded, false, 0, true);
            var _local_7:ClientConfig = ClientApplication.Instance.Config;
            if (_local_7.CurrentPlatformId == ClientConfig.STANDALONE)
            {
                this._loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
            }
            else
            {
                this._loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
            };
            this._loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
            var _local_8:String = ClientApplication.Instance.Config.GetFileURL(_local_2);
            this._dataLoader.add(_local_8, {
                "context":this._loaderContext,
                "type":BulkLoader.TYPE_MOVIECLIP
            });
            this._dataLoader.start();
            return (false);
        }

        public function LoadLocationDataInternal():void
        {
            this.OnAllItemsLoaded(null);
        }

        private function IsNewImageFormat():Boolean
        {
            var _local_1:String;
            _local_1 = (String(this._lastBaseName) + "_Back_0001");
            return (this._loaderContext.applicationDomain.hasDefinition(_local_1));
        }

        protected function NewImageFormatLoaded(_arg_1:Event):void
        {
            var _local_2:uint = this._bitmapBufferData.length;
            _arg_1.currentTarget.removeEventListener(Event.COMPLETE, this.NewImageFormatLoaded);
            if (++this._newImageFormatCounter == _local_2)
            {
                this.OnNewImageFormatFilesLoaded();
            };
        }

        private function OnNewImageFormatFilesLoaded():void
        {
            var _local_3:Bitmap;
            var _local_4:uint;
            var _local_5:uint;
            var _local_1:uint = this._bitmapBufferData.length;
            var _local_2:uint;
            while (_local_2 < _local_1)
            {
                _local_3 = Bitmap(this._bitmapLoaderData[_local_2].content);
                this._bitmapBufferData[_local_2] = _local_3.bitmapData;
                this._bitmapLoaderData[_local_2].unload();
                _local_4 = (_local_2 % this._lastLocationImagesWidth);
                _local_5 = uint((_local_2 / this._lastLocationImagesWidth));
                _local_3.x = (_local_4 * _local_3.width);
                _local_3.y = (_local_5 * _local_3.height);
                this._lastBackgroundTileWidth = _local_3.width;
                this._lastBackgroundTileHeight = _local_3.height;
                _local_2++;
            };
            this._bitmapLoaderData = new Array();
            RenderSystem.Instance.MainCamera.MaxWidth = (this._lastLocationImagesWidth * this._lastBackgroundTileWidth);
            RenderSystem.Instance.MainCamera.MaxHeight = (this._lastLocationImagesHeight * this._lastBackgroundTileHeight);
            this.LoadStaticObjects();
            this.LoadCollisionData();
            ClientApplication.Instance.OnBackgroundLoaded();
        }

        private function OnAllItemsLoaded(_arg_1:Event):void
        {
            var _local_6:String;
            var _local_7:uint;
            var _local_8:String;
            var _local_9:Class;
            var _local_10:ByteArray;
            var _local_11:Bitmap;
            var _local_12:uint;
            var _local_13:uint;
            if (_arg_1 != null)
            {
                this._loadedMapList[this._lastBaseName] = this._loaderContext;
            };
            var _local_2:Boolean = this.IsNewImageFormat();
            var _local_3:* = "_Back_";
            var _local_4:uint = this._bitmapBufferData.length;
            if (!_local_2)
            {
                _local_3 = "_Item_";
            };
            var _local_5:uint = 1;
            while (_local_5 <= _local_4)
            {
                _local_6 = String(_local_5);
                if (_local_5 < 10)
                {
                    _local_6 = (String("000") + _local_6);
                }
                else
                {
                    if (_local_5 < 100)
                    {
                        _local_6 = (String("00") + _local_6);
                    }
                    else
                    {
                        if (_local_5 < 1000)
                        {
                            _local_6 = (String("0") + _local_6);
                        };
                    };
                };
                _local_7 = (_local_5 - 1);
                _local_8 = ((String(this._lastBaseName) + _local_3) + _local_6);
                _local_9 = (this._loaderContext.applicationDomain.getDefinition(_local_8) as Class);
                if (_local_2)
                {
                    _local_10 = (new (_local_9)() as ByteArray);
                    this._bitmapLoaderData[_local_7] = new Loader();
                    this._bitmapLoaderData[_local_7].contentLoaderInfo.addEventListener(Event.COMPLETE, this.NewImageFormatLoaded);
                    this._bitmapLoaderData[_local_7].loadBytes(_local_10, this._newImageFormatLoaderContext);
                }
                else
                {
                    _local_11 = new (_local_9)();
                    if (_local_11 != null)
                    {
                        this._bitmapBufferData[_local_7] = _local_11.bitmapData;
                        _local_12 = (_local_7 % this._lastLocationImagesWidth);
                        _local_13 = uint((_local_7 / this._lastLocationImagesWidth));
                        _local_11.x = (_local_12 * _local_11.width);
                        _local_11.y = (_local_13 * _local_11.height);
                        this._lastBackgroundTileWidth = _local_11.width;
                        this._lastBackgroundTileHeight = _local_11.height;
                    };
                };
                _local_5++;
            };
            if (!_local_2)
            {
                RenderSystem.Instance.MainCamera.MaxWidth = (this._lastLocationImagesWidth * this._lastBackgroundTileWidth);
                RenderSystem.Instance.MainCamera.MaxHeight = (this._lastLocationImagesHeight * this._lastBackgroundTileHeight);
                this.LoadStaticObjects();
                this.LoadCollisionData();
                ClientApplication.Instance.OnBackgroundLoaded();
            };
            this._dataLoader.removeEventListener(BulkLoader.COMPLETE, this.OnAllItemsLoaded);
        }

        override public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            var _local_16:BitmapData;
            var _local_3:Number = _arg_1.TopLeftPoint.x;
            var _local_4:Number = _arg_1.TopLeftPoint.y;
            var _local_5:uint = (uint(_local_3) % this._lastBackgroundTileWidth);
            var _local_6:uint = (uint(_local_4) % this._lastBackgroundTileHeight);
            var _local_7:uint = uint((uint(_local_3) / this._lastBackgroundTileWidth));
            var _local_8:uint = uint((uint(_local_4) / this._lastBackgroundTileHeight));
            var _local_9:uint = _local_7;
            var _local_10:uint = _local_8;
            var _local_11:uint;
            var _local_12:uint;
            var _local_13:Point = new Point(0, 0);
            var _local_14:Rectangle = new Rectangle(0, 0, this._lastBackgroundTileWidth, this._lastBackgroundTileHeight);
            var _local_15:BitmapData = this.GetCellBitmapData(0, 0);
            if (_local_15 == null)
            {
                return;
            };
            while (_local_12 < RenderSystem.Instance.ScreenHeight)
            {
                _local_16 = this.GetCellBitmapData(_local_9, _local_10);
                _local_14.x = 0;
                _local_14.y = 0;
                _local_14.width = this._lastBackgroundTileWidth;
                _local_14.height = this._lastBackgroundTileHeight;
                if (_local_9 == _local_7)
                {
                    _local_14.left = _local_5;
                };
                if (_local_10 == _local_8)
                {
                    _local_14.top = _local_6;
                };
                if ((_local_14.left + _local_14.width) >= _arg_2.width)
                {
                    _local_14.width = (_arg_2.width - _local_14.left);
                };
                if ((_local_14.top + _local_14.height) >= _arg_2.height)
                {
                    _local_14.height = (_arg_2.height - _local_14.top);
                };
                _local_13.x = _local_11;
                _local_13.y = _local_12;
                if (_local_16 != null)
                {
                    _arg_2.copyPixels(_local_16, _local_14, _local_13);
                };
                _local_9++;
                _local_11 = (_local_11 + _local_14.width);
                if (_local_11 >= RenderSystem.Instance.ScreenWidth)
                {
                    _local_9 = _local_7;
                    _local_10++;
                    _local_11 = 0;
                    _local_12 = (_local_12 + _local_14.height);
                };
            };
        }


    }
}//package hbm.Game.Renderer

