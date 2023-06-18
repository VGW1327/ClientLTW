


//hbm.Game.GUI.PremiumShop.NewShopArea

package hbm.Game.GUI.PremiumShop
{
    import org.aswing.JPanel;
    import org.aswing.JTextField;
    import flash.utils.Timer;
    import org.aswing.JCheckBox;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.Utility.AsWingUtil;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Application.ClientApplication;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import org.aswing.GridLayout;
    import hbm.Game.GUI.CashShopNew.NewShopItem;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Actors.CharacterEquipment;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Game.GUI.Tutorial.HelpManager;

    public class NewShopArea extends JPanel 
    {

        private static const ITEMS_PER_PAGE:uint = 10;
        private static const START_SEARCH_DELAY:uint = 1000;

        private var _curPage:int;
        private var _maxPage:int;
        private var _filters:Array;
        private var _allItems:Array = [];
        private var _buyItems:Array;
        private var _selectFilterIndex:uint;
        private var _filtersCheckBox:Array;
        private var _filtersPanel:JPanel;
        private var _searchText:JTextField;
        private var _timerSearch:Timer;
        private var _itemsPanel:JPanel;
        private var _callbackChangeSelect:Function;
        private var _goldenCheckBox:JCheckBox;
        private var _allJobsCheckBox:JCheckBox;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _itemsLibrary:ItemsResourceLibrary;
        private var _player:CharacterInfo;
        private var _exceptionItems:Array;
        private var _jobsArmor:Object;

        public function NewShopArea()
        {
            super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.TOP));
            this.InitUI();
        }

        public function get CurPage():int
        {
            return (this._curPage + 1);
        }

        public function get MaxPage():int
        {
            return (this._maxPage);
        }

        public function ScrollLeft():void
        {
            this._curPage = Math.max(0, (this._curPage - 1));
            this.UpdateItems();
        }

        public function ScrollRight():void
        {
            this._curPage = Math.min((this._maxPage - 1), (this._curPage + 1));
            this.UpdateItems();
        }

        public function set ChangeFilterCallback(_arg_1:Function):void
        {
            this._callbackChangeSelect = _arg_1;
        }

        private function InitUI():void
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            this._filtersPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            AsWingUtil.SetWidth(this._filtersPanel, 430);
            _local_1.append(this._filtersPanel);
            this._goldenCheckBox = AsWingUtil.CreateCheckBoxFromAsset("NCS_ActiveCoin", "NCS_PressCoin");
            new CustomToolTip(this._goldenCheckBox, ClientApplication.Instance.GetPopupText(271), 300);
            this._goldenCheckBox.addActionListener(this.OnChangeGoldFilter, 0, true);
            _local_1.append(this._goldenCheckBox);
            this._allJobsCheckBox = AsWingUtil.CreateCheckBoxFromAsset("NCS_ActiveWeapon", "NCS_PressWeapon");
            new CustomToolTip(this._allJobsCheckBox, ClientApplication.Instance.GetPopupText(272), 300);
            this._allJobsCheckBox.addActionListener(this.OnChangeGoldFilter, 0, true);
            _local_1.append(this._allJobsCheckBox);
            this._searchText = new JTextField();
            this._searchText.setMaxChars(25);
            this._searchText.addEventListener(Event.CHANGE, this.OnEditSearch, false, 0, true);
            AsWingUtil.SetWidth(this._searchText, 190);
            _local_1.append(this._searchText);
            this._timerSearch = new Timer(START_SEARCH_DELAY, 1);
            this._timerSearch.addEventListener(TimerEvent.TIMER, this.OnSearch, false, 0, true);
            append(_local_1);
            this._itemsPanel = new JPanel(new GridLayout(2, 5));
            AsWingUtil.SetSize(this._itemsPanel, (570 + 147), 348);
            append(this._itemsPanel);
        }

        public function LoadFilters(_arg_1:Array, _arg_2:Array, _arg_3:Array, _arg_4:Object):void
        {
            var _local_6:Object;
            this._buyItems = _arg_2;
            this._exceptionItems = _arg_3;
            this._jobsArmor = _arg_4;
            var _local_5:int = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerFraction();
            this._filters = [];
            this._filtersCheckBox = [];
            this._filtersPanel.removeAll();
            for each (_local_6 in _arg_1)
            {
                if (_local_6.fraction != null)
                {
                    if ((((_local_6.fraction == 0) && (_local_5 == CharacterInfo.FRACTION_LIGHT)) || ((_local_6.fraction == 1) && (_local_5 == CharacterInfo.FRACTION_DARK))))
                    {
                        this.AddFilterTab(_local_6);
                    };
                }
                else
                {
                    this.AddFilterTab(_local_6);
                };
            };
            this._selectFilterIndex = 0;
        }

        public function HasItem(_arg_1:uint):Boolean
        {
            if (((this._filters) && (this._filters[0])))
            {
                return (this._filters[0].items.indexOf(_arg_1) >= 0);
            };
            return (false);
        }

        public function GetItem(_arg_1:uint):NewShopItem
        {
            var _local_2:NewShopItem;
            for each (_local_2 in this._allItems)
            {
                if (_local_2.ItemID == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        private function AddFilterTab(_arg_1:Object):void
        {
            var _local_2:JCheckBox;
            if (_arg_1.icons)
            {
                _local_2 = AsWingUtil.CreateCheckBoxFromAsset(_arg_1.icons[0], _arg_1.icons[1]);
            }
            else
            {
                _local_2 = new JCheckBox();
            };
            new CustomToolTip(_local_2, _arg_1.text, 300);
            _local_2.addActionListener(this.OnChangeTabFilter, 0, true);
            if (this._filters.length)
            {
                this._filtersCheckBox.push(_local_2);
                this._filtersPanel.append(_local_2);
            };
            this._filters.push(_arg_1);
        }

        private function OnEditSearch(_arg_1:Event):void
        {
            this._timerSearch.reset();
            if (this._searchText.getText().length > 0)
            {
                this._timerSearch.start();
            }
            else
            {
                this.ApplyFilter();
            };
        }

        private function OnSearch(_arg_1:Event):void
        {
            this._timerSearch.stop();
            this.ResetFilters();
            this.ApplyFilter();
        }

        public function ResetFilters():void
        {
            var _local_1:JCheckBox;
            this._selectFilterIndex = 0;
            this._goldenCheckBox.setSelected(false);
            this._allJobsCheckBox.setSelected(false);
            for each (_local_1 in this._filtersCheckBox)
            {
                _local_1.setSelected(false);
            };
        }

        private function OnChangeGoldFilter(_arg_1:Event):void
        {
            this.UpdateFilter();
        }

        private function OnChangeTabFilter(_arg_1:Event):void
        {
            var _local_4:JCheckBox;
            var _local_2:JCheckBox = (_arg_1.target as JCheckBox);
            if (!_local_2)
            {
                return;
            };
            var _local_3:Boolean = _local_2.isSelected();
            for each (_local_4 in this._filtersCheckBox)
            {
                if (_local_4 != _local_2)
                {
                    _local_4.setSelected(false);
                };
            };
            if (_local_3)
            {
                this._selectFilterIndex = (this._filtersCheckBox.indexOf(_local_2) + 1);
            }
            else
            {
                this._selectFilterIndex = 0;
            };
            this.UpdateFilter();
        }

        public function UpdateFilter():void
        {
            if (!this._filters)
            {
                return;
            };
            this._searchText.setText("");
            this.ApplyFilter();
        }

        public function ShowItem(_arg_1:int):Boolean
        {
            var _local_3:Object;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Boolean;
            var _local_2:uint = 1;
            while (_local_2 < this._filters.length)
            {
                _local_3 = this._filters[_local_2];
                if (((_local_3) && (_local_3.items)))
                {
                    _local_4 = (ClientApplication.Instance.timeOnServer * 1000);
                    _local_5 = ClientApplication.Instance.ConvertDate(_local_3["StartDate"]);
                    _local_6 = ClientApplication.Instance.ConvertDate(_local_3["EndDate"]);
                    _local_7 = (((((_local_3.itemsDate) && (_local_5 > 0)) && (_local_6 > 0)) && (_local_4 >= _local_5)) && (_local_4 < _local_6));
                    if ((((_local_7) && (_local_3.itemsDate.indexOf(_arg_1) >= 0)) || (_local_3.items.indexOf(_arg_1) >= 0)))
                    {
                        return (true);
                    };
                };
                _local_2++;
            };
            return (false);
        }

        private function ApplyFilter():void
        {
            var _local_3:Boolean;
            var _local_4:Array;
            var _local_5:Boolean;
            var _local_6:ItemData;
            var _local_8:String;
            var _local_9:Boolean;
            this._dataLibrary = ((this._dataLibrary) || (AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"))));
            this._itemsLibrary = ((this._itemsLibrary) || (ItemsResourceLibrary(ResourceManager.Instance.Library("Items"))));
            this._player = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_1:Object = this._filters[this._selectFilterIndex];
            this._allItems = [];
            var _local_2:uint;
            var _local_7:String = this._searchText.getText().toLocaleLowerCase();
            if (_local_7.length > 0)
            {
                for each (_local_6 in this._buyItems)
                {
                    _local_8 = this._itemsLibrary.GetItemFullName(_local_6.NameId).toLocaleLowerCase();
                    _local_3 = (_local_8.indexOf(_local_7) >= 0);
                    _local_4 = this.GetRangeItem(_local_6);
                    if (_local_3)
                    {
                        _local_5 = (this._player.baseLevel < _local_4[0]);
                        _local_2++;
                        this._allItems.push(new NewShopItem(_local_6, _local_5));
                    };
                };
            }
            else
            {
                if (((_local_1) && (_local_1.items)))
                {
                    for each (_local_6 in this._buyItems)
                    {
                        _local_4 = this.GetRangeItem(_local_6);
                        _local_9 = (this._exceptionItems.indexOf(_local_6.NameId) >= 0);
                        _local_3 = ((this._allJobsCheckBox.isSelected()) || (this.IsCompareJobItem(_local_6)));
                        if (this._goldenCheckBox.isSelected())
                        {
                            _local_3 = ((_local_3) && (_local_6.Origin == ItemData.CASH));
                        };
                        if (!_local_9)
                        {
                            _local_3 = ((_local_3) && (this._player.baseLevel <= _local_4[2]));
                        };
                        if (_local_3)
                        {
                            if (_local_1.items.indexOf(_local_6.NameId) >= 0)
                            {
                                _local_5 = (this._player.baseLevel < _local_4[0]);
                                _local_2++;
                                this._allItems.push(new NewShopItem(_local_6, _local_5));
                            };
                        };
                    };
                };
            };
            while ((_local_2 % ITEMS_PER_PAGE))
            {
                this._allItems.push(new NewShopItem(null));
                _local_2++;
            };
            this._curPage = 0;
            this._maxPage = (_local_2 / ITEMS_PER_PAGE);
            this.UpdateItems();
            if (this._callbackChangeSelect != null)
            {
                this._callbackChangeSelect();
            };
        }

        private function IsCompareJobItem(_arg_1:ItemData):Boolean
        {
            var _local_2:Object;
            var _local_5:int;
            _local_2 = this._itemsLibrary.GetServerDescriptionObject(_arg_1.NameId);
            var _local_3:uint = _local_2["equip_jobs"];
            if (_local_3 < 1)
            {
                return (true);
            };
            var _local_4:uint = ((this._jobsArmor) ? this._jobsArmor[this._player.jobId] : 0);
            if ((((_local_4 > 0) && (_arg_1.Type == ItemData.IT_ARMOR)) && ((_local_2["equip_locations"] & ((CharacterEquipment.MASK_HEAD_TOP | CharacterEquipment.MASK_BODY) | CharacterEquipment.MASK_SHOES)) > 0)))
            {
                return (_local_3 == _local_4);
            };
            _local_5 = ((_local_3 >> CharacterStorage.Instance.GetJobEquipID(this._player.jobId)) & 0x01);
            return (_local_5 == 1);
        }

        private function GetRangeItem(_arg_1:ItemData):Array
        {
            var _local_2:Object = this._itemsLibrary.GetServerDescriptionObject(_arg_1.NameId);
            if (_local_2.equip_level < 30)
            {
                return ([_local_2.equip_level, 0, 29]);
            };
            if (_local_2.equip_level < 50)
            {
                return ([_local_2.equip_level, 30, 49]);
            };
            if (_local_2.equip_level < 70)
            {
                return ([_local_2.equip_level, 50, 69]);
            };
            if (_local_2.equip_level < 80)
            {
                return ([_local_2.equip_level, 70, 79]);
            };
            if (_local_2.equip_level < 90)
            {
                return ([_local_2.equip_level, 80, 89]);
            };
            if (_local_2.equip_level < 99)
            {
                return ([_local_2.equip_level, 90, 98]);
            };
            return ([_local_2.equip_level, 99, 99]);
        }

        private function UpdateItems():void
        {
            var _local_1:uint;
            var _local_2:NewShopItem;
            this._itemsPanel.removeAll();
            if (this._allItems.length > (((this._curPage * ITEMS_PER_PAGE) + ITEMS_PER_PAGE) - 1))
            {
                _local_1 = 0;
                while (_local_1 < ITEMS_PER_PAGE)
                {
                    _local_2 = this._allItems[((this._curPage * ITEMS_PER_PAGE) + _local_1)];
                    _local_2.Loading();
                    this._itemsPanel.append(_local_2);
                    _local_1++;
                };
            };
            HelpManager.Instance.UpdatePremiumShopHelper();
        }


    }
}//package hbm.Game.GUI.PremiumShop

