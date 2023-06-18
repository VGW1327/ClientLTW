


//hbm.Game.GUI.CashShopNew.ButtonPrototype

package hbm.Game.GUI.CashShopNew
{
    import org.aswing.JButton;
    import org.aswing.ASFont;
    import flash.events.MouseEvent;
    import org.aswing.Icon;
    import hbm.Application.ClientApplication;
    import hbm.Game.Music.Music;
    import flash.events.Event;

    public class ButtonPrototype extends JButton 
    {

        private var _Id:int = 0;
        private var _customId:int = 0;

        public function ButtonPrototype(_arg_1:String="", _arg_2:Icon=null, _arg_3:int=0, _arg_4:Number=0, _arg_5:int=0)
        {
            var _local_6:ASFont;
            super(_arg_1, _arg_2);
            _local_6 = getFont();
            var _local_7:ASFont = new ASFont(_local_6.getName(), 12, true);
            setFont(_local_7);
            useHandCursor = true;
            buttonMode = true;
            if (_arg_4 != 0)
            {
                setPreferredWidth(_arg_4);
            };
            this._customId = _arg_5;
            this._Id = _arg_3;
            addEventListener(MouseEvent.CLICK, this.OnButtonPressed, false, 0, true);
        }

        public function set Id(_arg_1:int):void
        {
            this._Id = _arg_1;
        }

        public function get Id():int
        {
            return (this._Id);
        }

        public function set CustomId(_arg_1:int):void
        {
            this._customId = _arg_1;
        }

        public function get CustomId():int
        {
            return (this._customId);
        }

        private function OnButtonPressed(_arg_1:Event):void
        {
            if (ClientApplication.Instance.GameSettings.IsPlaySoundsEnabled)
            {
                Music.Instance.PlaySound(Music.ClickSound);
            };
        }


    }
}//package hbm.Game.GUI.CashShopNew

