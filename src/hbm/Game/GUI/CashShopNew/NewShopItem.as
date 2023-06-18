


//hbm.Game.GUI.CashShopNew.NewShopItem

package hbm.Game.GUI.CashShopNew
{
    import org.aswing.JPanel;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import hbm.Game.GUI.Tools.EditableSpinBox;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.EmptyLayout;
    import org.aswing.JTextArea;
    import flash.text.TextFormat;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Game.GUI.PremiumPack.PremiumPackItem;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.SoftBoxLayout;
    import flash.text.TextFormatAlign;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.ASFont;
    import org.aswing.BorderLayout;
    import hbm.Game.GUI.Tools.WindowSprites;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.SolidBackground;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.JOptionPane;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import hbm.Game.Utility.Payments;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.AttachIcon;
    import flash.events.Event;

    public class NewShopItem extends JPanel 
    {

        public static const ITEMS_TYPE_GOLD_BG:Array = ["NCS_BottleItem", "NCS_OtherItem", "NCS_ScrollItem", "NCS_OtherItem", "NCS_WeaponItem", "NCS_ArmorItem", "NCS_OtherItem", "NCS_PetsItem", "NCS_OtherItem", "NCS_OtherItem", "NCS_OtherItem", "NCS_OtherItem", "NCS_OtherItem"];
        public static const ITEMS_TYPE_SILVER_BG:Array = ["NCS_SilverBottleItem", "NCS_SilverOtherItem", "NCS_SilverScrollItem", "NCS_SilverOtherItem", "NCS_SilverWeaponItem", "NCS_SilverArmorItem", "NCS_SilverOtherItem", "NCS_SilverPetsItem", "NCS_SilverOtherItem", "NCS_SilverOtherItem", "NCS_SilverOtherItem", "NCS_SilverOtherItem", "NCS_SilverOtherItem"];

        private var _itemData:ItemData;
        private var _item:InventoryStoreItem;
        private var _amount:EditableSpinBox;
        private var _buyButton:CustomButton;
        private var _loaded:Boolean = false;
        private var _locked:Boolean = false;

        public function NewShopItem(_arg_1:ItemData, _arg_2:Boolean=false)
        {
            super(new EmptyLayout());
            this._itemData = _arg_1;
            this._locked = _arg_2;
        }

        public function get ItemID():uint
        {
            return ((this._item) ? this._item.Item.NameId : 0);
        }

        public function get BuyButton():CustomButton
        {
            return (this._buyButton);
        }

        public function Loading():void
        {
            var _local_1:String;
            var _local_2:JPanel;
            var _local_3:String;
            var _local_4:JTextArea;
            var _local_5:TextFormat;
            var _local_6:JPanel;
            var _local_7:String;
            var _local_8:JLabel;
            var _local_9:JPanel;
            var _local_10:JPanel;
            var _local_11:int;
            var _local_12:CustomToolTip;
            var _local_13:JPanel;
            var _local_14:PremiumPackItem;
            var _local_15:ItemsResourceLibrary;
            var _local_16:Object;
            var _local_17:JLabel;
            if (this._loaded)
            {
                return;
            };
            this._item = ((this._itemData) ? new InventoryStoreItem(this._itemData, false) : null);
            if (this._item)
            {
                _local_1 = ((this._itemData.Origin == ItemData.CASH) ? ITEMS_TYPE_GOLD_BG[this._item.Item.Type] : ITEMS_TYPE_SILVER_BG[this._item.Item.Type]);
                AsWingUtil.SetBackgroundFromAsset(this, _local_1);
                _local_2 = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
                AsWingUtil.SetSize(_local_2, 140, 171);
                _local_3 = (this._item.Refined + this._item.Name);
                _local_4 = AsWingUtil.CreateTextArea(_local_3);
                _local_5 = _local_4.getTextFormat();
                _local_5.align = TextFormatAlign.CENTER;
                _local_5.color = 1183752;
                _local_5.size = 13;
                _local_5.font = HtmlText.fontName;
                _local_4.setTextFormat(_local_5);
                AsWingUtil.SetSize(_local_4, 130, 62);
                _local_2.append(AsWingUtil.AlignCenter(_local_4));
                AsWingUtil.SetBorder(this._item, 0, 4);
                _local_2.append(AsWingUtil.AlignCenter(this._item));
                _local_6 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
                AsWingUtil.SetBorder(_local_6, 0, 8);
                if (this._item.Item.Price >= 1000000)
                {
                    _local_7 = ((this._item.Item.Price / 1000000) + "kk");
                }
                else
                {
                    if (this._item.Item.Price >= 100000)
                    {
                        _local_7 = ((this._item.Item.Price / 1000) + "k");
                    }
                    else
                    {
                        _local_7 = this._item.Item.Price.toString();
                    };
                };
                _local_8 = AsWingUtil.CreateLabel(_local_7, 0xFFFFFF, new ASFont(getFont().getName(), 19, true));
                _local_8.setTextFilters([HtmlText.shadow2]);
                _local_8.setHorizontalAlignment(JLabel.RIGHT);
                _local_6.append(_local_8);
                _local_9 = new JPanel(new BorderLayout());
                AsWingUtil.SetBackground(_local_9, ((this._item.Item.Origin == ItemData.CASH) ? new WindowSprites.CoinGoldBig() : new WindowSprites.CoinSilverBig()));
                _local_6.append(AsWingUtil.AlignCenter(_local_9));
                _local_2.append(AsWingUtil.AlignCenter(_local_6));
                if (!this._locked)
                {
                    _local_10 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
                    AsWingUtil.SetHeight(_local_10, 33);
                    AsWingUtil.SetBorder(_local_10, 0, 6);
                    if ((((((!(this._item.Item.TypeEquip == 0)) && (!(this._item.Item.Type == ItemData.IT_CARD))) && (!(this._item.Item.Type == ItemData.IT_AMMO))) && (!(this._item.Item.Type == ItemData.IT_SOULSHOT))) || (this._item.Item.Type == ItemData.IT_PETEGG)))
                    {
                        _local_11 = 1;
                    }
                    else
                    {
                        _local_11 = this._item.Item.Amount;
                    };
                    this._amount = new EditableSpinBox(45, 28, 1, _local_11);
                    AsWingUtil.SetHeight(this._amount.EditBox, 24);
                    this._amount.EditBox.setBorder(new LineBorder(null, new ASColor(3758946), 1));
                    this._amount.EditBox.setBackgroundDecorator(new SolidBackground(new ASColor(859945)));
                    this._amount.EditBox.setForeground(new ASColor(0xFFFFFF));
                    if (_local_11 > 1)
                    {
                        _local_10.append(this._amount);
                    };
                    this._buyButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("NCS_BuyButton", "NCS_BuyButtonOver", "NCS_BuyButtonPress");
                    this._buyButton.addActionListener(this.OnBuyButtonClick, 0, true);
                    _local_12 = new CustomToolTip(this._buyButton, ClientApplication.Instance.GetPopupText(126, this._item.Item.Price.toString()), 150, 10);
                    _local_10.append(this._buyButton);
                    _local_2.append(AsWingUtil.AlignCenter(_local_10));
                };
                append(_local_2);
                if (this._locked)
                {
                    _local_13 = new JPanel(new EmptyLayout());
                    AsWingUtil.SetBackgroundColor(_local_13, 0, 0.5);
                    AsWingUtil.SetSize(_local_13, 140, 171);
                    append(_local_13);
                    _local_14 = new PremiumPackItem(this._itemData, false, false);
                    AsWingUtil.SetSize(_local_14, 32, 32);
                    _local_14.setLocationXY(54, 65);
                    _local_13.append(_local_14);
                    _local_15 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
                    _local_16 = _local_15.GetServerDescriptionObject(this._item.Item.NameId);
                    _local_17 = AsWingUtil.CreateLabel(HtmlText.GetText("Необходим\n%val1% уровень", _local_16.equip_level), 0xFFFFFF, getFont());
                    _local_17.alpha = 0.75;
                    AsWingUtil.SetSize(_local_17, 140, 30);
                    _local_17.setLocationXY(0, 140);
                    _local_13.append(_local_17);
                };
            }
            else
            {
                AsWingUtil.SetBackgroundFromAsset(this, "NCS_EmptyItem");
            };
            this._loaded = true;
        }

        private function OnBuyButtonClick(evt:Event):void
        {
            var amount:int;
            var resultDlgBuy:Function;
            resultDlgBuy = function (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    ClientApplication.Instance.LocalGameClient.SendPremiumShopBuy(ClientApplication.Instance.PremiumShop.ShopID, _item.Item.NameId, amount);
                    if (_item.Item.Origin == ItemData.ZENY)
                    {
                        HelpManager.Instance.BuyItem(_item.Item.NameId);
                    };
                };
            };
            amount = this._amount.GetValue();
            var cost:uint = (this._item.Item.Price * amount);
            if (!Payments.TestAmountPay(this._item.Item.Origin, cost))
            {
                return;
            };
            var inf:String = ClientApplication.Localization.BUY_ITEM_DIALOG.concat();
            if (amount > 1)
            {
                inf = inf.replace("%1", (((amount + " '") + this._item.Name) + "'"));
            }
            else
            {
                inf = inf.replace("%1", (("'" + this._item.Name) + "'"));
            };
            inf = inf.replace("%2", Payments.GetTextAmountCoins(this._item.Item.Origin, cost));
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.BUY_ITEM_DIALOG_TITLE, inf, resultDlgBuy, null, false, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }


    }
}//package hbm.Game.GUI.CashShopNew

