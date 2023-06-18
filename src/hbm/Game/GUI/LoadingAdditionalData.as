package hbm.Game.GUI
{
    import hbm.Game.GUI.Tools.CustomWindow2;
    import hbm.Engine.Resource.LocalizationPreloaderResourceLibrary;
    import hbm.Engine.Resource.ResourceLibrary;
    import org.aswing.JPanel;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import org.aswing.SoftBoxLayout;
    import org.aswing.AssetBackground;
    import hbm.Game.Utility.HtmlText;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import flash.events.Event;

    public class LoadingAdditionalData extends CustomWindow2 
    {

        public static const ON_RESOURCES_LOADED:String = "ON_RESOURCES_LOADED";

        private const _width:int = 280;
        private const _height:int = 40;

        private var _info:PaddedValue;

        public function LoadingAdditionalData()
        {
            var _local_2:LocalizationPreloaderResourceLibrary;
            var _local_7:ResourceLibrary;
            super(null, true, this._width, this._height, false);
            var _local_1:JPanel = new JPanel();
            _local_1.setBorder(new EmptyBorder(null, new Insets(5, 10, 0, 0)));
            _local_2 = LocalizationPreloaderResourceLibrary(ResourceManager.Instance.Library("LocalizationPreloader"));
            var _local_3:Bitmap = _local_2.GetBitmapAsset("Localization_Item_LoadingAddHeader");
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_4.setBorder(new EmptyBorder(null, new Insets(0, 65, 0, 0)));
            if (_local_3)
            {
                _local_4.setBackgroundDecorator(new AssetBackground(_local_3));
                _local_4.setPreferredHeight(_local_3.height);
                _local_4.setPreferredWidth((_local_3.width + 65));
                _local_4.setMaximumHeight(_local_3.height);
                _local_4.setMaximumWidth((_local_3.width + 65));
                _local_4.pack();
                _local_1.append(_local_4);
            };
            var _local_5:String = HtmlText.GetText(ClientApplication.Localization.LOADING_ADDITIONAL_WINDOW_INFO_PART1, 0, 5);
            this._info = new PaddedValue((ClientApplication.Localization.LOADING_ADDITIONAL_WINDOW_INFO + " "), _local_5, 220, 40, -1, 0xFFD700);
            _local_1.append(this._info);
            var _local_6:CustomToolTip = new CustomToolTip(this._info, ClientApplication.Instance.GetPopupText(117), 250, 20);
            MainPanel.append(_local_1);
            pack();
            for each (_local_7 in ResourceManager.Instance.Libraries)
            {
                _local_7.addEventListener(ResourceLibrary.ON_LOADED, this.UpdateStatus, false, 0, true);
            };
            this.Center();
        }

        private function UpdateStatus(_arg_1:Event):void
        {
            var _local_4:ResourceLibrary;
            var _local_2:int = ResourceManager.Instance.GetLibrariesCount();
            var _local_3:int = ResourceManager.Instance.GetLibrariesLoadedCount();
            this._info.Value = HtmlText.GetText(ClientApplication.Localization.LOADING_ADDITIONAL_WINDOW_INFO_PART1, _local_3, _local_2);
            if (_local_3 == _local_2)
            {
                dispose();
                for each (_local_4 in ResourceManager.Instance.Libraries)
                {
                    _local_4.removeEventListener(ResourceLibrary.ON_LOADED, this.UpdateStatus);
                };
                dispatchEvent(new Event(ON_RESOURCES_LOADED));
            };
        }

        public function Center():void
        {
            setLocationXY(((ClientApplication.stageWidth / 2) - (this._width / 2)), 300);
        }


    }
}