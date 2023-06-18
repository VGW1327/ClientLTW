


//hbm.Game.GUI.Tools.FlashCustomButton

package hbm.Game.GUI.Tools
{
    import org.aswing.JButton;
    import flash.display.SimpleButton;
    import org.aswing.AssetIcon;
    import flash.events.MouseEvent;
    import hbm.Application.ClientApplication;
    import hbm.Game.Music.Music;
    import flash.events.Event;

    public class FlashCustomButton extends JButton 
    {

        private var _callbackClick:Function;

        public function FlashCustomButton(_arg_1:Class, _arg_2:Function=null)
        {
            setBackgroundChild();
            setForegroundChild();
            setBackground(null);
            setForeground(null);
            var _local_3:SimpleButton = new (_arg_1)();
            setIcon(new AssetIcon(_local_3.upState));
            setPressedIcon(new AssetIcon(_local_3.downState));
            setRollOverIcon(new AssetIcon(_local_3.overState));
            this._callbackClick = _arg_2;
            useHandCursor = true;
            buttonMode = true;
            addEventListener(MouseEvent.CLICK, this.OnButtonPressed, false, 0, true);
            pack();
        }

        private function OnButtonPressed(_arg_1:Event):void
        {
            if (ClientApplication.Instance.GameSettings.IsPlaySoundsEnabled)
            {
                Music.Instance.PlaySound(Music.ClickSound);
            };
            if (this._callbackClick != null)
            {
                this._callbackClick(_arg_1);
            };
        }


    }
}//package hbm.Game.GUI.Tools

