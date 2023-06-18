


//hbm.Game.GUI.NPCDialog.NPCLocationItem

package hbm.Game.GUI.NPCDialog
{
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.EmptyLayout;
    import mx.core.BitmapAsset;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.JLabel;
    import org.aswing.JTextArea;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import hbm.Application.ClientApplication;
    import flash.events.Event;

    public class NPCLocationItem extends JPanel 
    {

        private var _location:String;
        private var _npcId:String;
        private var _compass:JPanel;

        public function NPCLocationItem(_arg_1:Object, _arg_2:String, _arg_3:String)
        {
            var _local_5:String;
            var _local_8:Object;
            super(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            AsWingUtil.SetBackgroundFromAsset(this, "NL_Background");
            var _local_4:JPanel = new JPanel(new EmptyLayout());
            _local_5 = ("MiniNpc" + _arg_1.Icon);
            var _local_6:BitmapAsset = AsWingUtil.GetAsset(_local_5);
            if (_local_6)
            {
                AsWingUtil.SetBackground(_local_4, _local_6);
            }
            else
            {
                AsWingUtil.SetBackgroundFromAsset(_local_4, "MiniNpc0");
            };
            append(AsWingUtil.OffsetBorder(_local_4, 10));
            this._compass = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(this._compass, "NL_CompassStamp");
            this._compass.setLocationXY((_local_4.getWidth() - this._compass.getWidth()), 0);
            _local_4.append(this._compass);
            this._compass.visible = false;
            var _local_7:String = ((_arg_1.MainMap == _arg_2) ? _arg_1.MapName : _arg_2);
            _local_8 = AsWingUtil.AdditionalData.GetMapsData(_local_7);
            var _local_9:String = ((_local_8) ? _local_8.Name : "Unknown");
            var _local_10:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            AsWingUtil.SetBorder(_local_10, 0, 8);
            AsWingUtil.SetWidth(_local_10, 150);
            var _local_11:JLabel = AsWingUtil.CreateLabel(_arg_1.Name, 0xFFFFFF, new ASFont(HtmlText.fontName, 12, true));
            _local_11.setHorizontalAlignment(JLabel.LEFT);
            _local_11.setTextFilters([HtmlText.shadow]);
            _local_10.append(_local_11);
            var _local_12:JLabel = AsWingUtil.CreateLabel(_local_9, 16768877, new ASFont(HtmlText.fontName, 12));
            _local_12.setHorizontalAlignment(JLabel.LEFT);
            _local_12.setTextFilters([HtmlText.shadow]);
            _local_10.append(_local_12);
            append(_local_10);
            var _local_13:JTextArea = AsWingUtil.CreateTextArea((("<font size='10'>" + ((_arg_1.Description) || ("Unknown"))) + "</font>"));
            _local_13.filters = [HtmlText.shadow];
            AsWingUtil.SetBorder(_local_13, 0, 8);
            AsWingUtil.SetWidth(_local_13, 120);
            append(_local_13);
            var _local_14:CustomButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("NL_FolowButton", "NL_FolowButtonOver", "NL_FolowButtonPress");
            this._npcId = _arg_3;
            this._location = _local_7;
            _local_14.addActionListener(this.OnFind, 0, true);
            append(AsWingUtil.OffsetBorder(_local_14, 0, 15));
            var _local_15:CustomButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("NL_WarpButtonDisable");
            append(AsWingUtil.OffsetBorder(_local_15, 0, 15));
            var _local_16:* = (((((((("<font face='" + HtmlText.fontName) + "'><b>") + _arg_1.Name) + "</b><br><font color='#ffdf6d'>") + _local_9) + "</font></font><br><font size='10'>") + ((_arg_1.Description) || ("Unknown"))) + "</font>");
            new CustomToolTip(this, _local_16, 300);
        }

        public function EnableNavigate(_arg_1:Boolean):void
        {
            this._compass.visible = _arg_1;
        }

        private function OnFind(_arg_1:Event):void
        {
            HelpManager.Instance.GetRoadAtlas().HelpMoveToMap(this._location, this._npcId);
            ClientApplication.Instance.OpenNPCLocationWindow();
        }


    }
}//package hbm.Game.GUI.NPCDialog

