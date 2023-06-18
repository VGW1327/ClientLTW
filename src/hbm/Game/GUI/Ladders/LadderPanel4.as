


//hbm.Game.GUI.Ladders.LadderPanel4

package hbm.Game.GUI.Ladders
{
    import org.aswing.JPanel;
    import org.aswing.JTable;
    import hbm.Game.GUI.Tools.CustomTableModel;
    import org.aswing.table.sorter.TableSorter;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JLabel;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import org.aswing.JScrollPane;
    import org.aswing.ASFont;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import flash.display.Bitmap;
    import org.aswing.table.TableColumn;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Application.ClientApplication;
    import org.aswing.EmptyLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.geom.IntPoint;
    import org.aswing.ASColor;
    import hbm.Game.GUI.Tools.WindowSprites;
    import org.aswing.AssetIcon;
    import hbm.Engine.Actors.LadderInfo;
    import flash.events.Event;
    import org.aswing.event.AWEvent;

    public class LadderPanel4 extends JPanel 
    {

        private var _table:JTable;
        private var _tableModel:CustomTableModel;
        private var _sorter:TableSorter;
        private var _button:CustomButton;
        private var _kafraAmountLabel:JLabel;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localizationLibrary:LocalizationResourceLibrary;

        public function LadderPanel4(_arg_1:int)
        {
            var _local_3:*;
            var _local_4:JScrollPane;
            var _local_5:JPanel;
            var _local_6:JLabel;
            var _local_7:ASFont;
            var _local_8:ASFont;
            var _local_9:CustomToolTip;
            var _local_10:Bitmap;
            var _local_11:JLabel;
            var _local_12:Bitmap;
            var _local_13:Bitmap;
            var _local_14:Bitmap;
            var _local_15:CustomButton;
            var _local_16:CustomToolTip;
            var _local_17:Bitmap;
            var _local_18:Bitmap;
            var _local_19:Bitmap;
            var _local_20:Bitmap;
            var _local_21:CustomToolTip;
            var _local_22:TableColumn;
            super();
            setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.TOP));
            setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            this._tableModel = new CustomTableModel();
            this._tableModel.initWithRowcountColumncount(0, 0);
            this._tableModel.setAllCellEditable(false);
            this._table = new JTable();
            this._sorter = new TableSorter(this._tableModel, this._table.getTableHeader());
            this._table.setModel(this._sorter);
            this._table.setSelectionMode(0);
            var _local_2:Array = [{
                "id":0,
                "title":ClientApplication.Localization.LADDERS_MEMBERS_HEADER[0],
                "resizable":false,
                "editable":false,
                "type":"Int",
                "width":20
            }, {
                "id":1,
                "title":ClientApplication.Localization.LADDERS_MEMBERS_HEADER[1],
                "resizable":true,
                "editable":false,
                "type":"String",
                "width":300
            }, {
                "id":2,
                "title":ClientApplication.Localization.LADDERS_MEMBERS_HEADER[3],
                "resizable":false,
                "editable":false,
                "type":"String",
                "width":120
            }];
            for each (_local_3 in _local_2)
            {
                _local_22 = new TableColumn(_local_3.id, _local_3.width);
                _local_22.setHeaderValue(_local_3.title);
                _local_22.setResizable(_local_3.resizable);
                this._table.addColumn(_local_22);
                this._tableModel.setColumnClass(_local_3.id, _local_3.title);
                this._table.setDefaultCellFactory(_local_3.title, new LaddersTableFactory());
            };
            this._table.addSelectionListener(this.OnSelected, 0, true);
            _local_4 = new JScrollPane(this._table);
            _local_4.setPreferredHeight(130);
            _local_4.setMaximumHeight(130);
            _local_5 = new JPanel(new EmptyLayout());
            _local_5.setPreferredHeight(70);
            _local_5.setPreferredWidth(_arg_1);
            _local_5.setMaximumHeight(70);
            _local_5.setMaximumWidth(_arg_1);
            _local_6 = new JLabel((ClientApplication.Localization.KAFRA_SHOP_GOLD_BALANSE + " "));
            _local_7 = _local_6.getFont();
            _local_8 = new ASFont(_local_7.getName(), 14, true);
            _local_6.setFont(_local_8);
            _local_6.setHorizontalAlignment(JLabel.LEFT);
            _local_6.setSize(new IntDimension(120, 20));
            _local_6.setLocation(new IntPoint(10, 31));
            this._kafraAmountLabel = new JLabel();
            this._kafraAmountLabel.setFont(_local_8);
            this._kafraAmountLabel.setForeground(new ASColor(16240402));
            this._kafraAmountLabel.setHorizontalAlignment(JLabel.RIGHT);
            this._kafraAmountLabel.setSize(new IntDimension(70, 20));
            this._kafraAmountLabel.setLocation(new IntPoint(110, 31));
            _local_9 = new CustomToolTip(this._kafraAmountLabel, ClientApplication.Instance.GetPopupText(201), 185, 40);
            _local_10 = new WindowSprites.CoinKafra();
            _local_11 = new JLabel(" ", new AssetIcon(_local_10));
            _local_11.setSize(new IntDimension(20, 20));
            _local_11.setLocation(new IntPoint(180, 31));
            _local_12 = this._localizationLibrary.GetBitmapAsset("Localization_Item_KafraShopButton");
            _local_13 = this._localizationLibrary.GetBitmapAsset("Localization_Item_KafraShopButtonSelected");
            _local_14 = this._localizationLibrary.GetBitmapAsset("Localization_Item_KafraShopButtonPressed");
            _local_15 = new CustomButton();
            _local_16 = new CustomToolTip(_local_15, ClientApplication.Instance.GetPopupText(202), 250, 60);
            _local_15.addActionListener(this.OnKafraButtonPressed, 0, true);
            _local_15.setIcon(new AssetIcon(_local_12));
            _local_15.setRollOverIcon(new AssetIcon(_local_13));
            _local_15.setPressedIcon(new AssetIcon(_local_14));
            _local_15.setBackgroundDecorator(null);
            _local_15.setSize(new IntDimension(_local_12.width, _local_12.height));
            _local_15.setLocation(new IntPoint(190, 3));
            _local_17 = this._localizationLibrary.GetBitmapAsset("Localization_Item_LadderButton");
            _local_18 = this._localizationLibrary.GetBitmapAsset("Localization_Item_LadderButtonSelected");
            _local_19 = this._localizationLibrary.GetBitmapAsset("Localization_Item_LadderButtonPressed");
            _local_20 = this._localizationLibrary.GetBitmapAsset("Localization_Item_LadderButtonDisabled");
            this._button = new CustomButton();
            _local_21 = new CustomToolTip(this._button, ClientApplication.Instance.GetPopupText(200), 220, 30);
            this._button.addActionListener(this.OnButtonPressed, 0, true);
            this._button.setEnabled(false);
            this._button.setIcon(new AssetIcon(_local_17));
            this._button.setRollOverIcon(new AssetIcon(_local_18));
            this._button.setPressedIcon(new AssetIcon(_local_19));
            this._button.setDisabledIcon(new AssetIcon(_local_20));
            this._button.setBackgroundDecorator(null);
            this._button.setSize(new IntDimension(_local_17.width, _local_17.height));
            this._button.setLocation(new IntPoint(360, 3));
            _local_5.append(_local_6);
            _local_5.append(this._kafraAmountLabel);
            _local_5.append(_local_11);
            _local_5.append(_local_15);
            _local_5.append(this._button);
            append(_local_4);
            append(_local_5);
            pack();
        }

        public function ClearTable():void
        {
            this._tableModel.clearRows();
        }

        public function UpdateKafraAmount(_arg_1:int):void
        {
            this._kafraAmountLabel.setText(_arg_1.toString());
        }

        public function AddRow(_arg_1:LadderInfo):void
        {
            var _local_2:Object;
            var _local_3:Object;
            var _local_4:String;
            if (((_arg_1) && (_arg_1.type == 4)))
            {
                _local_2 = this._dataLibrary.GetLadderData(_arg_1.ladderId);
                _local_3 = this._dataLibrary.GetMapsData(_arg_1.mapName);
                _local_4 = ((_local_3) ? _local_3.Name : _arg_1.mapName);
                this._tableModel.addRow(new Array(_arg_1.ladderId, ((_local_4 + " ") + ((_local_2 != null) ? _local_2.Description : "")), ((_arg_1.side1 + "/") + _arg_1.side2)));
            };
        }

        private function OnSelected(_arg_1:Event):void
        {
            var _local_2:int = this._table.getSelectedRow();
            this._button.setEnabled((_local_2 >= 0));
        }

        private function OnButtonPressed(_arg_1:AWEvent):void
        {
            var _local_3:int;
            var _local_2:int = this._table.getSelectedRow();
            if (_local_2 >= 0)
            {
                _local_3 = this._sorter.getValueAt(_local_2, 0);
                ClientApplication.Instance.LocalGameClient.SendEnterLadder(_local_3);
            };
        }

        private function OnKafraButtonPressed(_arg_1:AWEvent):void
        {
            ClientApplication.Instance.LocalGameClient.SendOpenKafraShop();
        }


    }
}//package hbm.Game.GUI.Ladders

