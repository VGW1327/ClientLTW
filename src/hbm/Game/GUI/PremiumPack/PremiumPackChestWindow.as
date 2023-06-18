


//hbm.Game.GUI.PremiumPack.PremiumPackChestWindow

package hbm.Game.GUI.PremiumPack
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Application.ClientApplication;
    import org.aswing.JPanel;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.EmptyLayout;
    import flash.display.Bitmap;
    import org.aswing.AssetBackground;
    import org.aswing.geom.IntDimension;
    import hbm.Engine.Actors.ItemData;
    import flash.events.Event;

    public class PremiumPackChestWindow extends WindowPrototype 
    {

        private static var _localizationLibrary:LocalizationResourceLibrary;

        private var _winTitle:String = ClientApplication.Localization.PREMIUM_PACK_CHEST_WINDOW_TITLE;
        private var _winWidth:uint = 527;
        private var _winHeight:uint = 457;
        private var _items:Array = null;
        private var _content:JPanel;

        public function PremiumPackChestWindow(_arg_1:Boolean=false)
        {
            super(null, this._winTitle, _arg_1, this._winWidth, this._winHeight, true, true);
            _localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            setLocationXY(((ClientApplication.stageWidth / 2) - (this._winWidth / 2)), 70);
            this.InitWinUI();
        }

        public function InitWinUI():void
        {
            this._content = new JPanel(new EmptyLayout());
            var _local_1:Bitmap = _localizationLibrary.GetBitmapAsset("Localization_Item_PremiumPackChest");
            this._content.setBackgroundDecorator(new AssetBackground(_local_1));
            this._content.setPreferredSize(new IntDimension(_local_1.width, _local_1.height));
            this._content.setMaximumSize(new IntDimension(_local_1.width, _local_1.height));
            Body.append(this._content);
            Bottom.removeAll();
        }

        public function LoadItems(_arg_1:Array):void
        {
            var _local_3:ItemData;
            var _local_4:PremiumPackItem;
            if (((_arg_1 == null) || (_arg_1.length < 1)))
            {
                return;
            };
            this._items = _arg_1;
            this._content.removeAll();
            var _local_2:int;
            for each (_local_3 in this._items)
            {
                _local_4 = new PremiumPackItem(_local_3, false, true);
                _local_4.setPreferredWidth(32);
                _local_4.setPreferredHeight(32);
                _local_4.setMaximumWidth(32);
                _local_4.setMaximumHeight(32);
                _local_4.setSizeWH(32, 32);
                _local_4.setLocationXY((207 + (_local_2 * 42)), 144);
                this._content.append(_local_4);
                _local_2++;
            };
        }

        override public function show():void
        {
            super.show();
            ClientApplication.Instance.SetShortcutsEnabled(false);
        }

        override protected function OnClosePressed(_arg_1:Event):void
        {
            ClientApplication.Instance.SetShortcutsEnabled(true);
            dispose();
        }


    }
}//package hbm.Game.GUI.PremiumPack

