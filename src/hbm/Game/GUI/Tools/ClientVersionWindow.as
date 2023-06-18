


//hbm.Game.GUI.Tools.ClientVersionWindow

package hbm.Game.GUI.Tools
{
    import hbm.Application.ClientApplication;
    import org.aswing.JLabel;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.BorderLayout;
    import org.aswing.CenterLayout;
    import org.aswing.geom.IntDimension;
    import flash.events.Event;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import hbm.Application.ClientConfig;

    public class ClientVersionWindow extends CustomWindow 
    {

        private const WIDTH:int = 345;
        private const HEIGHT:int = 75;

        private var _okButton:CustomButton;
        private var _linkButton:CustomButton;

        public function ClientVersionWindow(_arg_1:*)
        {
            super(_arg_1, ClientApplication.Localization.WARNING_WINDOW_TITLE, true, this.WIDTH, this.HEIGHT);
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_1:JLabel = new JLabel(ClientApplication.Localization.VERSION_MESSAGE);
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.TOP, 20));
            _local_2.setBorder(new EmptyBorder(null, new Insets(6, 4, 4, 4)));
            _local_2.append(_local_1);
            _local_2.append(this.CreateButtonsPanel());
            MainPanel.append(_local_2, BorderLayout.CENTER);
            pack();
            setLocationXY(((ClientApplication.stageWidth / 2) - (this.WIDTH / 2)), 250);
        }

        private function CreateButtonsPanel():JPanel
        {
            var _local_1:JPanel = new JPanel(new CenterLayout());
            _local_1.setPreferredSize(new IntDimension(this.WIDTH, 25));
            var _local_2:JPanel = new JPanel(new BorderLayout());
            _local_2.setPreferredSize(new IntDimension(200, 25));
            this._okButton = new CustomButton(ClientApplication.Localization.OK);
            this._okButton.addActionListener(this.OnOkButton, 0, true);
            this._okButton.setPreferredWidth(60);
            this._linkButton = new CustomButton(ClientApplication.Localization.VERSION_HOW_TO_MESSAGE);
            this._linkButton.addActionListener(this.OnLinkButton, 0, true);
            this._linkButton.setPreferredWidth(130);
            _local_2.append(this._okButton, BorderLayout.LINE_START);
            _local_2.append(this._linkButton, BorderLayout.LINE_END);
            _local_1.append(_local_2);
            return (_local_1);
        }

        private function OnOkButton(_arg_1:Event):void
        {
            dispose();
        }

        private function OnLinkButton(_arg_1:Event):void
        {
            dispose();
            switch (ClientApplication.platform)
            {
                case ClientConfig.VKONTAKTE:
                case ClientConfig.VKONTAKTE_TEST:
                    navigateToURL(new URLRequest("http://vk.com/pages?oid=-18990411&p=-_%D0%9A%D0%90%D0%9A_%D0%9E%D0%A7%D0%98%D0%A1%D0%A2%D0%98%D0%A2%D0%AC_%D0%9A%D0%AD%D0%A8_%D0%91%D0%A0%D0%90%D0%A3%D0%97%D0%95%D0%A0%D0%90_%3F"));
                    return;
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                    navigateToURL(new URLRequest("http://my.mail.ru/community/light-n-darkness/74A90AD407173416.html#74A90AD407173416"));
                    return;
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                    navigateToURL(new URLRequest("http://www.odnoklassniki.ru/group/51808205668477/topic/203826735229"));
                    return;
                case ClientConfig.STANDALONE:
                case ClientConfig.DEBUG:
                case ClientConfig.TEST:
                case ClientConfig.WEB:
                case ClientConfig.WEB_TEST:
                    navigateToURL(new URLRequest("http://lnd.novo-play.ru/faq/?SECTION_ID=16#50"));
                    return;
                case ClientConfig.FOTOSTRANA:
                case ClientConfig.FOTOSTRANA_TEST:
                    navigateToURL(new URLRequest("http://lnd.novo-play.ru/faq/?SECTION_ID=16#50"));
                    return;
            };
        }


    }
}//package hbm.Game.GUI.Tools

