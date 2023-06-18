


//hbm.Game.GUI.Store.StoreWindow

package hbm.Game.GUI.Store
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.BannerPanel;
    import hbm.Application.ClientApplication;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.JLabel;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.FlowLayout;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Engine.Actors.ItemData;
    import flash.utils.Dictionary;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Actors.ItemList;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import org.aswing.event.AWEvent;
    import hbm.Game.GUI.*;

    public class StoreWindow extends CustomWindow 
    {

        private const _width:int = 650;
        private const _height:int = 520;

        private var _closeButton:CustomButton;
        private var _sellSelectedButton:CustomButton;
        private var _advtPanel:BannerPanel;
        private var _buyPanel:StorePanel;
        private var _sellPanel:StorePanel;

        public function StoreWindow(_arg_1:*=null)
        {
            super(_arg_1, ClientApplication.Localization.STORE_TITLE, false, this._width, this._height, true);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_2:JLabel = new JLabel(ClientApplication.Localization.STORE_INFO_MESSAGE);
            var _local_3:JPanel = new JPanel();
            _local_3.append(_local_2);
            this._advtPanel = new BannerPanel();
            this._buyPanel = new StorePanel(StorePanel.BUY_PANEL);
            this._buyPanel.putClientProperty(StoreDnd.DND_TYPE, StoreDnd.BUY_PANEL);
            this._buyPanel.setBorder(_local_1);
            this._sellPanel = new StorePanel(StorePanel.SELL_PANEL);
            this._sellPanel.putClientProperty(StoreDnd.DND_TYPE, StoreDnd.SELL_PANEL);
            this._sellPanel.setBorder(_local_1);
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_4.append(this._advtPanel);
            _local_4.append(this._buyPanel);
            _local_4.append(_local_3);
            _local_4.append(this._sellPanel);
            this._sellSelectedButton = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_SELL_SELECTED);
            this._sellSelectedButton.addActionListener(this.OnSellSelectedButtonPressed, 0, true);
            this._closeButton = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            this._closeButton.addActionListener(this.OnCloseButtonPressed, 0, true);
            var _local_5:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 4));
            _local_5.append(this._sellSelectedButton);
            var _local_6:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            _local_6.append(this._closeButton);
            var _local_7:JPanel = new JPanel(new BorderLayout());
            _local_7.setBorder(new EmptyBorder(null, new Insets(4, 0, 0, 0)));
            _local_7.append(_local_5, BorderLayout.WEST);
            _local_7.append(_local_6, BorderLayout.EAST);
            var _local_8:JPanel = new JPanel(new BorderLayout());
            _local_8.setBorder(new EmptyBorder(null, new Insets(2, 4, 0, 4)));
            _local_8.append(_local_4, BorderLayout.CENTER);
            _local_8.append(_local_7, BorderLayout.PAGE_END);
            MainPanel.append(_local_8, BorderLayout.CENTER);
            pack();
        }

        public function LoadBuyItems(_arg_1:Array):void
        {
            this._buyPanel.LoadItems(_arg_1);
            this._advtPanel.LoadItems(_arg_1);
        }

        public function GetItemGrid(_arg_1:int):StoreItemPanel
        {
            return (this._buyPanel.GetItemGrid(_arg_1));
        }

        public function LoadSellItems(_arg_1:CharacterInfo):void
        {
            var _local_4:ItemData;
            var _local_2:Array = new Array();
            var _local_3:Dictionary = _arg_1.Items;
            for each (_local_4 in _local_3)
            {
                if (_local_4.Equip == 0)
                {
                    _local_2.push(_local_4);
                };
            };
            this._sellPanel.LoadItems(_local_2);
            this._sellSelectedButton.setEnabled(true);
        }

        private function OnSellSelectedButtonPressed(_arg_1:AWEvent):void
        {
            var _local_3:AdditionalDataResourceLibrary;
            var _local_4:ItemList;
            var _local_5:Object;
            var _local_2:Array = this._sellPanel.GetSelectedItems();
            if (((!(_local_2 == null)) && (_local_2.length > 0)))
            {
                _local_3 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
                for each (_local_4 in _local_2)
                {
                    _local_5 = _local_3.GetCanSellData(_local_4.NameId);
                    if (((!(_local_5 == null)) && (int(_local_5) > 0)))
                    {
                        new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.ERR_SELL_ITEMS, null, null, true, new AttachIcon("AchtungIcon")));
                        return;
                    };
                };
                ClientApplication.Instance.LocalGameClient.SendSellItemList(_local_2);
                this._sellSelectedButton.setEnabled(false);
            };
        }

        private function OnCloseButtonPressed(_arg_1:AWEvent):void
        {
            this.dispose();
        }

        override public function dispose():void
        {
            var _local_2:ItemData;
            super.dispose();
            var _local_1:Dictionary = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Items;
            for each (_local_2 in _local_1)
            {
                _local_2.Price = 0;
            };
            this._advtPanel.Dispose();
        }


    }
}//package hbm.Game.GUI.Store

