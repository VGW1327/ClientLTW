


//hbm.Game.GUI.Trade.TradeWindow

package hbm.Game.GUI.Trade
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JLabel;
    import org.aswing.JAdjuster;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Application.ClientApplication;
    import org.aswing.JPanel;
    import org.aswing.BoxLayout;
    import org.aswing.BorderLayout;
    import hbm.Engine.Actors.Actors;
    import org.aswing.EmptyLayout;
    import org.aswing.SoftBoxLayout;
    import flash.display.Bitmap;
    import org.aswing.geom.IntDimension;
    import org.aswing.AssetBackground;
    import org.aswing.Component;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.CenterLayout;
    import org.aswing.AsWingConstants;
    import org.aswing.FlowLayout;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.event.AWEvent;
    import flash.events.Event;

    public class TradeWindow extends WindowPrototype 
    {

        private const _winWidth:int = 423;
        private const _winHeight:int = 440;

        private var _sellerId:int;
        private var _player:CharacterInfo;
        private var _otherSideItemsPanel:TradePanel;
        private var _playerSideItemsPanel:TradePanel;
        private var _closeButton:CustomButton;
        private var _lockButton:CustomButton;
        private var _confirmButton:CustomButton;
        private var _otherReadyLabel:TradeStatusLabel;
        private var _playerSideLabel:JLabel;
        private var _otherSideLabel:JLabel;
        private var _playerSilverOffering:JAdjuster;
        private var _otherSilverOffering:JLabel;
        private var _sendCancel:Boolean = true;
        private var _sellConfirm:Boolean = false;
        private var _buyConfirm:Boolean = false;
        private var _lastZeny:int = 0;
        private var _decorativeBorder:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
        private var _dataLibrary:AdditionalDataResourceLibrary = (ResourceManager.Instance.Library("AdditionalData") as AdditionalDataResourceLibrary);

        public function TradeWindow(_arg_1:int)
        {
            super(owner, ClientApplication.Localization.TRADE_TITLE, false, this._winWidth, this._winHeight, true);
            this._sellerId = _arg_1;
            setLocationXY(((ClientApplication.stageWidth / 2) + 10), ((0x0300 - this._winHeight) / 2));
            this.InitGUI();
        }

        private function InitGUI():void
        {
            var _local_1:JPanel = new JPanel(new BoxLayout());
            var _local_2:JPanel = new JPanel(new BorderLayout());
            _local_2.append(this.CreateItemExchangePanel(), BorderLayout.CENTER);
            _local_2.append(this.CreateMoneyPanel(), BorderLayout.PAGE_END);
            _local_1.append(_local_2);
            Body.append(_local_1, BorderLayout.CENTER);
            Bottom.removeAll();
            Bottom.append(this.CreateButtonPanel());
            pack();
        }

        private function CreateItemExchangePanel():Component
        {
            var _local_1:Actors;
            _local_1 = ClientApplication.Instance.LocalGameClient.ActorList;
            var _local_2:CharacterInfo = _local_1.GetActor(this._sellerId);
            this._player = _local_1.GetPlayer();
            var _local_3:JPanel = new JPanel(new EmptyLayout());
            var _local_4:JPanel = new JPanel(new BoxLayout(SoftBoxLayout.X_AXIS, 4));
            var _local_5:Bitmap = this.GetImage("ItemExchangePanelBack");
            var _local_6:IntDimension = new IntDimension(_local_5.width, _local_5.height);
            _local_4.setBackgroundDecorator(new AssetBackground(_local_5));
            _local_4.setSize(_local_6);
            _local_4.append(this.CreateLeftPanel());
            _local_4.append(this.CreateRightPanel(_local_2));
            _local_3.setPreferredSize(_local_6);
            _local_3.append(_local_4);
            _local_3.append(this.CreateOtherReadyLabel());
            return (_local_3);
        }

        private function CreateLeftPanel():Component
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 10));
            _local_1.setBorder(new EmptyBorder(null, new Insets(22, 0, 0, 7)));
            var _local_2:JPanel = new JPanel(new CenterLayout());
            _local_2.setBorder(new EmptyBorder(null, new Insets(0, 15)));
            this._playerSideLabel = new JLabel(this._player.name, null, JLabel.CENTER);
            this._playerSideLabel.setPreferredWidth(120);
            _local_2.append(this._playerSideLabel);
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(0, 4, SoftBoxLayout.RIGHT));
            this._playerSideItemsPanel = new TradePanel(TradePanel.SELL_PANEL);
            _local_3.append(this.CreateInfoPanel());
            _local_3.append(this._playerSideItemsPanel);
            _local_1.append(_local_2);
            _local_1.append(_local_3);
            return (_local_1);
        }

        private function CreateRightPanel(_arg_1:CharacterInfo):Component
        {
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 10));
            _local_2.setBorder(new EmptyBorder(null, new Insets(22, 8)));
            var _local_3:JPanel = new JPanel(new CenterLayout());
            _local_3.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 7)));
            this._otherSideLabel = new JLabel(((_arg_1) ? _arg_1.name : "Unknown"), null, JLabel.CENTER);
            this._otherSideLabel.setPreferredWidth(120);
            _local_3.append(this._otherSideLabel);
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(0, 0, SoftBoxLayout.LEFT));
            this._otherSideItemsPanel = new TradePanel(TradePanel.BUY_PANEL);
            _local_4.append(this._otherSideItemsPanel);
            _local_2.append(_local_3);
            _local_2.append(_local_4);
            return (_local_2);
        }

        private function CreateInfoPanel():Component
        {
            var _local_1:JLabel = new JLabel();
            _local_1.setBorder(new EmptyBorder(this._decorativeBorder, new Insets(40, 0, 40)));
            _local_1.setHorizontalTextPosition(AsWingConstants.CENTER);
            _local_1.setText(ClientApplication.Localization.TRADE_DRAG_DROP_MESSAGE);
            _local_1.setSizeWH(90, 140);
            _local_1.setLocationXY(11, 85);
            _local_1.updateUI();
            _local_1.setOpaque(false);
            return (_local_1);
        }

        private function CreateOtherReadyLabel():Component
        {
            this._otherReadyLabel = new TradeStatusLabel();
            this._otherReadyLabel.setLocationXY(300, 115);
            return (this._otherReadyLabel);
        }

        private function GetImage(_arg_1:String):Bitmap
        {
            return (this._dataLibrary.GetBitmapAsset(("AdditionalData_Item_" + _arg_1)));
        }

        private function CreateMoneyPanel():Component
        {
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            _local_1.setPreferredSize(new IntDimension(380, 55));
            var _local_2:JLabel = new JLabel(ClientApplication.Localization.TRADE_SILVER_LABEL, null, JLabel.CENTER);
            _local_2.setSizeWH(85, 20);
            _local_2.setLocationXY(5, 4);
            this._playerSilverOffering = new JAdjuster();
            this._playerSilverOffering.setValues(0, 1, 0, this._player.money);
            this._playerSilverOffering.setSizeWH(85, 22);
            this._playerSilverOffering.setLocationXY(5, 25);
            this._playerSilverOffering.addActionListener(this.OnStateChanged, 0, true);
            var _local_3:JLabel = new JLabel(ClientApplication.Localization.TRADE_SILVER_LABEL, null, JLabel.CENTER);
            _local_3.setSizeWH(85, 20);
            _local_3.setLocationXY(310, 4);
            this._otherSilverOffering = new JLabel("0");
            this._otherSilverOffering.setSizeWH(85, 22);
            this._otherSilverOffering.setLocationXY(310, 25);
            var _local_4:JLabel = new JLabel(ClientApplication.Localization.TRADE_TAX_MESSAGE, null, JLabel.CENTER);
            _local_4.setSizeWH(220, 40);
            _local_4.setLocationXY(95, 8);
            _local_1.append(_local_2);
            _local_1.append(this._playerSilverOffering);
            _local_1.append(_local_3);
            _local_1.append(this._otherSilverOffering);
            _local_1.append(_local_4);
            return (_local_1);
        }

        private function CreateButtonPanel():Component
        {
            var _local_1:JPanel = new JPanel(new BorderLayout());
            var _local_2:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 4));
            this._lockButton = new CustomButton(ClientApplication.Localization.TRADE_LOCK_BUTTON);
            this._lockButton.addActionListener(this.OnLockButtonPressed, 0, true);
            this._confirmButton = new CustomButton(ClientApplication.Localization.TRADE_CONFIRM_BUTTON);
            this._confirmButton.addActionListener(this.OnConfirmButtonPressed, 0, true);
            this._confirmButton.visible = false;
            _local_2.append(this._lockButton);
            _local_2.append(this._confirmButton);
            var _local_3:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            this._closeButton = new CustomButton(ClientApplication.Localization.TRADE_CANCEL_BUTTON);
            this._closeButton.addActionListener(this.OnCloseButtonPressed, 0, true);
            _local_3.append(this._closeButton);
            _local_1.setBorder(new EmptyBorder(null, new Insets(3, 0, 4, 0)));
            _local_1.append(_local_2, BorderLayout.WEST);
            _local_1.append(_local_3, BorderLayout.EAST);
            return (_local_1);
        }

        public function LoadSellItem(_arg_1:ItemData):void
        {
            this._playerSideItemsPanel.LoadItem(_arg_1);
            this._playerSideItemsPanel.Revalidate();
        }

        public function RemoveSellItem(_arg_1:ItemData):void
        {
            this._playerSideItemsPanel.RemoveItem(_arg_1);
            this._playerSideItemsPanel.Revalidate();
        }

        public function LoadBuyItem(_arg_1:ItemData):void
        {
            this._otherSideItemsPanel.LoadItem(_arg_1);
            this._otherSideItemsPanel.Revalidate();
        }

        public function RemoveBuyItem(_arg_1:ItemData):void
        {
            this._otherSideItemsPanel.RemoveItem(_arg_1);
            this._otherSideItemsPanel.Revalidate();
        }

        public function LoadZeny(_arg_1:int):void
        {
            this._otherSilverOffering.setText(_arg_1.toString());
        }

        public function LockOtherSidePanel():void
        {
            this._otherSideLabel.setText((this._otherSideLabel.getText() + " +"));
            this._otherReadyLabel.SetActive(true);
            this._buyConfirm = true;
            if (this._sellConfirm)
            {
                this._confirmButton.visible = true;
            };
        }

        public function LockPlayerSidePanel():void
        {
            this._playerSideItemsPanel.LockPanel();
            this._lockButton.setEnabled(false);
            this._playerSilverOffering.setEnabled(false);
            this._sellConfirm = true;
            if (this._buyConfirm)
            {
                this._confirmButton.visible = true;
            };
        }

        public function Close():void
        {
            this._sendCancel = false;
            this.dispose();
            this._sendCancel = true;
        }

        private function OnCloseButtonPressed(_arg_1:AWEvent):void
        {
            this._sendCancel = true;
            this.dispose();
        }

        private function OnConfirmButtonPressed(_arg_1:AWEvent):void
        {
            this._confirmButton.setEnabled(false);
            ClientApplication.Instance.LocalGameClient.SendTradeCommit();
        }

        private function OnLockButtonPressed(_arg_1:AWEvent):void
        {
            ClientApplication.Instance.LocalGameClient.SendTradeOk();
        }

        private function OnStateChanged(_arg_1:Event):void
        {
            if (this._playerSilverOffering.getValue() > this._player.money)
            {
                this._playerSilverOffering.setValue(this._player.money);
            };
            if (this._playerSilverOffering.getValue() == this._lastZeny)
            {
                return;
            };
            ClientApplication.Instance.LocalGameClient.SendTradeAddItem(0, this._playerSilverOffering.getValue());
            this._lastZeny = this._playerSilverOffering.getValue();
        }

        public function CheckSellItem(_arg_1:ItemData):Boolean
        {
            return (this._playerSideItemsPanel.CheckItem(_arg_1));
        }

        override public function show():void
        {
            super.show();
            ClientApplication.Instance.SetShortcutsEnabled(false);
        }

        override public function dispose():void
        {
            super.dispose();
            ClientApplication.Instance.SetShortcutsEnabled(true);
            if (this._sendCancel)
            {
                ClientApplication.Instance.LocalGameClient.SendTradeCancel();
            };
        }


    }
}//package hbm.Game.GUI.Trade

