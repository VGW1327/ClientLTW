


//hbm.Game.GUI.Tutorial.WelcomeWindow

package hbm.Game.GUI.Tutorial
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Resource.ResourceLibrary;
    import flash.display.Bitmap;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.SoftBoxLayout;
    import org.aswing.EmptyLayout;
    import hbm.Engine.Resource.TutorialDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import org.aswing.AssetBackground;
    import org.aswing.geom.IntDimension;
    import org.aswing.geom.IntPoint;
    import org.aswing.FlowLayout;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Actors.ItemData;
    import flash.events.Event;

    public class WelcomeWindow extends CustomWindow 
    {

        private const _width:int = 566;
        private const _height:int = 410;

        private var _race:String;

        public function WelcomeWindow(_arg_1:String=null)
        {
            super(null, "", true, this._width, this._height, (!(_arg_1 == null)));
            this._race = _arg_1;
            this.InitUI();
            pack();
            setLocationXY(((ClientApplication.stageWidth / 2) - (this._width / 2)), 80);
        }

        private function InitUI():void
        {
            var _local_5:ResourceLibrary;
            var _local_6:String;
            var _local_7:Bitmap;
            var _local_8:Array;
            var _local_9:Array;
            var _local_10:int;
            var _local_11:InventoryStoreItem;
            var _local_12:CustomButton;
            var _local_13:CustomToolTip;
            var _local_14:JPanel;
            var _local_15:CustomButton;
            var _local_16:CustomToolTip;
            var _local_17:JPanel;
            var _local_18:JPanel;
            var _local_1:JPanel = new JPanel(new BorderLayout());
            var _local_2:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            _local_1.setBorder(new EmptyBorder(null, new Insets(6, 6, 4, 4)));
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.TOP));
            SetTitle(ClientApplication.Localization.TUTORIAL_WINDOW_WELCOME);
            var _local_4:JPanel = new JPanel(new EmptyLayout());
            _local_4.setBorder(_local_2);
            if (this._race == null)
            {
                _local_5 = TutorialDataResourceLibrary(ResourceManager.Instance.Library("TutorialData"));
            }
            else
            {
                _local_5 = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            };
            if (_local_5)
            {
                _local_6 = ((this._race) ? ("Localization_Item_WelcomeScreen" + this._race) : "TutorialData_Item_WelcomeScreen");
                _local_7 = _local_5.GetBitmapAsset(_local_6);
                if (_local_7)
                {
                    _local_4.setBackgroundDecorator(new AssetBackground(_local_7));
                    _local_4.setPreferredHeight(_local_7.height);
                    _local_4.setPreferredWidth(_local_7.width);
                };
            };
            if (this._race == null)
            {
                _local_8 = [2, 31013, 23906, 31006, 5, 4, 31007, 23907, 31010, 3];
                _local_9 = [1, 1, 3, 1, 50, 500, 1, 1, 1, 4000];
                _local_10 = 0;
                while (_local_10 < _local_8.length)
                {
                    _local_11 = this.CreateItem(_local_8[_local_10], _local_9[_local_10]);
                    if (_local_11)
                    {
                        _local_11.setSize(new IntDimension(64, 64));
                        _local_11.setLocation(new IntPoint((73 + (_local_10 * 40)), 300));
                        _local_11.setBackgroundDecorator(null);
                        _local_11.setBorder(null);
                        _local_4.append(_local_11);
                    };
                    _local_10++;
                };
            };
            _local_3.append(_local_4);
            _local_1.append(_local_3, BorderLayout.CENTER);
            if (this._race == null)
            {
                _local_12 = new CustomButton(ClientApplication.Localization.TUTORIAL_WINDOW_CANCEL_BUTTON);
                _local_13 = new CustomToolTip(_local_12, ClientApplication.Instance.GetPopupText(148), 230, 55);
                _local_12.addActionListener(this.OnCancel, 0, true);
                _local_14 = new JPanel(new FlowLayout(FlowLayout.RIGHT));
                _local_14.append(_local_12);
                _local_15 = new CustomButton(ClientApplication.Localization.TUTORIAL_WINDOW_START_BUTTON);
                _local_16 = new CustomToolTip(_local_15, ClientApplication.Instance.GetPopupText(155), 250, 80);
                _local_15.addActionListener(this.OnStart, 0, true);
                _local_17 = new JPanel(new FlowLayout(FlowLayout.LEFT, 4));
                _local_17.append(_local_15);
                _local_18 = new JPanel(new BorderLayout());
                _local_18.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
                _local_18.append(_local_14, BorderLayout.WEST);
                _local_18.append(_local_17, BorderLayout.EAST);
                setDefaultButton(_local_15);
                _local_1.append(_local_18, BorderLayout.PAGE_END);
            }
            else
            {
                setHeight(463);
                setMaximumHeight(463);
                setPreferredHeight(463);
            };
            MainPanel.append(_local_1, BorderLayout.CENTER);
            addEventListener(CustomWindow.CUSTOM_WINDOW_CLOSED, this.OnCloseButtonPressed, false, 0, true);
        }

        private function CreateItem(_arg_1:int, _arg_2:int):InventoryStoreItem
        {
            var _local_3:ItemsResourceLibrary;
            if (_arg_1 == 0)
            {
                return (null);
            };
            _local_3 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            var _local_4:ItemData = new ItemData();
            var _local_5:Object = _local_3.GetServerDescriptionObject(_arg_1);
            if (!_local_5)
            {
                return (null);
            };
            _local_4.Amount = _arg_2;
            _local_4.NameId = _arg_1;
            _local_4.Identified = 1;
            _local_4.Origin = ItemData.QUEST;
            _local_4.Type = _local_5["type"];
            return (new InventoryStoreItem(_local_4, false));
        }

        private function OnCancel(_arg_1:Event):void
        {
            dispose();
        }

        private function OnCloseButtonPressed(_arg_1:Event):void
        {
            this.CloseWindow();
        }

        private function OnStart(_arg_1:Event):void
        {
            this.CloseWindow();
            dispose();
        }

        private function CloseWindow():void
        {
        }


    }
}//package hbm.Game.GUI.Tutorial

