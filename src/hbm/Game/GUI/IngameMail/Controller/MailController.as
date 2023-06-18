


//hbm.Game.GUI.IngameMail.Controller.MailController

package hbm.Game.GUI.IngameMail.Controller
{
    import hbm.Engine.Network.Client.Client;
    import hbm.Game.GUI.IngameMail.IngameMail;
    import hbm.Game.GUI.IngameMail.OpenMail;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Network.Events.MailEvent;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;

    public class MailController 
    {

        private var _gameClient:Client;
        private var _mailListWindow:IngameMail;
        private var _mailWindow:OpenMail;

        public function MailController()
        {
            this._gameClient = ClientApplication.Instance.LocalGameClient;
            this._gameClient.addEventListener(MailEvent.ON_MAIL_LIST, this.OnReceivedMailList);
            this._gameClient.addEventListener(MailEvent.ON_MAIL_READ, this.OnReceivedMailMessage);
            this._gameClient.addEventListener(MailEvent.ON_MAIL_GET_ATTACH_RESULT, this.OnReceivedGetAttachResult);
            this._gameClient.addEventListener(MailEvent.ON_MAIL_NEW, this.OnReceivedNewMail);
            this._gameClient.addEventListener(MailEvent.ON_MAIL_DELETE_RESULT, this.OnReceivedDeleteMailResult);
            this._gameClient.addEventListener(MailEvent.ON_MAIL_RETURN_RESULT, this.OnReceivedMailReturnResult);
            this._gameClient.addEventListener(MailEvent.ON_MAIL_SEND_RESULT, this.OnReceivedMailSendResult);
        }

        private function OnReceivedMailList(_arg_1:MailEvent):void
        {
            if (this._mailListWindow == null)
            {
                this._mailListWindow = new IngameMail();
            };
            this._mailListWindow.SetData(_arg_1.MailList);
            if (!this._mailListWindow.isShowing())
            {
                this._mailListWindow.show();
            };
            ClientApplication.Instance.BottomHUD.BlinkMail(false);
        }

        private function OnReceivedMailMessage(_arg_1:MailEvent):void
        {
            if (this._mailWindow == null)
            {
                this._mailWindow = new OpenMail();
            };
            this._mailWindow.SetData(_arg_1.Header, _arg_1.Message, _arg_1.Item);
            if (!this._mailWindow.isShowing())
            {
                this._mailWindow.show();
            };
        }

        public function OpenMailList():void
        {
            if (((this._mailListWindow) && (this._mailListWindow.isShowing())))
            {
                this._mailListWindow.dispose();
            }
            else
            {
                ClientApplication.Instance.LocalGameClient.SendMailboxRefresh();
            };
        }

        public function OpenMailBody(_arg_1:int):void
        {
            if (((this._mailWindow) && (this._mailWindow.isShowing())))
            {
                this._mailWindow.dispose();
            };
            ClientApplication.Instance.LocalGameClient.SendMailRead(_arg_1);
        }

        public function OnReceivedGetAttachResult(_arg_1:MailEvent):void
        {
            var _local_2:String;
            switch (_arg_1.Flag)
            {
                case 0:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE0;
                    return;
                case 1:
                    _local_2 = ClientApplication.Localization.MAIL_WINDOW_MSG1;
                    break;
                case 2:
                    _local_2 = ClientApplication.Localization.CASH_SHOP_ERR_OVERWEIGHT;
                    break;
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, _local_2, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
        }

        public function OnReceivedDeleteMailResult(_arg_1:MailEvent):void
        {
            var _local_2:String;
            switch (_arg_1.Flag)
            {
                case 0:
                    ClientApplication.Instance.LocalGameClient.SendMailboxRefresh();
                    return;
                case 1:
                    _local_2 = ClientApplication.Localization.MAIL_WINDOW_MSG2;
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, _local_2, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
                    return;
            };
        }

        public function OnReceivedMailReturnResult(_arg_1:MailEvent):void
        {
            var _local_2:String;
            switch (_arg_1.Flag)
            {
                case 0:
                case 1:
                    return;
                case 2:
                    _local_2 = ClientApplication.Localization.MAIL_WINDOW_MSG3;
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, _local_2, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
                    return;
            };
        }

        public function OnReceivedMailSendResult(_arg_1:MailEvent):void
        {
            switch (_arg_1.Flag)
            {
                case 0:
                    return;
                case 1:
                    ClientApplication.Instance.LeftChatBarInstance.PublicChannel.AddMessage(ClientApplication.Localization.MAIL_WINDOW_MSG4);
                    return;
            };
        }

        private function OnReceivedNewMail(_arg_1:MailEvent):void
        {
            ClientApplication.Instance.BottomHUD.BlinkMail(true);
            if (((this._mailListWindow) && (this._mailListWindow.isShowing())))
            {
                ClientApplication.Instance.LocalGameClient.SendMailboxRefresh();
            };
        }


    }
}//package hbm.Game.GUI.IngameMail.Controller

