


//hbm.Game.GUI.Ladders.LaddersWindow

package hbm.Game.GUI.Ladders
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Application.ClientApplication;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import org.aswing.SoftBoxLayout;
    import org.aswing.AssetBackground;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.JTabbedPane;
    import org.aswing.BorderLayout;
    import org.aswing.event.InteractiveEvent;
    import hbm.Engine.Actors.LadderInfo;
    import hbm.Engine.Actors.CharacterInfo;

    public class LaddersWindow extends CustomWindow 
    {

        private const _width:int = 520;
        private const _height:int = 445;

        private var _imagePanel:JPanel;
        private var _textLabel:JLabel;
        private var _ladderPanel1:LadderPanel1;
        private var _ladderPanel2:LadderPanel2;
        private var _ladderPanel3:LadderPanel3;
        private var _ladderPanel4:LadderPanel4;
        private var _ladderPanel5:LadderPanel5;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localizationLibrary:LocalizationResourceLibrary;

        public function LaddersWindow()
        {
            super(null, ClientApplication.Localization.LADDERS_TITLE, false, this._width, this._height, true);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            var _local_2:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_LadderType1");
            this._imagePanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            this._imagePanel.setBackgroundDecorator(new AssetBackground(_local_2));
            this._imagePanel.setPreferredHeight(130);
            this._imagePanel.setPreferredWidth((this._width + 20));
            this._imagePanel.setMaximumHeight(130);
            this._imagePanel.setMaximumWidth((this._width + 20));
            this._textLabel = new JLabel("", null, JLabel.LEFT);
            this._textLabel.setPreferredHeight(50);
            this._textLabel.setMaximumHeight(50);
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2));
            _local_3.setBorder(new EmptyBorder(null, new Insets(8, 6, 5, 0)));
            _local_3.append(this._textLabel);
            var _local_4:JTabbedPane = new JTabbedPane();
            _local_4.setBorder(_local_1);
            _local_4.setPreferredHeight(260);
            var _local_5:Object = this._dataLibrary.GetLadderTypeData(1);
            this._ladderPanel1 = new LadderPanel1(this._width);
            _local_4.appendTab(this._ladderPanel1, ((_local_5 != null) ? _local_5.Description : ""), null);
            if (_local_5)
            {
                this._textLabel.setText(_local_5.Text);
            };
            _local_5 = this._dataLibrary.GetLadderTypeData(2);
            this._ladderPanel2 = new LadderPanel2(this._width);
            _local_4.appendTab(this._ladderPanel2, ((_local_5 != null) ? _local_5.Description : ""), null);
            _local_5 = this._dataLibrary.GetLadderTypeData(3);
            this._ladderPanel3 = new LadderPanel3(this._width);
            _local_4.appendTab(this._ladderPanel3, ((_local_5 != null) ? _local_5.Description : ""), null);
            _local_5 = this._dataLibrary.GetLadderTypeData(4);
            this._ladderPanel4 = new LadderPanel4(this._width);
            _local_4.appendTab(this._ladderPanel4, ((_local_5 != null) ? _local_5.Description : ""), null);
            _local_5 = this._dataLibrary.GetLadderTypeData(5);
            this._ladderPanel5 = new LadderPanel5(this._width);
            _local_4.appendTab(this._ladderPanel5, ((_local_5 != null) ? _local_5.Description : ""), null);
            _local_4.addStateListener(this.OnChanged);
            var _local_6:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_6.append(this._imagePanel);
            _local_6.append(_local_3);
            _local_6.append(_local_4);
            MainPanel.append(_local_6, BorderLayout.CENTER);
            pack();
        }

        protected function OnChanged(_arg_1:InteractiveEvent):void
        {
            var _local_3:Bitmap;
            var _local_4:Object;
            var _local_2:int = (_arg_1.target as JTabbedPane).getSelectedIndex();
            if (((_local_2 >= 0) && (_local_2 < 6)))
            {
                _local_4 = this._dataLibrary.GetLadderTypeData((_local_2 + 1));
                if (_local_4)
                {
                    this._textLabel.setText(_local_4.Text);
                };
            };
            switch (_local_2)
            {
                case 0:
                    _local_3 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_LadderType1");
                    this._imagePanel.setBackgroundDecorator(new AssetBackground(_local_3));
                    return;
                case 1:
                    _local_3 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_LadderType2");
                    this._imagePanel.setBackgroundDecorator(new AssetBackground(_local_3));
                    return;
                case 3:
                    _local_3 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_LadderType4");
                    this._imagePanel.setBackgroundDecorator(new AssetBackground(_local_3));
                    return;
                default:
                    _local_3 = this._localizationLibrary.GetBitmapAsset("Localization_Item_LadderType0");
                    this._imagePanel.setBackgroundDecorator(new AssetBackground(_local_3));
            };
        }

        public function LoadLadders(_arg_1:Array):void
        {
            var _local_3:LadderInfo;
            this._ladderPanel1.ClearTable();
            this._ladderPanel2.ClearTable();
            this._ladderPanel3.ClearTable();
            this._ladderPanel4.ClearTable();
            this._ladderPanel5.ClearTable();
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            this.UpdateKafraAmount(_local_2.kafraPoints);
            for each (_local_3 in _arg_1)
            {
                if (_local_3.type == 1)
                {
                    this._ladderPanel1.AddRow(_local_3);
                }
                else
                {
                    if (_local_3.type == 2)
                    {
                        this._ladderPanel2.AddRow(_local_3);
                    }
                    else
                    {
                        if (_local_3.type == 3)
                        {
                            this._ladderPanel3.AddRow(_local_3);
                        }
                        else
                        {
                            if (_local_3.type == 4)
                            {
                                this._ladderPanel4.AddRow(_local_3);
                            }
                            else
                            {
                                if (_local_3.type == 5)
                                {
                                    this._ladderPanel5.AddRow(_local_3);
                                };
                            };
                        };
                    };
                };
            };
        }

        public function UpdateKafraAmount(_arg_1:int):void
        {
            this._ladderPanel1.UpdateKafraAmount(_arg_1);
            this._ladderPanel2.UpdateKafraAmount(_arg_1);
            this._ladderPanel3.UpdateKafraAmount(_arg_1);
            this._ladderPanel4.UpdateKafraAmount(_arg_1);
            this._ladderPanel5.UpdateKafraAmount(_arg_1);
        }


    }
}//package hbm.Game.GUI.Ladders

