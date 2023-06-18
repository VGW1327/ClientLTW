


//hbm.Game.GUI.BannerPanel

package hbm.Game.GUI
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.SoftBoxLayout;
    import org.aswing.EmptyLayout;
    import org.aswing.AssetBackground;
    import org.aswing.AssetIcon;
    import org.aswing.StyleTune;
    import org.aswing.geom.IntDimension;
    import org.aswing.geom.IntPoint;
    import flash.events.Event;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.JTextArea;
    import hbm.Game.GUI.Inventory.InventoryBannerItem;
    import flash.text.TextFormat;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import flash.utils.getTimer;

    public class BannerPanel extends JPanel 
    {

        public static const TIME_TO_SHOW_NEXT_BANNER:int = (1000 * 30);//30000

        private var _lButton:CustomButton;
        private var _rButton:CustomButton;
        private var _hPanel_center:JPanel;
        private var _advtList:Object;
        private var _currentId:int;
        private var _lastFrameTickTime:int;
        private var _timeToShowNextBanner:int = 0;
        private var _dataLibrary:AdditionalDataResourceLibrary;

        public function BannerPanel()
        {
            super(null);
            this.InitUI();
        }

        protected function InitUI():void
        {
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_1:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CleanCenter");
            var _local_2:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_Board_left");
            var _local_3:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_Board_right");
            var _local_4:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_LeftButton");
            var _local_5:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_LeftButtonSelected");
            var _local_6:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_LeftButtonPressed");
            var _local_7:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_RightButton");
            var _local_8:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_RightButtonSelected");
            var _local_9:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_RightButtonPressed");
            var _local_10:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            var _local_11:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_11.setBorder(_local_10);
            var _local_12:JPanel = new JPanel(new EmptyLayout());
            _local_12.setBorder(_local_10);
            _local_12.setBackgroundDecorator(new AssetBackground(_local_2));
            _local_12.setPreferredHeight(_local_2.height);
            _local_12.setPreferredWidth(_local_2.width);
            this._lButton = new CustomButton(null);
            this._lButton.setIcon(new AssetIcon(_local_4));
            this._lButton.setRollOverIcon(new AssetIcon(_local_5));
            this._lButton.setPressedIcon(new AssetIcon(_local_6));
            this._lButton.setStyleTune(new StyleTune(0.18, 0.05, 0.2, 0.2, 20));
            this._lButton.setSize(new IntDimension(26, 26));
            this._lButton.setBackgroundDecorator(null);
            this._lButton.setLocation(new IntPoint(17, 23));
            this._lButton.addActionListener(this.OnLeftPressed, 0, true);
            _local_12.append(this._lButton);
            this._hPanel_center = new JPanel(new EmptyLayout());
            this._hPanel_center.setBorder(_local_10);
            this._hPanel_center.setBackgroundDecorator(new AssetBackground(_local_1));
            this._hPanel_center.setPreferredHeight(_local_1.height);
            this._hPanel_center.setPreferredWidth(_local_1.width);
            var _local_13:JPanel = new JPanel(new EmptyLayout());
            _local_13.setBorder(_local_10);
            _local_13.setBackgroundDecorator(new AssetBackground(_local_3));
            _local_13.setPreferredHeight(_local_3.height);
            _local_13.setPreferredWidth(_local_3.width);
            this._rButton = new CustomButton(null);
            this._rButton.setIcon(new AssetIcon(_local_7));
            this._rButton.setRollOverIcon(new AssetIcon(_local_8));
            this._rButton.setPressedIcon(new AssetIcon(_local_9));
            this._rButton.setStyleTune(new StyleTune(0.18, 0.05, 0.2, 0.2, 20));
            this._rButton.setSize(new IntDimension(26, 26));
            this._rButton.setBackgroundDecorator(null);
            this._rButton.setLocation(new IntPoint(9, 23));
            this._rButton.addActionListener(this.OnRightPressed, 0, true);
            _local_13.append(this._rButton);
            _local_11.append(_local_12);
            _local_11.append(this._hPanel_center);
            _local_11.append(_local_13);
            this.append(_local_11);
            this.setBorder(_local_10);
            addEventListener(Event.ENTER_FRAME, this.OnFrameUpdate, false, 0, true);
        }

        public function LoadItems(_arg_1:Array):void
        {
            var _local_2:ItemData;
            var _local_3:int;
            var _local_4:String;
            if (((_arg_1) && (_arg_1.length > 0)))
            {
                _local_2 = (_arg_1[0] as ItemData);
                _local_3 = _local_2.NameId;
                if (((((_local_3 >= 20000) && (_local_3 <= 20999)) || ((_local_3 >= 22050) && (_local_3 <= 22099))) || (_local_3 == 1065)))
                {
                    _local_4 = "WeaponsList";
                }
                else
                {
                    if ((((_local_3 >= 21100) && (_local_3 <= 21299)) || ((_local_3 >= 21400) && (_local_3 <= 21899))))
                    {
                        _local_4 = "EquipmentsList";
                    }
                    else
                    {
                        if ((((_local_3 >= 21000) && (_local_3 <= 21099)) || ((_local_3 >= 21300) && (_local_3 <= 21399))))
                        {
                            _local_4 = "AccessoriesList";
                        }
                        else
                        {
                            if ((((_local_3 >= 22150) && (_local_3 <= 22714)) || ((_local_3 >= 22750) && (_local_3 <= 22799))))
                            {
                                _local_4 = "PotionsList";
                            }
                            else
                            {
                                _local_4 = "PotionsList";
                            };
                        };
                    };
                };
                this._advtList = this._dataLibrary.GetAdvtsData(_local_4);
                if (((this._advtList) && (this._advtList.length > 0)))
                {
                    this._currentId = (Math.random() * this._advtList.length);
                    this.UpdateItems();
                };
            };
            pack();
        }

        private function UpdateItems():void
        {
            var _local_5:JTextArea;
            this._hPanel_center.removeAll();
            var _local_1:Object = this._advtList[this._currentId];
            if (!_local_1)
            {
                return;
            };
            var _local_2:InventoryBannerItem = this.CreateItem(_local_1.NameId1);
            if (_local_2)
            {
                _local_2.setSize(new IntDimension(64, 64));
                _local_2.setLocation(new IntPoint(-10, 3));
                _local_2.setBackgroundDecorator(null);
                _local_2.setBorder(null);
                this._hPanel_center.append(_local_2);
            };
            var _local_3:InventoryBannerItem = this.CreateItem(_local_1.NameId2);
            if (_local_3)
            {
                _local_3.setSize(new IntDimension(64, 64));
                _local_3.setLocation(new IntPoint(30, 3));
                _local_3.setBackgroundDecorator(null);
                _local_3.setBorder(null);
                this._hPanel_center.append(_local_3);
            };
            var _local_4:InventoryBannerItem = this.CreateItem(_local_1.NameId3);
            if (_local_4)
            {
                _local_4.setSize(new IntDimension(64, 64));
                _local_4.setLocation(new IntPoint(70, 3));
                _local_4.setBackgroundDecorator(null);
                _local_4.setBorder(null);
                this._hPanel_center.append(_local_4);
            };
            _local_5 = new JTextArea();
            _local_5.setHtmlText(_local_1.Description);
            _local_5.setEditable(false);
            _local_5.setWordWrap(true);
            _local_5.setBackgroundDecorator(null);
            _local_5.getTextField().selectable = false;
            _local_5.setSize(new IntDimension(400, 30));
            _local_5.setLocation(new IntPoint(130, 22));
            var _local_6:TextFormat = _local_5.getTextFormat();
            _local_6.align = "center";
            _local_6.size = 16;
            _local_6.bold = true;
            _local_5.setTextFormat(_local_6);
            this._hPanel_center.append(_local_5);
        }

        private function OnLeftPressed(_arg_1:Event):void
        {
            this._currentId--;
            if (this._currentId < 0)
            {
                this._currentId = (this._advtList.length - 1);
            };
            this.UpdateItems();
        }

        private function OnRightPressed(_arg_1:Event):void
        {
            this._currentId++;
            if (this._currentId >= this._advtList.length)
            {
                this._currentId = 0;
            };
            this.UpdateItems();
        }

        private function CreateItem(_arg_1:String):InventoryBannerItem
        {
            var _local_3:ItemsResourceLibrary;
            var _local_2:int = int(_arg_1);
            if (_local_2 == 0)
            {
                return (null);
            };
            _local_3 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            var _local_4:ItemData = new ItemData();
            var _local_5:Object = _local_3.GetServerDescriptionObject(_local_2);
            if (!_local_5)
            {
                return (null);
            };
            _local_4.Amount = 1;
            _local_4.NameId = _local_2;
            _local_4.Identified = 1;
            _local_4.Origin = ItemData.CASH;
            _local_4.Price = Number((_local_5["price_buy"] / 200));
            _local_4.Type = _local_5["type"];
            return (new InventoryBannerItem(_local_4));
        }

        private function OnFrameUpdate(_arg_1:Event):void
        {
            var _local_2:int;
            if (((!(this._advtList)) || (this._advtList.length == 0)))
            {
                return;
            };
            _local_2 = getTimer();
            this._lastFrameTickTime = _local_2;
            var _local_3:uint = (_local_2 - this._timeToShowNextBanner);
            if (_local_3 < TIME_TO_SHOW_NEXT_BANNER)
            {
                return;
            };
            this._timeToShowNextBanner = _local_2;
            this.OnRightPressed(null);
        }

        public function Dispose():void
        {
            removeEventListener(Event.ENTER_FRAME, this.OnFrameUpdate);
        }


    }
}//package hbm.Game.GUI

