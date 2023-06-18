


//hbm.Game.GUI.Craft.ProduceListDialog

package hbm.Game.GUI.Craft
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JPanel;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.FlowLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.BorderLayout;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.GridLayout;
    import org.aswing.JScrollPane;
    import org.aswing.Container;
    import org.aswing.event.AWEvent;
    import flash.events.Event;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;

    public class ProduceListDialog extends CustomWindow 
    {

        private const _width:int = 495;
        private const _height:int = 230;

        private var _itemsPanel:JPanel;
        private var _percent:int;

        public function ProduceListDialog(_arg_1:Array=null, _arg_2:Array=null, _arg_3:int=100)
        {
            var _local_8:Object;
            super(null, ClientApplication.Localization.CRAFT_WINDOW_TITLE, true, this._width, this._height, true);
            var _local_4:CustomButton = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            _local_4.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            _local_4.addActionListener(this.OnClosePressed, 0, true);
            var _local_5:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 6, 4, false));
            _local_5.setBorder(new EmptyBorder(null, new Insets(6, 0, 0, 0)));
            _local_5.append(_local_4);
            var _local_6:CharacterInfo = CharacterStorage.Instance.LocalPlayerCharacter.LocalCharacterInfo;
            if ((((_arg_3 == 24112) || (_arg_3 == 24113)) || (_arg_3 == 24120)))
            {
                this._percent = ((((5000 + (_local_6.jobLevel * 20)) + ((_local_6.dex + _local_6.dexBonus) * 10)) + ((_local_6.luk + _local_6.lukBonus) * 10)) / 100);
                _local_8 = _local_6.Skills[107];
                if (_local_8)
                {
                    this._percent = (this._percent + _local_8.Lv);
                };
            }
            else
            {
                if (_arg_3 == 24114)
                {
                    this._percent = (((2000 + ((_local_6.dex + _local_6.dexBonus) * 40)) + ((_local_6.luk + _local_6.lukBonus) * 20)) / 100);
                }
                else
                {
                    this._percent = 100;
                };
            };
            if (this._percent > 100)
            {
                this._percent = 100;
            };
            var _local_7:JPanel = new JPanel(new BorderLayout());
            _local_7.setBorder(new EmptyBorder(null, new Insets(6, 4, 4, 4)));
            _local_7.append(this.CreateProduceListPanel(), BorderLayout.CENTER);
            _local_7.append(_local_5, BorderLayout.PAGE_END);
            MainPanel.append(_local_7, BorderLayout.CENTER);
            addEventListener(CustomWindow.CUSTOM_WINDOW_CLOSED, this.OnClose, false, 0, true);
            pack();
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
            if (_arg_1 != null)
            {
                this.Revalidate(_arg_1, _arg_2);
            };
        }

        private function CreateProduceListPanel():Container
        {
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            this._itemsPanel = new JPanel(new GridLayout(0, 1, 4, 4));
            var _local_2:JScrollPane = new JScrollPane(this._itemsPanel, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
            _local_2.setPreferredHeight(220);
            _local_2.setPreferredWidth(515);
            _local_2.setBorder(_local_1);
            return (_local_2);
        }

        private function OnClosePressed(_arg_1:AWEvent):void
        {
            dispose();
            ClientApplication.Instance.LocalGameClient.SendProduceMix();
        }

        private function OnClose(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendProduceMix();
        }

        private function Revalidate(_arg_1:Array, _arg_2:Array):void
        {
            var _local_4:int;
            var _local_5:Object;
            var _local_6:int;
            var _local_7:Object;
            this._itemsPanel.removeAll();
            var _local_3:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            for each (_local_4 in _arg_1)
            {
                _local_5 = _local_3.GetCraftedItemsForScheme(_local_4);
                for each (_local_6 in _local_5)
                {
                    _local_7 = _local_3.GetItemsCraftData(_local_6);
                    if (((_local_7) && (_local_7.RequiredItemList)))
                    {
                        this._itemsPanel.append(new ProduceItemPanel(_local_6, _local_7.RequiredItemList, this._percent, this));
                    };
                };
            };
        }


    }
}//package hbm.Game.GUI.Craft

