


//hbm.Application.Social.InviteFriendWindow

package hbm.Application.Social
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import hbm.Application.ClientConfig;
    import hbm.Application.ClientApplication;
    import org.aswing.JTextArea;
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.BorderLayout;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.Utility.AsWingUtil;
    import com.hbm.socialmodule.connection.crypto.MD5;
    import org.aswing.JScrollPane;
    import org.aswing.ASFont;
    import org.aswing.JLabel;
    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;
    import org.aswing.event.AWEvent;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.events.Event;
    import flash.net.URLVariables;
    import flash.net.URLRequest;
    import mx.validators.EmailValidator;
    import mx.validators.ValidationResult;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import flash.net.URLRequestMethod;
    import flash.net.sendToURL;

    public class InviteFriendWindow extends WindowPrototype 
    {

        private static const SCRIPT_EMAIL:String = "http://novo-play.ru/lnd/utils/mail_inviter.php";

        private const WIDTH:int = 460;
        private const HEIGHT:int = 370;
        private const HEIGHT_WITH_WALLPOST:int = 445;

        private var _link:String;
        private var _hashInvite:String;
        private var _enablePost:Boolean = (ClientConfig.DisableWallPost.indexOf(ClientApplication.Instance.Config.CurrentPlatformId) < 0);
        private var _emailInput:JTextArea;

        public function InviteFriendWindow()
        {
            var _local_1:uint = ((this._enablePost) ? this.HEIGHT_WITH_WALLPOST : this.HEIGHT);
            super(owner, ClientApplication.Localization.REFERAL_DIALOG_INVITE_FRIEND, false, this.WIDTH, _local_1, true, true);
        }

        override protected function InitUI():void
        {
            var _local_3:JTextArea;
            var _local_10:JPanel;
            var _local_11:JPanel;
            var _local_12:String;
            var _local_13:CustomButton;
            super.InitUI();
            Body.setLayout(new BorderLayout());
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.TOP));
            var _local_2:JTextArea = AsWingUtil.CreateTextArea(ClientApplication.Localization.REFERAL_DIALOG_DESCRIPTION);
            AsWingUtil.SetSize(_local_2, (this.WIDTH - 30), 40);
            _local_1.append(_local_2);
            this._hashInvite = MD5.encrypt((ClientApplication.Instance.LocalGameClient.CurrentLoginId + ClientApplication.Instance.LocalGameClient.UserEmail));
            this._link = ("http://novo-play.ru/lnd/?from=" + this._hashInvite);
            _local_3 = AsWingUtil.CreateTextArea(this._link);
            _local_3.getTextField().selectable = true;
            var _local_4:JScrollPane = new JScrollPane(_local_3, JScrollPane.SCROLLBAR_AS_NEEDED);
            AsWingUtil.SetBackgroundColor(_local_4, 859945);
            AsWingUtil.SetLineBorder(_local_4, 3758946);
            AsWingUtil.SetSize(_local_4, this.WIDTH, 40);
            _local_1.append(_local_4);
            var _local_5:CustomButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("IW_InviteLink", "IW_InviteLinkOver");
            _local_5.addActionListener(this.OnCopyLink, 0, true);
            _local_1.append(AsWingUtil.AlignCenter(_local_5));
            if (this._enablePost)
            {
                _local_10 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 10, SoftBoxLayout.TOP));
                AsWingUtil.SetBorder(_local_10, 15, 10);
                _local_11 = new JPanel(new BorderLayout());
                switch (ClientApplication.Instance.Config.CurrentPlatformId)
                {
                    case ClientConfig.VKONTAKTE:
                    case ClientConfig.VKONTAKTE_TEST:
                        _local_12 = "LevelWindowVk";
                        break;
                    case ClientConfig.FOTOSTRANA:
                    case ClientConfig.FOTOSTRANA_TEST:
                        _local_12 = "LevelWindowFs";
                        break;
                    case ClientConfig.MAILRU:
                    case ClientConfig.MAILRU_TEST:
                        _local_12 = "LevelWindowMm";
                        break;
                    case ClientConfig.ODNOKLASSNIKI:
                    case ClientConfig.ODNOKLASSNIKI_TEST:
                        _local_12 = "LevelWindowOk";
                        break;
                };
                if (_local_12)
                {
                    AsWingUtil.SetBackgroundFromAsset(_local_11, _local_12);
                    _local_10.append(AsWingUtil.OffsetBorder(_local_11, 0, 5));
                };
                _local_13 = AsWingUtil.CreateCustomButtonFromAssetLocalization("IW_InviteWall", "IW_InviteWallOver");
                _local_10.append(_local_13);
                _local_13.addActionListener(this.OnSendToWall, 0, true);
                _local_1.append(AsWingUtil.AlignCenter(_local_10));
            };
            var _local_6:JPanel = AsWingUtil.CreateCenterTextArea(ClientApplication.Localization.REFERAL_DIALOG_EMAIL_TEXT, 0xFFFFFF, new ASFont(getFont().getName(), 14, true));
            _local_1.append(_local_6);
            var _local_7:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.TOP));
            AsWingUtil.SetBorder(_local_7, 15, 10);
            var _local_8:JLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.REFERAL_DIALOG_EMAIL, 0xFFFFFF, new ASFont(getFont().getName(), 14, true));
            _local_7.append(_local_8);
            this._emailInput = AsWingUtil.CreateTextArea("");
            this._emailInput.setEditable(true);
            this._emailInput.getTextField().selectable = true;
            this._emailInput.getTextField().maxChars = 64;
            AsWingUtil.SetWidth(this._emailInput, 350);
            AsWingUtil.SetBackgroundColor(this._emailInput, 859945);
            AsWingUtil.SetLineBorder(this._emailInput, 3758946);
            _local_7.append(this._emailInput);
            _local_1.append(_local_7);
            var _local_9:CustomButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("IW_InviteMail", "IW_InviteMailOver");
            _local_9.addActionListener(this.OnSendToMail, 0, true);
            _local_1.append(AsWingUtil.AlignCenter(_local_9));
            Body.append(_local_1);
            Bottom.removeAll();
        }

        private function OnCopyLink(_arg_1:AWEvent):void
        {
            Clipboard.generalClipboard.clear();
            Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, this._link);
            this.dispose();
        }

        override public function show():void
        {
            super.show();
            setLocationXY(((RenderSystem.Instance.ScreenWidth - width) / 2), ((RenderSystem.Instance.ScreenHeight - height) / 2));
            ClientApplication.Instance.SetShortcutsEnabled(false);
        }

        override public function dispose():void
        {
            super.dispose();
            ClientApplication.Instance.SetShortcutsEnabled(true);
        }

        private function OnSendToWall(_arg_1:Event):void
        {
            var _local_2:String;
            var _local_3:AdditionalDataResourceLibrary;
            var _local_5:String;
            _local_3 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_4:Object = _local_3.GetWallInviteFriendData();
            if (_local_4 != null)
            {
                switch (ClientApplication.Instance.Config.CurrentPlatformId)
                {
                    case ClientConfig.VKONTAKTE:
                    case ClientConfig.VKONTAKTE_TEST:
                        _local_2 = _local_4[ClientConfig.VKONTAKTE]["image"];
                        if (ClientApplication.fromPortal > 0)
                        {
                            _local_2 = ClientApplication.Instance.Config.GetFileURLExt((("Wall/" + _local_2) + ".jpg"));
                        };
                        break;
                    case ClientConfig.FOTOSTRANA:
                    case ClientConfig.FOTOSTRANA_TEST:
                        _local_2 = _local_4[ClientConfig.FOTOSTRANA]["image"];
                        _local_2 = ClientApplication.Instance.Config.GetFileURLExt(_local_2);
                        break;
                    case ClientConfig.MAILRU:
                    case ClientConfig.MAILRU_TEST:
                        _local_2 = _local_4[ClientConfig.MAILRU]["image"];
                        _local_2 = ClientApplication.Instance.Config.GetFileURLExt(_local_2);
                        break;
                    case ClientConfig.ODNOKLASSNIKI:
                    case ClientConfig.ODNOKLASSNIKI_TEST:
                        _local_2 = _local_4[ClientConfig.ODNOKLASSNIKI]["image"];
                        _local_2 = ClientApplication.Instance.Config.GetFileURLExt(_local_2);
                        break;
                };
                _local_5 = ((ClientApplication.fromPortal > 0) ? this._hashInvite : this._link);
                ClientApplication.Instance.WallPost(ClientApplication.Localization.REFERAL_DIALOG_WALL_TEXT, _local_2, _local_5);
            };
            this.dispose();
        }

        private function OnSendToMail(_arg_1:Event):void
        {
            var _local_2:String;
            var _local_4:String;
            var _local_5:URLVariables;
            var _local_6:URLRequest;
            _local_2 = this._emailInput.getText();
            var _local_3:Array = EmailValidator.validateEmail(new EmailValidator(), _local_2, "");
            if (_local_3.length)
            {
                _local_4 = "Неизвестная ошибка!";
                switch ((_local_3[0] as ValidationResult).errorCode)
                {
                    case "missingAtSign":
                        _local_4 = ClientApplication.Localization.REFERAL_DIALOG_EMAIL_ERROR_1;
                        break;
                    case "tooManyAtSigns":
                        _local_4 = ClientApplication.Localization.REFERAL_DIALOG_EMAIL_ERROR_2;
                        break;
                    case "missingUsername":
                        _local_4 = ClientApplication.Localization.REFERAL_DIALOG_EMAIL_ERROR_3;
                        break;
                    case "invalidChar":
                        _local_4 = ClientApplication.Localization.REFERAL_DIALOG_EMAIL_ERROR_4;
                        break;
                    case "invalidIPDomain":
                        _local_4 = ClientApplication.Localization.REFERAL_DIALOG_EMAIL_ERROR_5;
                        break;
                    case "missingPeriodInDomain":
                        _local_4 = ClientApplication.Localization.REFERAL_DIALOG_EMAIL_ERROR_6;
                        break;
                    case "invalidDomain":
                        _local_4 = ClientApplication.Localization.REFERAL_DIALOG_EMAIL_ERROR_7;
                        break;
                    case "invalidPeriodsInDomain":
                        _local_4 = ClientApplication.Localization.REFERAL_DIALOG_EMAIL_ERROR_8;
                        break;
                };
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.REFERAL_DIALOG_EMAIL_ERROR_DLG, _local_4, null, null, false, new AttachIcon("AchtungIcon"), JOptionPane.YES));
            }
            else
            {
                _local_5 = new URLVariables();
                _local_5.to = _local_2;
                _local_5.from = this._hashInvite;
                _local_6 = new URLRequest(SCRIPT_EMAIL);
                _local_6.method = URLRequestMethod.POST;
                _local_6.data = _local_5;
                sendToURL(_local_6);
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.REFERAL_DIALOG_EMAIL_TITLE_DLG, ClientApplication.Localization.REFERAL_DIALOG_EMAIL_TEXT_DLG, null, null, false, new AttachIcon("AchtungIcon"), JOptionPane.YES));
                this.dispose();
            };
        }


    }
}//package hbm.Application.Social

