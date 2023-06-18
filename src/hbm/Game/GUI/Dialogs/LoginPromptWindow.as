


//hbm.Game.GUI.Dialogs.LoginPromptWindow

package hbm.Game.GUI.Dialogs
{
    import flash.events.EventDispatcher;
    import org.aswing.JTextField;
    import hbm.Game.GUI.Tools.CustomWindow2;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Engine.Resource.LocalizationPreloaderResourceLibrary;
    import org.aswing.AsWingManager;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.WindowSprites;
    import flash.display.Bitmap;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.AssetBackground;
    import org.aswing.geom.IntDimension;
    import org.aswing.geom.IntPoint;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.EmptyLayout;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.AssetIcon;
    import flash.events.Event;

    public class LoginPromptWindow extends EventDispatcher 
    {

        public static const ON_LOGIN_PRESSED:String = "ON_LOGIN_PRESSED";

        private const _width:int = 315;
        private const _height:int = 168;

        private var _email:String;
        private var _password:String;
        private var _emailField:JTextField;
        private var _passwordField:JTextField;
        private var _window:CustomWindow2;
        private var _loginButton:CustomButton;

        public function LoginPromptWindow()
        {
            var _local_8:LocalizationPreloaderResourceLibrary;
            super();
            this._window = new CustomWindow2(AsWingManager.getRoot(), false, this._width, this._height, false);
            this._window.setLocationXY(((ClientApplication.stageWidth / 2) - (this._width / 2)), 250);
            var _local_1:Bitmap = new WindowSprites.LoginScreenBack();
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            if (_local_1)
            {
                _local_2.setBackgroundDecorator(new AssetBackground(_local_1));
                _local_2.setPreferredHeight(_local_1.height);
                _local_2.setPreferredWidth(_local_1.width);
                _local_2.setMaximumHeight(_local_1.height);
                _local_2.setMaximumWidth(_local_1.width);
                _local_2.setSize(new IntDimension(_local_1.width, _local_1.height));
                _local_2.setLocation(new IntPoint(215, 5));
                _local_2.pack();
            };
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
            _local_3.setSize(new IntDimension(this._width, this._height));
            _local_3.setLocation(new IntPoint(0, 0));
            var _local_4:Bitmap = new WindowSprites.LoginScreenHeader();
            var _local_5:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_5.setBorder(new EmptyBorder(null, new Insets(4, 90, 0, 0)));
            if (_local_4)
            {
                _local_5.setBackgroundDecorator(new AssetBackground(_local_4));
                _local_5.setPreferredHeight((_local_4.height + 4));
                _local_5.setPreferredWidth((_local_4.width + 90));
                _local_5.setMaximumHeight((_local_4.height + 4));
                _local_5.setMaximumWidth((_local_4.width + 90));
                _local_5.pack();
                _local_3.append(_local_5);
            };
            this._emailField = new JTextField("", 16);
            this._emailField.setBackgroundDecorator(null);
            this._emailField.setSize(new IntDimension(230, 26));
            this._emailField.setLocation(new IntPoint(82, 13));
            this._passwordField = new JTextField("", 16);
            this._passwordField.setBackgroundDecorator(null);
            this._passwordField.setDisplayAsPassword(true);
            this._passwordField.setSize(new IntDimension(230, 20));
            this._passwordField.setLocation(new IntPoint(82, 54));
            var _local_6:Bitmap = new WindowSprites.LoginScreenFields();
            var _local_7:JPanel = new JPanel(new EmptyLayout());
            _local_7.setBorder(new EmptyBorder(null, new Insets(10, 10, 0, 0)));
            if (_local_6)
            {
                _local_7.setBackgroundDecorator(new AssetBackground(_local_6));
                _local_7.setPreferredHeight((_local_6.height + 10));
                _local_7.setPreferredWidth((_local_6.width + 10));
                _local_7.setMaximumHeight((_local_6.height + 10));
                _local_7.setMaximumWidth((_local_6.width + 10));
                _local_7.append(this._emailField);
                _local_7.append(this._passwordField);
                _local_7.pack();
                _local_3.append(_local_7);
            };
            _local_8 = LocalizationPreloaderResourceLibrary(ResourceManager.Instance.Library("LocalizationPreloader"));
            var _local_9:Bitmap = _local_8.GetBitmapAsset("Localization_Item_LoginScreenPlayButton");
            var _local_10:Bitmap = _local_8.GetBitmapAsset("Localization_Item_LoginScreenPlayButtonSelected");
            var _local_11:Bitmap = _local_8.GetBitmapAsset("Localization_Item_LoginScreenPlayButtonPressed");
            this._loginButton = new CustomButton(null);
            this._loginButton.setIcon(new AssetIcon(_local_9));
            this._loginButton.setRollOverIcon(new AssetIcon(_local_10));
            this._loginButton.setPressedIcon(new AssetIcon(_local_11));
            this._loginButton.setSize(new IntDimension(_local_9.width, _local_9.height));
            this._loginButton.setBackgroundDecorator(null);
            this._loginButton.setBorder(new EmptyBorder(null, new Insets(15, 20, 0, 0)));
            _local_3.append(this._loginButton);
            var _local_12:JPanel = new JPanel(new EmptyLayout());
            _local_12.setPreferredHeight((this._height + 30));
            _local_12.setPreferredWidth((this._width + 15));
            _local_12.setMaximumHeight((this._height + 30));
            _local_12.setMaximumWidth((this._width + 15));
            _local_12.append(_local_2);
            _local_12.append(_local_3);
            this._window.MainPanel.append(_local_12);
            this._window.pack();
            this._window.setDefaultButton(this._loginButton);
            this._emailField.addActionListener(this.LoginButtonPressed, 0, true);
            this._passwordField.addActionListener(this.LoginButtonPressed, 0, true);
            this._loginButton.addActionListener(this.LoginButtonPressed, 0, true);
        }

        public function Show():void
        {
            this._emailField.setText("");
            this._passwordField.setText("");
            this._loginButton.setEnabled(true);
            this._window.show();
            this.SetFocus();
        }

        public function Dispose():void
        {
            this._window.dispose();
        }

        public function IsShowing():Boolean
        {
            return (this._window.isShowing());
        }

        public function SetFocus():void
        {
            this._emailField.requestFocus();
        }

        private function LoginButtonPressed(_arg_1:Event):void
        {
            this._email = this._emailField.getText();
            this._password = this._passwordField.getText();
            if (this._email.length == 0)
            {
                this._emailField.requestFocus();
                return;
            };
            if (this._password.length == 0)
            {
                this._passwordField.requestFocus();
                return;
            };
            this._loginButton.setEnabled(false);
            dispatchEvent(new Event(ON_LOGIN_PRESSED));
        }

        public function get email():String
        {
            return (this._email);
        }

        public function set email(_arg_1:String):void
        {
            this._email = _arg_1;
        }

        public function set password(_arg_1:String):void
        {
            this._password = _arg_1;
        }

        public function get password():String
        {
            return (this._password);
        }

        public function Center():void
        {
            this._window.setLocationXY(((ClientApplication.stageWidth / 2) - (this._width / 2)), 250);
        }


    }
}//package hbm.Game.GUI.Dialogs

