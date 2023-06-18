


//hbm.Game.GUI.Dialogs.MessageToGameMasters

package hbm.Game.GUI.Dialogs
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JLabel;
    import org.aswing.JTextField;
    import org.aswing.JButton;
    import hbm.Application.ClientApplication;
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.ASColor;
    import org.aswing.CenterLayout;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.GUI.Tools.StandardButtonsFactory;
    import org.aswing.Component;
    import flash.events.Event;

    public class MessageToGameMasters extends CustomWindow 
    {

        private const _width:int = 395;
        private const _height:int = 130;

        private var _descriptionLabel:JLabel;
        private var _messageField:JTextField;
        private var _okButton:JButton;
        private var _cancelButton:JButton;

        public function MessageToGameMasters()
        {
            super(null, ClientApplication.Localization.TOPBAR_MENU_MESSAGE_TO_GM, false, this._width, this._height, true);
            this.InitGui();
        }

        private function InitGui():void
        {
            var _local_1:JPanel = new JPanel(new BorderLayout(8, 9));
            _local_1.setBorder(new EmptyBorder(null, new Insets(4, 6, 0, 6)));
            this._descriptionLabel = new JLabel(ClientApplication.Localization.GM_MESSAGE_DESCRIPTION);
            this._messageField = new JTextField("", 254);
            this._messageField.setMaxChars(254);
            this._messageField.setForeground(ASColor.DARK_GRAY);
            _local_1.append(this._descriptionLabel, BorderLayout.NORTH);
            _local_1.append(this._messageField, BorderLayout.CENTER);
            _local_1.append(this.CreateButtonPanel(), BorderLayout.SOUTH);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), 300);
            MainPanel.append(_local_1);
        }

        private function CreateButtonPanel():Component
        {
            var _local_1:JPanel = new JPanel(new CenterLayout());
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(0, 8));
            var _local_3:StandardButtonsFactory = new StandardButtonsFactory();
            this._okButton = _local_3.CreateButton(StandardButtonsFactory.OK);
            this._okButton.addActionListener(this.OnSendMessage);
            this._cancelButton = _local_3.CreateButton(StandardButtonsFactory.CANCEL);
            this._cancelButton.addActionListener(this.OnCancel);
            _local_2.append(this._okButton);
            _local_2.append(this._cancelButton);
            _local_1.append(_local_2);
            return (_local_1);
        }

        private function OnTextChanged(_arg_1:Event):void
        {
            this._okButton.setEnabled((!(this._messageField.getText().length == 0)));
        }

        private function OnCancel(_arg_1:Event):void
        {
            this.dispose();
        }

        private function OnSendMessage(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendRequestMessage(this._messageField.getText());
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
}//package hbm.Game.GUI.Dialogs

