


//hbm.Game.GUI.Storage.StorageWindow

package hbm.Game.GUI.Storage
{
    import hbm.Game.GUI.Inventory.InventoryWindow;
    import hbm.Application.ClientApplication;
    import org.aswing.BorderLayout;
    import hbm.Engine.Actors.ItemData;

    public class StorageWindow extends InventoryWindow 
    {

        private const _width:int = 357;
        private const _height:int = 352;

        private var _storagePanel:StoragePanel;

        public function StorageWindow()
        {
            super(null, ClientApplication.Localization.STORAGE_TITLE, false, this._width, this._height, true);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
        }

        override protected function InitUI():void
        {
            this._storagePanel = new StoragePanel();
            MainPanel.append(this._storagePanel, BorderLayout.CENTER);
            pack();
        }

        override public function RevalidateItems(_arg_1:Boolean=false, _arg_2:ItemData=null):void
        {
            this._storagePanel.RevalidateItems(_arg_1, _arg_2);
        }

        public function RevalidateStatusBar():void
        {
            this._storagePanel.RevalidateStatusBar();
            SetTitle(((this._storagePanel._isGuild) ? ClientApplication.Localization.STORAGE_GUILD_TITLE : ClientApplication.Localization.STORAGE_TITLE));
        }

        override public function show():void
        {
            super.show();
        }

        override public function dispose():void
        {
            ClientApplication.Instance.LocalGameClient.SendStorageClose();
            super.dispose();
        }


    }
}//package hbm.Game.GUI.Storage

