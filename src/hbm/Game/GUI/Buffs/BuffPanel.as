


//hbm.Game.GUI.Buffs.BuffPanel

package hbm.Game.GUI.Buffs
{
    import org.aswing.JPanel;
    import flash.utils.Dictionary;
    import org.aswing.GridLayout;
    import org.aswing.FlowLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Game.Utility.HtmlText;
    import hbm.Game.Utility.AsWingUtil;
    import hbm.Game.GUI.DndTargets;
    import org.aswing.geom.IntPoint;
    import org.aswing.JLabel;
    import org.aswing.ASFont;
    import org.aswing.ASColor;
    import org.aswing.EmptyLayout;
    import flash.display.Bitmap;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.AssetBackground;
    import caurina.transitions.Tweener;
    import hbm.Application.ClientApplication;

    public class BuffPanel extends JPanel 
    {

        private var _lastFrameTickTime:uint = 0;
        protected var _buffsCount:int;
        private var _slots:Array;
        private var _cdSlots:Array;
        private var _cdPanels:Array;
        private var _cdPanelLabels:Array;
        private var _timeToUseBuff:Dictionary;

        public function BuffPanel()
        {
            super(new GridLayout(1, 10));
            this.Clear();
        }

        public function Clear():void
        {
            removeAll();
            this._buffsCount = 0;
            this._slots = new Array();
            this._cdSlots = new Array();
            this._cdPanels = new Array();
            this._cdPanelLabels = new Array();
            this._timeToUseBuff = new Dictionary(true);
        }

        protected function CreateSlot():JPanel
        {
            var _local_3:FlowLayout;
            var _local_1:IntDimension = new IntDimension(38, 38);
            var _local_2:EmptyBorder = new EmptyBorder(null, new Insets(1, 3, 0, 0));
            _local_3 = new FlowLayout();
            _local_3.setMargin(false);
            var _local_4:JPanel = new JPanel(_local_3);
            _local_4.filters = [HtmlText.glow];
            AsWingUtil.SetBorder(_local_4, 2, 2, 0, 0);
            _local_4.setPreferredSize(_local_1);
            _local_4.setMaximumSize(_local_1);
            _local_4.setSize(_local_1);
            _local_4.putClientProperty(DndTargets.DND_INDEX, this._slots.length);
            _local_4.setLocation(new IntPoint(0, 0));
            var _local_5:JPanel = new JPanel(_local_3);
            _local_5.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            _local_5.setSize(new IntDimension(40, 40));
            _local_5.setLocation(new IntPoint(0, 38));
            var _local_6:JLabel = new JLabel("", null, JLabel.CENTER);
            _local_6.setBorder(new EmptyBorder(null, new Insets(10, 2, 0, 0)));
            _local_6.setWidth(40);
            _local_6.setPreferredWidth(40);
            _local_6.setFont(new ASFont(HtmlText.fontName, 12, false));
            _local_6.setForeground(new ASColor(16767612));
            _local_6.setTextFilters([HtmlText.glow]);
            _local_6.setVisible(false);
            _local_5.append(_local_6);
            var _local_7:JPanel = new JPanel(_local_3);
            _local_7.setBorder(_local_2);
            _local_7.setSize(new IntDimension(38, 40));
            _local_7.setLocation(new IntPoint(-2, 41));
            var _local_8:JPanel = new JPanel(new EmptyLayout());
            _local_8.setBorder(null);
            _local_8.setSize(new IntDimension(36, 34));
            _local_8.setPreferredSize(new IntDimension(36, 34));
            _local_8.append(_local_4);
            _local_8.append(_local_7);
            _local_8.append(_local_5);
            append(_local_8);
            this._slots.push(_local_4);
            this._cdSlots.push(_local_7);
            this._cdPanels.push(_local_5);
            this._cdPanelLabels.push(_local_6);
            return (_local_4);
        }

        public function AddBuffItem(_arg_1:BuffItem):void
        {
            var _local_2:JPanel;
            var _local_3:String;
            var _local_4:Bitmap;
            var _local_6:int;
            _local_2 = this.CreateSlot();
            _local_3 = "AdditionalData_Item_Cooldown";
            _local_4 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmapAsset(_local_3);
            var _local_5:AssetBackground = new AssetBackground(_local_4);
            _local_6 = _local_2.getClientProperty(DndTargets.DND_INDEX);
            var _local_7:JPanel = this._cdSlots[_local_6];
            _local_7.setBackgroundDecorator(_local_5);
            _arg_1.putClientProperty(DndTargets.DND_SLOT, _local_2);
            _local_2.putClientProperty(DndTargets.DND_BUFF, _arg_1);
            _local_2.append(_arg_1);
            this._buffsCount++;
        }

        private function DoCooldownSlot(_arg_1:JPanel):Boolean
        {
            if (_arg_1.alpha < 1)
            {
                return (false);
            };
            Tweener.addTween(_arg_1, {
                "alpha":0.5,
                "time":0.1,
                "transition":"linear"
            });
            Tweener.addTween(_arg_1, {
                "alpha":1,
                "time":0.1,
                "transition":"linear",
                "delay":0.15
            });
            return (true);
        }

        private function DoCooldownBuffSlot(_arg_1:int=-1):void
        {
            var _local_2:JPanel;
            var _local_3:BuffItem;
            if (((_arg_1 < 0) || (_arg_1 >= this._slots.length)))
            {
                return;
            };
            _local_2 = this._slots[_arg_1];
            _local_3 = _local_2.getClientProperty(DndTargets.DND_BUFF);
            var _local_4:Number = _local_3.Cooldown;
            if (_local_4 <= 0)
            {
                if (_arg_1 >= 0)
                {
                    this.DoCooldownSlot(_local_2);
                };
                return;
            };
            this._timeToUseBuff[_arg_1] = _local_4;
            var _local_5:JPanel = this._cdSlots[_arg_1];
            var _local_6:JPanel = this._cdPanels[_arg_1];
            var _local_7:JLabel = this._cdPanelLabels[_arg_1];
            _local_7.setVisible(false);
            Tweener.addTween(_local_5, {
                "y":0,
                "time":0,
                "transition":"linear"
            });
            Tweener.addTween(_local_6, {
                "y":0,
                "time":0,
                "transition":"linear"
            });
            Tweener.addTween(_local_5, {
                "y":40,
                "time":_local_4,
                "transition":"linear",
                "delay":0.01
            });
            Tweener.addTween(_local_6, {
                "y":36,
                "time":0,
                "transition":"linear",
                "delay":_local_4
            });
            Tweener.addTween(_local_2, {
                "alpha":0.5,
                "time":0.1,
                "transition":"linear",
                "delay":(_local_4 + 0.01)
            });
            Tweener.addTween(_local_2, {
                "alpha":1,
                "time":0.1,
                "transition":"linear",
                "delay":(_local_4 + 0.15)
            });
        }

        private function CheckCooldownBuff(_arg_1:int):Boolean
        {
            if (this._timeToUseBuff.hasOwnProperty(_arg_1.toString()))
            {
                return (this._timeToUseBuff[_arg_1] == 0);
            };
            return (true);
        }

        public function UseBuff(_arg_1:int, _arg_2:int):void
        {
            if (this.CheckCooldownBuff(_arg_1))
            {
                this.DoCooldownBuffSlot(_arg_1);
                ClientApplication.Instance.LocalGameClient.SendChatMessage(("@cashbuff " + _arg_2));
            };
        }

        public function Update(_arg_1:uint):void
        {
            var _local_3:Object;
            var _local_4:Number;
            var _local_5:int;
            var _local_6:String;
            var _local_7:JLabel;
            var _local_2:Number = (Number((_arg_1 - this._lastFrameTickTime)) / 1000);
            this._lastFrameTickTime = _arg_1;
            for (_local_3 in this._timeToUseBuff)
            {
                _local_4 = this._timeToUseBuff[_local_3];
                if (_local_4 != 0)
                {
                    if (_local_4 > 0)
                    {
                        _local_4 = (_local_4 - _local_2);
                        if (_local_4 < 0)
                        {
                            _local_4 = 0;
                        };
                    };
                    this._timeToUseBuff[_local_3] = _local_4;
                    _local_5 = (int(_local_4) + 1);
                    if (_local_5 > 60)
                    {
                        _local_6 = ((Math.round((_local_5 / 60)) + ClientApplication.Localization.TIME_MINUTES) as String);
                    }
                    else
                    {
                        _local_6 = (_local_5 + ClientApplication.Localization.TIME_SECONDS);
                    };
                    _local_7 = this._cdPanelLabels[_local_3];
                    _local_7.setVisible(true);
                    _local_7.setText(_local_6);
                };
            };
        }


    }
}//package hbm.Game.GUI.Buffs

