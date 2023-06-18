


//hbm.Game.Utility.AsWingUtil

package hbm.Game.Utility
{
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import mx.core.BitmapAsset;
    import org.aswing.JLabel;
    import org.aswing.ASColor;
    import org.aswing.ASFont;
    import org.aswing.JTextArea;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.AssetIcon;
    import flash.display.DisplayObject;
    import org.aswing.Icon;
    import org.aswing.JCheckBox;
    import org.aswing.EmptyIcon;
    import org.aswing.JButton;
    import hbm.Game.GUI.Tools.CustomButton;
    import flash.filters.ColorMatrixFilter;
    import org.aswing.CenterLayout;
    import org.aswing.Component;
    import org.aswing.geom.IntDimension;
    import org.aswing.AssetBackground;
    import org.aswing.border.LineBorder;
    import org.aswing.SolidBackground;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.BorderLayout;

    public class AsWingUtil 
    {

        private static var _dataLib:AdditionalDataResourceLibrary;


        public static function get AdditionalData():AdditionalDataResourceLibrary
        {
            _dataLib = ((_dataLib) || (ResourceManager.Instance.Library("AdditionalData") as AdditionalDataResourceLibrary));
            return (_dataLib);
        }

        public static function GetAsset(_arg_1:String):BitmapAsset
        {
            _dataLib = ((_dataLib) || (ResourceManager.Instance.Library("AdditionalData") as AdditionalDataResourceLibrary));
            return ((_dataLib) ? _dataLib.GetBitmapAsset(("AdditionalData_Item_" + _arg_1)) : null);
        }

        public static function GetAssetLocalization(_arg_1:String):BitmapAsset
        {
            _dataLib = ((_dataLib) || (ResourceManager.Instance.Library("AdditionalData") as AdditionalDataResourceLibrary));
            return ((_dataLib) ? _dataLib.GetBitmapAsset(("Localization_Item_" + _arg_1)) : null);
        }

        public static function CreateLabel(_arg_1:String, _arg_2:uint, _arg_3:ASFont):JLabel
        {
            var _local_4:JLabel = new JLabel(_arg_1);
            _local_4.setForeground(new ASColor(_arg_2));
            _local_4.setFont(_arg_3);
            return (_local_4);
        }

        public static function CreateTextArea(_arg_1:String):JTextArea
        {
            var _local_2:JTextArea = new JTextArea();
            _local_2.setEditable(false);
            _local_2.getTextField().selectable = false;
            _local_2.setWordWrap(true);
            _local_2.setBackgroundDecorator(null);
            _local_2.setHtmlText(_arg_1);
            return (_local_2);
        }

        public static function CreateCenterTextArea(_arg_1:String, _arg_2:uint, _arg_3:ASFont):JPanel
        {
            var _local_6:String;
            var _local_7:JLabel;
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            var _local_5:Array = _arg_1.split("\n");
            for each (_local_6 in _local_5)
            {
                _local_7 = CreateLabel(_local_6, _arg_2, _arg_3);
                _local_4.append(_local_7);
            };
            return (_local_4);
        }

        public static function CreateCenterTextFromWidth(_arg_1:String, _arg_2:uint, _arg_3:ASFont, _arg_4:uint):JPanel
        {
            var _local_5:JTextArea;
            var _local_9:JLabel;
            _local_5 = CreateTextArea(_arg_1);
            SetWidth(_local_5, _arg_4);
            var _local_6:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            var _local_7:uint = _local_5.getTextField().numLines;
            var _local_8:uint;
            while (_local_8 < _local_7)
            {
                _arg_1 = _local_5.getTextField().getLineText(_local_8);
                _local_9 = CreateLabel(_arg_1, _arg_2, _arg_3);
                _local_6.append(_local_9);
                _local_8++;
            };
            return (_local_6);
        }

        public static function CreateIcon(_arg_1:DisplayObject):JLabel
        {
            var _local_2:JLabel = new JLabel("", new AssetIcon(_arg_1));
            SetSize(_local_2, _arg_1.width, _arg_1.height);
            return (_local_2);
        }

        public static function CreateIconFromAsset(_arg_1:String):Icon
        {
            var _local_2:BitmapAsset;
            _local_2 = GetAsset(_arg_1);
            return (new AssetIcon(_local_2));
        }

        public static function CreateCheckBoxFromAsset(_arg_1:String, _arg_2:String):JCheckBox
        {
            var _local_3:JCheckBox = new JCheckBox();
            AsWingUtil.SetBackgroundFromAsset(_local_3, _arg_1);
            _local_3.setIcon(new EmptyIcon(_local_3.getPreferredWidth(), _local_3.getPreferredHeight()));
            _local_3.setSelectedIcon(AsWingUtil.CreateIconFromAsset(_arg_2));
            _local_3.buttonMode = true;
            return (_local_3);
        }

        public static function CreateButton(_arg_1:DisplayObject, _arg_2:DisplayObject=null, _arg_3:DisplayObject=null, _arg_4:DisplayObject=null):JButton
        {
            var _local_5:JButton = new JButton();
            _local_5.setIcon(new AssetIcon(_arg_1));
            if (_arg_2)
            {
                _local_5.setRollOverIcon(new AssetIcon(_arg_2));
            };
            if (_arg_3)
            {
                _local_5.setPressedIcon(new AssetIcon(_arg_3));
            };
            if (_arg_4)
            {
                _local_5.setDisabledIcon(new AssetIcon(_arg_4));
            };
            _local_5.setOpaque(false);
            _local_5.setSizeWH(_arg_1.width, _arg_1.height);
            _local_5.buttonMode = true;
            return (_local_5);
        }

        public static function CreateCustomButtonFromAssetLocalization(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:Boolean=false):CustomButton
        {
            var _local_5:DisplayObject;
            if (_arg_4)
            {
                _local_5 = GetAssetLocalization(_arg_1);
                _local_5.filters = [HtmlText.gray];
            };
            return (CreateCustomButton(GetAssetLocalization(_arg_1), GetAssetLocalization(_arg_2), GetAssetLocalization(_arg_3), _local_5));
        }

        public static function CreateCustomButtonFromAsset(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:Boolean=false):CustomButton
        {
            var _local_5:DisplayObject;
            if (_arg_4)
            {
                _local_5 = GetAssetLocalization(_arg_1);
                _local_5.filters = [HtmlText.gray];
            };
            return (CreateCustomButton(GetAsset(_arg_1), GetAsset(_arg_2), GetAsset(_arg_3), _local_5));
        }

        public static function CreateCustomButton(_arg_1:DisplayObject, _arg_2:DisplayObject=null, _arg_3:DisplayObject=null, _arg_4:DisplayObject=null):CustomButton
        {
            var _local_5:CustomButton = new CustomButton(null);
            _local_5.setIcon(new AssetIcon(_arg_1));
            if (_arg_2)
            {
                _local_5.setRollOverIcon(new AssetIcon(_arg_2));
            };
            if (_arg_3)
            {
                _local_5.setPressedIcon(new AssetIcon(_arg_3));
            };
            if (_arg_4)
            {
                _local_5.setDisabledIcon(new AssetIcon(_arg_4));
            };
            _local_5.setBackgroundDecorator(null);
            _local_5.setOpaque(false);
            SetSize(_local_5, _arg_1.width, _arg_1.height);
            _local_5.buttonMode = true;
            return (_local_5);
        }

        public static function UpdateCustomButton(_arg_1:CustomButton, _arg_2:DisplayObject, _arg_3:DisplayObject=null, _arg_4:DisplayObject=null, _arg_5:DisplayObject=null, _arg_6:Boolean=false):CustomButton
        {
            var _local_7:ColorMatrixFilter;
            _arg_1.setIcon(new AssetIcon(_arg_2));
            if (_arg_3)
            {
                _arg_1.setRollOverIcon(new AssetIcon(_arg_3));
            };
            if (_arg_4)
            {
                _arg_1.setPressedIcon(new AssetIcon(_arg_4));
            };
            if (_arg_5)
            {
                if (_arg_6)
                {
                    _local_7 = HtmlText.gray;
                    _arg_5.filters = [_local_7];
                };
                _arg_1.setDisabledIcon(new AssetIcon(_arg_5));
            };
            _arg_1.setBackgroundDecorator(null);
            _arg_1.setOpaque(false);
            SetSize(_arg_1, _arg_2.width, _arg_2.height);
            _arg_1.buttonMode = true;
            return (_arg_1);
        }

        public static function UpdateCustomButtonFromAssetLocalization(_arg_1:CustomButton, _arg_2:String, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:Boolean=false):CustomButton
        {
            return (UpdateCustomButton(_arg_1, GetAssetLocalization(_arg_2), GetAssetLocalization(_arg_3), GetAssetLocalization(_arg_4), GetAssetLocalization(_arg_5), _arg_6));
        }

        public static function UpdateCustomButtonFromAsset(_arg_1:CustomButton, _arg_2:String, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:Boolean=false):CustomButton
        {
            return (UpdateCustomButton(_arg_1, GetAsset(_arg_2), GetAsset(_arg_3), GetAsset(_arg_4), GetAsset(_arg_5), _arg_6));
        }

        public static function CreateTextButton(_arg_1:String, _arg_2:uint, _arg_3:uint):CustomButton
        {
            var _local_4:CustomButton = new CustomButton(_arg_1);
            _local_4.setBackgroundDecorator(null);
            _local_4.setOpaque(false);
            SetSize(_local_4, _arg_2, _arg_3);
            _local_4.buttonMode = true;
            return (_local_4);
        }

        public static function AlignCenter(_arg_1:Component):JPanel
        {
            var _local_2:JPanel = new JPanel(new CenterLayout());
            _local_2.append(_arg_1);
            return (_local_2);
        }

        public static function SetSize(_arg_1:Component, _arg_2:int, _arg_3:int):void
        {
            var _local_4:IntDimension = new IntDimension(_arg_2, _arg_3);
            _arg_1.setPreferredSize(_local_4);
            _arg_1.setMaximumSize(_local_4);
            _arg_1.setMinimumSize(_local_4);
            _arg_1.setSize(_local_4);
        }

        public static function SetWidth(_arg_1:Component, _arg_2:int):void
        {
            _arg_1.setPreferredWidth(_arg_2);
            _arg_1.setMaximumWidth(_arg_2);
            _arg_1.setMinimumWidth(_arg_2);
            _arg_1.setWidth(_arg_2);
        }

        public static function SetHeight(_arg_1:Component, _arg_2:int):void
        {
            _arg_1.setPreferredHeight(_arg_2);
            _arg_1.setMaximumHeight(_arg_2);
            _arg_1.setMinimumHeight(_arg_2);
            _arg_1.setHeight(_arg_2);
        }

        public static function SetBackground(_arg_1:Component, _arg_2:DisplayObject):void
        {
            if (!_arg_2)
            {
                return;
            };
            _arg_1.setBackgroundDecorator(new AssetBackground(_arg_2));
            SetSize(_arg_1, _arg_2.width, _arg_2.height);
        }

        public static function SetBackgroundFromAsset(_arg_1:Component, _arg_2:String):void
        {
            SetBackground(_arg_1, GetAsset(_arg_2));
        }

        public static function SetBackgroundFromAssetLocalization(_arg_1:Component, _arg_2:String):void
        {
            SetBackground(_arg_1, GetAssetLocalization(_arg_2));
        }

        public static function SetLineBorder(_arg_1:Component, _arg_2:uint, _arg_3:Number=1):void
        {
            _arg_1.setBorder(new LineBorder(null, new ASColor(_arg_2), _arg_3));
        }

        public static function SetBackgroundColor(_arg_1:Component, _arg_2:uint, _arg_3:Number=1):void
        {
            _arg_1.setBackgroundDecorator(new SolidBackground(new ASColor(_arg_2, _arg_3)));
        }

        public static function SetBorder(_arg_1:Component, _arg_2:int=0, _arg_3:int=0, _arg_4:int=0, _arg_5:int=0):void
        {
            _arg_1.setBorder(new EmptyBorder(null, new Insets(_arg_3, _arg_2, _arg_5, _arg_4)));
        }

        public static function OffsetBorder(_arg_1:Component, _arg_2:int=0, _arg_3:int=0, _arg_4:int=0, _arg_5:int=0):JPanel
        {
            var _local_6:JPanel = new JPanel(new BorderLayout());
            _local_6.setBorder(new EmptyBorder(null, new Insets(_arg_3, _arg_2, _arg_5, _arg_4)));
            _local_6.append(_arg_1);
            return (_local_6);
        }


    }
}//package hbm.Game.Utility

