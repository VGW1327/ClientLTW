


//hbm.Game.GUI.PaddedValue

package hbm.Game.GUI
{
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import flash.display.Bitmap;
    import org.aswing.SoftBoxLayout;
    import org.aswing.AssetIcon;
    import org.aswing.geom.IntDimension;
    import org.aswing.ASColor;
    import hbm.Game.GUI.Tools.WindowSprites;

    public class PaddedValue extends JPanel 
    {

        private var _valueLabel:JLabel;
        private var _nameLabel:JLabel;

        public function PaddedValue(_arg_1:String, _arg_2:String="", _arg_3:int=70, _arg_4:int=45, _arg_5:int=-1, _arg_6:int=-1, _arg_7:int=11, _arg_8:Boolean=false)
        {
			var _local_9:AssetIcon;
            var _local_10:Bitmap;
            var _local_11:JLabel;
            super();
            setLayout(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, ((_arg_8) ? SoftBoxLayout.LEFT : SoftBoxLayout.RIGHT)));
            this._nameLabel = new JLabel(_arg_1, null, JLabel.LEFT);
            if (_arg_3 > 0)
            {
                this._nameLabel.setPreferredSize(new IntDimension(_arg_3, 15));
            };
            if (_arg_6 > 0)
            {
                this._nameLabel.setForeground(new ASColor(_arg_6));
            };
            if (((_arg_5 >= 0) && (_arg_5 < 3)))
            {
                switch (_arg_5)
                {
                    case 0:
                        _local_10 = new WindowSprites.CoinSilver();
                        break;
                    case 1:
                        _local_10 = new WindowSprites.CoinGold();
                        break;
                    case 2:
                        _local_10 = new WindowSprites.CoinKafra();
                        break;
                };
                _local_9 = new AssetIcon(_local_10);
            };
            this._valueLabel = new JLabel(_arg_2, null, ((_arg_8) ? JLabel.LEFT : JLabel.RIGHT));
            if (_arg_4 > 0)
            {
                this._valueLabel.setPreferredWidth(_arg_4);
            };
            if (_arg_6 > 0)
            {
                this._valueLabel.setForeground(new ASColor(_arg_6));
            };
            append(this._nameLabel);
            append(this._valueLabel);
            if (_local_9)
            {
                _local_11 = new JLabel("", _local_9);
                append(_local_11);
            };
        }

        public function get Value():String
        {
            return (this._valueLabel.getText());
        }

        public function set Value(_arg_1:String):void
        {
            this._valueLabel.setText(_arg_1);
        }

        public function SetPadding(_arg_1:int):void
        {
            this._valueLabel.setHorizontalAlignment(_arg_1);
        }


    }
}//package hbm.Game.GUI

