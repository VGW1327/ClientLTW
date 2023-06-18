


//hbm.Game.GUI.CharacterInventory.CharacterInventoryWindow

package hbm.Game.GUI.CharacterInventory
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JPanel;
    import hbm.Game.GUI.CharacterStats.CharacterStatsPanel;
    import hbm.Game.GUI.Inventory.InventoryPanel;
    import hbm.Application.ClientApplication;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.EmptyLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.BorderLayout;
    import hbm.Game.GUI.CharacterStats.CharacterStatsButton;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Actors.CartData;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import flash.utils.Dictionary;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import flash.display.DisplayObject;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import flash.display.Bitmap;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.AssetBackground;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import hbm.Game.GUI.CharacterStats.*;

    public class CharacterInventoryWindow extends CustomWindow 
    {

        private const _width:int = 460;
        private const _height:int = 535;

        private var _contentPane:JPanel;
        private var _characterStatsPanel:CharacterStatsPanel;
        private var _inventoryPanel:InventoryPanel;
        private var _expBar:BaseExpBar;
        private var _inited:Boolean = false;

        public function CharacterInventoryWindow(_arg_1:*=null)
        {
            super(_arg_1, ClientApplication.Localization.WINDOW_CHARACTER_STATS, false, this._width, this._height, true);
            this.Init();
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
        }

        private function Init():void
        {
            this._characterStatsPanel = new CharacterStatsPanel();
            AsWingUtil.SetSize(this._characterStatsPanel, 435, 360);
            this._characterStatsPanel.setLocationXY(19, 12);
            this._inventoryPanel = new InventoryPanel();
            AsWingUtil.SetSize(this._inventoryPanel, 425, 230);
            this._inventoryPanel.setLocationXY(25, 370);
            this._expBar = new BaseExpBar();
            this._expBar.x = ((this._width / 2) + 5);
            this._expBar.y = 15;
            this._contentPane = new JPanel(new EmptyLayout());
            this._contentPane.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            this._contentPane.append(this._characterStatsPanel);
            this._contentPane.append(this._inventoryPanel);
            this._contentPane.addChild(this._expBar);
            MainPanel.append(this._contentPane, BorderLayout.CENTER);
            pack();
        }

        public function GetButtonAddStat(_arg_1:uint):CharacterStatsButton
        {
            return (this._characterStatsPanel.GetButtonAddStat(_arg_1));
        }

        public function RevalidateCharacterIcon():void
        {
            this._characterStatsPanel.RevalidateCharacterIcon();
        }

        public function RevalidateEquipment():void
        {
            this._characterStatsPanel.RevalidateEquipment();
        }

        public function RevalidateStats(_arg_1:CharacterInfo):void
        {
            this._characterStatsPanel.RevalidateStats(_arg_1);
            this._expBar._text.text = _arg_1.baseLevel.toString();
            this._expBar._progress.scaleX = ClientApplication.Instance.BottomHUD.GetBottomHUD._baseLevelBar._progressMask.scaleX;
        }

        public function OpenVenderShop():void
        {
            var _local_1:CartData = ClientApplication.Instance.LocalGameClient.Cart;
            if (_local_1 == null)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.INVENTORY_CART_DIALOG_TITLE1, ClientApplication.Localization.INVENTORY_CART_DIALOG_MESSAGE1, null, null, true, new AttachIcon("StopIcon")));
            }
            else
            {
                if (ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerIsTrader())
                {
                    ClientApplication.Instance.ShowCart();
                }
                else
                {
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.INVENTORY_CART_DIALOG_TITLE1, ClientApplication.Localization.INVENTORY_CART_DIALOG_MESSAGE3, null, null, true, new AttachIcon("StopIcon")));
                };
            };
        }

        public function Revalidate(_arg_1:Dictionary):void
        {
            this._inventoryPanel.Revalidate(_arg_1);
        }

        public function GetInventoryItem(_arg_1:uint):InventoryItem
        {
            return (this._inventoryPanel.GetInventoryItem(_arg_1));
        }

        public function GetIconTab(_arg_1:uint):DisplayObject
        {
            return (this._inventoryPanel.GetIconTab(_arg_1));
        }

        public function RevalidateAmount(_arg_1:Dictionary, _arg_2:ItemData):void
        {
            this._inventoryPanel.RevalidateAmount(_arg_1, _arg_2);
        }

        public function RevalidateItems(_arg_1:Boolean=false, _arg_2:ItemData=null):void
        {
            this._inventoryPanel.RevalidateItems(_arg_1, _arg_2);
        }

        public function GetStatsPanel():CharacterStatsPanel
        {
            return (this._characterStatsPanel);
        }

        override public function show():void
        {
            var _local_1:AdditionalDataResourceLibrary;
            var _local_2:Bitmap;
            if (!this._inited)
            {
                _local_1 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
                _local_2 = _local_1.GetBitmapAsset("AdditionalData_Item_CharacterInventoryBack");
                this._contentPane.setBackgroundDecorator(new AssetBackground(_local_2));
                AsWingUtil.SetSize(this._contentPane, _local_2.width, _local_2.height);
                this._characterStatsPanel.UpdateGraphics();
                this._inventoryPanel.UpdateGraphics();
                this._inited = true;
            };
            ClientApplication.Instance.BottomHUD.BlinkCharacterStats(false);
            super.show();
            HelpManager.Instance.UpdateStatsHelper();
            HelpManager.Instance.UpdateInventoryHelper();
            HelpManager.Instance.CharacterInventoryPressed();
        }

        override public function dispose():void
        {
            super.dispose();
            HelpManager.Instance.UpdateStatsHelper();
            HelpManager.Instance.UpdateInventoryHelper();
        }


    }
}//package hbm.Game.GUI.CharacterInventory

