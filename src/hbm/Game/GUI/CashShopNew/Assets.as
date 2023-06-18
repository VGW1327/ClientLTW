


//hbm.Game.GUI.CashShopNew.Assets

package hbm.Game.GUI.CashShopNew
{
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;

    public class Assets 
    {

        private static var _dataLibrary:AdditionalDataResourceLibrary;
        private static var _localizationLibrary:LocalizationResourceLibrary;


        public static function Init():void
        {
            _dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            _localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
        }

        public static function InactiveTab():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_Tab"));
        }

        public static function InactiveTabMouseover():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_TabMouseover"));
        }

        public static function ActiveTab():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_ActiveTab"));
        }

        public static function Minus():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_Minus"));
        }

        public static function Plus():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_Plus"));
        }

        public static function Background():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_Background"));
        }

        public static function BackgroundDark():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_BackgroundDark"));
        }

        public static function BackgroundSuperDark():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_BackgroundSuperDark"));
        }

        public static function WinCup():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_WinCup"));
        }

        public static function TopMenuButton():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("Localization_Item_CS_WinBuy"));
        }

        public static function TopMenuButtonActive():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("Localization_Item_CS_WinBuyActive"));
        }

        public static function UpdateButton():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_Update"));
        }

        public static function UpdateButtonActive():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_UpdateActive"));
        }

        public static function StashButton():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_Stash"));
        }

        public static function StashButtonOver():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_StashOver"));
        }

        public static function StashButtonPressed():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_StashPressed"));
        }

        public static function AuctionButton():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_Auction"));
        }

        public static function AuctionButtonOver():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_AuctionOver"));
        }

        public static function AuctionButtonPressed():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_AuctionPressed"));
        }

        public static function GoldUnChecked():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_GoldCheckEmpty"));
        }

        public static function GoldChecked():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_GoldCheckSelected"));
        }

        public static function SpecButton():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_SpecButton"));
        }

        public static function SpecButtonActive():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_SpecButtonActive"));
        }

        public static function SpecButtonOver():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_SpecButtonOver"));
        }

        public static function HorizontalLine():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_HorizontalLine"));
        }

        public static function HorizontalLineMin():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_HorizontalLineMin"));
        }

        public static function VerticalLine():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_VerticalLine"));
        }

        public static function Ornament1():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_TopOrnament"));
        }

        public static function Ornament2():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_BannerOrnament"));
        }

        public static function ItemUnSelected():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_ItemUnSelected"));
        }

        public static function ItemSelected():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_ItemSelected"));
        }

        public static function BuyButton():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_BuyButton"));
        }

        public static function BuyButtonActive():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_BuyButtonActive"));
        }

        public static function BuyButtonOver():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_BuyButtonOver"));
        }

        public static function ChangeButton():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_ChangeButton"));
        }

        public static function ChangeButtonActive():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_ChangeButtonActive"));
        }

        public static function ChangeButtonOver():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_ChangeButtonOver"));
        }

        public static function DropDownTab():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_DropDownTab"));
        }

        public static function DropDownTabMouseover():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_DropDownTabMouseover"));
        }

        public static function DropDownTabSelected():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_DropDownTabSelected"));
        }

        public static function BackToShop():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_Stash_BackToShop"));
        }

        public static function BackToShopOver():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_Stash_BackToShopOver"));
        }

        public static function TopLeft():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_TopLeft"));
        }

        public static function TopRight():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_TopRight"));
        }

        public static function TopRightNoClose():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_TopRightNoClose"));
        }

        public static function TopLeft2():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_LeftPattern"));
        }

        public static function TopRight2():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_RightPattern"));
        }

        public static function TopRight2NoClose():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_RightPatternNoClose"));
        }

        public static function Top():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_TopPanel"));
        }

        public static function LeftBottom():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_BottomLeft"));
        }

        public static function RightBottom():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_BottomRight"));
        }

        public static function CloseButton():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_WindowCloseButton"));
        }

        public static function CloseButtonOver():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_WindowCloseButtonOver"));
        }

        public static function CloseButtonPressed():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_WindowCloseButtonPressed"));
        }

        public static function LeftBorder():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_LeftBorder"));
        }

        public static function RightBorder():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_RightBorder"));
        }

        public static function BottomLeft():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_BottomLeft"));
        }

        public static function BottomRight():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_BottomRight"));
        }

        public static function Bottom():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_Bottom"));
        }

        public static function BottomCloseButton():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_BottomCloseButton"));
        }

        public static function BottomCloseButtonOver():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_BottomCloseButtonOver"));
        }

        public static function HeaderBack():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_HeaderBackground"));
        }

        public static function Clapboard():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_CS_Clapboard"));
        }

        public static function BottomOkButton():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_BottomOkButton"));
        }

        public static function BottomOkButtonOver():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_CS_BottomOkButtonOver"));
        }

        public static function Ornament3():Bitmap
        {
            return (_dataLibrary.GetBitmapAsset("AdditionalData_Item_PremiumPackCentralElement"));
        }

        public static function PremiumPackNagradaBg():Bitmap
        {
            return (_localizationLibrary.GetBitmapAsset("Localization_Item_PremiumPackNagradaBg"));
        }

        public static function PremiumPackCard(_arg_1:int):Bitmap
        {
            return (_dataLibrary.GetBitmapAsset(("AdditionalData_Item_PremiumPackCard" + _arg_1)));
        }


    }
}//package hbm.Game.GUI.CashShopNew

