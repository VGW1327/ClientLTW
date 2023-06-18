


//hbm.Game.GUI.CharacterStats.CharacterStatsPanel

package hbm.Game.GUI.CharacterStats
{
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import hbm.Game.GUI.PaddedValue;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.colorchooser.VerticalLayout;
    import hbm.Engine.Actors.CharacterEquipment;
    import hbm.Application.ClientApplication;
    import org.aswing.BorderLayout;
    import org.aswing.SoftBoxLayout;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.JOptionPane;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import mx.utils.StringUtil;
    import org.aswing.AttachIcon;
    import flash.events.Event;
    import hbm.Game.Utility.AsWingUtil;
    import flash.display.Bitmap;
    import hbm.Game.Character.CharacterStorage;
    import org.aswing.AssetIcon;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Game.GUI.*;

    public class CharacterStatsPanel extends JPanel 
    {

        private var _resetCost:int = 50000;
        private var _characterPic:JLabel;
        private var _jobId:int = -1;
        private var _str:CharacterStatsButton;
        private var _agi:CharacterStatsButton;
        private var _vit:CharacterStatsButton;
        private var _int:CharacterStatsButton;
        private var _dex:CharacterStatsButton;
        private var _luk:CharacterStatsButton;
        private var _atk:PaddedValue;
        private var _matk:PaddedValue;
        private var _hit:PaddedValue;
        private var _critical:PaddedValue;
        private var _def:PaddedValue;
        private var _mdef:PaddedValue;
        private var _flee:PaddedValue;
        private var _aspd:PaddedValue;
        private var _statusPoints:PaddedValue;
        private var _defTip:CustomToolTip;
        private var _lastDef:int;
        private var _lastOldDef:int;
        private var _head1:CharacterStatsItemSlot;
        private var _head2:CharacterStatsItemSlot;
        private var _head3:CharacterStatsItemSlot;
        private var _body:CharacterStatsItemSlot;
        private var _rightHand:CharacterStatsItemSlot;
        private var _leftHand:CharacterStatsItemSlot;
        private var _robe:CharacterStatsItemSlot;
        private var _shoes:CharacterStatsItemSlot;
        private var _accessary1:CharacterStatsItemSlot;
        private var _accessary2:CharacterStatsItemSlot;
        private var _soulshot:CharacterStatsItemSlot;
        private var _mount:CharacterStatsItemSlot;
        private var _belt:CharacterStatsItemSlot;
        private var _tabard:CharacterStatsItemSlot;
        private var _suit:CharacterStatsItemSlot;
        private var _midPanel:JPanel;
        private var _leftEquip:JPanel;
        private var _rightEquip:JPanel;
        private var _statToButton:Array = [];
        private var _resetStatsButton:CustomButton;

        public function CharacterStatsPanel(_arg_1:*=null)
        {
            this.Init();
        }

        private function Init():void
        {
            var _local_1:LineBorder = new LineBorder(null, ASColor.RED, 1, 4);
            this._characterPic = new JLabel();
            this._characterPic.setBorder(new EmptyBorder(null, new Insets(0, 4, 4, 4)));
            var _local_2:VerticalLayout = new VerticalLayout(0, 2);
            this._leftEquip = new JPanel(_local_2);
            this._rightEquip = new JPanel(_local_2);
            this._head1 = new CharacterStatsItemSlot(CharacterEquipment.SLOT_HEAD_TOP, ClientApplication.Instance.GetPopupText(31), 220, 40);
            this._head2 = new CharacterStatsItemSlot(CharacterEquipment.SLOT_HEAD_LOW, ClientApplication.Instance.GetPopupText(179), 220, 20);
            this._head3 = new CharacterStatsItemSlot(CharacterEquipment.SLOT_HEAD_MID, ClientApplication.Instance.GetPopupText(178), 230, 20);
            this._body = new CharacterStatsItemSlot(CharacterEquipment.SLOT_BODY, ClientApplication.Instance.GetPopupText(35), 180, 40);
            this._leftHand = new CharacterStatsItemSlot(CharacterEquipment.SLOT_LEFT_HAND, ClientApplication.Instance.GetPopupText(36), 220, 40);
            this._rightHand = new CharacterStatsItemSlot(CharacterEquipment.SLOT_RIGHT_HAND, ClientApplication.Instance.GetPopupText(32), 230, 40);
            this._robe = new CharacterStatsItemSlot(CharacterEquipment.SLOT_ROBE, ClientApplication.Instance.GetPopupText(33), 160, 25);
            this._shoes = new CharacterStatsItemSlot(CharacterEquipment.SLOT_SHOES, ClientApplication.Instance.GetPopupText(37), 150, 20);
            this._accessary1 = new CharacterStatsItemSlot(CharacterEquipment.SLOT_ACCESSARY1, ClientApplication.Instance.GetPopupText(34), 240, 20);
            this._accessary2 = new CharacterStatsItemSlot(CharacterEquipment.SLOT_ACCESSARY2, ClientApplication.Instance.GetPopupText(34), 240, 20);
            this._soulshot = new CharacterStatsItemSlot(CharacterEquipment.SLOT_SOULSHOTS, ClientApplication.Instance.GetPopupText(183), 240, 20);
            this._mount = new CharacterStatsItemSlot(CharacterEquipment.SLOT_MOUNT, ClientApplication.Instance.GetPopupText(232), 240, 40);
            this._tabard = new CharacterStatsItemSlot(CharacterEquipment.SLOT_TABARD, ClientApplication.Instance.GetPopupText(233), 240, 25);
            this._belt = new CharacterStatsItemSlot(CharacterEquipment.SLOT_BELT, ClientApplication.Instance.GetPopupText(234), 240, 25);
            this._suit = new CharacterStatsItemSlot(CharacterEquipment.SLOT_SUIT, ClientApplication.Instance.GetPopupText(235), 240, 40);
            var _local_3:JPanel = new JPanel(new BorderLayout());
            _local_3.append(this._tabard, BorderLayout.EAST);
            _local_3.append(this._head1, BorderLayout.WEST);
            this._leftEquip.append(_local_3);
            var _local_4:JPanel = new JPanel(new BorderLayout());
            _local_4.append(this._soulshot, BorderLayout.EAST);
            _local_4.append(this._rightHand, BorderLayout.WEST);
            this._leftEquip.append(_local_4);
            this._leftEquip.append(this._robe);
            this._leftEquip.append(this._accessary1);
            var _local_5:JPanel = new JPanel(new BorderLayout());
            _local_5.append(this._belt, BorderLayout.EAST);
            _local_5.append(this._head2, BorderLayout.WEST);
            this._leftEquip.append(_local_5);
            var _local_6:JPanel = new JPanel(new BorderLayout());
            _local_6.append(this._body, BorderLayout.EAST);
            _local_6.append(this._suit, BorderLayout.WEST);
            this._rightEquip.append(_local_6);
            var _local_7:JPanel = new JPanel(new BorderLayout());
            _local_7.setBorder(new EmptyBorder(null, new Insets(0, 38, 0, 0)));
            _local_7.append(this._leftHand, BorderLayout.WEST);
            this._rightEquip.append(_local_7);
            var _local_8:JPanel = new JPanel(new BorderLayout());
            _local_8.setBorder(new EmptyBorder(null, new Insets(0, 38, 0, 0)));
            _local_8.append(this._shoes, BorderLayout.WEST);
            this._rightEquip.append(_local_8);
            var _local_9:JPanel = new JPanel(new BorderLayout());
            _local_9.setBorder(new EmptyBorder(null, new Insets(0, 38, 0, 0)));
            _local_9.append(this._accessary2, BorderLayout.WEST);
            this._rightEquip.append(_local_9);
            var _local_10:JPanel = new JPanel(new BorderLayout());
            _local_10.append(this._head3, BorderLayout.EAST);
            _local_10.append(this._mount, BorderLayout.WEST);
            this._rightEquip.append(_local_10);
            this._midPanel = new JPanel(new BorderLayout());
            this._midPanel.setBorder(new EmptyBorder(null, new Insets(3, 3, 3, 3)));
            this._midPanel.append(this._leftEquip, BorderLayout.WEST);
            this._midPanel.append(this._rightEquip, BorderLayout.EAST);
            this._midPanel.append(this._characterPic, BorderLayout.CENTER);
            var _local_11:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            _local_11.setBorder(new EmptyBorder(null, new Insets(3, 3, 3, 3)));
            this._str = new CharacterStatsButton(ClientApplication.Localization.STAT_STR, CharacterInfo.SP_STR, ClientApplication.Instance.GetPopupText(38), 280, 55);
            this._agi = new CharacterStatsButton(ClientApplication.Localization.STAT_AGI, CharacterInfo.SP_AGI, ClientApplication.Instance.GetPopupText(39), 250, 40);
            this._vit = new CharacterStatsButton(ClientApplication.Localization.STAT_VIT, CharacterInfo.SP_VIT, ClientApplication.Instance.GetPopupText(40), 250, 85);
            this._int = new CharacterStatsButton(ClientApplication.Localization.STAT_INT, CharacterInfo.SP_INT, ClientApplication.Instance.GetPopupText(41), 250, 50);
            this._dex = new CharacterStatsButton(ClientApplication.Localization.STAT_DEX, CharacterInfo.SP_DEX, ClientApplication.Instance.GetPopupText(42), 280, 110);
            this._luk = new CharacterStatsButton(ClientApplication.Localization.STAT_LUK, CharacterInfo.SP_LUK, ClientApplication.Instance.GetPopupText(43), 280, 70);
            this._statToButton[CharacterInfo.SP_STR] = this._str;
            this._statToButton[CharacterInfo.SP_AGI] = this._agi;
            this._statToButton[CharacterInfo.SP_VIT] = this._vit;
            this._statToButton[CharacterInfo.SP_INT] = this._int;
            this._statToButton[CharacterInfo.SP_DEX] = this._dex;
            this._statToButton[CharacterInfo.SP_LUK] = this._luk;
            this._str.addEventListener(CharacterStatsButtonEvent.ON_STAT_INCREASED, this.OnStatIncreased, false, 0, true);
            this._agi.addEventListener(CharacterStatsButtonEvent.ON_STAT_INCREASED, this.OnStatIncreased, false, 0, true);
            this._vit.addEventListener(CharacterStatsButtonEvent.ON_STAT_INCREASED, this.OnStatIncreased, false, 0, true);
            this._int.addEventListener(CharacterStatsButtonEvent.ON_STAT_INCREASED, this.OnStatIncreased, false, 0, true);
            this._dex.addEventListener(CharacterStatsButtonEvent.ON_STAT_INCREASED, this.OnStatIncreased, false, 0, true);
            this._luk.addEventListener(CharacterStatsButtonEvent.ON_STAT_INCREASED, this.OnStatIncreased, false, 0, true);
            _local_11.append(this._str);
            _local_11.append(this._agi);
            _local_11.append(this._vit);
            _local_11.append(this._int);
            _local_11.append(this._dex);
            _local_11.append(this._luk);
            var _local_12:int = 60;
            var _local_13:int = 70;
            var _local_14:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            _local_14.setBorder(new EmptyBorder(null, new Insets(3, 5, 3, 3)));
            _local_14.append((this._atk = new PaddedValue(ClientApplication.Localization.STAT_ATK, "", (_local_12 - 10), (_local_13 + 10))));
            var _local_15:CustomToolTip = new CustomToolTip(this._atk, ClientApplication.Instance.GetPopupText(44), 250, 70);
            _local_14.append((this._matk = new PaddedValue(ClientApplication.Localization.STAT_MATK, "", (_local_12 - 5), (_local_13 + 5))));
            var _local_16:CustomToolTip = new CustomToolTip(this._matk, ClientApplication.Instance.GetPopupText(45), 250, 40);
            _local_14.append((this._hit = new PaddedValue(ClientApplication.Localization.STAT_HIT, "", (_local_12 + 10), (_local_13 - 10))));
            var _local_17:CustomToolTip = new CustomToolTip(this._hit, ClientApplication.Instance.GetPopupText(46), 250, 70);
            _local_14.append((this._critical = new PaddedValue(ClientApplication.Localization.STAT_CRITICAL, "", (_local_12 + 10), (_local_13 - 10))));
            var _local_18:CustomToolTip = new CustomToolTip(this._critical, ClientApplication.Instance.GetPopupText(47), 280, 115);
            var _local_19:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            _local_19.setBorder(new EmptyBorder(null, new Insets(3, 1, 3, 3)));
            _local_19.append((this._def = new PaddedValue(ClientApplication.Localization.STAT_DEF, "", _local_12, _local_13)));
            this._defTip = new CustomToolTip(this._def, ClientApplication.Instance.GetPopupText(48, 0, 0), 280, 175, false);
            _local_19.append((this._mdef = new PaddedValue(ClientApplication.Localization.STAT_MDEF, "", (_local_12 + 5), (_local_13 - 5))));
            var _local_20:CustomToolTip = new CustomToolTip(this._mdef, ClientApplication.Instance.GetPopupText(49), 280, 160);
            _local_19.append((this._flee = new PaddedValue(ClientApplication.Localization.STAT_FLEE, "", (_local_12 + 10), (_local_13 - 10))));
            var _local_21:CustomToolTip = new CustomToolTip(this._flee, ClientApplication.Instance.GetPopupText(50), 250, 40);
            _local_19.append((this._aspd = new PaddedValue(ClientApplication.Localization.STAT_ASPD, "", (_local_12 + 10), (_local_13 - 10))));
            var _local_22:CustomToolTip = new CustomToolTip(this._aspd, ClientApplication.Instance.GetPopupText(51), 210, 40);
            this._resetStatsButton = new CustomButton();
            this._resetStatsButton.addActionListener(this.OnResetStatsPressed);
            this._resetStatsButton.setBorder(new EmptyBorder(null, new Insets(3, 10, 0, 0)));
            new CustomToolTip(this._resetStatsButton, ClientApplication.Instance.GetPopupText(247), 180, 70);
            this._statusPoints = new PaddedValue(ClientApplication.Localization.STAT_STATUSPOINTS, "6", 135);
            this._statusPoints.setBorder(new EmptyBorder(null, new Insets(0, 5, 0, 0)));
            var _local_23:CustomToolTip = new CustomToolTip(this._statusPoints, ClientApplication.Instance.GetPopupText(52), 250, 40);
            var _local_24:JPanel = new JPanel(new SoftBoxLayout(0, 5));
            _local_24.append(this._statusPoints);
            _local_24.append(this._resetStatsButton);
            _local_24.setBorder(new EmptyBorder(null, new Insets(0, 0, 5, 0)));
            var _local_25:JPanel = new JPanel(new BorderLayout(2, 4));
            _local_25.append(_local_14, BorderLayout.WEST);
            _local_25.append(_local_19, BorderLayout.EAST);
            _local_25.append(_local_24, BorderLayout.SOUTH);
            var _local_26:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            _local_26.setBorder(new EmptyBorder(null, new Insets(4, 6, 0, 0)));
            _local_26.append(_local_11);
            _local_26.append(_local_25);
            setLayout(new BorderLayout());
            setBorder(new EmptyBorder(null, new Insets(6, 4, 4, 4)));
            append(this._midPanel, BorderLayout.CENTER);
            append(_local_26, BorderLayout.PAGE_END);
            pack();
        }

        public function GetButtonAddStat(_arg_1:uint):CharacterStatsButton
        {
            return (this._statToButton[_arg_1]);
        }

        private function OnStatIncreased(_arg_1:CharacterStatsButtonEvent):void
        {
            dispatchEvent(_arg_1);
        }

        private function OnResetStatsPressed(event:Event):void
        {
            var handler:Function = function (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    PerformStatReset();
                };
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.RESET_STATS_DIALOG_TITLE, StringUtil.substitute(ClientApplication.Localization.RESET_STATS_DIALOG_INFO, this._resetCost), handler, null, false, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }

        private function PerformStatReset():void
        {
            var _local_1:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (_local_1.money > this._resetCost)
            {
                ClientApplication.Instance.LocalGameClient.SendRemoteNPCClick("GeneralNPC_ReloadStats");
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.RESET_STATS_DIALOG_TITLE, ClientApplication.Localization.RESET_FAILED_DIALOG_INFO, null, null, false, new AttachIcon("AchtungIcon")));
            };
        }

        public function UpdateGraphics():void
        {
            AsWingUtil.UpdateCustomButtonFromAssetLocalization(this._resetStatsButton, "CharacterInventoryButton_reset1", "CharacterInventoryButton_reset2", "CharacterInventoryButton_reset3");
            AsWingUtil.SetSize(this._resetStatsButton, 75, 21);
            this._str.UpdateGraphics();
            this._agi.UpdateGraphics();
            this._vit.UpdateGraphics();
            this._int.UpdateGraphics();
            this._dex.UpdateGraphics();
            this._luk.UpdateGraphics();
        }

        public function RevalidateCharacterIcon():void
        {
            var _local_3:AttachIcon;
            var _local_4:Bitmap;
            var _local_1:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_2:String = CharacterStorage.Instance.LocalPlayerIconBig;
            if (_local_2 != null)
            {
                this._jobId = _local_1.jobId;
                _local_3 = new AttachIcon(_local_2);
                _local_4 = CharacterStorage.Instance.GetCustomizedCharacterIcon(420, 220, _local_1.Equipment);
                if (_local_4)
                {
                    this._characterPic.setIcon(new AssetIcon(_local_4));
                }
                else
                {
                    this._characterPic.setIcon(_local_3);
                };
                pack();
            };
        }

        public function RevalidateEquipment():void
        {
            var _local_1:CharacterInfo;
            var _local_2:ItemData;
            var _local_3:ItemData;
            var _local_6:CharacterStatsItemSlot;
            var _local_7:Object;
            var _local_8:int;
            _local_1 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_4:ItemData = _local_1.Equipment.GetItemBySlotName(CharacterEquipment.SLOT_RIGHT_HAND);
            if (_local_4 != null)
            {
                _local_7 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items")).GetServerDescriptionObject(_local_4.NameId);
                _local_8 = ((_local_7 != null) ? int(_local_7["view"]) : 0);
                if (((_local_4.Type == 4) && (_local_8 == 11)))
                {
                    this._leftHand.SetSlotItem(CharacterEquipment.SLOT_ARROWS);
                }
                else
                {
                    _local_2 = _local_1.Equipment.GetItemBySlotName(CharacterEquipment.SLOT_ARROWS);
                    _local_3 = _local_1.Equipment.GetItemBySlotName(CharacterEquipment.SLOT_LEFT_HAND);
                    if (((!(_local_2 == null)) && (_local_3 == null)))
                    {
                        this._leftHand.SetSlotItem(CharacterEquipment.SLOT_ARROWS);
                    }
                    else
                    {
                        this._leftHand.SetSlotItem(CharacterEquipment.SLOT_LEFT_HAND);
                    };
                };
            }
            else
            {
                _local_2 = _local_1.Equipment.GetItemBySlotName(CharacterEquipment.SLOT_ARROWS);
                _local_3 = _local_1.Equipment.GetItemBySlotName(CharacterEquipment.SLOT_LEFT_HAND);
                if (((!(_local_2 == null)) && (_local_3 == null)))
                {
                    this._leftHand.SetSlotItem(CharacterEquipment.SLOT_ARROWS);
                }
                else
                {
                    this._leftHand.SetSlotItem(CharacterEquipment.SLOT_LEFT_HAND);
                };
            };
            var _local_5:Array = [this._head1, this._head2, this._head3, this._body, this._rightHand, this._leftHand, this._robe, this._shoes, this._accessary1, this._accessary2, this._soulshot, this._mount, this._belt, this._tabard, this._suit];
            for each (_local_6 in _local_5)
            {
                _local_6.Revalidate();
            };
            this.RevalidateCharacterIcon();
        }

        public function RevalidateStats(_arg_1:CharacterInfo):void
        {
            this._str.SetPoints(_arg_1.str, _arg_1.strBonus, _arg_1.ustr, _arg_1.statusPoint);
            this._agi.SetPoints(_arg_1.agi, _arg_1.agiBonus, _arg_1.uagi, _arg_1.statusPoint);
            this._vit.SetPoints(_arg_1.vit, _arg_1.vitBonus, _arg_1.uvit, _arg_1.statusPoint);
            this._int.SetPoints(_arg_1.intl, _arg_1.intBonus, _arg_1.uintl, _arg_1.statusPoint);
            this._dex.SetPoints(_arg_1.dex, _arg_1.dexBonus, _arg_1.udex, _arg_1.statusPoint);
            this._luk.SetPoints(_arg_1.luk, _arg_1.lukBonus, _arg_1.uluk, _arg_1.statusPoint);
            this._atk.Value = (((_arg_1.batk + _arg_1.atk1) + " + ") + _arg_1.atk2);
            this._matk.Value = ((_arg_1.matkMin + " ~ ") + _arg_1.matkMax);
            this._hit.Value = _arg_1.hit.toString();
            this._critical.Value = _arg_1.critical.toString();
            this._def.Value = ((_arg_1.def1 + " + ") + _arg_1.def2);
            this._mdef.Value = ((_arg_1.mdef1 + " + ") + _arg_1.mdef2);
            this._flee.Value = ((_arg_1.flee1 + " + ") + _arg_1.flee2);
            if ((((!(this._lastDef == _arg_1.def1)) || (!(this._lastOldDef == _arg_1.olddef))) && (!(_arg_1.kdef == 0))))
            {
                this._lastDef = _arg_1.def1;
                this._lastOldDef = _arg_1.olddef;
                this._defTip.updateToolTip(ClientApplication.Instance.GetPopupText(48, _arg_1.olddef, Number((_arg_1.kdef / 100))));
            };
            var _local_2:int = (200 - ((_arg_1.aspd < 10) ? 10 : (_arg_1.aspd / 10)));
            this._aspd.Value = _local_2.toString();
            this._statusPoints.Value = _arg_1.statusPoint.toString();
            pack();
        }


    }
}//package hbm.Game.GUI.CharacterStats

