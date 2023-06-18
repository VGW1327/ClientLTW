


//hbm.Game.GUI.CashShop.Stash.MiniGamesPanel

package hbm.Game.GUI.CashShop.Stash
{
    import org.aswing.JPanel;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import org.aswing.JLabel;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.CenterLayout;
    import hbm.Application.ClientApplication;
    import org.aswing.geom.IntDimension;
    import org.aswing.geom.IntPoint;
    import flash.display.Bitmap;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.AssetIcon;
    import hbm.Application.GoogleAnalyticsClient;
    import org.aswing.event.AWEvent;

    public class MiniGamesPanel extends JPanel 
    {

        private static var _localizationLibrary:LocalizationResourceLibrary;

        private var _betScrollBar:BetScrollBar;
        private var _result:JLabel;
        private var _dataLibrary:AdditionalDataResourceLibrary;

        public function MiniGamesPanel()
        {
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            _localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            this.InitUI();
        }

        protected function InitUI():void
        {
            setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            AsWingUtil.SetBackground(this, this._dataLibrary.GetBitmapAsset("AdditionalData_Item_Stash_Roulette"));
            var _local_1:JPanel = new JPanel(new CenterLayout());
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4, SoftBoxLayout.RIGHT));
            var _local_3:JPanel = new JPanel(new CenterLayout());
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 1));
            var _local_5:JLabel = new JLabel(ClientApplication.Localization.CASH_SHOP_MINIGAMES_AMOUNT);
            var _local_6:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4, SoftBoxLayout.LEFT));
            var _local_7:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4, SoftBoxLayout.LEFT));
            var _local_8:JLabel = new JLabel(ClientApplication.Localization.CASH_SHOP_MINIGAMES_TITLE, null, JLabel.CENTER);
            _local_1.setPreferredSize(new IntDimension(601, 33));
            _local_1.append(_local_8);
            _local_2.setPreferredSize(new IntDimension(601, 70));
            _local_2.setBorder(new EmptyBorder(null, new Insets(10)));
            _local_4.setPreferredSize(new IntDimension(192, 75));
            this._betScrollBar = new BetScrollBar(193, 19, this._dataLibrary.GetBitmapAsset("AdditionalData_Item_Stash_Slider"), new IntPoint(100, 5000), 300);
            this._betScrollBar.SetStateListener(this.OnChangeValue);
            _local_6.setPreferredSize(new IntDimension(193, 19));
            var _local_9:JLabel = new JLabel(ClientApplication.Localization.CASH_SHOP_MINIGAMES_CHANCE);
            _local_9.setBorder(new EmptyBorder(null, new Insets(0, 10)));
            _local_6.append(_local_9);
            _local_7.setPreferredSize(new IntDimension(193, 19));
            var _local_10:JLabel = new JLabel(ClientApplication.Localization.CASH_SHOP_MINIGAMES_RESULT);
            _local_10.setBorder(new EmptyBorder(null, new Insets(0, 10)));
            _local_7.append(_local_10);
            _local_7.append((this._result = new JLabel("", null, JLabel.LEFT)));
            this._result.setPreferredWidth(40);
            this._result.setText((int((this._betScrollBar.Value * 0.5)) + ""));
            _local_4.append(this._betScrollBar);
            _local_4.append(_local_6);
            _local_4.append(_local_7);
            _local_3.setPreferredSize(new IntDimension(230, 60));
            var _local_11:Bitmap = _localizationLibrary.GetBitmapAsset("Localization_Item_Stash_PlayButton");
            var _local_12:CustomButton = new CustomButton("");
            _local_12.setIcon(new AssetIcon(_local_11));
            _local_12.setRollOverIcon(new AssetIcon(_localizationLibrary.GetBitmapAsset("Localization_Item_Stash_PlayButtonOver")));
            _local_12.setPressedIcon(new AssetIcon(_localizationLibrary.GetBitmapAsset("Localization_Item_Stash_PlayButtonActive")));
            _local_12.setBackgroundDecorator(null);
            _local_12.setPreferredSize(new IntDimension(_local_11.width, _local_11.height));
            _local_12.addActionListener(this.OnGameButtonPressed, 0, true);
            _local_3.append(_local_12);
            _local_2.append(_local_4);
            _local_2.append(_local_3);
            append(_local_1);
            append(_local_2);
        }

        private function OnGameButtonPressed(_arg_1:AWEvent):void
        {
            var _local_2:int = this._betScrollBar.Value;
            if (_local_2 > 0)
            {
                ClientApplication.Instance.LocalGameClient.SendRoulette(_local_2);
                GoogleAnalyticsClient.Instance.trackIngame(("roulette/" + _local_2.toString()));
                ClientApplication.Instance.LocalGameClient.SendUpdatePayments();
            };
        }

        private function OnChangeValue(_arg_1:int):void
        {
            this._result.setText((int((_arg_1 * 0.5)) + ""));
        }


    }
}//package hbm.Game.GUI.CashShop.Stash

