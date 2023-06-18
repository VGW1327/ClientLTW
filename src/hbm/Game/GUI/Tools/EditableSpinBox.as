


//hbm.Game.GUI.Tools.EditableSpinBox

package hbm.Game.GUI.Tools
{
    import org.aswing.JPanel;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import org.aswing.JTextField;
    import flash.utils.Timer;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.geom.IntDimension;
    import org.aswing.SoftBoxLayout;
    import org.aswing.CenterLayout;
    import org.aswing.ASFont;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import flash.events.Event;
    import flash.display.Bitmap;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.AssetIcon;
    import flash.events.TimerEvent;
    import flash.events.MouseEvent;
    import flash.text.TextFormat;

    public class EditableSpinBox extends JPanel 
    {

        private static const AUTO_START_SPIN_DELAY:uint = 600;
        private static const AUTO_INCREMENT_SPIN_DELAY:uint = 70;

        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _spinMin:int = 1;
        private var _spinMax:int = 2147483647;
        private var _spinStep:int = 1;
        private var _spinAmount:int = 1;
        protected var _spinAmountLbl:JTextField;
        protected var _spinArrowUp:CustomButton;
        protected var _spinArrowDown:CustomButton;
        private var _onStateChanged:Function = null;
        private var _timerUp:Timer = new Timer(AUTO_START_SPIN_DELAY);
        private var _timerDown:Timer = new Timer(AUTO_START_SPIN_DELAY);
        private var _width:int;
        private var _height:int;

        public function EditableSpinBox(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int=1)
        {
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._width = _arg_1;
            this._height = _arg_2;
            this._spinMin = (_arg_3 - (_arg_3 % _arg_5));
            this._spinMax = (_arg_4 - (_arg_3 % _arg_5));
            this._spinStep = _arg_5;
            this._spinAmount = _arg_3;
            this.InitUI();
        }

        public function get EditBox():JTextField
        {
            return (this._spinAmountLbl);
        }

        public function SetStateListener(_arg_1:Function):void
        {
            this._onStateChanged = _arg_1;
        }

        public function GetValue():int
        {
            return (this._spinAmount);
        }

        private function InitUI():void
        {
            setSizeWH(this._width, this._height);
            setPreferredSize(new IntDimension(this._width, this._height));
            setLayout(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            append(this.CreateAmountPanel());
            append(this.CreateSpinBoxPanel());
        }

        private function CreateAmountPanel():JPanel
        {
            var _local_1:JPanel = new JPanel(new CenterLayout());
            _local_1.setPreferredWidth((this._width - 18));
            this._spinAmountLbl = new JTextField(this._spinAmount.toString());
            this._spinAmountLbl.setFont(new ASFont(getFont().getName(), 16, true));
            this.SetText(1);
            this._spinAmountLbl.setPreferredWidth((this._width - 20));
            this._spinAmountLbl.setBorder(new EmptyBorder(null, new Insets(-2)));
            this._spinAmountLbl.setRestrict("0-9");
            this._spinAmountLbl.getTextField().addEventListener(Event.CHANGE, this.OnAmountEdit);
            _local_1.append(this._spinAmountLbl);
            return (_local_1);
        }

        private function CreateSpinBoxPanel():JPanel
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            _local_1.setBorder(new EmptyBorder(null, new Insets(1, 0, 0, 0)));
            var _local_2:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_arrow_top_active");
            AsWingUtil.SetWidth(_local_1, _local_2.width);
            this._spinArrowUp = new CustomButton();
            this._spinArrowUp.setBackgroundDecorator(null);
            this._spinArrowUp.setIcon(new AssetIcon(_local_2));
            AsWingUtil.SetSize(this._spinArrowUp, _local_2.width, _local_2.height);
            this._spinArrowUp.setRollOverIcon(new AssetIcon(this._dataLibrary.GetBitmapAsset("AdditionalData_Item_arrow_top_over")));
            this._spinArrowUp.addActionListener(this.OnUpSpinArrow, 0, true);
            this._timerUp.addEventListener(TimerEvent.TIMER, this.OnUpSpinArrow, false, 0, true);
            this._spinArrowUp.addEventListener(MouseEvent.MOUSE_DOWN, this.OnStartUpTimer);
            this._spinArrowUp.addEventListener(MouseEvent.MOUSE_UP, this.OnStopTimers);
            this._spinArrowUp.addEventListener(MouseEvent.MOUSE_OUT, this.OnStopTimers);
            this._spinArrowDown = new CustomButton();
            this._spinArrowDown.setBackgroundDecorator(null);
            var _local_3:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_arrow_bottom_active");
            AsWingUtil.SetSize(this._spinArrowDown, _local_3.width, _local_3.height);
            this._spinArrowDown.setIcon(new AssetIcon(_local_3));
            this._spinArrowDown.setRollOverIcon(new AssetIcon(this._dataLibrary.GetBitmapAsset("AdditionalData_Item_arrow_bottom_over")));
            this._spinArrowDown.addActionListener(this.OnDownSpinArrow, 0, true);
            this._timerDown.addEventListener(TimerEvent.TIMER, this.OnDownSpinArrow, false, 0, true);
            this._spinArrowDown.addEventListener(MouseEvent.MOUSE_DOWN, this.OnStartDownTimer);
            this._spinArrowDown.addEventListener(MouseEvent.MOUSE_UP, this.OnStopTimers);
            this._spinArrowDown.addEventListener(MouseEvent.MOUSE_OUT, this.OnStopTimers);
            _local_1.appendAll(this._spinArrowUp, this._spinArrowDown);
            return (_local_1);
        }

        private function OnStartUpTimer(_arg_1:Event):void
        {
            if (!this._timerUp.running)
            {
                this._timerUp.delay = AUTO_START_SPIN_DELAY;
                this._timerUp.reset();
                this._timerUp.start();
            };
        }

        private function OnStartDownTimer(_arg_1:Event):void
        {
            if (!this._timerDown.running)
            {
                this._timerDown.delay = AUTO_START_SPIN_DELAY;
                this._timerDown.reset();
                this._timerDown.start();
            };
        }

        private function OnStopTimers(_arg_1:Event):void
        {
            if (this._timerUp.running)
            {
                this._timerUp.stop();
            };
            if (this._timerDown.running)
            {
                this._timerDown.stop();
            };
        }

        private function OnUpSpinArrow(_arg_1:Event):void
        {
            if (this._spinAmount < this._spinMax)
            {
                if (this._timerUp.running)
                {
                    this._timerUp.delay = AUTO_INCREMENT_SPIN_DELAY;
                };
                this._spinAmount = (this._spinAmount + this._spinStep);
                this.SetText(this._spinAmount);
                if (this._onStateChanged != null)
                {
                    this._onStateChanged();
                };
            };
        }

        private function OnDownSpinArrow(_arg_1:Event):void
        {
            if (this._spinAmount > this._spinMin)
            {
                if (this._timerDown.running)
                {
                    this._timerDown.delay = AUTO_INCREMENT_SPIN_DELAY;
                };
                this._spinAmount = (this._spinAmount - this._spinStep);
                this.SetText(this._spinAmount);
                if (this._onStateChanged != null)
                {
                    this._onStateChanged();
                };
            };
        }

        private function OnAmountEdit(_arg_1:Event):void
        {
            var _local_2:int;
            try
            {
                _local_2 = int(this._spinAmountLbl.getText());
                if (_local_2)
                {
                    if (_local_2 < this._spinMin)
                    {
                        this._spinAmount = this._spinMin;
                    }
                    else
                    {
                        if (_local_2 > this._spinMax)
                        {
                            this._spinAmount = this._spinMax;
                        }
                        else
                        {
                            this._spinAmount = _local_2;
                        };
                    };
                    this.SetText(this._spinAmount);
                    if (this._onStateChanged != null)
                    {
                        this._onStateChanged();
                    };
                };
            }
            catch(e:Event)
            {
            };
        }

        private function SetText(_arg_1:int):void
        {
            this._spinAmountLbl.setText(_arg_1.toString());
            var _local_2:TextFormat = this._spinAmountLbl.getTextFormat();
            _local_2.align = "center";
            this._spinAmountLbl.setTextFormat(_local_2);
        }


    }
}//package hbm.Game.GUI.Tools

