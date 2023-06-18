


//hbm.Game.GUI.CashShopNew.CustomLabel

package hbm.Game.GUI.CashShopNew
{
    import org.aswing.JTextArea;
    import org.aswing.ASFont;
    import org.aswing.ASColor;
    import flash.text.TextFormat;

    public class CustomLabel extends JTextArea 
    {

        public function CustomLabel(_arg_1:String="", _arg_2:ASFont=null)
        {
            var _local_3:ASFont;
            super(_arg_1);
            if (_arg_2 != null)
            {
                _local_3 = new ASFont(_arg_2.getName(), 12);
            }
            else
            {
                _local_3 = null;
            };
            setEditable(false);
            getTextField().selectable = false;
            setBackgroundDecorator(null);
            setFont(_local_3);
            setForeground(new ASColor(0xEEEEEE));
            setWordWrap(true);
            var _local_4:TextFormat = getTextFormat();
            _local_4.align = "left";
            setTextFormat(_local_4);
        }

    }
}//package hbm.Game.GUI.CashShopNew

