


//hbm.Game.GUI.NPCDialog.NPCLocationWindow

package hbm.Game.GUI.NPCDialog
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import org.aswing.JPanel;
    import hbm.Application.ClientApplication;
    import hbm.Game.Utility.AsWingUtil;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.BorderLayout;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JScrollPane;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import flash.events.Event;
    import org.aswing.EmptyLayout;
    import hbm.Engine.Renderer.RenderSystem;

    public class NPCLocationWindow extends WindowPrototype 
    {

        private const WIDTH:int = 565;
        private const HEIGHT:int = 650;

        private var _listPanel:JPanel;
        private var _lastLocation:String;
        private var _npcList:Object;

        public function NPCLocationWindow()
        {
            super(owner, ClientApplication.Localization.NPC_LOCATION_WINDOW_TITLE, false, this.WIDTH, this.HEIGHT, true);
            dispose();
        }

        override protected function InitUI():void
        {
            super.InitUI();
            if (_closeWindowButton2)
            {
                _closeWindowButton2.removeFromContainer();
            };
            var _local_1:CustomButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("NL_CancelButton", "NL_CancelButtonOver", "NL_CancelButtonPress");
            _local_1.addActionListener(this.OnCancelFind, 0, true);
            Bottom.append(AsWingUtil.AlignCenter(_local_1));
            Body.setLayout(new BorderLayout());
            this._listPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2));
            var _local_2:JScrollPane = new JScrollPane(this._listPanel, JScrollPane.SCROLLBAR_AS_NEEDED);
            Body.append(_local_2, BorderLayout.CENTER);
            pack();
        }

        private function OnCancelFind(_arg_1:Event):void
        {
            var _local_2:String;
            _local_2 = HelpManager.Instance.GetRoadAtlas().NpcId;
            var _local_3:NPCLocationItem = this._npcList[_local_2];
            if (_local_3)
            {
                _local_3.EnableNavigate(false);
            };
            HelpManager.Instance.GetRoadAtlas().Reset();
        }

        public function LoadNPCData():void
        {
            var _local_5:String;
            var _local_6:NPCLocationItem;
            var _local_7:Object;
            var _local_9:JPanel;
            var _local_1:String = this.CurrentLocation();
            if (this._lastLocation == _local_1)
            {
                return;
            };
            var _local_2:Array = AsWingUtil.AdditionalData.GetNpcIdArray(_local_1);
            var _local_3:Array = AsWingUtil.AdditionalData.GetSubNpcIdArray(_local_1);
            this._listPanel.removeAll();
            this._npcList = {};
            var _local_4:String = HelpManager.Instance.GetRoadAtlas().NpcId;
            for each (_local_5 in _local_2)
            {
                _local_7 = AsWingUtil.AdditionalData.GetNpcDataFromId(_local_5);
                if (!((((!(_local_7)) || (_local_7.MainMap == "0")) || (_local_7.PositionX < 0)) || (_local_7.PositionY < 0)))
                {
                    _local_6 = new NPCLocationItem(_local_7, _local_1, _local_5);
                    this._listPanel.append(_local_6);
                    this._npcList[_local_5] = _local_6;
                };
            };
            for each (_local_5 in _local_3)
            {
                _local_7 = AsWingUtil.AdditionalData.GetNpcDataFromId(_local_5);
                if (!((((!(_local_7)) || (_local_7.MainMap == "0")) || (_local_7.PositionX < 0)) || (_local_7.PositionY < 0)))
                {
                    _local_6 = new NPCLocationItem(_local_7, _local_1, _local_5);
                    this._listPanel.append(_local_6);
                    this._npcList[_local_5] = _local_6;
                };
            };
            _local_6 = this._npcList[_local_4];
            if (_local_6)
            {
                _local_6.EnableNavigate(true);
            };
            this._listPanel.pack();
            var _local_8:Number = ((this.HEIGHT - 110) - this._listPanel.getHeight());
            if (_local_8 > 0)
            {
                _local_9 = new JPanel(new EmptyLayout());
                AsWingUtil.SetHeight(_local_9, _local_8);
                this._listPanel.append(_local_9);
            };
        }

        override public function show():void
        {
            this.LoadNPCData();
            super.show();
            setLocationXY(((RenderSystem.Instance.ScreenWidth - width) / 2), ((RenderSystem.Instance.ScreenHeight - height) / 2));
        }

        private function CurrentLocation():String
        {
            return (ClientApplication.Instance.LocalGameClient.MapName.replace(/(\w+)\.gat/i, "$1"));
        }


    }
}//package hbm.Game.GUI.NPCDialog

