


//hbm.Game.GUI.Gifts.WitchWindow

package hbm.Game.GUI.Gifts
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import org.aswing.JTextArea;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.BorderLayout;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.SoftBoxLayout;
    import org.aswing.EmptyLayout;
    import org.aswing.ASFont;
    import org.aswing.JScrollPane;
    import hbm.Game.GUI.Tools.WindowSprites;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.Utility.Payments;
    import hbm.Game.Utility.HtmlText;
    import flash.events.Event;
    import hbm.Game.GUI.CashShopNew.Assets;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.display.DisplayObject;

    public class WitchWindow extends WindowPrototype 
    {

        private static const WIDTH:int = 606;
        private static const HEIGHT:int = 510;

        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localisationLib:LocalizationResourceLibrary;
        private var _imagePanel:JPanel;
        private var _labelPanel:JLabel;
        private var _textPanel:JTextArea;
        private var _itemPanel:JPanel;
        private var _pricePanel:JPanel;
        private var _costLabel:JLabel;
        private var _buttonOpen:CustomButton;
        private var _price:uint;

        public function WitchWindow()
        {
            super(null, ClientApplication.Localization.WITCH_WINDOW_TITLE, true, WIDTH, HEIGHT, true);
            dispose();
        }

        override protected function InitUI():void
        {
            var _local_6:CharacterInfo;
            super.InitUI();
            if (_closeWindowButton2)
            {
                _closeWindowButton2.removeFromContainer();
            };
            this.BuildTopMenu();
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localisationLib = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            var _local_1:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBorder(_local_1, 2);
            AsWingUtil.SetBackground(_local_1, this._localisationLib.GetBitmapAsset("Localization_Item_WitchWindowBackground"));
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            this._imagePanel = new JPanel(new EmptyLayout());
            var _local_3:JPanel = AsWingUtil.OffsetBorder(this._imagePanel, 4, 3, -4, -3);
            AsWingUtil.SetSize(_local_3, 575, 170);
            _local_2.append(_local_3);
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 20, SoftBoxLayout.TOP));
            AsWingUtil.SetHeight(_local_4, 124);
            this._labelPanel = AsWingUtil.CreateLabel(ClientApplication.Localization.WITCH_WINDOW_NAME, 16768877, new ASFont(getFont().getName(), 14, true));
            var _local_5:JPanel = AsWingUtil.AlignCenter(this._labelPanel);
            AsWingUtil.SetWidth(_local_5, 155);
            AsWingUtil.SetBorder(_local_5, 10, 0, 10, 104);
            _local_4.append(_local_5);
            _local_6 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_7:String = ((_local_6.sex > 0) ? ClientApplication.Localization.WITCH_WINDOW_TEXT_M : ClientApplication.Localization.WITCH_WINDOW_TEXT_W);
            this._textPanel = AsWingUtil.CreateTextArea(_local_7);
            AsWingUtil.SetWidth(this._textPanel, 400);
            var _local_8:JScrollPane = new JScrollPane(this._textPanel);
            AsWingUtil.SetSize(_local_8, 420, 124);
            _local_4.append(_local_8);
            _local_2.append(_local_4);
            this._itemPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBorder(this._itemPanel, 0x0100, 0);
            _local_2.append(this._itemPanel);
            _local_1.append(_local_2, BorderLayout.CENTER);
            var _local_9:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 20, SoftBoxLayout.TOP));
            this._buttonOpen = AsWingUtil.CreateCustomButtonFromAssetLocalization("GiftWindowOpenButton", "GiftWindowOpenButtonOver");
            this._buttonOpen.addActionListener(this.OnOpen, 0, true);
            _local_9.append(AsWingUtil.OffsetBorder(this._buttonOpen, 66, 0, 0, 5));
            this._pricePanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.TOP));
            _local_9.append(this._pricePanel);
            this._costLabel = AsWingUtil.CreateLabel("", 0xFFFFFF, new ASFont(getFont().getName(), 14, true));
            AsWingUtil.SetWidth(this._costLabel, 30);
            this._pricePanel.append(AsWingUtil.OffsetBorder(this._costLabel, 0, 0, 0, 6));
            var _local_10:JLabel = AsWingUtil.CreateIcon(new WindowSprites.CoinGold());
            this._pricePanel.append(AsWingUtil.OffsetBorder(_local_10, 0, 8));
            Bottom.append(AsWingUtil.AlignCenter(_local_9), BorderLayout.PAGE_END);
            Body.setLayout(new BorderLayout());
            Body.append(_local_1, BorderLayout.CENTER);
        }

        private function OnOpen(evt:Event):void
        {
            var text:String;
            var player:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (player.ItemsCount >= ItemData.MAX_INVENTORY)
            {
                return;
            };
            if (this._price > 0)
            {
                var successPay:Function = function ():void
                {
                    ClientApplication.Instance.LocalGameClient.SendGetGift2();
                    dispose();
                };
                if (Payments.TestAmountPay(ItemData.CASH, this._price))
                {
                    text = HtmlText.GetText(ClientApplication.Localization.WITCH_DIALOG_TEXT, Payments.GetTextAmountCoins(ItemData.CASH, this._price));
                    Payments.ConfirmPayDialog(ItemData.CASH, this._price, successPay, ClientApplication.Localization.WITCH_DIALOG_TITLE, text);
                };
            }
            else
            {
                ClientApplication.Instance.LocalGameClient.SendGetGift2();
                dispose();
            };
        }

        private function BuildTopMenu():void
        {
            Top.setLayout(new BorderLayout());
            var _local_1:JPanel = new JPanel();
            AsWingUtil.SetBackground(_local_1, Assets.Ornament3());
            Top.append(_local_1, BorderLayout.PAGE_END);
        }

        override public function show():void
        {
            this.InitWitch();
            super.show();
            setLocationXY(((RenderSystem.Instance.ScreenWidth - width) / 2), ((RenderSystem.Instance.ScreenHeight - height) / 2));
        }

        private function InitWitch():void
        {
            var _local_3:DisplayObject;
            var _local_1:Object = AsWingUtil.AdditionalData.GetGiftDb2;
            this._price = _local_1.PriceList[ClientApplication.gift2Counter];
            if (this._price > 0)
            {
                this._pricePanel.alpha = 1;
                this._costLabel.setText(this._price.toString());
            }
            else
            {
                this._pricePanel.alpha = 0;
            };
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (_local_2.ItemsCount < ItemData.MAX_INVENTORY)
            {
                AsWingUtil.UpdateCustomButtonFromAssetLocalization(this._buttonOpen, "GiftWindowOpenButton", "GiftWindowOpenButtonOver");
                this._buttonOpen.setToolTipText(ClientApplication.Instance.GetPopupText(288));
            }
            else
            {
                _local_3 = AsWingUtil.GetAssetLocalization("GiftWindowOpenButton");
                _local_3.filters = [HtmlText.gray];
                AsWingUtil.UpdateCustomButton(this._buttonOpen, _local_3, _local_3, _local_3);
                this._buttonOpen.setToolTipText(ClientApplication.Instance.GetPopupText(289));
            };
        }


    }
}//package hbm.Game.GUI.Gifts

