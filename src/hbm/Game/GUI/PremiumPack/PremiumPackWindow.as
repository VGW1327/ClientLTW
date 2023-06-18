


//hbm.Game.GUI.PremiumPack.PremiumPackWindow

package hbm.Game.GUI.PremiumPack
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import org.aswing.JPanel;
    import flash.display.MovieClip;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Application.ClientApplication;
    import org.aswing.BorderLayout;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.GUI.CashShopNew.Assets;
    import flash.display.Bitmap;
    import org.aswing.AssetBackground;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.EmptyLayout;
    import org.aswing.JLabel;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.CashShopNew.ButtonPrototype;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.AssetIcon;
    import org.aswing.geom.IntDimension;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.ASFont;
    import hbm.Game.GUI.Tools.WindowSprites;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.AttachIcon;
    import mx.core.BitmapAsset;
    import flash.events.Event;
    import hbm.Game.Music.Music;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Game.Utility.Payments;
    import hbm.Game.GUI.CashShopNew.*;
    import org.aswing.*;

    public class PremiumPackWindow extends WindowPrototype 
    {

        private const WIDTH:int = 601;
        private const HEIGHT:int = 507;

        private var _items:Array = null;
        private var _nagrada:JPanel;
        private var _rasklad:MovieClip;
        private var _itemsLibrary:ItemsResourceLibrary;
        private var _type:int;
        private var _price:uint;

        public function PremiumPackWindow(_arg_1:int, _arg_2:Boolean=false)
        {
            this._type = _arg_1;
            super(null, ClientApplication.Localization.PREMIUM_PACK_WINDOW_TITLE, _arg_2, this.WIDTH, this.HEIGHT);
            validate();
            pack();
        }

        override protected function InitUI():void
        {
            super.InitUI();
            this.BuildTopMenu();
            this.BuildMiddleArea();
            this.BuildBottomArea();
        }

        private function BuildTopMenu():void
        {
            _header.setLayout(new BorderLayout());
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.BOTTOM));
            var _local_2:Bitmap = Assets.Ornament3();
            var _local_3:JPanel = new JPanel();
            _local_3.setPreferredWidth(_local_2.width);
            _local_3.setPreferredHeight(_local_2.height);
            _local_3.setMaximumWidth(_local_2.width);
            _local_3.setMaximumHeight(_local_2.height);
            _local_3.setBackgroundDecorator(new AssetBackground(_local_2));
            _local_3.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            _local_1.append(_local_3);
            _header.append(_local_1, BorderLayout.CENTER);
        }

        private function BuildMiddleArea():void
        {
            var _local_1:Bitmap = Assets.PremiumPackNagradaBg();
            this._nagrada = new JPanel(new EmptyLayout());
            this._nagrada.setPreferredWidth(_local_1.width);
            this._nagrada.setPreferredHeight(_local_1.height);
            this._nagrada.setMaximumWidth(_local_1.width);
            this._nagrada.setMaximumHeight(_local_1.height);
            this._nagrada.setBackgroundDecorator(new AssetBackground(_local_1));
            this._nagrada.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            _body.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            _body.append(this._nagrada);
        }

        private function BuildBottomArea():void
        {
            var _local_1:Bitmap;
            var _local_2:Bitmap;
            var _local_5:JPanel;
            var _local_6:Object;
            var _local_7:JLabel;
            var _local_8:JLabel;
            var _local_9:CharacterInfo;
            _closeWindowButton2 = new ButtonPrototype("");
            var _local_3:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            if (this._type == 1)
            {
                _local_1 = _local_3.GetBitmapAsset("Localization_Item_GiftWindowOpenButton");
                _local_2 = _local_3.GetBitmapAsset("Localization_Item_GiftWindowOpenButtonOver");
            }
            else
            {
                _local_1 = _local_3.GetBitmapAsset("Localization_Item_PremiumPackTakeButton");
                _local_2 = _local_3.GetBitmapAsset("Localization_Item_PremiumPackTakeButtonOver");
            };
            _closeWindowButton2.setIconTextGap(-70);
            _closeWindowButton2.setIcon(new AssetIcon(_local_1));
            _closeWindowButton2.setRollOverIcon(new AssetIcon(_local_2));
            _closeWindowButton2.setPreferredSize(new IntDimension(_local_1.width, _local_1.height));
            _closeWindowButton2.setMaximumSize(new IntDimension(_local_1.width, _local_1.height));
            _closeWindowButton2.setSize(new IntDimension(_local_1.width, _local_1.height));
            _closeWindowButton2.setLocationXY(100, 10);
            _closeWindowButton2.setBackgroundDecorator(null);
            _closeWindowButton2.addActionListener(this.OnClosePressed, 0, true);
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.CENTER));
            _local_4.append(_closeWindowButton2);
            _local_4.setBorder(new EmptyBorder(null, new Insets(6, 0, 0, 0)));
            if (this._type == 1)
            {
                _local_5 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.TOP));
                _local_4.append(_local_5);
                _local_6 = AsWingUtil.AdditionalData.GetGiftDb2;
                this._price = _local_6.PriceList[ClientApplication.gift2Counter];
                _local_7 = AsWingUtil.CreateLabel(this._price.toString(), 0xFFFFFF, new ASFont(getFont().getName(), 14, true));
                AsWingUtil.SetWidth(_local_7, 30);
                _local_5.append(AsWingUtil.OffsetBorder(_local_7, 0, 0, 0, 6));
                _local_8 = AsWingUtil.CreateIcon(new WindowSprites.CoinGold());
                _local_5.append(AsWingUtil.OffsetBorder(_local_8, 0, 8));
                _local_9 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                if (_local_9.ItemsCount < ItemData.MAX_INVENTORY)
                {
                    _closeWindowButton2.setToolTipText(ClientApplication.Instance.GetPopupText(288));
                }
                else
                {
                    _closeWindowButton2.filters = [HtmlText.gray];
                    _closeWindowButton2.setToolTipText(ClientApplication.Instance.GetPopupText(289));
                };
                AsWingUtil.SetBorder(_closeWindowButton2, 40);
                AsWingUtil.SetWidth(_closeWindowButton2, (_closeWindowButton2.getWidth() + 50));
            };
            _bottom.removeAll();
            _bottom.append(_local_4, BorderLayout.CENTER);
        }

        public function LoadItems(_arg_1:Array):void
        {
            var _local_2:AdditionalDataResourceLibrary;
            var _local_3:JPanel;
            if (((_arg_1 == null) || (_arg_1.length < 1)))
            {
                return;
            };
            this._nagrada.removeAll();
            this._items = _arg_1;
            if (this._type == 1)
            {
                _local_2 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
                _local_3 = new JPanel(new EmptyLayout());
                AsWingUtil.SetBackground(_local_3, _local_2.GetBitmapAsset("AdditionalData_Item_PremiumPackBanner"));
                _local_3.setLocationXY(5, 4);
                this._nagrada.append(_local_3);
                this._items.splice(0, 1);
            };
            if (((this._rasklad) && (this._nagrada.contains(this._rasklad))))
            {
                this._nagrada.removeChild(this._rasklad);
            };
            this.CreateRasklad();
            if (this._rasklad == null)
            {
                return;
            };
            this._rasklad.x = (this._nagrada.width / 2);
            this._rasklad.y = ((this._nagrada.height / 2) + (165 / 2));
            this._rasklad._all.addEventListener("ON_RASKLAD_END", this.OnRaskladEnd, false, 0, true);
            this._rasklad._all.addEventListener("ON_RASKLAD_CARD", this.OnRaskladCard, false, 0, true);
            this._nagrada.addChild(this._rasklad);
        }

        private function CreateRasklad():void
        {
            var _local_3:ItemData;
            var _local_4:Object;
            var _local_5:int;
            var _local_6:Bitmap;
            var _local_7:Bitmap;
            var _local_8:AttachIcon;
            var _local_9:Bitmap;
            var _local_1:int;
            switch (this._items.length)
            {
                case 3:
                    this._rasklad = new Rasklad3();
                    break;
                case 5:
                    this._rasklad = new Rasklad5();
                    break;
                case 10:
                    this._rasklad = new Rasklad10();
                    break;
                default:
                    this._rasklad = null;
                    return;
            };
            if (this._itemsLibrary == null)
            {
                this._itemsLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            };
            var _local_2:int = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerFraction();
            for each (_local_3 in this._items)
            {
                _local_4 = this._itemsLibrary.GetServerDescriptionObject(_local_3.NameId);
                _local_3.Type = _local_4["type"];
                _local_3.Attr = ((_local_2) ? ItemData.ITEM_ATTRIBUTE_FRACTION : 0);
                _local_5 = this._itemsLibrary.GetPremiumPackType(_local_3.NameId);
                _local_6 = Assets.PremiumPackCard(_local_5);
                _local_7 = Assets.PremiumPackCard(_local_5);
                _local_8 = this._itemsLibrary.GetItemAttachIcon(_local_3.NameId);
                _local_9 = ((_local_8) ? (_local_8.getAsset() as BitmapAsset) : null);
                if (((_local_6) && (_local_9)))
                {
                    switch (_local_1)
                    {
                        case 0:
                            this._rasklad._all.card01.addChild(_local_6);
                            this._rasklad._all.card11.addChild(_local_7);
                            this._rasklad._all.item1.addChild(_local_9);
                            break;
                        case 1:
                            this._rasklad._all.card02.addChild(_local_6);
                            this._rasklad._all.card12.addChild(_local_7);
                            this._rasklad._all.item2.addChild(_local_9);
                            break;
                        case 2:
                            this._rasklad._all.card03.addChild(_local_6);
                            this._rasklad._all.card13.addChild(_local_7);
                            this._rasklad._all.item3.addChild(_local_9);
                            break;
                        case 3:
                            this._rasklad._all.card04.addChild(_local_6);
                            this._rasklad._all.card14.addChild(_local_7);
                            this._rasklad._all.item4.addChild(_local_9);
                            break;
                        case 4:
                            this._rasklad._all.card05.addChild(_local_6);
                            this._rasklad._all.card15.addChild(_local_7);
                            this._rasklad._all.item5.addChild(_local_9);
                            break;
                        case 5:
                            this._rasklad._all.card06.addChild(_local_6);
                            this._rasklad._all.card16.addChild(_local_7);
                            this._rasklad._all.item6.addChild(_local_9);
                            break;
                        case 6:
                            this._rasklad._all.card07.addChild(_local_6);
                            this._rasklad._all.card17.addChild(_local_7);
                            this._rasklad._all.item7.addChild(_local_9);
                            break;
                        case 7:
                            this._rasklad._all.card08.addChild(_local_6);
                            this._rasklad._all.card18.addChild(_local_7);
                            this._rasklad._all.item8.addChild(_local_9);
                            break;
                        case 8:
                            this._rasklad._all.card09.addChild(_local_6);
                            this._rasklad._all.card19.addChild(_local_7);
                            this._rasklad._all.item9.addChild(_local_9);
                            break;
                        case 9:
                            this._rasklad._all.card010.addChild(_local_6);
                            this._rasklad._all.card110.addChild(_local_7);
                            this._rasklad._all.item10.addChild(_local_9);
                            break;
                    };
                };
                _local_1++;
            };
        }

        private function OnRaskladEnd(_arg_1:Event):void
        {
            var _local_5:ItemData;
            var _local_6:PremiumPackItem;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            switch (this._items.length)
            {
                case 3:
                    _local_3 = 160;
                    _local_4 = 240;
                    break;
                case 5:
                    _local_3 = 66;
                    _local_4 = 240;
                    break;
                case 10:
                    _local_3 = 68;
                    _local_4 = 195;
                    break;
            };
            for each (_local_5 in this._items)
            {
                _local_6 = new PremiumPackItem(_local_5, false);
                _local_6.setPreferredWidth(32);
                _local_6.setPreferredHeight(32);
                _local_6.setMaximumWidth(32);
                _local_6.setMaximumHeight(32);
                _local_6.setSizeWH(32, 32);
                if (_local_2 == 5)
                {
                    _local_2 = 0;
                    _local_4 = (_local_4 + (88 + 10));
                };
                _local_6.setLocationXY(((_local_3 + (_local_2 * (60 + 35))) + 13), (_local_4 + 48));
                this._nagrada.append(_local_6);
                _local_2++;
            };
        }

        private function OnRaskladStart(_arg_1:Event):void
        {
        }

        private function OnRaskladCard(_arg_1:Event):void
        {
            if (ClientApplication.Instance.GameSettings.IsPlaySoundsEnabled)
            {
                Music.Instance.PlaySound(Music.ScriptSounds["pm_card"]);
            };
        }

        override public function show():void
        {
            super.show();
            setLocationXY(((RenderSystem.Instance.ScreenWidth - width) / 2), ((RenderSystem.Instance.ScreenHeight - height) / 2));
            ClientApplication.Instance.SetShortcutsEnabled(false);
        }

        override protected function OnClosePressed(evt:Event):void
        {
            var player:CharacterInfo;
            var text:String;
            if (((this._type == 1) && (evt.currentTarget == _closeWindowButton2)))
            {
                player = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                if (player.ItemsCount >= ItemData.MAX_INVENTORY)
                {
                    return;
                };
                if (this._price > 0)
                {
                    var successPay:Function = function ():void
                    {
                        ClientApplication.Instance.SetShortcutsEnabled(true);
                        dispose();
                        ClientApplication.Instance.LocalGameClient.SendGetGift2();
                    };
                    if (Payments.TestAmountPay(ItemData.CASH, this._price))
                    {
                        text = HtmlText.GetText(ClientApplication.Localization.WITCH_DIALOG_TEXT, Payments.GetTextAmountCoins(ItemData.CASH, this._price));
                        Payments.ConfirmPayDialog(ItemData.CASH, this._price, successPay, ClientApplication.Localization.WITCH_DIALOG_TITLE, text);
                    };
                }
                else
                {
                    ClientApplication.Instance.SetShortcutsEnabled(true);
                    dispose();
                    ClientApplication.Instance.LocalGameClient.SendGetGift2();
                };
            }
            else
            {
                ClientApplication.Instance.SetShortcutsEnabled(true);
                dispose();
            };
        }


    }
}//package hbm.Game.GUI.PremiumPack

