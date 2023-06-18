


//hbm.Game.GUI.CharacterStats.CharacterStatsButton

package hbm.Game.GUI.CharacterStats
{
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.SoftBoxLayout;
    import org.aswing.ASColor;
    import flash.events.Event;
    import hbm.Application.ClientApplication;
    import hbm.Game.Utility.AsWingUtil;

    public class CharacterStatsButton extends JPanel 
    {

        private var _valueLabel:JLabel;
        private var _increaseButton:CustomButton;
        private var _stat:int;
        private var _toolTip:CustomToolTip;

        public function CharacterStatsButton(_arg_1:String, _arg_2:int, _arg_3:String=null, _arg_4:int=-1, _arg_5:int=-1)
        {
            this._stat = _arg_2;
            setLayout(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.RIGHT));
            this._valueLabel = new JLabel("", null, JLabel.RIGHT);
            this._valueLabel.setPreferredWidth(42);
            this._increaseButton = new CustomButton("");
            this._increaseButton.addActionListener(this.OnButtonPressed, 0, true);
            var _local_6:JLabel = new JLabel(_arg_1, null, JLabel.LEFT);
            _local_6.setForeground(new ASColor(7000662));
            if (_arg_3)
            {
                this._toolTip = new CustomToolTip(_local_6, _arg_3, _arg_4, _arg_5);
            };
            append(_local_6);
            append(this._valueLabel);
            append(this._increaseButton);
        }

        private function OnButtonPressed(_arg_1:Event):void
        {
            dispatchEvent(new CharacterStatsButtonEvent(this._stat));
        }

        public function set RemainPoints(_arg_1:int):void
        {
            var _local_2:String;
            if (_arg_1 > 0)
            {
                if (((_arg_1 >= 2) && (_arg_1 <= 4)))
                {
                    _local_2 = ClientApplication.Localization.NEEDED_POINTS_PART2;
                }
                else
                {
                    _local_2 = ClientApplication.Localization.NEEDED_POINTS_PART3;
                };
                this._increaseButton.setToolTipText(((((ClientApplication.Localization.NEEDED_POINTS_PART1 + " ") + _arg_1) + " ") + _local_2));
                this._increaseButton.setEnabled(true);
            }
            else
            {
                this._increaseButton.setEnabled(false);
            };
        }

        public function set Value(_arg_1:int):void
        {
            this._valueLabel.setText(_arg_1.toString());
        }

        public function SetPoints(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            this.Value = (_arg_1 + _arg_2);
            this.RemainPoints = _arg_3;
            this._increaseButton.setEnabled(((_arg_4 >= _arg_3) && (_arg_1 < 99)));
        }

        public function get Enabled():Boolean
        {
            return (this._increaseButton.isEnabled());
        }

        public function UpdateGraphics():void
        {
            AsWingUtil.UpdateCustomButtonFromAsset(this._increaseButton, "CharacterInventoryButton_plus1", "CharacterInventoryButton_plus3", "CharacterInventoryButton_plus2", "CharacterInventoryButton_plus1", true);
            AsWingUtil.SetSize(this._increaseButton, 17, 19);
        }


    }
}//package hbm.Game.GUI.CharacterStats

