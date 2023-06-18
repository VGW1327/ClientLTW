


//hbm.Game.GUI.Tools.StandardButtonsFactory

package hbm.Game.GUI.Tools
{
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import flash.display.Bitmap;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.JButton;
    import org.aswing.AssetIcon;

    public class StandardButtonsFactory 
    {

        public static const OK:String = "OK_BUTTON";
        public static const CANCEL:String = "CANCEL_BUTTON";
        public static const YES:String = "YES_BUTTON";
        public static const NO:String = "NO_BUTTON";
        public static const APPLY:String = "APPLY_BUTTON";
        public static const BUY:String = "BUY_BUTTON";
        public static const CLOSE:String = "CLOSE_BUTTON";
        public static const DISCONNECT:String = "DISCONNECT_BUTTON";

        private var _localizationLibrary:LocalizationResourceLibrary;
        private var _activeSkin:Bitmap;
        private var _inactiveSkin:Bitmap;
        private var _rolloverSkin:Bitmap;
        private var _pressedSkin:Bitmap;

        public function StandardButtonsFactory()
        {
            this._localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
        }

        public function CreateButton(_arg_1:String):JButton
        {
            var _local_2:JButton = new CustomButton();
            return (this.SetGraphicsToButton(_local_2, _arg_1));
        }

        public function SetGraphicsToButton(_arg_1:JButton, _arg_2:String):JButton
        {
            switch (_arg_2)
            {
                case OK:
                    this.LoadGraphics("CommonButtonOk", "CommonButtonOk", "CommonButtonOkOver", "CommonButtonOkPressed");
                    break;
                case CANCEL:
                    this.LoadGraphics("CommonButtonCancel", "CommonButtonCancel", "CommonButtonCancelOver", "CommonButtonCancelPressed");
                    break;
                case YES:
                    this.LoadGraphics("CommonButtonYes", "CommonButtonYes", "CommonButtonYesOver", "CommonButtonYesPressed");
                    break;
                case NO:
                    this.LoadGraphics("CommonButtonNo", "CommonButtonNo", "CommonButtonNoOver", "CommonButtonNoPressed");
                    break;
                case APPLY:
                    this.LoadGraphics("CommonButtonApply", "CommonButtonApply", "CommonButtonApplyOver", "CommonButtonApplyPressed");
                    break;
                case BUY:
                    this.LoadGraphics("CommonButtonBuy", "CommonButtonBuy", "CommonButtonBuyOver", "CommonButtonBuyPressed");
                    break;
                case CLOSE:
                    this.LoadGraphics("CommonButtonClose", "CommonButtonClose", "CommonButtonCloseOver", "CommonButtonClosePressed");
                    break;
                case DISCONNECT:
                    this.LoadGraphics("CommonButtonDisconnect", "CommonButtonDisconnect", "CommonButtonDisconnectOver", "CommonButtonDisconnectPressed");
                    break;
                default:
                    throw (new ArgumentError("Unknown button type. Use StandardButtonsFactory constants."));
            };
            return (this.WrapButtonWithCurrentGraphics(_arg_1));
        }

        private function LoadGraphics(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String):void
        {
            this._activeSkin = this.GetBitmap(_arg_1);
            this._inactiveSkin = this.GetBitmap(_arg_2);
            this._rolloverSkin = this.GetBitmap(_arg_3);
            this._pressedSkin = this.GetBitmap(_arg_4);
        }

        private function GetBitmap(_arg_1:String):Bitmap
        {
            return (this._localizationLibrary.GetBitmapAsset(("Localization_Item_" + _arg_1)));
        }

        private function WrapButtonWithCurrentGraphics(_arg_1:JButton):JButton
        {
            var _local_2:int;
            var _local_3:int;
            if (this._activeSkin)
            {
                _local_2 = this._activeSkin.height;
                _local_3 = this._activeSkin.width;
                _arg_1.setIcon(new AssetIcon(this._activeSkin));
                _arg_1.setDisabledIcon(new AssetIcon(this._inactiveSkin));
                _arg_1.setRollOverIcon(new AssetIcon(this._rolloverSkin));
                _arg_1.setPressedIcon(new AssetIcon(this._pressedSkin));
                _arg_1.setPreferredHeight(_local_2);
                _arg_1.setPreferredWidth(_local_3);
                _arg_1.setSizeWH(_local_3, _local_2);
            };
            return (_arg_1);
        }

        public function CreateCustomButton(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String):JButton
        {
            var _local_5:JButton = new CustomButton();
            this.SetCustomGraphicsToButton(_local_5, _arg_1, _arg_2, _arg_3, _arg_4);
            return (_local_5);
        }

        public function SetCustomGraphicsToButton(_arg_1:JButton, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String):JButton
        {
            this.LoadGraphics(_arg_2, _arg_3, _arg_4, _arg_5);
            return (this.WrapButtonWithCurrentGraphics(_arg_1));
        }


    }
}//package hbm.Game.GUI.Tools

