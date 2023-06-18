


//hbm.Game.GUI.Repair.RepairWindow

package hbm.Game.GUI.Repair
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import org.aswing.ASFont;
    import hbm.Game.GUI.Tools.WindowSprites;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.EmptyLayout;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JScrollPane;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.BorderLayout;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import org.aswing.JTextArea;
    import org.aswing.JOptionPane;
    import hbm.Game.Utility.Payments;
    import hbm.Game.Utility.HtmlText;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.AttachIcon;
    import flash.events.Event;
    import hbm.Engine.Renderer.RenderSystem;

    public class RepairWindow extends WindowPrototype 
    {

        private const WIDTH:int = 640;
        private const HEIGHT:int = 650;

        private var _listPanel:JPanel;
        private var _costAllRepair:JLabel;
        private var _repairAllPanel:JPanel;
        private var _cantRepair:JLabel;
        private var _costFont:ASFont;
        private var _coinClassIcon:Class;
        private var _currency:int;
        private var _items:Object;

        public function RepairWindow(_arg_1:int, _arg_2:Array, _arg_3:uint)
        {
            this._currency = _arg_1;
            this._coinClassIcon = ((this._currency == 1) ? WindowSprites.CoinGoldBig : WindowSprites.CoinSilverBig);
            super(owner, ClientApplication.Localization.REPAIR_WINDOW_TITLE, true, this.WIDTH, this.HEIGHT, true);
            var _local_4:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_5:* = (_arg_2.length > 0);
            this._cantRepair.visible = (!(_local_5));
            this._repairAllPanel.visible = (this._listPanel.visible = _local_5);
            if (_local_5)
            {
                this.LoadItems(_arg_2);
                this._costAllRepair.setText(_arg_3.toString());
            };
        }

        override protected function InitUI():void
        {
            super.InitUI();
            this._costFont = new ASFont(getFont().getName(), 15);
            if (_closeWindowButton2)
            {
                _closeWindowButton2.removeFromContainer();
            };
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(_local_1, "RW_Background");
            this._listPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
            var _local_2:JScrollPane = new JScrollPane(this._listPanel, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER);
            _local_2.setLocationXY(10, 23);
            AsWingUtil.SetSize(_local_2, 584, 414);
            _local_1.append(_local_2);
            this._repairAllPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 6));
            AsWingUtil.SetSize(this._repairAllPanel, 400, 32);
            this._repairAllPanel.setLocationXY(184, 460);
            _local_1.append(this._repairAllPanel);
            var _local_3:CustomButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("RW_RepairAllButton", "RW_RepairAllButtonOver");
            _local_3.addActionListener(this.OnRepairAll, 0, true);
            this._repairAllPanel.append(_local_3);
            var _local_4:JLabel = new JLabel();
            AsWingUtil.SetBackground(_local_4, new this._coinClassIcon());
            this._repairAllPanel.append(AsWingUtil.OffsetBorder(_local_4, 0, 4));
            this._costAllRepair = AsWingUtil.CreateLabel("", 0xFFFFFF, this._costFont);
            this._repairAllPanel.append(this._costAllRepair);
            this._cantRepair = AsWingUtil.CreateLabel(ClientApplication.Localization.REPAIR_WINDOW_NOTREPAIR, 0xFFFFFF, this._costFont);
            AsWingUtil.SetSize(this._cantRepair, 500, 40);
            this._cantRepair.setLocationXY(50, 50);
            _local_1.append(this._cantRepair);
            Body.append(_local_1, BorderLayout.CENTER);
            pack();
        }

        private function LoadItems(_arg_1:Array):void
        {
            var _local_3:ItemData;
            var _local_4:JPanel;
            var _local_5:uint;
            var _local_6:uint;
            this._items = {};
            this._listPanel.removeAll();
            var _local_2:Boolean = true;
            for each (_local_3 in _arg_1)
            {
                _local_4 = this.CreateItemList(_local_3, _local_2);
                this._items[_local_3.Id] = _local_4;
                this._listPanel.append(_local_4);
                _local_2 = (!(_local_2));
            };
            if (_arg_1.length < 6)
            {
                _local_5 = (6 - _arg_1.length);
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    this._listPanel.append(this.CreateFakeItemList(_local_2));
                    _local_2 = (!(_local_2));
                    _local_6++;
                };
            };
        }

        private function CreateFakeItemList(_arg_1:Boolean):JPanel
        {
            var _local_2:JPanel = new JPanel();
            AsWingUtil.SetBackgroundFromAsset(_local_2, ((_arg_1) ? "RW_ItemFrame1" : "RW_ItemFrame2"));
            return (_local_2);
        }

        private function CreateItemList(_arg_1:ItemData, _arg_2:Boolean):JPanel
        {
            var _local_4:InventoryStoreItem;
            var _local_7:uint;
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
            AsWingUtil.SetBackgroundFromAsset(_local_3, ((_arg_2) ? "RW_ItemFrame1" : "RW_ItemFrame2"));
            _local_4 = new InventoryStoreItem(_arg_1, false);
            AsWingUtil.SetBorder(_local_4, 30, 0);
            _local_3.append(_local_4);
            var _local_5:JTextArea = AsWingUtil.CreateTextArea((("<font color='#ffffff' size='15'>" + _local_4.Name) + "</font>"));
            AsWingUtil.SetWidth(_local_5, 195);
            AsWingUtil.SetBorder(_local_5, 20);
            _local_5.pack();
            AsWingUtil.SetBorder(_local_5, 20, ((66 - _local_5.getTextField().textHeight) / 2));
            _local_3.append(_local_5);
            var _local_6:JTextArea = AsWingUtil.CreateTextArea((("<font size='15'>" + _local_4.GetDurabilityText()) + "</font>"));
            AsWingUtil.SetWidth(_local_6, 85);
            AsWingUtil.SetBorder(_local_6, 8, 24);
            _local_3.append(_local_6);
            _local_7 = _local_4.GetRepairPrice((this._currency == 1));
            var _local_8:CustomButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("RW_RepairButton", "RW_RepairButtonOver");
            _local_8.putClientProperty("RepairID", _arg_1.Id);
            _local_8.putClientProperty("Cost", _local_7);
            _local_8.addActionListener(this.OnRepairItem, 0, true);
            _local_3.append(AsWingUtil.OffsetBorder(_local_8, 4, 18));
            var _local_9:JLabel = new JLabel();
            AsWingUtil.SetBackground(_local_9, new this._coinClassIcon());
            _local_3.append(AsWingUtil.OffsetBorder(_local_9, 10, 22));
            var _local_10:JLabel = AsWingUtil.CreateLabel(_local_7.toString(), 0xFFFFFF, this._costFont);
            AsWingUtil.SetBorder(_local_10, 4);
            _local_3.append(_local_10);
            return (_local_3);
        }

        private function OnRepairItem(evt:Event):void
        {
            var id:uint;
            var cost:uint;
            var text:String;
            var btn:CustomButton = (evt.currentTarget as CustomButton);
            if (btn)
            {
                id = btn.getClientProperty("RepairID");
                cost = btn.getClientProperty("Cost");
                if (this._currency == 1)
                {
                    var resultDlgBuy:Function = function (_arg_1:int):void
                    {
                        if (_arg_1 == JOptionPane.YES)
                        {
                            if (Payments.TestAmountPay(ItemData.CASH, cost))
                            {
                                ClientApplication.Instance.LocalGameClient.SendRepairItem(id);
                            };
                        };
                    };
                    text = HtmlText.GetText(ClientApplication.Localization.REPAIR_WINDOW_APPLY_REPAIR, Payments.GetTextAmountCoins(ItemData.CASH, cost));
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.REPAIR_WINDOW_DIALOG_TITLE, text, resultDlgBuy, null, false, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
                }
                else
                {
                    if (Payments.TestAmountPay(ItemData.ZENY, cost))
                    {
                        ClientApplication.Instance.LocalGameClient.SendRepairItem(id);
                    };
                };
            };
        }

        override public function show():void
        {
            super.show();
            setLocationXY(((RenderSystem.Instance.ScreenWidth - width) / 2), ((RenderSystem.Instance.ScreenHeight - height) / 2));
        }

        public function UpdateTotalRepairPrice(_arg_1:int):void
        {
            var _local_2:Boolean;
            _local_2 = (_arg_1 > 0);
            this._cantRepair.visible = (!(_local_2));
            this._repairAllPanel.visible = (this._listPanel.visible = _local_2);
            this._costAllRepair.setText(_arg_1.toString());
        }

        public function RepairItem(_arg_1:ItemData):void
        {
            var _local_3:uint;
            var _local_4:Boolean;
            var _local_5:uint;
            var _local_2:JPanel = this._items[_arg_1.Id];
            if (_local_2)
            {
                _local_2.removeFromContainer();
                delete this._items[_arg_1.Id];
                _local_4 = true;
                _local_3 = 0;
                while (_local_3 < this._listPanel.getComponentCount())
                {
                    AsWingUtil.SetBackgroundFromAsset(this._listPanel.getComponent(_local_3), ((_local_4) ? "RW_ItemFrame1" : "RW_ItemFrame2"));
                    _local_4 = (!(_local_4));
                    _local_3++;
                };
                if (this._listPanel.getComponentCount() < 6)
                {
                    _local_5 = (6 - this._listPanel.getComponentCount());
                    _local_3 = 0;
                    while (_local_3 < _local_5)
                    {
                        this._listPanel.append(this.CreateFakeItemList(_local_4));
                        _local_4 = (!(_local_4));
                        _local_3++;
                    };
                };
                ClientApplication.Instance.LocalGameClient.SendGetRepairList(false);
            };
        }

        private function OnRepairAll(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendRepairAllItems(this._currency);
        }


    }
}//package hbm.Game.GUI.Repair

