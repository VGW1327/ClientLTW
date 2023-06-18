


//hbm.Game.GUI.Buffs.BuffWindow

package hbm.Game.GUI.Buffs
{
    import org.aswing.JWindow;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.Container;
    import org.aswing.EmptyLayout;
    import hbm.Application.ClientApplication;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.JLabel;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Game.GUI.Tools.CustomButton;

    public class BuffWindow extends JWindow 
    {

        private var _loading:Boolean;
        protected var _buffPanel:BuffPanel;

        public function BuffWindow()
        {
            this.InitUI();
            setLocationXY(0, 100);
        }

        private function InitUI():void
        {
            AsWingUtil.SetBorder(this);
            var _local_1:Container = getContentPane();
            _local_1.setLayout(new EmptyLayout());
            var _local_2:JLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.BUFF_WINDOW_TITLE, 16772788, new ASFont(HtmlText.fontName, 14, false));
            _local_2.setTextFilters([HtmlText.shadow]);
            _local_2.setLocationXY(116, 2);
            AsWingUtil.SetSize(_local_2, 240, 16);
            _local_1.append(_local_2);
            this._buffPanel = new BuffPanel();
            this._buffPanel.setLocationXY(10, 24);
            AsWingUtil.SetSize(this._buffPanel, 430, 38);
            _local_1.append(this._buffPanel);
            _local_1.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown, false, 0, true);
            _local_1.addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
            pack();
        }

        private function OnMouseDown(_arg_1:Event):void
        {
            startDrag(false, new Rectangle(0, 0, (stage.stageWidth - width), (stage.stageHeight - height)));
        }

        private function OnMouseUp(_arg_1:Event):void
        {
            stopDrag();
        }

        public function Revalidate():void
        {
            var _local_1:AdditionalDataResourceLibrary;
            var _local_3:Object;
            this._buffPanel.Clear();
            _local_1 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_2:Object = _local_1.GetBuffs();
            if (_local_2)
            {
                for each (_local_3 in _local_2)
                {
                    if (_local_3.iconId < 999)
                    {
                        this._buffPanel.AddBuffItem(new BuffItem(_local_3));
                    };
                };
            };
        }

        public function get BuffPanelInstance():BuffPanel
        {
            return (this._buffPanel);
        }

        override public function show():void
        {
            var _local_1:Container;
            var _local_2:CustomButton;
            if (!this._loading)
            {
                _local_1 = getContentPane();
                AsWingUtil.SetBackgroundFromAsset(_local_1, "BW_Background");
                _local_2 = AsWingUtil.CreateCustomButtonFromAsset("BW_CloseButton", "BW_CloseButtonOver", "BW_CloseButtonPress");
                _local_2.setLocationXY(428, 18);
                _local_2.addActionListener(this.OnClose, 0, true);
                _local_1.append(_local_2);
                AsWingUtil.SetSize(this, _local_1.getWidth(), _local_1.getHeight());
                pack();
                this._loading = true;
            };
            super.show();
        }

        private function OnClose(_arg_1:Event):void
        {
            dispose();
        }


    }
}//package hbm.Game.GUI.Buffs

