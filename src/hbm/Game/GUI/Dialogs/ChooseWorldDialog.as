


//hbm.Game.GUI.Dialogs.ChooseWorldDialog

package hbm.Game.GUI.Dialogs
{
    import hbm.Game.GUI.Tools.CustomWindow2;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JList;
    import org.aswing.JTextArea;
    import org.aswing.VectorListModel;
    import hbm.Game.GUI.WorldDescription;
    import hbm.Engine.Resource.LocalizationPreloaderResourceLibrary;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.SolidBackground;
    import hbm.Game.GUI.Tools.WindowSprites;
    import flash.display.Bitmap;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.AssetBackground;
    import org.aswing.geom.IntDimension;
    import org.aswing.geom.IntPoint;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.JScrollPane;
    import org.aswing.AssetIcon;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.EmptyLayout;
    import org.aswing.BorderLayout;
    import flash.events.Event;
    import org.aswing.event.AWEvent;
    import hbm.Application.ClientConfig;
    import hbm.Game.GUI.*;

    public class ChooseWorldDialog extends CustomWindow2 
    {

        public static const WORLD_CHOOSED:String = "WORLD_CHOOSED";

        private const _width:int = 540;
        private const _height:int = 315;

        private var _button:CustomButton;
        private var _worldsList:JList;
        private var _descriptionText:JTextArea;
        private var _worlds:VectorListModel;
        private var _selectedWorld:WorldDescription;
        private var _dataLibrary:LocalizationPreloaderResourceLibrary;

        public function ChooseWorldDialog(_arg_1:*=null)
        {
            super(_arg_1, false, this._width, this._height, false);
            this.InitUI();
            setLocationXY(((ClientApplication.stageWidth / 2) - (this._width / 2)), 180);
        }

        private function InitUI():void
        {
            var _local_15:int;
            var _local_16:int;
            this._dataLibrary = LocalizationPreloaderResourceLibrary(ResourceManager.Instance.Library("LocalizationPreloader"));
            this._worlds = new VectorListModel();
            var _local_1:LineBorder = new LineBorder(null, new ASColor(6766364), 2, 4);
            this._worldsList = new JList(this._worlds);
            this._worldsList.setForeground(new ASColor(16438034));
            this._worldsList.addSelectionListener(this.OnItemChoosed);
            this._descriptionText = new JTextArea();
            this._descriptionText.setEditable(false);
            this._descriptionText.setWordWrap(true);
            this._descriptionText.setBorder(_local_1);
            this._descriptionText.setBackgroundDecorator(new SolidBackground(new ASColor(132881, 0.7)));
            this._descriptionText.getTextField().selectable = false;
            var _local_2:Bitmap = new WindowSprites.LoginScreenBack();
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            if (_local_2)
            {
                _local_3.setBackgroundDecorator(new AssetBackground(_local_2));
                _local_3.setPreferredHeight(_local_2.height);
                _local_3.setPreferredWidth(_local_2.width);
                _local_3.setMaximumHeight(_local_2.height);
                _local_3.setMaximumWidth(_local_2.width);
                _local_3.setSize(new IntDimension(_local_2.width, _local_2.height));
                _local_3.setLocation(new IntPoint(265, 70));
                _local_3.pack();
            };
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
            var _local_5:Bitmap = this._dataLibrary.GetBitmapAsset("Localization_Item_ChoseWorldHeader");
            var _local_6:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            if (_local_5)
            {
                _local_15 = 170;
                _local_16 = 4;
                _local_6.setBorder(new EmptyBorder(null, new Insets(_local_16, _local_15, 0, 0)));
                _local_6.setBackgroundDecorator(new AssetBackground(_local_5));
                _local_6.setPreferredHeight((_local_5.height + _local_16));
                _local_6.setPreferredWidth((_local_5.width + _local_15));
                _local_6.setMaximumHeight((_local_5.height + _local_16));
                _local_6.setMaximumWidth((_local_5.width + _local_15));
                _local_6.pack();
                _local_4.append(_local_6);
            };
            var _local_7:JScrollPane = new JScrollPane(this._worldsList);
            _local_7.setPreferredSize(new IntDimension(160, (this._height - 60)));
            _local_7.setBorder(_local_1);
            _local_7.setBackgroundDecorator(new SolidBackground(new ASColor(132881, 0.7)));
            var _local_8:JScrollPane = new JScrollPane(this._descriptionText);
            _local_8.setSize(new IntDimension(380, (this._height - 60)));
            _local_8.setLocation(new IntPoint(0, 0));
            var _local_9:Bitmap = this._dataLibrary.GetBitmapAsset("Localization_Item_LoginScreenPlayButton");
            var _local_10:Bitmap = this._dataLibrary.GetBitmapAsset("Localization_Item_LoginScreenPlayButtonSelected");
            var _local_11:Bitmap = this._dataLibrary.GetBitmapAsset("Localization_Item_LoginScreenPlayButtonPressed");
            this._button = new CustomButton(null);
            this._button.addActionListener(this.OnCloseButtonPressed, 0, true);
            this._button.setIcon(new AssetIcon(_local_9));
            this._button.setRollOverIcon(new AssetIcon(_local_10));
            this._button.setPressedIcon(new AssetIcon(_local_11));
            this._button.setSize(new IntDimension(_local_9.width, _local_9.height));
            this._button.setBackgroundDecorator(null);
            this._button.setBorder(new EmptyBorder(null, new Insets(5, 15, 0, 0)));
            var _local_12:CustomToolTip = new CustomToolTip(this._button, ClientApplication.Instance.GetPopupText(1), 150, 20);
            var _local_13:JPanel = new JPanel(new EmptyLayout());
            _local_13.setPreferredHeight((this._height - 60));
            _local_13.setPreferredWidth(380);
            _local_13.setMaximumHeight((this._height - 60));
            _local_13.setMaximumWidth(380);
            _local_13.append(_local_3);
            _local_13.append(_local_8);
            var _local_14:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            _local_14.setBorder(new EmptyBorder(null, new Insets(2, 4, 0, 0)));
            _local_14.append(_local_7);
            _local_14.append(_local_13);
            _local_4.append(_local_14);
            MainPanel.append(_local_4, BorderLayout.CENTER);
            MainPanel.append(this._button, BorderLayout.SOUTH);
            pack();
            setDefaultButton(this._button);
        }

        private function OnCloseButtonPressed(_arg_1:AWEvent):void
        {
            dispatchEvent(new Event(WORLD_CHOOSED));
            dispose();
        }

        private function OnItemChoosed(_arg_1:AWEvent):void
        {
            var _local_2:WorldDescription = this.GetSelectedWorld();
            this._descriptionText.setHtmlText(_local_2.Description);
        }

        public function AddWorld(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int):void
        {
            if (_arg_5 == "darkness01")
            {
                _arg_4 = ClientApplication.Localization.SERVER_DESCRIPTION_PVP;
            }
            else
            {
                if (_arg_5 == "darkness02")
                {
                    _arg_4 = ClientApplication.Localization.SERVER_DESCRIPTION_PVE;
                };
            };
            this._worlds.append(new WorldDescription(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
            this._worldsList.setSelectedIndex(0);
        }

        public function GetSelectedWorld():WorldDescription
        {
            this._selectedWorld = (this._worldsList.getSelectedValue() as WorldDescription);
            return (this._selectedWorld);
        }

        public function Center():void
        {
            setLocationXY(((ClientApplication.stageWidth / 2) - (this._width / 2) - 10), 200);
        }

        /*override public function show():void
        {
            if (((this._worlds.getSize() > 1) && ((ClientApplication.serverList) || (ClientApplication.platform == ClientConfig.DEBUG))))
            {
                super.show();
            }
            else
            {
                this._selectedWorld = this._worlds.get(0);
                dispatchEvent(new Event(WORLD_CHOOSED));
            };
        }*/


    }
}//package hbm.Game.GUI.Dialogs

