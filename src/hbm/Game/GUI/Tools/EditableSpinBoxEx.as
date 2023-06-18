


//hbm.Game.GUI.Tools.EditableSpinBoxEx

package hbm.Game.GUI.Tools
{
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.ASFont;
    import org.aswing.ASColor;
    import flash.text.TextFormat;
    import org.aswing.AssetIcon;

    public class EditableSpinBoxEx extends EditableSpinBox 
    {

        public function EditableSpinBoxEx(_arg_1:int, _arg_2:int, _arg_3:int=1)
        {
            super(150, 50, _arg_1, _arg_2, _arg_3);
            this.ReInitUI();
        }

        protected function ReInitUI():void
        {
            var _local_1:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            removeAll();
            setLayout(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4, SoftBoxLayout.LEFT));
            AsWingUtil.SetBackground(_spinAmountLbl, _local_1.GetBitmapAsset("AdditionalData_Item_NBCW_SpinEdit"));
            _spinAmountLbl.setFont(new ASFont(getFont().getName(), 20, true));
            _spinAmountLbl.setForeground(new ASColor(0xFFFFFF));
            var _local_2:TextFormat = _spinAmountLbl.getTextFormat();
            _local_2.align = "center";
            _spinAmountLbl.setDefaultTextFormat(_local_2);
            _spinAmountLbl.setTextFormat(_local_2);
            _spinArrowUp.setIcon(new AssetIcon(_local_1.GetBitmapAsset("AdditionalData_Item_NBCW_SpinPlus")));
            _spinArrowUp.setRollOverIcon(new AssetIcon(_local_1.GetBitmapAsset("AdditionalData_Item_NBCW_SpinPlusOver")));
            _spinArrowUp.setPressedIcon(new AssetIcon(_local_1.GetBitmapAsset("AdditionalData_Item_NBCW_SpinPlusPress")));
            AsWingUtil.SetSize(_spinArrowUp, 22, 21);
            AsWingUtil.SetBorder(_spinArrowUp);
            _spinArrowDown.setIcon(new AssetIcon(_local_1.GetBitmapAsset("AdditionalData_Item_NBCW_SpinMinus")));
            _spinArrowDown.setRollOverIcon(new AssetIcon(_local_1.GetBitmapAsset("AdditionalData_Item_NBCW_SpinMinusOver")));
            _spinArrowDown.setPressedIcon(new AssetIcon(_local_1.GetBitmapAsset("AdditionalData_Item_NBCW_SpinMinusPress")));
            AsWingUtil.SetSize(_spinArrowDown, 22, 21);
            AsWingUtil.SetBorder(_spinArrowDown);
            appendAll(_spinArrowDown, _spinAmountLbl, _spinArrowUp);
        }


    }
}//package hbm.Game.GUI.Tools

