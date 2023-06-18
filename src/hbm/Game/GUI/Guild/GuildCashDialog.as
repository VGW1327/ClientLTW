


//hbm.Game.GUI.Guild.GuildCashDialog

package hbm.Game.GUI.Guild
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JAdjuster;
    import hbm.Game.Utility.HtmlText;
    import hbm.Application.ClientApplication;
    import org.aswing.JLabel;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.EmptyLayout;
    import org.aswing.BorderLayout;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.events.Event;

    public class GuildCashDialog extends CustomWindow 
    {

        public static const ON_INPUT_PRESSED:String = "ON_INPUT_PRESSED";
        public static const ON_INPUT_CANCELED:String = "ON_INPUT_CANCELED";

        private const _width:int = 400;
        private const _height:int = 55;

        private var _number:int;
        private var _inputNumberAdjuster:JAdjuster;

        public function GuildCashDialog(_arg_1:String, _arg_2:int)
        {
            super(null, HtmlText.GetText(ClientApplication.Localization.GUILD_CASH_WINDOW_TITLE, _arg_1), true, this._width, this._height, false);
            var _local_3:JLabel = new JLabel(ClientApplication.Localization.GUILD_CASH_WINDOW_MESSAGE, null, JLabel.LEFT);
            this._inputNumberAdjuster = new JAdjuster(3);
            this._inputNumberAdjuster.setMinimum(1);
            this._inputNumberAdjuster.setMaximum(_arg_2);
            this._inputNumberAdjuster.setValue(1);
            this._inputNumberAdjuster.setEditable(true);
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 6, SoftBoxLayout.CENTER));
            _local_4.setSizeWH(395, 25);
            _local_4.setLocationXY(1, 2);
            _local_4.append(_local_3);
            _local_4.append(this._inputNumberAdjuster);
            var _local_5:CustomButton = new CustomButton(ClientApplication.Localization.DLG_NPC_OK_BUTTON);
            _local_5.setPreferredWidth(60);
            _local_5.addActionListener(this.OnInputPressed, 0, true);
            var _local_6:CustomButton = new CustomButton(ClientApplication.Localization.DLG_NPC_CANCEL_BUTTON);
            _local_6.setPreferredWidth(60);
            _local_6.addActionListener(this.OnInputCanceled, 0, true);
            var _local_7:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4, SoftBoxLayout.CENTER));
            _local_7.setSizeWH(395, 26);
            _local_7.setLocationXY(1, 40);
            _local_7.append(_local_5);
            _local_7.append(_local_6);
            var _local_8:JPanel = new JPanel(new EmptyLayout());
            _local_8.append(_local_4);
            _local_8.append(_local_7);
            MainPanel.append(_local_8, BorderLayout.CENTER);
            pack();
            setLocationXY(((RenderSystem.Instance.ScreenWidth - this._width) / 2), 200);
        }

        public function GetInputNumber():int
        {
            return (this._number);
        }

        public function OnInputPressed(_arg_1:Event):void
        {
            this._number = this._inputNumberAdjuster.getValue();
            dispatchEvent(new Event(ON_INPUT_PRESSED));
            this.dispose();
        }

        public function OnInputCanceled(_arg_1:Event):void
        {
            dispatchEvent(new Event(ON_INPUT_CANCELED));
            this.dispose();
        }

        override public function show():void
        {
            ClientApplication.Instance.SetShortcutsEnabled(false);
            super.show();
        }

        override public function dispose():void
        {
            ClientApplication.Instance.SetShortcutsEnabled(true);
            super.dispose();
        }


    }
}//package hbm.Game.GUI.Guild

