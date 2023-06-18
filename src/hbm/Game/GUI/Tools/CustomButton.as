


//hbm.Game.GUI.Tools.CustomButton

package hbm.Game.GUI.Tools
{
    import org.aswing.JButton;
    import org.aswing.ASFont;
    import org.aswing.ASColor;
    import flash.events.MouseEvent;
    import org.aswing.Icon;
    import hbm.Application.ClientApplication;
    import hbm.Game.Music.Music;
    import flash.events.Event;

    public class CustomButton extends JButton 
    {

        public function CustomButton(_arg_1:String="", _arg_2:Icon=null)
        {
            var _local_3:ASFont;
            super(_arg_1, _arg_2);
            setBackground(new ASColor(7104092));
            setForeground(new ASColor(16767612));
            _local_3 = getFont();
            var _local_4:ASFont = new ASFont(_local_3.getName(), 12, true);
            setFont(_local_4);
            useHandCursor = true;
            buttonMode = true;
            addEventListener(MouseEvent.CLICK, this.OnButtonPressed, false, 0, true);
        }

        private function OnButtonPressed(_arg_1:Event):void
        {
            if (ClientApplication.Instance.GameSettings.IsPlaySoundsEnabled)
            {
                Music.Instance.PlaySound(Music.ClickSound);
            };
        }


    }
}//package hbm.Game.GUI.Tools

