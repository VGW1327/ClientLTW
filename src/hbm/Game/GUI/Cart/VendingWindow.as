


//hbm.Game.GUI.Cart.VendingWindow

package hbm.Game.GUI.Cart
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JTextField;
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.PaddedValue;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Application.ClientApplication;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.JLabel;
    import org.aswing.JScrollPane;
    import org.aswing.FlowLayout;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Actors.CartData;
    import hbm.Engine.Actors.ItemData;
    import flash.utils.Dictionary;
    import flash.events.Event;
    import org.aswing.AttachIcon;
    import org.aswing.event.AWEvent;

    public class VendingWindow extends CustomWindow 
    {

        private const _width:int = 570;
        private const _height:int = 395;

        private var _vendingData:Array;
        private var _shopName:JTextField;
        private var _vendingItemsPanel:JPanel;
        private var _vendingItems:Array;
        private var _slots:int;
        private var _tradeButton:CustomButton;
        private var _closeButton:CustomButton;
        private var _trading:Boolean;
        private var _statusLabel:PaddedValue;
        private var _tradeToolTip1:CustomToolTip;
        private var _closeToolTip1:CustomToolTip;
        private var _tradeToolTip2:CustomToolTip;
        private var _closeToolTip2:CustomToolTip;

        public function VendingWindow(_arg_1:CharacterInfo=null, _arg_2:int=0)
        {
            super(null, ClientApplication.Localization.VENDING_TITLE, false, this._width, this._height, true);
            this._slots = _arg_2;
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.TOP));
            var _local_4:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_5:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.TOP));
            _local_5.setBorder(_local_4);
            var _local_6:JLabel = new JLabel(ClientApplication.Localization.VENDING_SHOP_MSG1);
            _local_6.setHorizontalAlignment(JLabel.LEFT);
            this._shopName = new JTextField(((ClientApplication.Localization.VENDING_SHOP_NAME_PART1 + " ") + ((_arg_1 == null) ? ClientApplication.Localization.VENDING_SHOP_NAME_PART2 : _arg_1.name)));
            this._shopName.setPreferredWidth(520);
            _local_5.append(_local_6);
            _local_5.append(this._shopName);
            _local_3.append(_local_5);
            var _local_7:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.TOP));
            _local_7.setBorder(_local_4);
            var _local_8:JLabel = new JLabel(((((ClientApplication.Localization.VENDING_SHOP_MSG2_PART1 + " ") + this._slots) + " ") + ClientApplication.Localization.VENDING_SHOP_MSG2_PART2));
            _local_8.setHorizontalAlignment(JLabel.LEFT);
            _local_7.append(_local_8);
            var _local_9:JLabel = new JLabel(ClientApplication.Localization.VENDING_SHOP_MSG3);
            _local_9.setHorizontalAlignment(JLabel.LEFT);
            _local_7.append(_local_9);
            this._vendingItemsPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.TOP));
            var _local_10:JScrollPane = new JScrollPane(this._vendingItemsPanel, JScrollPane.SCROLLBAR_ALWAYS);
            _local_10.setPreferredHeight(250);
            _local_7.append(_local_10);
            _local_3.append(_local_7);
            var _local_11:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            this._statusLabel = new PaddedValue(ClientApplication.Localization.VENDING_STATUS_BAR, ((("0 " + ClientApplication.Localization.VENDING_STATUS_BAR_PART1) + " ") + this._slots.toString()), 260, 120);
            var _local_12:CustomToolTip = new CustomToolTip(this._statusLabel, ClientApplication.Instance.GetPopupText(109), 235, 40);
            this._tradeButton = new CustomButton(ClientApplication.Localization.VENDING_BUTTON_TRADE1);
            this._tradeToolTip1 = new CustomToolTip(this._tradeButton, ClientApplication.Instance.GetPopupText(97), 160, 20);
            this._tradeToolTip2 = new CustomToolTip(this._tradeButton, ClientApplication.Instance.GetPopupText(120), 180, 40);
            this._tradeToolTip2.setVisible(false);
            this._tradeButton.setEnabled(false);
            this._tradeButton.addActionListener(this.OnVendingBegin, 0, true);
            this._closeButton = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            this._closeToolTip1 = new CustomToolTip(this._closeButton, ClientApplication.Instance.GetPopupText(2), 180, 20);
            this._closeToolTip2 = new CustomToolTip(this._closeButton, ClientApplication.Instance.GetPopupText(119), 240, 40);
            this._closeToolTip2.setVisible(false);
            this._closeButton.addActionListener(this.OnCloseButton, 0, true);
            _local_11.append(this._statusLabel);
            _local_11.append(this._tradeButton);
            _local_11.append(this._closeButton);
            var _local_13:JPanel = new JPanel(new BorderLayout());
            _local_13.setBorder(new EmptyBorder(null, new Insets(6, 4, 4, 4)));
            _local_13.append(_local_3, BorderLayout.CENTER);
            _local_13.append(_local_11, BorderLayout.PAGE_END);
            MainPanel.append(_local_13, BorderLayout.CENTER);
            pack();
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
            ClientApplication.Instance.SetShortcutsEnabled(false);
            addEventListener(CustomWindow.CUSTOM_WINDOW_CLOSED, this.OnClose, false, 0, true);
        }

        public function RevalidateItems():void
        {
            var _local_1:CartData = ClientApplication.Instance.LocalGameClient.Cart;
            if (_local_1)
            {
                this.Revalidate(_local_1.Cart);
            };
        }

        protected function Revalidate(_arg_1:Dictionary):void
        {
            var _local_3:ItemData;
            var _local_5:VendingItemPanel;
            var _local_6:int;
            var _local_7:VendingItemPanel;
            var _local_8:String;
            var _local_9:VendingItemPanel;
            this._vendingItemsPanel.removeAll();
            var _local_2:Array = new Array();
            var _local_4:Dictionary = new Dictionary(true);
            for each (_local_5 in this._vendingItems)
            {
                _local_3 = _local_5.Item.Item;
                _local_4[((_local_3.Id + ":") + _local_3.NameId)] = _local_5;
            };
            _local_6 = 0;
            for each (_local_3 in _arg_1)
            {
                if (_local_3.Identified != 0)
                {
                    _local_7 = new VendingItemPanel(_local_3);
                    _local_7.addEventListener(VendingItemPanel.ON_SELECTION_CHANGED, this.OnSelectionChanged, false, 0, true);
                    this._vendingItemsPanel.append(_local_7);
                    _local_8 = ((_local_3.Id + ":") + _local_3.NameId);
                    _local_9 = _local_4[_local_8];
                    if (_local_9)
                    {
                        if (_local_9.IsChecked)
                        {
                            _local_6 = (_local_6 + 1);
                        };
                        _local_7.SetVendingData(_local_9.IsChecked, Math.min(_local_9.Amount, _local_3.Amount), _local_9.Price);
                    };
                    _local_2.push(_local_7);
                };
            };
            this._vendingItems = _local_2;
            this._tradeButton.setEnabled((_local_6 > 0));
            this._statusLabel.Value = ((((_local_6.toString() + " ") + ClientApplication.Localization.VENDING_STATUS_BAR_PART1) + " ") + this._slots.toString());
        }

        private function OnSelectionChanged(_arg_1:Event):void
        {
            var _local_4:VendingItemPanel;
            var _local_2:VendingItemPanel = (_arg_1.target as VendingItemPanel);
            var _local_3:int;
            for each (_local_4 in this._vendingItems)
            {
                if (_local_4.IsChecked)
                {
                    _local_3++;
                };
            };
            if (_local_3 > this._slots)
            {
                _local_2.Clear();
                _local_3 = this._slots;
            };
            this._tradeButton.setEnabled((_local_3 > 0));
            this._statusLabel.Value = ((((_local_3.toString() + " ") + ClientApplication.Localization.VENDING_STATUS_BAR_PART1) + " ") + this._slots.toString());
        }

        private function SetTradingMode(_arg_1:Boolean):void
        {
            this._trading = _arg_1;
            ClientApplication.Instance._tradingMode = _arg_1;
            if (this._trading)
            {
                ClientApplication.Instance.SetShortcutsEnabled(false);
                this._tradeButton.setText(ClientApplication.Localization.VENDING_BUTTON_TRADE2);
                this._tradeToolTip1.setVisible(false);
                this._tradeToolTip2.setVisible(true);
                this._shopName.setEnabled(false);
                this._closeButton.setText(ClientApplication.Localization.VENDING_BUTTON_CLOSE2);
                this._closeToolTip1.setVisible(false);
                this._closeToolTip2.setVisible(true);
                this._statusLabel.setVisible(false);
                this._vendingItemsPanel.removeAll();
                this._vendingItemsPanel.append(new JLabel(ClientApplication.Localization.VENDING_MESSAGE, new AttachIcon("AchtungIcon"), JLabel.CENTER));
                SetClosable(false);
                alpha = 0.9;
                ClientApplication.Instance.LocalGameClient.SendPetReturnToEgg();
            }
            else
            {
                ClientApplication.Instance.SetShortcutsEnabled(true);
                this._tradeButton.setEnabled(false);
                this._tradeButton.setText(ClientApplication.Localization.VENDING_BUTTON_TRADE1);
                this._tradeToolTip1.setVisible(true);
                this._tradeToolTip2.setVisible(false);
                this._shopName.setEnabled(true);
                this._closeButton.setText(ClientApplication.Localization.BUTTON_CLOSE);
                this._closeToolTip1.setVisible(true);
                this._closeToolTip2.setVisible(false);
                this._statusLabel.setVisible(true);
                this.RevalidateItems();
                SetClosable(true);
                alpha = 1;
            };
        }

        private function OnVendingBegin(_arg_1:AWEvent):void
        {
            var _local_3:VendingItemPanel;
            if (this._trading)
            {
                if (this._vendingData)
                {
                    this._vendingData = null;
                };
                this.SetTradingMode(false);
                ClientApplication.Instance.SetShortcutsEnabled(false);
                ClientApplication.Instance.LocalGameClient.SendVenderStop();
                return;
            };
            var _local_2:String = this._shopName.getText();
            if (_local_2.length == 0)
            {
                return;
            };
            this._vendingData = new Array();
            for each (_local_3 in this._vendingItems)
            {
                if (_local_3.IsChecked)
                {
                    this._vendingData.push({
                        "Id":_local_3.Item.Item.Id,
                        "Amount":_local_3.Amount,
                        "Price":_local_3.Price
                    });
                };
            };
            if (this._vendingData.length > 0)
            {
                ClientApplication.Instance.LocalGameClient.SendVenderCreate(_local_2, this._vendingData);
            };
        }

        public function VenderCreate():void
        {
            if (((this._vendingData) && (this._vendingData.length > 0)))
            {
                this.SetTradingMode(true);
            };
        }

        public function VenderClose():void
        {
            this.SetTradingMode(false);
        }

        private function OnClose(_arg_1:Event):void
        {
            if (this._trading)
            {
                ClientApplication.Instance.LocalGameClient.SendQuit(true);
            }
            else
            {
                ClientApplication.Instance.SetShortcutsEnabled(true);
            };
        }

        private function OnCloseButton(_arg_1:AWEvent):void
        {
            this.OnClose(null);
            dispose();
        }


    }
}//package hbm.Game.GUI.Cart

