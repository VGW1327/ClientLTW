


//hbm.Game.GUI.CharacterCreation.CharacterListItem

package hbm.Game.GUI.CharacterCreation
{
    import org.aswing.JPanel;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.CustomButton;
    import flash.display.Bitmap;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.EmptyLayout;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.ASColor;
    import hbm.Application.ClientApplication;
    import hbm.Game.Character.CharacterStorage;
    import org.aswing.AssetIcon;
    import flash.events.MouseEvent;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.AssetBackground;
    import org.aswing.geom.IntDimension;
    import org.aswing.event.AWEvent;

    public class CharacterListItem extends JPanel 
    {

        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localizationLibrary:LocalizationResourceLibrary;
        private var _slotId:int;
        private var _jobId:int;
        private var _sex:int;
        private var _clothesColor:int;
        private var _name:String;
        private var _characterNameLabel:JLabel;
        private var _baseLevelLabel:JLabel;
        private var _jobLabel:JLabel;
        private var _avatarPanel:JPanel;
        private var _createPanel:JPanel;
        private var _unlocked:Boolean;
        private var _pressed:Boolean = false;
        private var _activeRename:Boolean = false;

        public function CharacterListItem(_arg_1:int, _arg_2:CharacterInfo, _arg_3:Boolean=true)
        {
			trace("CharacterListItem");
            var _local_4:CustomButton;
            var _local_5:Bitmap;
            var _local_6:Bitmap;
            var _local_7:Bitmap;
            var _local_8:CustomToolTip;
            var _local_9:CustomToolTip;
            super(new EmptyLayout());
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            this._slotId = _arg_1;
            this._unlocked = _arg_3;
            this._clothesColor = 0;
            this._name = "";
			trace("CharacterListItem_arg_3: " + _arg_3);
            if (_arg_3)
            {
				trace("CharacterListItem_arg_2: " + _arg_2);				
                if (_arg_2 != null)
                {
					trace("CharacterListItem_arg_2");
                    this._clothesColor = _arg_2.clothesColor;
                    this._jobId = _arg_2.jobId;
                    this._name = _arg_2.name;
                    this._sex = _arg_2.sex;
                    this._characterNameLabel = new JLabel(_arg_2.name, null, JLabel.LEFT);
                    this._characterNameLabel.setFont(new ASFont(HtmlText.fontName, 12, true));
                    this._characterNameLabel.setTextFilters([HtmlText.glow]);
                    this._characterNameLabel.setSizeWH(125, 20);
                    this._characterNameLabel.setLocationXY(50, 10);
                    this._characterNameLabel.setForeground(new ASColor(13677406));
                    append(this._characterNameLabel);
                    this._baseLevelLabel = new JLabel(((_arg_2.baseLevel + " ") + ClientApplication.Localization.CHARACTER_LIST_LEVEL_MESSAGE), null, JLabel.LEFT);
                    this._baseLevelLabel.setFont(new ASFont(HtmlText.fontName, 12, true));
                    this._baseLevelLabel.setTextFilters([HtmlText.glow]);
                    this._baseLevelLabel.setSizeWH(60, 20);
                    this._baseLevelLabel.setLocationXY(50, 28);
                    this._baseLevelLabel.setForeground(new ASColor(13418930));
                    append(this._baseLevelLabel);
                    this._jobLabel = new JLabel(CharacterStorage.Instance.GetJobName(_arg_2.clothesColor, _arg_2.jobId), null, JLabel.LEFT);
                    this._jobLabel.setFont(new ASFont(HtmlText.fontName, 12, true));
                    this._jobLabel.setTextFilters([HtmlText.glow]);
                    this._jobLabel.setSizeWH(120, 20);
                    this._jobLabel.setLocationXY(85, 28);
                    this._jobLabel.setForeground(new ASColor(13418930));
                    append(this._jobLabel);
                    if (_arg_2.Rename == 0)
                    {
                        _local_4 = new CustomButton(null);
                        _local_4.addActionListener(this.OnRename, 0, true);
                        _local_5 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharListRenameButton");
                        _local_6 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharListRenameButtonSelected");
                        _local_7 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharListRenameButtonPressed");
                        _local_4.setIcon(new AssetIcon(_local_5));
                        _local_4.setRollOverIcon(new AssetIcon(_local_6));
                        _local_4.setPressedIcon(new AssetIcon(_local_7));
                        _local_4.setSizeWH(_local_5.width, _local_5.height);
                        _local_4.setBackgroundDecorator(null);
                        _local_4.setLocationXY(138, 0);
                        _local_8 = new CustomToolTip(_local_4, ClientApplication.Instance.GetPopupText(203), 250, 20);
                        append(_local_4);
                    };
                }
                else
                {
                    this._createPanel = new JPanel();
                    this._createPanel.setLocationXY(55, 15);
                    append(this._createPanel);
                    this._jobId = -1;
                };
                this._avatarPanel = new JPanel();
                this._avatarPanel.setLocationXY(11, 12);
                append(this._avatarPanel);
                addEventListener(MouseEvent.MOUSE_OVER, this.OnMouseOver, false, 0, true);
                addEventListener(MouseEvent.CLICK, this.OnMouseClick, false, 0, true);
                addEventListener(MouseEvent.ROLL_OUT, this.OnMouseOut, false, 0, true);
                addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown, false, 0, true);
            }
            else
            {
                this._jobId = -2;
                _local_9 = new CustomToolTip(this, ClientApplication.Instance.GetPopupText(231), 250, 55);
            };
            this.SetActiveBack();
        }

        private function SetActiveBack():void
        {
            var _local_1:Bitmap;
            var _local_3:Bitmap;
            var _local_4:Bitmap;
            if (this._jobId == -2)
            {
                _local_1 = this._localizationLibrary.GetBitmapAsset("Localization_Item_CharListPremuimSlot");
            }
            else
            {
                _local_1 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharListSlot");
            };
            setBackgroundDecorator(new AssetBackground(_local_1));
            var _local_2:IntDimension = new IntDimension(_local_1.width, _local_1.height);
            setSize(_local_2);
            setPreferredSize(_local_2);
            if (this._unlocked)
            {
                if (this._jobId == -1)
                {
                    _local_4 = this._localizationLibrary.GetBitmapAsset("Localization_Item_CharListCreateButton");
                    if (_local_4)
                    {
                        this._createPanel.setBackgroundDecorator(new AssetBackground(_local_4));
                        this._createPanel.setSizeWH(_local_4.width, _local_4.height);
                    };
                }
                else
                {
                    if (this._jobId >= 0)
                    {
                        this._characterNameLabel.setForeground(new ASColor(8289650));
                        this._baseLevelLabel.setForeground(new ASColor(7238257));
                        this._jobLabel.setForeground(new ASColor(7238257));
                    };
                };
                _local_3 = this.GetSmallIconName(2);
                if (_local_3)
                {
                    this._avatarPanel.setBackgroundDecorator(new AssetBackground(_local_3));
                    this._avatarPanel.setSizeWH(_local_3.width, _local_3.height);
                };
                useHandCursor = false;
                buttonMode = false;
            };
        }

        private function SetPressedBack():void
        {
            var _local_1:String;
            if (this._jobId == -2)
            {
                return;
            };
            _local_1 = "AdditionalData_Item_CharListSlotPressed";
            var _local_2:Bitmap = this._dataLibrary.GetBitmapAsset(_local_1);
            setBackgroundDecorator(new AssetBackground(_local_2));
            setSizeWH(_local_2.width, _local_2.height);
            if (((this._unlocked) && (this._jobId >= 0)))
            {
                this._characterNameLabel.setForeground(new ASColor(13677406));
                this._baseLevelLabel.setForeground(new ASColor(13418930));
                this._jobLabel.setForeground(new ASColor(13418930));
            };
            var _local_3:Bitmap = this.GetSmallIconName(1);
            if (_local_3)
            {
                this._avatarPanel.setBackgroundDecorator(new AssetBackground(_local_3));
                this._avatarPanel.setSizeWH(_local_3.width, _local_3.height);
            };
            useHandCursor = true;
            buttonMode = true;
        }

        private function SetOverBack():void
        {
            var _local_1:String;
            var _local_4:Bitmap;
            if (this._jobId == -2)
            {
                return;
            };
            _local_1 = "AdditionalData_Item_CharListSlotSelected";
            var _local_2:Bitmap = this._dataLibrary.GetBitmapAsset(_local_1);
            setBackgroundDecorator(new AssetBackground(_local_2));
            setSizeWH(_local_2.width, _local_2.height);
            if (((this._unlocked) && (this._jobId >= 0)))
            {
                this._characterNameLabel.setForeground(new ASColor(13677406));
                this._baseLevelLabel.setForeground(new ASColor(13418930));
                this._jobLabel.setForeground(new ASColor(13418930));
            };
            if (this._jobId == -1)
            {
                _local_4 = this._localizationLibrary.GetBitmapAsset("Localization_Item_CharListCreateButtonSelected");
                if (_local_4)
                {
                    this._createPanel.setBackgroundDecorator(new AssetBackground(_local_4));
                    this._createPanel.setSizeWH(_local_4.width, _local_4.height);
                };
            };
            var _local_3:Bitmap = this.GetSmallIconName(0);
            if (_local_3)
            {
                this._avatarPanel.setBackgroundDecorator(new AssetBackground(_local_3));
                this._avatarPanel.setSizeWH(_local_3.width, _local_3.height);
            };
        }

        private function GetSmallIconName(_arg_1:int):Bitmap
        {
            var _local_2:* = "AdditionalData_Item_CharIconSmall_";
            var _local_3:String = ((_arg_1 > 0) ? ((_arg_1 > 1) ? "p" : "s") : "");
            var _local_4:String = ((this._clothesColor > 0) ? "_1" : "_0");
            if (this._jobId > 0)
            {
                _local_2 = (_local_2 + ((this._jobId + _local_4) + _local_3));
            };
            var _local_5:Bitmap = this._dataLibrary.GetBitmapAsset(_local_2);
            if (!_local_5)
            {
                _local_5 = this._dataLibrary.GetBitmapAsset(("AdditionalData_Item_CharIconSmall_0" + _local_3));
            };
            return (_local_5);
        }

        private function OnMouseOver(_arg_1:MouseEvent):void
        {
            if (!this._pressed)
            {
                this.SetOverBack();
            };
        }

        private function OnMouseClick(_arg_1:MouseEvent):void
        {
            if (!this._activeRename)
            {
                dispatchEvent(new CharacterListEvent(CharacterListEvent.ON_ACTION, this._slotId, this._jobId));
                this._pressed = true;
            }
            else
            {
                this._activeRename = false;
            };
        }

        private function OnMouseOut(_arg_1:MouseEvent):void
        {
            if (!this._pressed)
            {
                this.SetActiveBack();
            };
        }

        private function OnMouseDown(_arg_1:MouseEvent):void
        {
            this.SetPressedBack();
        }

        private function OnRename(_arg_1:AWEvent):void
        {
            this._activeRename = true;
            dispatchEvent(new CharacterListEvent(CharacterListEvent.ON_RENAME, this._slotId, this._jobId));
        }

        public function get SlotId():int
        {
            return (this._slotId);
        }

        public function get JobId():int
        {
            return (this._jobId);
        }

        public function get Sex():int
        {
            return (this._sex);
        }

        public function get ClothesColor():int
        {
            return (this._clothesColor);
        }

        public function get Pressed():Boolean
        {
            return (this._pressed);
        }

        public function set Pressed(_arg_1:Boolean):void
        {
            this._pressed = _arg_1;
            if (!_arg_1)
            {
                this.SetActiveBack();
            }
            else
            {
                this.SetPressedBack();
            };
        }

        public function get CharacterName():String
        {
            return (this._name);
        }


    }
}//package hbm.Game.GUI.CharacterCreation

