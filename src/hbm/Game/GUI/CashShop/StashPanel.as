


//hbm.Game.GUI.CashShop.StashPanel

package hbm.Game.GUI.CashShop
{
    import org.aswing.JPanel;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import hbm.Game.GUI.CashShop.Stash.VioletSellPanel;
    import hbm.Game.GUI.CashShop.Stash.CraftRunePanel;
    import hbm.Game.GUI.CashShop.Stash.MiniGamesPanel;
    import org.aswing.SoftBoxLayout;
    import hbm.Application.ClientApplication;
    import hbm.Application.ClientConfig;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.BorderLayout;

    public class StashPanel extends JPanel 
    {

        private const _debugBorder:LineBorder = new LineBorder(null, new ASColor(0xFF0000));

        private var _violetSellContentPanel:VioletSellPanel;
        private var _craftRuneContentPanel:CraftRunePanel;

        public function StashPanel()
        {
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_1:MiniGamesPanel;
            var _local_5:JPanel;
            this.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            if (((!(ClientApplication.Instance.Config.CurrentPlatformId == ClientConfig.ODNOKLASSNIKI)) && (!(ClientApplication.Instance.Config.CurrentPlatformId == ClientConfig.ODNOKLASSNIKI_TEST))))
            {
                _local_1 = new MiniGamesPanel();
            };
            this._violetSellContentPanel = new VioletSellPanel();
            this._craftRuneContentPanel = new CraftRunePanel();
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 3, SoftBoxLayout.TOP));
            _local_2.setBorder(new EmptyBorder(null, new Insets(0, 24, 0, 0)));
            if (((!(ClientApplication.Instance.Config.CurrentPlatformId == ClientConfig.ODNOKLASSNIKI)) && (!(ClientApplication.Instance.Config.CurrentPlatformId == ClientConfig.ODNOKLASSNIKI_TEST))))
            {
                _local_5 = new JPanel(new BorderLayout());
                _local_5.append(_local_1, BorderLayout.CENTER);
                _local_2.append(_local_5);
            };
            var _local_3:JPanel = new JPanel(new BorderLayout());
            _local_3.setPreferredSize(this._violetSellContentPanel.getPreferredSize());
            _local_3.append(this._violetSellContentPanel, BorderLayout.CENTER);
            var _local_4:JPanel = new JPanel(new BorderLayout());
            _local_4.setPreferredSize(this._craftRuneContentPanel.getPreferredSize());
            _local_4.append(this._craftRuneContentPanel, BorderLayout.CENTER);
            _local_2.append(_local_3);
            _local_2.append(_local_4);
            append(_local_2);
        }

        public function get VioletSellPanelInstance():VioletSellPanel
        {
            return (this._violetSellContentPanel);
        }

        public function get CraftRunePanelInstance():CraftRunePanel
        {
            return (this._craftRuneContentPanel);
        }


    }
}//package hbm.Game.GUI.CashShop

