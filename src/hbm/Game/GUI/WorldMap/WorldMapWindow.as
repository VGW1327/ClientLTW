


//hbm.Game.GUI.WorldMap.WorldMapWindow

package hbm.Game.GUI.WorldMap
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import flash.geom.Point;
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilterQuality;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JLabel;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.utils.Dictionary;
    import flash.geom.Matrix;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import org.aswing.JPopupMenu;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import flash.events.MouseEvent;
    import org.aswing.JPanel;
    import org.aswing.EmptyLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.SoftBoxLayout;
    import org.aswing.BorderLayout;
    import flash.events.Event;
    import org.aswing.JMenuItem;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import org.aswing.event.AWEvent;
    import flash.utils.ByteArray;
    import flash.text.TextField;
    import hbm.Game.Utility.HtmlText;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;
    import flash.text.GridFitType;

    public class WorldMapWindow extends CustomWindow 
    {

        private static const _correctionPoint:Point = new Point(5, 5);
        private static var _glowFilter:GlowFilter = new GlowFilter(0xFF0000, 0.9, 10, 10, 2, BitmapFilterQuality.LOW);
        private static const _zeroPoint:Point = new Point(0, 0);

        private const MAP_SHOW_TIME:int = 10000;
        private const MAP_UPDATE_TIME:int = 250;
        private const _width:int = 920;
        private const _height:int = 473;

        private var _lastFrameTickTime:uint = 0;
        private var _lastOpenMapFrameTickTime:uint = 0;
        private var _frameTickTime:uint = 0;
        private var _plusButton:CustomButton;
        private var _minusButton:CustomButton;
        private var _zoomLabel:JLabel;
        private var _descLabel:JLabel;
        private var _map:Bitmap;
        private var _mapOpenDataCash:BitmapData;
        private var _mapWithObjectsDataCash:BitmapData;
        private var _mapBuffer:BitmapData;
        private var _mapObjectBitmaps:Dictionary;
        private var _position:Point;
        private var _matrix:Matrix;
        private var _mapPanel_center:Sprite;
        private var _zoom:Number = 0.5;
        private var _prevZoom:Number = 0.5;
        private var _lastDrawRect:Rectangle = null;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localizationLibrary:LocalizationResourceLibrary;
        private var _lastMapCollided:String;
        private var _menuNavigation:JPopupMenu;

        public function WorldMapWindow()
        {
            super(null, ClientApplication.Localization.WORLD_MAP_WINDOW_TITLE, false, this._width, this._height, true);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_8:Object;
            var _local_9:Bitmap;
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            this._map = this._localizationLibrary.GetBitmapAsset("Localization_Item_WorldMap");
            this._mapOpenDataCash = this._map.bitmapData.clone();
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_2:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            this._mapPanel_center = new Sprite();
            this._mapPanel_center.addChild(this._map);
            this._mapPanel_center.addEventListener(MouseEvent.MOUSE_OUT, this.OnMouseUp, false, 0, true);
            this._mapPanel_center.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown, false, 0, true);
            this._mapPanel_center.addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
            this._mapPanel_center.addEventListener(MouseEvent.CLICK, this.OnClick, false, 0, true);
            var _local_3:Sprite = new Sprite();
            _local_3.addChild(this._mapPanel_center);
            var _local_4:JPanel = new JPanel(new EmptyLayout());
            _local_4.addChild(_local_3);
            _local_4.setPreferredSize(new IntDimension((this._width - 10), (this._height - 10)));
            this._menuNavigation = new JPopupMenu();
            this._menuNavigation.addMenuItem(ClientApplication.Localization.WORLD_MAP_NAVIGATION_MENU).addActionListener(this.OnNavigationMap);
            var _local_5:CustomButton = new CustomButton(ClientApplication.Localization.WORLD_MAP_CANCEL_NAVIGATION);
            _local_5.setPreferredWidth(150);
            _local_5.setPreferredHeight(24);
            _local_5.addActionListener(this.OnNavigationMap, 0, true);
            this._descLabel = new JLabel("");
            this._descLabel.setWidth(100);
            this._descLabel.setPreferredWidth(630);
            this._minusButton = new CustomButton(" - ");
            this._minusButton.setPreferredWidth(24);
            this._minusButton.setPreferredHeight(24);
            this._minusButton.addActionListener(this.OnZoomOutButtonPressed, 0, true);
            this._plusButton = new CustomButton(" + ");
            this._plusButton.setPreferredWidth(24);
            this._plusButton.setPreferredHeight(24);
            this._plusButton.addActionListener(this.OnZoomInButtonPressed, 0, true);
            this._zoomLabel = new JLabel("100%");
            this._zoomLabel.setWidth(60);
            this._zoomLabel.setPreferredWidth(60);
            var _local_6:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            _local_6.setBorder(new EmptyBorder(null, new Insets(5, 0, 0, 0)));
            _local_6.append(_local_5);
            _local_6.append(this._descLabel);
            _local_6.append(this._minusButton);
            _local_6.append(this._zoomLabel);
            _local_6.append(this._plusButton);
            var _local_7:JPanel = new JPanel(new BorderLayout());
            _local_7.setBorder(new EmptyBorder(null, new Insets(6, 4, 4, 4)));
            _local_7.append(_local_6, BorderLayout.PAGE_END);
            _local_7.append(_local_4, BorderLayout.CENTER);
            MainPanel.append(_local_7, BorderLayout.CENTER);
            this._mapObjectBitmaps = this._dataLibrary.GetWorldMapObjects();
            if (this._mapObjectBitmaps)
            {
                for each (_local_8 in this._mapObjectBitmaps)
                {
                    if (_local_8["id"] < 1000)
                    {
                        _local_9 = this._dataLibrary.GetBitmap("map", _local_8["imageId"]);
                        if (_local_9)
                        {
                            _local_8["bitmap"] = _local_9;
                        };
                        if (_local_8["active"] == null)
                        {
                            _local_8["active"] = false;
                        };
                    };
                };
            };
            this._lastDrawRect = new Rectangle();
            this._position = new Point(0, 0);
            this._matrix = new Matrix();
            this.RevalidateMap();
            this.RevalidateMapObjects();
            pack();
        }

        override public function show():void
        {
            var _local_1:Object;
            super.show();
            if (this._mapObjectBitmaps)
            {
                this.ScrollToPlayer();
                if ((this._frameTickTime - this._lastOpenMapFrameTickTime) < this.MAP_SHOW_TIME)
                {
                    return;
                };
                this._lastOpenMapFrameTickTime = this._frameTickTime;
                for each (_local_1 in this._mapObjectBitmaps)
                {
                    if (((_local_1["id"] < 1000) && (_local_1["mapName"])))
                    {
                        if (((!(_local_1["active"] == null)) && (_local_1["active"])))
                        {
                            ClientApplication.Instance.LocalGameClient.SendGetMapOnlineInfo(_local_1["mapName"]);
                        }
                        else
                        {
                            _local_1["online"] = 0;
                        };
                    };
                };
            };
            this.RevalidateMapObjects();
        }

        private function ScrollToPlayer():void
        {
            var _local_2:Object;
            var _local_4:Object;
            var _local_5:Number;
            var _local_1:Object;
            if (this._dataLibrary == null)
            {
                this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            };
            _local_2 = this._dataLibrary.GetMapsData(ClientApplication.Instance.LocalGameClient.MapName);
            var _local_3:String = ((_local_2) ? _local_2["ScriptName"] : null);
            for each (_local_4 in this._mapObjectBitmaps)
            {
                if (((((_local_4["id"] < 1000) && (_local_4["mapName"])) && (_local_3)) && (_local_3 == _local_4["mapName"])))
                {
                    _local_1 = _local_4;
                    break;
                };
            };
            if (!_local_1)
            {
                return;
            };
            _local_5 = (this._width - (this._map.width * this._zoom));
            var _local_6:Number = (this._height - (this._map.height * this._zoom));
            var _local_7:Number = ((_local_5 < 0) ? _local_5 : (_local_5 / 2));
            var _local_8:Number = ((_local_6 < 0) ? (_local_6 - 25) : (_local_6 / 2));
            this._mapPanel_center.x = Math.max(_local_7, Math.min(0, ((this._width / 2) - (_local_1.x * this._zoom))));
            this._mapPanel_center.y = Math.max(_local_8, Math.min(0, ((this._height / 2) - (_local_1.y * this._zoom))));
        }

        private function OnMouseDown(_arg_1:Event):void
        {
            var _local_2:Number;
            _local_2 = (this._width - (this._map.width * this._zoom));
            var _local_3:Number = (this._height - (this._map.height * this._zoom));
            var _local_4:Number = ((_local_2 < 0) ? _local_2 : (_local_2 / 2));
            var _local_5:Number = ((_local_3 < 0) ? (_local_3 - 25) : (_local_3 / 2));
            var _local_6:Number = ((_local_2 < 0) ? -(_local_2) : 0);
            var _local_7:Number = ((_local_3 < 0) ? (-(_local_3) + 25) : 0);
            this._mapPanel_center.startDrag(false, new Rectangle(_local_4, _local_5, _local_6, _local_7));
        }

        private function OnClick(_arg_1:Event):void
        {
            if (this._lastMapCollided)
            {
                this._menuNavigation.putClientProperty("mapName", this._lastMapCollided);
                this._menuNavigation.show(null, (stage.mouseX + 20), stage.mouseY);
            };
        }

        private function OnNavigationMap(_arg_1:Event):void
        {
            var _local_2:JMenuItem = (_arg_1.target as JMenuItem);
            if (_local_2)
            {
                HelpManager.Instance.GetRoadAtlas().HelpMoveToMap(this._menuNavigation.getClientProperty("mapName"));
            }
            else
            {
                HelpManager.Instance.GetRoadAtlas().Reset();
            };
            dispose();
        }

        private function OnMouseUp(_arg_1:Event):void
        {
            this._mapPanel_center.stopDrag();
        }

        private function OnZoomInButtonPressed(_arg_1:AWEvent):void
        {
            this._prevZoom = this._zoom;
            if (this._zoom < 1)
            {
                this._zoom = 1;
            };
            this.RevalidateMap();
        }

        private function OnZoomOutButtonPressed(_arg_1:AWEvent):void
        {
            this._prevZoom = this._zoom;
            if (this._zoom > 0.5)
            {
                this._zoom = 0.5;
            };
            this.RevalidateMap();
        }

        private function LoadFogObjects():void
        {
            var _local_6:Object;
            var _local_7:Point;
            var _local_8:Rectangle;
            var _local_9:String;
            var _local_10:String;
            var _local_11:Class;
            var _local_12:Point;
            var _local_13:ByteArray;
            var _local_14:uint;
            var _local_15:uint;
            var _local_16:ByteArray;
            var _local_17:uint;
            var _local_18:uint;
            var _local_19:BitmapData;
            var _local_20:int;
            var _local_21:uint;
            var _local_1:* = "AdditionalData";
            var _local_2:Class = (this._dataLibrary.GetClass(_local_1) as Class);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:uint = uint((this._map.width / 2));
            var _local_4:uint = uint((this._map.height / 2));
            var _local_5:Array = (_local_2.ObjectList as Array);
            for each (_local_6 in _local_5)
            {
                _local_7 = _local_6["offset"];
                _local_8 = _local_6["rect"];
                _local_9 = _local_6["name"];
                if (!(((_local_7 == null) || (_local_8 == null)) || (_local_9 == null)))
                {
                    _local_10 = ((_local_1 + "_Mask_") + _local_9);
                    _local_11 = (this._dataLibrary.GetClass(_local_10) as Class);
                    if (_local_11 != null)
                    {
                        _local_12 = new Point(((_local_3 + _local_7.x) - (_local_8.width / 2)), ((_local_4 + _local_7.y) - (_local_8.height / 2)));
                        _local_13 = new (_local_11)();
                        _local_13.position = 0;
                        _local_14 = _local_13.length;
                        _local_15 = 0;
                        _local_16 = new ByteArray();
                        _local_17 = (_local_8.width * _local_8.height);
                        _local_18 = 0;
                        while (_local_18 < _local_14)
                        {
                            _local_20 = _local_13.readByte();
                            _local_21 = 0;
                            while (_local_21 < 8)
                            {
                                if (_local_15 >= _local_17) break;
                                if ((_local_20 & (1 << _local_21)) > 0)
                                {
                                    _local_16.writeInt(3372220415);
                                }
                                else
                                {
                                    _local_16.writeInt(0);
                                };
                                _local_21++;
                            };
                            _local_18++;
                        };
                        _local_16.position = 0;
                        _local_19 = new BitmapData(_local_8.width, _local_8.height, true, 0);
                        _local_19.setPixels(_local_8, _local_16);
                    };
                };
            };
        }

        public function RevalidateMapObjects():void
        {
            this._mapBuffer = this._mapOpenDataCash.clone();
            this.DrawObjects(false);
            this._mapWithObjectsDataCash = this._mapBuffer.clone();
        }

        public function RevalidateMap():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            this._zoomLabel.setText((int((this._zoom * 100)) + "%"));
            this._mapPanel_center.scaleX = this._zoom;
            this._mapPanel_center.scaleY = this._zoom;
            if (this.IsMapLargerThanFrame())
            {
                _local_3 = int((this._mapPanel_center.x - (this._width / 2)));
                _local_4 = int((this._mapPanel_center.y - (this._height / 2)));
                _local_3 = int((_local_3 * (this._zoom / this._prevZoom)));
                _local_4 = int((_local_4 * (this._zoom / this._prevZoom)));
                _local_1 = int((_local_3 + (this._width / 2)));
                _local_2 = int((_local_4 + (this._height / 2)));
            }
            else
            {
                _local_5 = (this._map.width * this._zoom);
                _local_6 = (this._map.height * this._zoom);
                _local_1 = int(((this._width - _local_5) / 2));
                _local_2 = int(((this._height - _local_6) / 2));
            };
            this._mapPanel_center.x = _local_1;
            this._mapPanel_center.y = _local_2;
            this.ValidateMapBounds();
        }

        private function IsMapLargerThanFrame():Boolean
        {
            var _local_1:int = (this._map.width * this._zoom);
            var _local_2:int = (this._map.height * this._zoom);
            return ((this._width < _local_1) || (this._height < _local_2));
        }

        private function ValidateMapBounds():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            if (this.IsMapLargerThanFrame())
            {
                _local_1 = (this._map.width * this._zoom);
                _local_2 = (this._map.height * this._zoom);
                _local_3 = this._mapPanel_center.x;
                _local_4 = this._mapPanel_center.y;
                if (_local_3 > 0)
                {
                    _local_3 = 0;
                };
                if (_local_4 > 0)
                {
                    _local_4 = 0;
                };
                if ((_local_3 + _local_1) < this._width)
                {
                    _local_3 = (-(_local_1) + this._width);
                };
                if ((_local_4 + _local_2) < this._height)
                {
                    _local_4 = ((-(_local_2) + this._height) - 25);
                };
                this._mapPanel_center.x = _local_3;
                this._mapPanel_center.y = _local_4;
            };
        }

        public function DrawObjects(_arg_1:Boolean):void
        {
            var _local_4:Object;
            var _local_7:Object;
            var _local_8:Bitmap;
            var _local_9:Boolean;
            var _local_10:Object;
            var _local_11:Rectangle;
            var _local_12:BitmapData;
            var _local_13:BitmapData;
            var _local_14:Point;
            var _local_15:Bitmap;
            var _local_16:TextField;
            var _local_17:Bitmap;
            var _local_2:* = "";
            var _local_3:Boolean;
            if (this._dataLibrary == null)
            {
                this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            };
            _local_4 = this._dataLibrary.GetMapsData(ClientApplication.Instance.LocalGameClient.MapName);
            var _local_5:String = ((_local_4) ? _local_4["ScriptName"] : null);
            var _local_6:Object;
            for each (_local_7 in this._mapObjectBitmaps)
            {
                if (!((_local_7 == null) || (_local_7["id"] >= 1000)))
                {
                    if ((((_local_5) && (_local_7["mapName"])) && (_local_5 == _local_7["mapName"])))
                    {
                        _local_6 = _local_7;
                    };
                    if (((_local_7["draw"]) && (_local_7["active"] == _arg_1)))
                    {
                        _local_8 = _local_7["bitmap"];
                        if (_local_8)
                        {
                            this._position.x = _local_7["x"];
                            this._position.y = _local_7["y"];
                            if (_arg_1)
                            {
                                this._lastDrawRect.x = this._position.x;
                                this._lastDrawRect.y = this._position.y;
                                this._lastDrawRect.width = _local_8.bitmapData.rect.width;
                                this._lastDrawRect.height = _local_8.bitmapData.rect.height;
                                if (_local_7["mapName"])
                                {
                                    _local_10 = this._dataLibrary.GetMapsData(_local_7["mapName"]);
                                    if (_local_10)
                                    {
                                        _local_7["online"] = _local_10["online"];
                                    };
                                };
                            };
                            _local_9 = this.IsCollided();
                            if (((_arg_1) && (_local_9)))
                            {
                                _local_11 = new Rectangle(0, 0, (_local_8.bitmapData.rect.width + 10), (_local_8.bitmapData.rect.height + 10));
                                _local_12 = new BitmapData(_local_11.width, _local_11.height, true, 0);
                                _local_13 = new BitmapData(_local_11.width, _local_11.height, true, 0);
                                _local_13.copyPixels(_local_8.bitmapData, _local_8.bitmapData.rect, _correctionPoint, _local_8.bitmapData, _local_8.bitmapData.rect.topLeft, true);
                                _local_12.applyFilter(_local_13, _local_11, _zeroPoint, _glowFilter);
                                _local_14 = this._position.clone();
                                _local_14.offset(-5, -5);
                                this._mapBuffer.copyPixels(_local_12, _local_11, _local_14, _local_12, _zeroPoint, true);
                            }
                            else
                            {
                                this._mapBuffer.copyPixels(_local_8.bitmapData, _local_8.bitmapData.rect, this._position, _local_8.bitmapData, _local_8.bitmapData.rect.topLeft, true);
                            };
                            if (_local_7["online"] != null)
                            {
                                _local_15 = this.GetIndicator(_local_7["online"]);
                                if (_local_15)
                                {
                                    this._position.x = ((_local_7["x"] + _local_8.bitmapData.width) + 5);
                                    this._position.y = ((_local_7["y"] + (_local_8.bitmapData.height / 2)) - (_local_15.bitmapData.height / 2));
                                    this._mapBuffer.copyPixels(_local_15.bitmapData, _local_15.bitmapData.rect, this._position, _local_15.bitmapData, _local_15.bitmapData.rect.topLeft, true);
                                };
                            };
                            if (_local_7["title"])
                            {
                                _local_16 = new TextField();
                                _local_16.x = 1;
                                _local_16.y = 1;
                                _local_16.textColor = 0xCCCCCC;
                                _local_16.htmlText = HtmlText.update(_local_7["title"]);
                                _local_16.autoSize = TextFieldAutoSize.LEFT;
                                _local_16.antiAliasType = AntiAliasType.ADVANCED;
                                _local_16.gridFitType = GridFitType.PIXEL;
                                _local_16.sharpness = -400;
                                _local_16.selectable = false;
                                _local_16.filters = [HtmlText.glow];
                                this._matrix.tx = ((_local_7["x"] + _local_8.bitmapData.width) + 10);
                                this._matrix.ty = ((_local_7["y"] + (_local_8.bitmapData.height / 2)) - (_local_16.height / 2));
                                this._mapBuffer.draw(_local_16, this._matrix);
                            };
                            if (((_local_9) && (_local_7["Description"])))
                            {
                                _local_3 = true;
                                _local_2 = _local_7["Description"];
                                this._lastMapCollided = _local_7["mapName"];
                            };
                        };
                    };
                };
            };
            if (_local_6)
            {
                _local_17 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_Pointer");
                this._matrix.tx = (_local_6["x"] + (_local_17.bitmapData.width / 2));
                this._matrix.ty = (_local_6["y"] + (_local_17.bitmapData.height / 2));
                this._mapBuffer.draw(_local_17, this._matrix);
            };
            this._descLabel.setText(((_local_3) ? _local_2 : ""));
            if (!_local_3)
            {
                this._lastMapCollided = null;
            };
        }

        public function IsCollided():Boolean
        {
            var _local_1:Point = new Point();
            _local_1.x = this._map.mouseX;
            _local_1.y = this._map.mouseY;
            var _local_2:Boolean;
            if (this._lastDrawRect != null)
            {
                _local_2 = this._lastDrawRect.containsPoint(_local_1);
            };
            return (_local_2);
        }

        public function Update(_arg_1:uint):void
        {
            if (this._map)
            {
                this._frameTickTime = _arg_1;
                if ((this._frameTickTime - this._lastFrameTickTime) < this.MAP_UPDATE_TIME)
                {
                    return;
                };
                this._lastFrameTickTime = _arg_1;
                this._mapBuffer = this._mapWithObjectsDataCash.clone();
                this.DrawObjects(true);
                this._map.bitmapData = this._mapBuffer;
            };
        }

        public function GetIndicator(_arg_1:int):Bitmap
        {
            var _local_2:int;
            if (this._dataLibrary)
            {
                _local_2 = ((_arg_1 >= 51) ? 5 : ((_arg_1 >= 21) ? 4 : ((_arg_1 >= 11) ? 3 : ((_arg_1 >= 6) ? 2 : 1))));
                return (this._dataLibrary.GetBitmapAsset(("AdditionalData_Item_ind00" + _local_2)));
            };
            return (null);
        }


    }
}//package hbm.Game.GUI.WorldMap

