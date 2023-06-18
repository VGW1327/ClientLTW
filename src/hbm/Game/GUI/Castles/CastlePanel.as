


//hbm.Game.GUI.Castles.CastlePanel

package hbm.Game.GUI.Castles
{
    import org.aswing.JPanel;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import org.aswing.AttachIcon;
    import org.aswing.JLabel;
    import org.aswing.ASFont;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Engine.Resource.ResourceManager;
    import mx.core.BitmapAsset;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.PaddedValue;
    import org.aswing.BorderLayout;
    import hbm.Engine.Actors.CastleInfo;

    public class CastlePanel extends JPanel 
    {

        private var _dataLibrary:AdditionalDataResourceLibrary;

        public function CastlePanel(_arg_1:CastleInfo)
        {
            var _local_3:Object;
            var _local_4:int;
            var _local_5:String;
            var _local_6:AttachIcon;
            var _local_9:JLabel;
            var _local_10:ASFont;
            var _local_15:String;
            var _local_19:JLabel;
            var _local_20:Bitmap;
            var _local_21:String;
            var _local_22:Bitmap;
            var _local_23:BitmapData;
            var _local_24:Rectangle;
            var _local_25:Point;
            var _local_26:JPanel;
            var _local_27:JPanel;
            var _local_28:AttachIcon;
            var _local_29:JLabel;
            super();
            var _local_2:LineBorder = new LineBorder(null, new ASColor(5333109), 1, 4);
            setLayout(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            _local_3 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetCastlesData(_arg_1.mapName);
            _local_4 = _local_3.IconId;
            _local_5 = ("AdditionalData_Item_castle" + _local_4);
            _local_6 = new AttachIcon(_local_5);
            var _local_7:JLabel = new JLabel("", _local_6);
            var _local_8:String = _local_3.Location;
            if (_arg_1.guildId > 0)
            {
                _local_20 = (_local_6.getAsset() as BitmapAsset);
                _local_21 = ((_arg_1.fraction) ? "AdditionalData_Item_OrcIcon" : "AdditionalData_Item_HumanIcon");
                _local_22 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmapAsset(_local_21);
                _local_23 = _local_22.bitmapData;
                _local_24 = new Rectangle(0, 0, _local_23.width, _local_23.height);
                _local_25 = new Point(0, 0);
                _local_20.bitmapData.copyPixels(_local_23, _local_24, _local_25, _local_23, _local_25, true);
            };
            _local_7.setPreferredWidth(36);
            _local_7.setPreferredHeight(36);
            _local_7.setBorder(new EmptyBorder(null, new Insets(0, 0, 4, 0)));
            _local_9 = new JLabel(_local_8, null, JLabel.CENTER);
            _local_10 = _local_9.getFont();
            var _local_11:ASFont = new ASFont(_local_10.getName(), 14, true);
            _local_9.setFont(_local_11);
            _local_9.setPreferredWidth(160);
            var _local_12:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.CENTER));
            _local_12.setBorder(_local_2);
            _local_12.setPreferredWidth(195);
            _local_12.append(_local_9);
            _local_12.append(_local_7);
            var _local_13:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 1));
            _local_13.setBorder(_local_2);
            _local_13.setPreferredWidth(345);
            var _local_14:String = ((_arg_1.woeDay == 1) ? ClientApplication.Localization.CASTLES_WOE_WEDNESDAY : ClientApplication.Localization.CASTLES_WOE_FRIDAY);
            _local_15 = ((((_local_14 + " ") + _arg_1.woeStartHour) + " - ") + _arg_1.woeEndHour);
            var _local_16:JPanel = new PaddedValue(ClientApplication.Localization.CASTLES_OWNER_WOETIME_LABEL, _local_15, 100, 240);
            _local_16.setBorder(new EmptyBorder(null, new Insets(0, 0, 8, 0)));
            _local_13.append(_local_16);
            var _local_17:JPanel = new JPanel(new BorderLayout());
            var _local_18:JLabel = new JLabel(ClientApplication.Localization.CASTLES_OWNER);
            if (_arg_1.guildId > 0)
            {
                if (((_arg_1.guildEmblemId > 0) && (this._dataLibrary == null)))
                {
                    this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
                };
                _local_26 = new JPanel(new BorderLayout());
                if (_arg_1.guildEmblemId > 0)
                {
                    _local_28 = this._dataLibrary.GetAttachIcon("guild", _arg_1.guildEmblemId.toString());
                    _local_29 = new JLabel("", _local_28, JLabel.LEFT);
                    _local_26.append(_local_29, BorderLayout.EAST);
                };
                _local_19 = new JLabel((((ClientApplication.Localization.CASTLES_OWNER_GUILD + " '") + _arg_1.guildName) + "'"), null, JLabel.LEFT);
                _local_26.append(_local_19, BorderLayout.WEST);
                _local_17.append(_local_18, BorderLayout.WEST);
                _local_17.append(_local_26, BorderLayout.EAST);
                _local_13.append(_local_17);
                _local_27 = new PaddedValue(ClientApplication.Localization.CASTLES_OWNER_GUILDMASTER, _arg_1.guildMasterName, 100, 240);
                _local_13.append(_local_27);
            }
            else
            {
                _local_19 = new JLabel(ClientApplication.Localization.CASTLES_OWNER_MONSTERS, null, JLabel.LEFT);
                _local_17.append(_local_18, BorderLayout.WEST);
                _local_17.append(_local_19, BorderLayout.EAST);
                _local_13.append(_local_17);
            };
            append(_local_12);
            append(_local_13);
            pack();
        }

    }
}//package hbm.Game.GUI.Castles

