


//hbm.Game.GUI.Inventory.InventoryPanel

package hbm.Game.GUI.Inventory
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomTabbedPane;
    import hbm.Game.GUI.PaddedValue;
    import flash.utils.Dictionary;
    import org.aswing.JScrollPane;
    import org.aswing.JTabbedPane;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Application.ClientApplication;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.FlowLayout;
    import hbm.Engine.Actors.ItemData;
    import flash.display.DisplayObject;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import org.aswing.event.InteractiveEvent;
    import hbm.Engine.Actors.CharacterInfo;
    import com.adobe.utils.DictionaryUtil;
    import org.aswing.AssetIcon;
    import hbm.Game.Utility.AsWingUtil;
    import hbm.Game.GUI.*;

    public class InventoryPanel extends JPanel 
    {

        protected var _tabbedPane:CustomTabbedPane = new CustomTabbedPane();
        protected var _itemsPanel:InventoryGridPanel;
        protected var _equipPanel:InventoryGridPanel;
        protected var _etcPanel:InventoryGridPanel;
        protected var _statusBar1:PaddedValue;
        protected var _statusBar2:PaddedValue;
        private var _inventoryItems:Dictionary;

        public function InventoryPanel()
        {
            this.InitUI();
        }

        protected function CreatePanels():void
        {
            this._itemsPanel = new InventoryGridPanel();
            this._equipPanel = new InventoryGridPanel();
            this._etcPanel = new InventoryGridPanel();
            this._tabbedPane.setMaximumHeight(148);
            this._tabbedPane.setMinimumHeight(148);
            this._tabbedPane.setPreferredHeight(148);
        }

        protected function InitUI():void
        {
            var _local_1:JScrollPane;
            var _local_2:JScrollPane;
            var _local_3:JScrollPane;
            this._tabbedPane.setTabPlacement(JTabbedPane.LEFT);
            this._tabbedPane.addStateListener(this.OnTabPaneChanged);
            this._tabbedPane.setFocusable(false);
            this.CreatePanels();
            if (this._itemsPanel != null)
            {
                _local_1 = new JScrollPane(this._itemsPanel);
                _local_1.setBorder(new EmptyBorder(null, new Insets(8, 0, 0, 4)));
                this._tabbedPane.AppendCustomTab(_local_1, null, null, ClientApplication.Localization.INVENTORY_PAGE_ITEMS);
            };
            if (this._equipPanel != null)
            {
                _local_2 = new JScrollPane(this._equipPanel);
                _local_2.setBorder(new EmptyBorder(null, new Insets(8, 0, 0, 4)));
                this._tabbedPane.AppendCustomTab(_local_2, null, null, ClientApplication.Localization.INVENTORY_PAGE_EQUIP);
            };
            if (this._etcPanel != null)
            {
                _local_3 = new JScrollPane(this._etcPanel);
                _local_3.setBorder(new EmptyBorder(null, new Insets(8, 0, 0, 4)));
                this._tabbedPane.AppendCustomTab(_local_3, null, null, ClientApplication.Localization.INVENTORY_PAGE_ETC);
            };
            setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            setBorder(new EmptyBorder(null, new Insets(3, 0, 4, 0)));
            append(this._tabbedPane);
            append(this.CreateStatusBar());
            if (this._tabbedPane.getTabCount() > 1)
            {
                this._tabbedPane.setSelectedIndex(1);
            };
            pack();
        }

        protected function CreateStatusBar():JPanel
        {
            this._statusBar1 = new PaddedValue(ClientApplication.Localization.INVENTORY_STATUS_BAR1, "0", 105, 65);
            this._statusBar2 = new PaddedValue(ClientApplication.Localization.INVENTORY_STATUS_BAR2, "0", 70, 100);
            var _local_1:CustomToolTip = new CustomToolTip(this._statusBar1, ClientApplication.Instance.GetPopupText(212), 250, 40);
            var _local_2:CustomToolTip = new CustomToolTip(this._statusBar2, ClientApplication.Instance.GetPopupText(58), 250, 40);
            var _local_3:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 4, 0, false));
            var _local_4:EmptyBorder = new EmptyBorder(null, new Insets(17, 10, 0, 0));
            _local_3.setBorder(_local_4);
            var _local_5:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 40));
            _local_5.append(this._statusBar1);
            _local_5.append(this._statusBar2);
            _local_3.append(_local_5);
            return (_local_3);
        }

        public function Revalidate(_arg_1:Dictionary):void
        {
            var _local_2:ItemData;
            var _local_3:InventoryItem;
            this._equipPanel.Clear();
            this._itemsPanel.Clear();
            this._etcPanel.Clear();
            this._inventoryItems = new Dictionary(true);
            for each (_local_2 in _arg_1)
            {
                if (_local_2.Equip == 0)
                {
                    _local_3 = new InventoryItem(_local_2);
                    this._inventoryItems[_local_2.Id] = _local_3;
                    switch (_local_2.Type)
                    {
                        case 3:
                            this._etcPanel.AddInventoryItem(_local_3);
                            break;
                        case 4:
                        case 5:
                        case 10:
                        case 12:
                            this._equipPanel.AddInventoryItem(_local_3);
                            break;
                        default:
                            this._itemsPanel.AddInventoryItem(_local_3);
                    };
                };
            };
            InventoryItem.DisposeTooltip();
        }

        public function GetInventoryItem(_arg_1:uint):InventoryItem
        {
            var _local_2:InventoryItem;
            for each (_local_2 in this._inventoryItems)
            {
                if (_local_2.Item.NameId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function GetIconTab(_arg_1:uint):DisplayObject
        {
            var _local_3:int;
            var _local_2:int = this._tabbedPane.getSelectedIndex();
            switch (_arg_1)
            {
                case 3:
                    _local_3 = 2;
                    break;
                case 4:
                case 5:
                case 10:
                case 12:
                    _local_3 = 1;
                    break;
                default:
                    _local_3 = 0;
            };
            if (_local_3 == _local_2)
            {
                return (null);
            };
            return (this._tabbedPane.getIconAt(_local_3).getDisplay(this._tabbedPane));
        }

        protected function OnTabPaneChanged(_arg_1:InteractiveEvent):void
        {
            HelpManager.Instance.SelectInventoryTab();
            HelpManager.Instance.UpdateInventoryHelper();
        }

        public function RevalidateAmount(_arg_1:Dictionary, _arg_2:ItemData):void
        {
            var _local_3:InventoryItem;
            if ((_arg_2.Id in _arg_1))
            {
                _local_3 = this._inventoryItems[_arg_2.Id];
                if (_local_3)
                {
                    _local_3.Revalidate();
                };
            };
        }

        public function RevalidateItems(_arg_1:Boolean=false, _arg_2:ItemData=null):void
        {
            var _local_7:Boolean;
            var _local_3:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (!_arg_1)
            {
                _local_7 = ((!(_arg_2 == null)) && (_arg_2.Amount > 0));
                if (!_local_7)
                {
                    this.Revalidate(_local_3.Items);
                }
                else
                {
                    this.RevalidateAmount(_local_3.Items, _arg_2);
                };
            };
            var _local_4:Number = (_local_3.weight / 1000);
            var _local_5:Number = (_local_3.weightMax / 1000);
            var _local_6:int = DictionaryUtil.getKeys(_local_3.Items).length;
            this._statusBar1.Value = ((((_local_6 + " ") + ClientApplication.Localization.INVENTORY_ITEM_STR1) + " ") + 100);
            this._statusBar2.Value = ((((_local_4 + " ") + ClientApplication.Localization.INVENTORY_ITEM_STR1) + " ") + _local_5);
        }

        public function UpdateGraphics():void
        {
            this._tabbedPane.SetActiveIconTo(new AssetIcon(AsWingUtil.GetAsset("CharacterInventoryTab_bottle_on")), 0);
            this._tabbedPane.SetInactiveIconTo(new AssetIcon(AsWingUtil.GetAsset("CharacterInventoryTab_bottle_off")), 0);
            this._tabbedPane.SetActiveIconTo(new AssetIcon(AsWingUtil.GetAsset("CharacterInventoryTab_armor_on")), 1);
            this._tabbedPane.SetInactiveIconTo(new AssetIcon(AsWingUtil.GetAsset("CharacterInventoryTab_armor_off")), 1);
            this._tabbedPane.SetActiveIconTo(new AssetIcon(AsWingUtil.GetAsset("CharacterInventoryTab_chest_on")), 2);
            this._tabbedPane.SetInactiveIconTo(new AssetIcon(AsWingUtil.GetAsset("CharacterInventoryTab_chest_off")), 2);
            this._tabbedPane.UpdateSelection();
        }


    }
}//package hbm.Game.GUI.Inventory

