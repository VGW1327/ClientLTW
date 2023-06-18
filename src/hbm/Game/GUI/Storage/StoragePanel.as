


//hbm.Game.GUI.Storage.StoragePanel

package hbm.Game.GUI.Storage
{
    import hbm.Game.GUI.Inventory.InventoryPanel;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.JScrollPane;
    import hbm.Game.GUI.PaddedValue;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.JPanel;
    import org.aswing.FlowLayout;
    import hbm.Engine.Actors.StorageData;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import flash.utils.Dictionary;

    public class StoragePanel extends InventoryPanel 
    {

        public var _isGuild:Boolean = false;

        public function StoragePanel()
        {
            this.RevalidateItems();
            this.RevalidateStatusBar();
        }

        override protected function InitUI():void
        {
            this.CreatePanels();
            setLayout(new BorderLayout());
            setBorder(new EmptyBorder(null, new Insets(4, 4, 4, 0)));
            var _local_1:JScrollPane = new JScrollPane(_etcPanel);
            _local_1.setBorder(new EmptyBorder(null, new Insets(4, 0, 0, 0)));
            append(_local_1, BorderLayout.CENTER);
            append(this.CreateStatusBar(), BorderLayout.PAGE_END);
            pack();
        }

        override protected function CreateStatusBar():JPanel
        {
            _statusBar2 = new PaddedValue(ClientApplication.Localization.STORAGE_STATUS_BAR, "0", (196 - 56), (160 + 56));
            var _local_1:CustomToolTip = new CustomToolTip(_statusBar2, ClientApplication.Instance.GetPopupText(106), 150, 20);
            var _local_2:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0, false));
            var _local_3:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            _local_2.setBorder(_local_3);
            _local_2.append(_statusBar2);
            return (_local_2);
        }

        override protected function CreatePanels():void
        {
            _etcPanel = new StorageTabPanel();
        }

        override public function RevalidateItems(_arg_1:Boolean=false, _arg_2:ItemData=null):void
        {
            var _local_3:StorageData = ClientApplication.Instance.LocalGameClient.Storage;
            this.Revalidate(_local_3.Storage);
        }

        override public function Revalidate(_arg_1:Dictionary):void
        {
            var _local_2:ItemData;
            var _local_3:InventoryItem;
            _etcPanel.Clear();
            for each (_local_2 in _arg_1)
            {
                _local_3 = new InventoryItem(_local_2);
                _etcPanel.AddInventoryItem(_local_3);
            };
        }

        public function RevalidateStatusBar():void
        {
            var _local_1:StorageData;
            _local_1 = ClientApplication.Instance.LocalGameClient.Storage;
            var _local_2:int = _local_1.MaxAmount;
            _statusBar2.Value = ((((_local_1.Amount.toString() + " ") + ClientApplication.Localization.STORAGE_STATUS_BAR_PART1) + " ") + _local_2);
            this._isGuild = (_local_2 == 1000);
        }


    }
}//package hbm.Game.GUI.Storage

