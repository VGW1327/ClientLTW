


//hbm.Game.GUI.Runes.UpgradeWindow

package hbm.Game.GUI.Runes
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JLabel;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.SoftBoxLayout;
    import org.aswing.EmptyLayout;
    import org.aswing.geom.IntPoint;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import org.aswing.AssetBackground;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import __AS3__.vec.Vector;
    import flash.events.Event;

    public class UpgradeWindow extends CustomWindow 
    {

        private const _width:int = 470;
        private const _height:int = 262;

        private var _itemSlot:UpgradeItemSlot;
        private var _runesCountLabel:JLabel;
        private var _runeSlots:Array;

        public function UpgradeWindow()
        {
            super(null, ClientApplication.Localization.UPGRADE_WINDOW_TITLE, false, this._width, this._height, true);
            this.InitUI();
            this.Revalidate();
            pack();
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
        }

        private function InitUI():void
        {
            var _local_4:AdditionalDataResourceLibrary;
            var _local_8:RuneSlot;
            var _local_9:RuneItemPanel;
            var _local_1:JPanel = new JPanel(new BorderLayout());
            _local_1.setBorder(new EmptyBorder(null, new Insets(12, 6, 4, 4)));
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4, SoftBoxLayout.TOP));
            var _local_3:JPanel = new JPanel(new EmptyLayout());
            this._itemSlot = new UpgradeItemSlot();
            this._itemSlot.Revalidate();
            this._itemSlot.setLocation(new IntPoint(36, 114));
            _local_4 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_5:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_UpgradeRune");
            if (_local_5)
            {
                _local_3.setBackgroundDecorator(new AssetBackground(_local_5));
                _local_3.setPreferredHeight((_local_5.height + 8));
                _local_3.setPreferredWidth((_local_5.width + 4));
                _local_3.setMaximumHeight((_local_5.height + 8));
                _local_3.setMaximumWidth((_local_5.width + 4));
            };
            _local_3.append(this._itemSlot);
            var _local_6:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            this._runeSlots = new Array();
            var _local_7:int;
            while (_local_7 < 4)
            {
                _local_8 = new RuneSlot(_local_7);
                _local_8.Revalidate();
                _local_9 = new RuneItemPanel(_local_8, this._itemSlot);
                this._runeSlots.push(_local_9);
                _local_6.append(_local_9);
                _local_7++;
            };
            this._runesCountLabel = new JLabel((ClientApplication.Localization.UPGRADE_WINDOW_RUNES_COUNT_LABEL + ": "), null, JLabel.LEFT);
            this._runesCountLabel.setBorder(new EmptyBorder(null, new Insets(5, 4, 0, 0)));
            _local_6.append(this._runesCountLabel, BorderLayout.PAGE_END);
            _local_2.append(_local_3);
            _local_2.append(_local_6);
            _local_1.append(_local_2, BorderLayout.CENTER);
            MainPanel.append(_local_1, BorderLayout.CENTER);
            addEventListener(CustomWindow.CUSTOM_WINDOW_CLOSED, this.OnClose, false, 0, true);
        }

        public function Revalidate():void
        {
            var _local_1:RuneItemPanel;
            var _local_2:CharacterInfo;
            var _local_3:ItemData;
            var _local_4:int;
            var _local_5:ItemsResourceLibrary;
            var _local_6:Object;
            var _local_7:int;
            var _local_8:Vector.<int>;
            var _local_9:Boolean;
            var _local_10:int;
            var _local_11:RuneSlot;
            var _local_12:int;
            var _local_13:ItemData;
            var _local_14:Object;
            if (this._itemSlot.Item)
            {
                _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                _local_3 = _local_2.Items[this._itemSlot.Item.Item.Id];
                if (_local_3)
                {
                    _local_4 = _local_3.Type;
                    if (((_local_4 == ItemData.IT_WEAPON) || (_local_4 == ItemData.IT_ARMOR)))
                    {
                        _local_5 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
                        _local_6 = _local_5.GetServerDescriptionObject(_local_3.NameId);
                        if (_local_6)
                        {
                            _local_7 = _local_6["slots"];
                            _local_8 = _local_3.Cards;
                            _local_9 = ((!(_local_8 == null)) && (_local_8[0] == 0xFF));
                            _local_10 = 0;
                            for each (_local_1 in this._runeSlots)
                            {
                                _local_11 = _local_1.SlotRune;
                                if ((((_local_11.SlotIndex >= _local_7) && (!(_local_9))) || ((_local_9) && (!(_local_11.SlotIndex == 1)))))
                                {
                                    _local_11.SetItem(null);
                                    _local_11.SlotType = -1;
                                }
                                else
                                {
                                    _local_12 = ((_local_8 != null) ? _local_8[_local_11.SlotIndex] : 0);
                                    if (_local_12 != 0)
                                    {
                                        _local_13 = new ItemData();
                                        _local_14 = _local_5.GetServerDescriptionObject(_local_12);
                                        _local_13.Amount = 1;
                                        _local_13.NameId = _local_12;
                                        _local_13.Identified = 1;
                                        _local_13.Origin = ItemData.QUEST;
                                        _local_13.Type = _local_14["type"];
                                        _local_13.Attr = _local_3.Attr;
                                        _local_11.SetItem(_local_13);
                                        _local_11.SlotType = 1;
                                    }
                                    else
                                    {
                                        if ((((!(_local_11.SlotType == 0)) || (!(_local_11.Item))) || ((_local_11.SlotType == 0) && (!(_local_2.Items[_local_11.Item.Item.Id])))))
                                        {
                                            _local_11.SetItem(null);
                                            _local_11.SlotType = 0;
                                            _local_10++;
                                        };
                                    };
                                };
                                _local_1.Revalidate();
                            };
                        };
                        this._runesCountLabel.visible = true;
                        this._runesCountLabel.setText(((ClientApplication.Localization.UPGRADE_WINDOW_RUNES_COUNT_LABEL + ": ") + _local_10));
                    };
                }
                else
                {
                    this._itemSlot.SetItem(null);
                    this._itemSlot.Revalidate();
                };
            }
            else
            {
                this.ClearRuneSlots();
                this._runesCountLabel.visible = false;
            };
        }

        public function ClearUpgradeSlot():void
        {
            this._itemSlot.SetItem(null);
            this._itemSlot.Revalidate();
        }

        public function SetUpgradeSlot(_arg_1:ItemData):void
        {
            this._itemSlot.SetItem(_arg_1);
            this._itemSlot.Revalidate();
            this.ClearRuneSlots();
        }

        public function ClearRuneSlot(_arg_1:ItemData):void
        {
            var _local_2:RuneItemPanel;
            var _local_3:RuneSlot;
            for each (_local_2 in this._runeSlots)
            {
                _local_3 = _local_2.SlotRune;
                if (((_local_3.Item) && (_local_3.Item.Item.Id == _arg_1.Id)))
                {
                    _local_3.SetItem(null);
                    _local_2.Revalidate();
                };
            };
        }

        private function ClearRuneSlots():void
        {
            var _local_1:RuneItemPanel;
            var _local_2:RuneSlot;
            for each (_local_1 in this._runeSlots)
            {
                _local_2 = _local_1.SlotRune;
                _local_2.SetItem(null);
                _local_1.Revalidate();
            };
        }

        private function OnClose(_arg_1:Event):void
        {
            this.ClearUpgradeSlot();
            this.ClearRuneSlots();
            dispose();
        }


    }
}//package hbm.Game.GUI.Runes

