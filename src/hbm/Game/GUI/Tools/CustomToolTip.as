


//hbm.Game.GUI.Tools.CustomToolTip

package hbm.Game.GUI.Tools
{
    import org.aswing.JToolTip;
    import org.aswing.JPanel;
    import flash.display.Bitmap;
    import org.aswing.border.EmptyBorder;
    import org.aswing.JTextArea;
    import org.aswing.Insets;
    import org.aswing.AssetBackground;
    import org.aswing.BorderLayout;
    import org.aswing.SoftBoxLayout;
    import org.aswing.Component;
    import flash.display.InteractiveObject;

    public class CustomToolTip extends JToolTip 
    {

        private var _centerHPanel_left:JPanel;
        private var _centerHPanel_center:JPanel;
        private var _centerHPanel_right:JPanel;
        private var _component:Object;

        public function CustomToolTip(_arg_1:InteractiveObject=null, _arg_2:Object=null, _arg_3:int=-1, _arg_4:int=-1, _arg_5:Boolean=true)
        {
            var _local_9:Bitmap;
            var _local_11:Bitmap;
            var _local_16:EmptyBorder;
            var _local_26:String;
            var _local_27:JTextArea;
            super();
            if (_arg_2 == null)
            {
                disposeToolTip();
                setTipText(null);
                setTargetComponent(null);
                return;
            };
            if (_arg_3 <= 0)
            {
                _arg_3 = 100;
            };
            if (((_arg_2) && (_arg_2 is String)))
            {
                _local_26 = (_arg_2 as String);
                _local_27 = new JTextArea();
                _local_27.setBorder(new EmptyBorder(null, new Insets(4, 4, 0, 4)));
                _local_27.setHtmlText(_local_26);
                _local_27.setEditable(false);
                _local_27.setWordWrap(true);
                _local_27.setBackgroundDecorator(null);
                _local_27.getTextField().selectable = false;
                if (_arg_5)
                {
                    _local_27.getTextField().width = _arg_3;
                    _arg_3 = (_local_27.getTextField().textWidth + 8);
                    _arg_4 = (_local_27.getTextField().textHeight + 16);
                };
                this._component = _local_27;
            }
            else
            {
                this._component = _arg_2;
                if (_arg_4 <= 0)
                {
                    if (this._component)
                    {
                        _arg_4 = this._component.height;
                    };
                    if (_arg_4 <= 0)
                    {
                        _arg_4 = 100;
                    };
                };
                if (_arg_3 <= 0)
                {
                    if (this._component)
                    {
                        _arg_3 = this._component.width;
                    };
                    if (_arg_3 <= 0)
                    {
                        _arg_3 = 100;
                    };
                };
            };
            _arg_3 = (_arg_3 + 10);
            setTipText("foo");
            removeAll();
            setBackgroundDecorator(null);
            setBorder(_local_16);
            var _local_6:Bitmap = new WindowSprites.TooltipTopLeft();
            var _local_7:Bitmap = new WindowSprites.TooltipTopCenter();
            var _local_8:Bitmap = new WindowSprites.TooltipTopRight();
            _local_9 = new WindowSprites.TooltipCenterLeft();
            var _local_10:Bitmap = new WindowSprites.TooltipCenterCenter();
            _local_11 = new WindowSprites.TooltipCenterRight();
            var _local_12:Bitmap = new WindowSprites.TooltipBottomLeft();
            var _local_13:Bitmap = new WindowSprites.TooltipBottomCenter();
            var _local_14:Bitmap = new WindowSprites.TooltipBottomRight();
            var _local_15:int = ((_arg_3 + _local_9.width) + _local_11.width);
            _local_16 = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            var _local_17:JPanel = new JPanel();
            _local_17.setBorder(_local_16);
            _local_17.setBackgroundDecorator(new AssetBackground(_local_6));
            _local_17.setPreferredHeight(_local_6.height);
            _local_17.setPreferredWidth(_local_6.width);
            var _local_18:JPanel = new JPanel(new BorderLayout(0, 0));
            _local_18.setBorder(_local_16);
            _local_18.setBackgroundDecorator(new AssetBackground(_local_7));
            _local_18.setPreferredHeight(_local_7.height);
            _local_18.setPreferredWidth((((_local_15 - _local_6.width) - _local_8.width) + 2));
            var _local_19:JPanel = new JPanel();
            _local_19.setBorder(_local_16);
            _local_19.setBackgroundDecorator(new AssetBackground(_local_8));
            _local_19.setPreferredHeight(_local_8.height);
            _local_19.setPreferredWidth(_local_8.width);
            var _local_20:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_20.setBorder(_local_16);
            _local_20.append(_local_17);
            _local_20.append(_local_18);
            _local_20.append(_local_19);
            this._centerHPanel_left = new JPanel();
            this._centerHPanel_left.setBorder(_local_16);
            this._centerHPanel_left.setBackgroundDecorator(new AssetBackground(_local_9));
            this._centerHPanel_left.setPreferredHeight(_arg_4);
            this._centerHPanel_left.setPreferredWidth(_local_9.width);
            this._centerHPanel_center = new JPanel(new BorderLayout(0, 0));
            this._centerHPanel_center.setBorder(_local_16);
            this._centerHPanel_center.setBackgroundDecorator(new AssetBackground(_local_10));
            this._centerHPanel_center.setPreferredHeight(_arg_4);
            this._centerHPanel_center.setPreferredWidth((_arg_3 + 2));
            this._centerHPanel_right = new JPanel();
            this._centerHPanel_right.setBorder(_local_16);
            this._centerHPanel_right.setBackgroundDecorator(new AssetBackground(_local_11));
            this._centerHPanel_right.setPreferredHeight(_arg_4);
            this._centerHPanel_right.setPreferredWidth(_local_11.width);
            if (this._component)
            {
                this._centerHPanel_center.append((this._component as org.aswing.Component));
            };
            var _local_21:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_21.setBorder(_local_16);
            _local_21.append(this._centerHPanel_left);
            _local_21.append(this._centerHPanel_center);
            _local_21.append(this._centerHPanel_right);
            var _local_22:JPanel = new JPanel();
            _local_22.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            _local_22.setBackgroundDecorator(new AssetBackground(_local_12));
            _local_22.setPreferredHeight(_local_12.height);
            _local_22.setPreferredWidth(_local_12.width);
            var _local_23:JPanel = new JPanel();
            _local_23.setBorder(_local_16);
            _local_23.setBackgroundDecorator(new AssetBackground(_local_13));
            _local_23.setPreferredHeight(_local_13.height);
            _local_23.setPreferredWidth((((_local_15 - _local_12.width) - _local_14.width) + 2));
            var _local_24:JPanel = new JPanel();
            _local_24.setBorder(_local_16);
            _local_24.setBackgroundDecorator(new AssetBackground(_local_14));
            _local_24.setPreferredHeight(_local_14.height);
            _local_24.setPreferredWidth(_local_14.width);
            var _local_25:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_25.setBorder(_local_16);
            _local_25.append(_local_22);
            _local_25.append(_local_23);
            _local_25.append(_local_24);
            setLayout(new BorderLayout());
            append(_local_20, BorderLayout.PAGE_START);
            append(_local_21, BorderLayout.CENTER);
            append(_local_25, BorderLayout.PAGE_END);
            if (_arg_1)
            {
                setTargetComponent(_arg_1);
            };
        }

        public function get Component():Object
        {
            return (this._component);
        }

        public function updateToolTip(_arg_1:String, _arg_2:int=-1):void
        {
            var _local_3:JTextArea;
            if (this._component == null)
            {
                setTipText(null);
                setTargetComponent(null);
                return;
            };
            if (((this._component) && (this._component is JTextArea)))
            {
                _local_3 = (this._component as JTextArea);
                _local_3.setHtmlText(_arg_1);
            };
            if (_arg_2 > 0)
            {
                this._centerHPanel_left.setPreferredHeight(_arg_2);
                this._centerHPanel_center.setPreferredHeight(_arg_2);
                this._centerHPanel_right.setPreferredHeight(_arg_2);
            };
        }

        public function Dispose():void
        {
            disposeToolTip();
            setTipText(null);
            setTargetComponent(null);
        }


    }
}//package hbm.Game.GUI.Tools

