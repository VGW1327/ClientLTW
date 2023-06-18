


//hbm.Game.GUI.CharacterCreation.CharacterRenameDialog

package hbm.Game.GUI.CharacterCreation
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JTextField;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Application.ClientApplication;
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.JLabel;
    import org.aswing.AttachIcon;
    import org.aswing.ASFont;
    import org.aswing.AsWingConstants;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import flash.events.Event;

    public class CharacterRenameDialog extends CustomWindow 
    {

        private const _width:int = 360;
        private const _height:int = 100;

        private var _name:String;
        private var _nameTextField:JTextField;
        private var _confirmButton:CustomButton;

        public function CharacterRenameDialog()
        {
            super(null, ClientApplication.Localization.DLG_CHARACTER_RENAME_TITLE, true, this._width, this._height, true);
            this.Init();
            pack();
        }

        private function Init():void
        {
            setLocationXY(((ClientApplication.stageWidth / 2) - (this._width / 2)), ((0x0300 - this._height) / 2));
            this._nameTextField = new JTextField("", 22);
            this._nameTextField.setMaxChars(22);
            this._confirmButton = new CustomButton(ClientApplication.Localization.DLG_CHARACTER_RENAME_BUTTON);
            var _local_1:JPanel = new JPanel(new BorderLayout(4, 4));
            _local_1.setBorder(new EmptyBorder(null, new Insets(4, 4, 4, 14)));
            _local_1.append(this._nameTextField, BorderLayout.WEST);
            _local_1.append(this._confirmButton, BorderLayout.EAST);
            _local_1.append(new JLabel(ClientApplication.Localization.DLG_CHARACTER_ERROR_MSG, new AttachIcon("AchtungIcon")), BorderLayout.PAGE_END);
            var _local_2:ASFont = new ASFont();
            var _local_3:JLabel = new JLabel(ClientApplication.Localization.DLG_CHARACTER_RENAME_ENTER_NAME);
            _local_3.setHorizontalAlignment(AsWingConstants.LEFT);
            _local_3.setFont(_local_2.changeBold(true).changeSize(12));
            var _local_4:JPanel = new JPanel();
            _local_4.append(_local_3);
            _local_4.append(_local_1);
            MainPanel.append(_local_4, BorderLayout.CENTER);
            setDefaultButton(this._confirmButton);
            this._confirmButton.addActionListener(this.OnConfirmPressed, 0, true);
        }

        private function OnConfirmPressed(_arg_1:Event):void
        {
            var _local_2:RegExp;
            var _local_4:String;
            var _local_5:int;
            this._name = this._nameTextField.getText();
            _local_2 = new RegExp(ClientApplication.Localization.PLAYER_NAME_PATTERN);
            var _local_3:Array = this._name.match(_local_2);
            if (_local_3 != null)
            {
                if (_local_3[0] === this._name)
                {
                    _local_4 = this._name.toLowerCase().replace(ClientApplication.Localization.CENSURE_PATTERN1, "_").replace(ClientApplication.Localization.CENSURE_PATTERN2, "_").replace(ClientApplication.Localization.CREATE_NAME_CENSURE_PATTERN, "_");
                    if (_local_4 != null)
                    {
                        _local_5 = _local_4.indexOf("_");
                        if (_local_5 >= 0)
                        {
                            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.ERR_WRONG_CHARACTER_NAME_TITLE, ClientApplication.Localization.ERR_CHARACTER_NAME_INCORRECT, null, null, true, new AttachIcon("AchtungIcon")));
                            return;
                        };
                    };
                    dispose();
                    dispatchEvent(new CharacterCreateEvent(CharacterCreateEvent.ON_CHARACTER_RENAME_CONFIRMED, this._name, true));
                    return;
                };
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.ERR_WRONG_CHARACTER_NAME_TITLE, ClientApplication.Localization.ERR_WRONG_CHARACTER_NAME, null, null, true, new AttachIcon("AchtungIcon")));
        }

        public function GetName():String
        {
            return (this._name);
        }

        override public function show():void
        {
            super.show();
            this._nameTextField.requestFocus();
        }


    }
}//package hbm.Game.GUI.CharacterCreation

