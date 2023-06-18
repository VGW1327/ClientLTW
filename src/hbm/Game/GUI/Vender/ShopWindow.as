


//hbm.Game.GUI.Vender.ShopWindow

package hbm.Game.GUI.Vender
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Application.ClientApplication;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.JLabel;
    import org.aswing.JPanel;
    import hbm.Game.GUI.Store.StorePanel;
    import hbm.Game.GUI.Store.StoreDnd;
    import org.aswing.SoftBoxLayout;
    import org.aswing.FlowLayout;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Actors.ItemData;
    import flash.utils.Dictionary;
    import org.aswing.event.AWEvent;
    import flash.events.Event;
    import hbm.Game.GUI.Store.*;

    public class ShopWindow extends CustomWindow 
    {

        private const _width:int = 640;
        private const _height:int = 445;

        private var _button:CustomButton;
        private var _buyPanel:ShopPanel;
        private var _sellPanel:ShopPanel;

        public function ShopWindow()
        {
            super(null, "", false, this._width, this._height, true);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_2:JLabel = new JLabel(ClientApplication.Localization.SHOP_INFO_MESSAGE);
            var _local_3:JPanel = new JPanel();
            _local_3.append(_local_2);
            this._buyPanel = new ShopPanel(StorePanel.BUY_PANEL);
            this._buyPanel.putClientProperty(StoreDnd.DND_TYPE, StoreDnd.BUY_PANEL);
            this._buyPanel.setBorder(_local_1);
            this._sellPanel = new ShopPanel(StorePanel.SELL_PANEL);
            this._sellPanel.putClientProperty(StoreDnd.DND_TYPE, StoreDnd.SELL_PANEL);
            this._sellPanel.setBorder(_local_1);
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_4.append(this._buyPanel);
            _local_4.append(_local_3);
            _local_4.append(this._sellPanel);
            this._button = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            this._button.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            this._button.addActionListener(this.OnCloseButtonPressed, 0, true);
            var _local_5:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 4, 4));
            _local_5.append(this._button);
            var _local_6:JPanel = new JPanel(new BorderLayout());
            _local_6.setBorder(new EmptyBorder(null, new Insets(6, 4, 4, 4)));
            _local_6.append(_local_4, BorderLayout.CENTER);
            _local_6.append(_local_5, BorderLayout.PAGE_END);
            MainPanel.append(_local_6, BorderLayout.CENTER);
            addEventListener(CustomWindow.CUSTOM_WINDOW_CLOSED, this.OnClose, false, 0, true);
            pack();
        }

        public function LoadBuyItems(_arg_1:Array):void
        {
            var _local_2:int;
            _local_2 = ClientApplication.Instance.LocalGameClient.VenderId;
            var _local_3:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetActor(_local_2);
            SetTitle(_local_3.VenderName);
            this._buyPanel.LoadItems(_arg_1);
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
        }

        private function OnCloseButtonPressed(_arg_1:AWEvent):void
        {
            ClientApplication.Instance.CloseVenderShop();
        }

        private function OnClose(_arg_1:Event):void
        {
            ClientApplication.Instance.CloseVenderShop();
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
        }


    }
}//package hbm.Game.GUI.Vender

