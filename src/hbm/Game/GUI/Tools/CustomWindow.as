


//hbm.Game.GUI.Tools.CustomWindow

package hbm.Game.GUI.Tools
{
    import org.aswing.JWindow;
    import org.aswing.Container;
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import hbm.Game.Music.Music;
    import flash.display.Bitmap;
    import org.aswing.ASFont;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.SoftBoxLayout;
    import org.aswing.AssetBackground;
    import org.aswing.BorderLayout;
    import org.aswing.ASColor;
    import org.aswing.EmptyLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.geom.IntPoint;
    import org.aswing.AssetIcon;
    import org.aswing.StyleTune;
    import hbm.Application.ClientApplication;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import hbm.Engine.Renderer.RenderSystem;

    public class CustomWindow extends JWindow 
    {

        public static const CUSTOM_WINDOW_CLOSED:String = "CUSTOM_WINDOW_CLOSED";

        private var _container:Container;
        private var _centerHPanel_center:JPanel;
        private var _closeWindowButton:CustomButton;
        private var _headerLabel:JLabel;
        private var _onWindowShowSound:Object = Music.MenuZoomInSound;
        private var _onwindowDisposeSound:Object = Music.MenuZoomOutSound;

        public function CustomWindow(_arg_1:*=null, _arg_2:String=null, _arg_3:Boolean=false, _arg_4:int=100, _arg_5:int=100, _arg_6:Boolean=false, _arg_7:Boolean=true)
        {
            var _local_12:Bitmap;
            var _local_14:Bitmap;
            var _local_28:ASFont;
            var _local_41:JPanel;
            var _local_42:JPanel;
            var _local_43:JPanel;
            var _local_44:JPanel;
            var _local_45:JPanel;
            var _local_46:JPanel;
            super(_arg_1, _arg_3);
            _arg_4 = (_arg_4 + 10);
            _arg_5 = (_arg_5 + 20);
            var _local_8:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            var _local_9:Bitmap = new WindowSprites.WindowTopLeft();
            var _local_10:Bitmap = new WindowSprites.WindowTopCenter();
            var _local_11:Bitmap = new WindowSprites.WindowTopRight();
            _local_12 = new WindowSprites.WindowCenterLeft();
            var _local_13:Bitmap = new WindowSprites.WindowCenterCenter();
            _local_14 = new WindowSprites.WindowCenterRight();
            var _local_15:Bitmap = new WindowSprites.WindowBottomLeft();
            var _local_16:Bitmap = new WindowSprites.WindowBottomCenter();
            var _local_17:Bitmap = new WindowSprites.WindowBottomRight();
            var _local_18:Bitmap = new WindowSprites.WindowBottomCenterBorderLeft();
            var _local_19:Bitmap = new WindowSprites.WindowBottomCenterBorderRight();
            var _local_20:Bitmap = new WindowSprites.WindowCenterLeftBorderBottom();
            var _local_21:Bitmap = new WindowSprites.WindowCenterLeftBorderTop();
            var _local_22:Bitmap = new WindowSprites.WindowCenterRightBorderBottom();
            var _local_23:Bitmap = new WindowSprites.WindowCenterRightBorderTop();
            var _local_24:int = ((_arg_4 + _local_12.width) + _local_14.width);
            setBorder(_local_8);
            var _local_25:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_25.setBorder(_local_8);
            var _local_26:JPanel = new JPanel();
            _local_26.setBorder(_local_8);
            _local_26.setBackgroundDecorator(new AssetBackground(_local_9));
            _local_26.setPreferredHeight(_local_9.height);
            _local_26.setPreferredWidth(_local_9.width);
            var _local_27:JPanel = new JPanel(new BorderLayout(0, 0));
            _local_27.setBorder(_local_8);
            _local_27.setBackgroundDecorator(new AssetBackground(_local_10));
            _local_27.setPreferredHeight(_local_10.height);
            _local_27.setPreferredWidth((((_local_24 - _local_9.width) - _local_11.width) + 2));
            this._headerLabel = new JLabel(_arg_2, null, JLabel.CENTER);
            _local_28 = this._headerLabel.getFont();
            var _local_29:ASFont = new ASFont(_local_28.getName(), 14, false);
            this._headerLabel.setFont(_local_29);
            this._headerLabel.setForeground(new ASColor(16767612));
            _local_27.append(this._headerLabel, BorderLayout.CENTER);
            var _local_30:JPanel = new JPanel(new BorderLayout(0, 0));
            _local_30.setBorder(_local_8);
            _local_30.setBackgroundDecorator(new AssetBackground(_local_11));
            _local_30.setPreferredHeight(_local_11.height);
            _local_30.setPreferredWidth(_local_11.width);
            _local_25.append(_local_26);
            _local_25.append(_local_27);
            _local_25.append(_local_30);
            var _local_31:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_31.setBorder(_local_8);
            var _local_32:JPanel = new JPanel(new EmptyLayout());
            _local_32.setBorder(_local_8);
            _local_32.setBackgroundDecorator(new AssetBackground(_local_12));
            _local_32.setPreferredHeight(_arg_5);
            _local_32.setPreferredWidth(_local_12.width);
            if (_arg_7)
            {
                _local_41 = new JPanel(new SoftBoxLayout());
                _local_41.setBorder(_local_8);
                _local_41.setBackgroundDecorator(new AssetBackground(_local_21));
                _local_41.setSize(new IntDimension(_local_21.width, _local_21.height));
                _local_41.setLocation(new IntPoint(0, ((_arg_5 * 0.2) - _local_21.height)));
                _local_42 = new JPanel(new SoftBoxLayout());
                _local_42.setBorder(_local_8);
                _local_42.setBackgroundDecorator(new AssetBackground(_local_20));
                _local_42.setSize(new IntDimension(_local_21.width, _local_21.height));
                _local_42.setLocation(new IntPoint(0, (_arg_5 * 0.75)));
                _local_32.append(_local_41);
                _local_32.append(_local_42);
            };
            this._centerHPanel_center = new JPanel(new BorderLayout(0, 0));
            this._centerHPanel_center.setBorder(_local_8);
            this._centerHPanel_center.setBackgroundDecorator(new AssetBackground(_local_13));
            this._centerHPanel_center.setPreferredHeight(_arg_5);
            this._centerHPanel_center.setPreferredWidth((_arg_4 + 2));
            var _local_33:JPanel = new JPanel(new EmptyLayout());
            _local_33.setBorder(_local_8);
            _local_33.setBackgroundDecorator(new AssetBackground(_local_14));
            _local_33.setPreferredHeight(_arg_5);
            _local_33.setPreferredWidth(_local_14.width);
            if (_arg_7)
            {
                _local_43 = new JPanel(new SoftBoxLayout());
                _local_43.setBorder(_local_8);
                _local_43.setBackgroundDecorator(new AssetBackground(_local_23));
                _local_43.setSize(new IntDimension(_local_23.width, _local_23.height));
                _local_43.setLocation(new IntPoint(0, ((_arg_5 * 0.2) - _local_23.height)));
                _local_44 = new JPanel(new SoftBoxLayout());
                _local_44.setBorder(_local_8);
                _local_44.setBackgroundDecorator(new AssetBackground(_local_22));
                _local_44.setSize(new IntDimension(_local_23.width, _local_23.height));
                _local_44.setLocation(new IntPoint(0, (_arg_5 * 0.75)));
                _local_33.append(_local_43);
                _local_33.append(_local_44);
            };
            _local_31.append(_local_32);
            _local_31.append(this._centerHPanel_center);
            _local_31.append(_local_33);
            var _local_34:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_34.setBorder(_local_8);
            var _local_35:JPanel = new JPanel();
            _local_35.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            _local_35.setBackgroundDecorator(new AssetBackground(_local_15));
            _local_35.setPreferredHeight(_local_15.height);
            _local_35.setPreferredWidth(_local_15.width);
            var _local_36:JPanel = new JPanel(new EmptyLayout());
            _local_36.setBorder(_local_8);
            _local_36.setBackgroundDecorator(new AssetBackground(_local_16));
            _local_36.setPreferredHeight(_local_16.height);
            _local_36.setPreferredWidth((((_local_24 - _local_15.width) - _local_17.width) + 2));
            if (_arg_7)
            {
                _local_45 = new JPanel(new SoftBoxLayout());
                _local_45.setBorder(_local_8);
                _local_45.setBackgroundDecorator(new AssetBackground(_local_18));
                _local_45.setSize(new IntDimension(_local_18.width, _local_18.height));
                _local_45.setLocation(new IntPoint(((_arg_4 * 0.25) - _local_18.width), 0));
                _local_46 = new JPanel(new SoftBoxLayout());
                _local_46.setBorder(_local_8);
                _local_46.setBackgroundDecorator(new AssetBackground(_local_19));
                _local_46.setSize(new IntDimension(_local_19.width, _local_19.height));
                _local_46.setLocation(new IntPoint((_arg_4 * 0.75), 0));
                _local_36.append(_local_45);
                _local_36.append(_local_46);
            };
            var _local_37:JPanel = new JPanel();
            _local_37.setBorder(_local_8);
            _local_37.setBackgroundDecorator(new AssetBackground(_local_17));
            _local_37.setPreferredHeight(_local_17.height);
            _local_37.setPreferredWidth(_local_17.width);
            _local_34.append(_local_35);
            _local_34.append(_local_36);
            _local_34.append(_local_37);
            this._closeWindowButton = new CustomButton(null);
            var _local_38:Bitmap = new WindowSprites.WindowCloseButton();
            var _local_39:Bitmap = new WindowSprites.WindowCloseButtonSelected();
            var _local_40:Bitmap = new WindowSprites.WindowCloseButtonPressed();
            this._closeWindowButton.setIcon(new AssetIcon(_local_38));
            this._closeWindowButton.setRollOverIcon(new AssetIcon(_local_39));
            this._closeWindowButton.setPressedIcon(new AssetIcon(_local_40));
            this._closeWindowButton.setStyleTune(new StyleTune(0.18, 0.05, 0.2, 0.2, 20));
            this._closeWindowButton.setPreferredWidth(35);
            this._closeWindowButton.setPreferredHeight(35);
            this._closeWindowButton.setBackgroundDecorator(null);
            this._closeWindowButton.addActionListener(this.OnClosePressed, 0, true);
            _local_30.append(this._closeWindowButton, BorderLayout.LINE_END);
            this._closeWindowButton.visible = _arg_6;
            this._closeWindowButton.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            this._container = getContentPane();
            this._container.append(_local_25, BorderLayout.PAGE_START);
            this._container.append(_local_31, BorderLayout.CENTER);
            this._container.append(_local_34, BorderLayout.PAGE_END);
            pack();
            setLocationXY(150, 150);
            addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
            _local_26.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown, false, 0, true);
            _local_26.addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
            _local_27.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown, false, 0, true);
            _local_27.addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
        }

        private function OnMouseDown(_arg_1:Event):void
        {
            startDrag(false, new Rectangle(0, 0, (stage.stageWidth - this._container.width), (stage.stageHeight - this._container.height)));
        }

        private function OnMouseUp(_arg_1:Event):void
        {
            stopDrag();
        }

        private function OnClosePressed(_arg_1:Event):void
        {
            dispatchEvent(new Event(CUSTOM_WINDOW_CLOSED));
            this.dispose();
        }

        public function get MainPanel():JPanel
        {
            return (this._centerHPanel_center);
        }

        public function SetClosable(_arg_1:Boolean):void
        {
            this._closeWindowButton.visible = _arg_1;
        }

        public function get CloseButton():CustomButton
        {
            return (this._closeWindowButton);
        }

        public function SetTitle(_arg_1:String):void
        {
            this._headerLabel.setText(_arg_1);
        }

        override public function show():void
        {
            var _local_1:Rectangle;
            var _local_2:IntPoint;
            var _local_3:Rectangle;
            if (ClientApplication.Instance.GameSettings.IsPlaySoundsEnabled)
            {
                Music.Instance.PlaySound(this._onWindowShowSound);
            };
            super.show();
            if (stage)
            {
                stage.addEventListener(Event.MOUSE_LEAVE, this.OnMouseUp, false, 0, true);
                this._container.pack();
                _local_1 = new Rectangle(0, 0, this._container.width, this._container.height);
                _local_2 = getLocation();
                _local_1.offset(_local_2.x, _local_2.y);
                if (RenderSystem.Instance.ScreenWidth < stage.width)
                {
                    _local_3 = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
                }
                else
                {
                    _local_3 = new Rectangle(0, 0, RenderSystem.Instance.ScreenWidth, RenderSystem.Instance.ScreenHeight);
                };
                if (!_local_3.containsRect(_local_1))
                {
                    setLocationXY(Math.max(0, ((_local_3.width - _local_1.width) / 2)), Math.max(0, ((_local_3.height - _local_1.height) / 2)));
                };
            };
        }

        override public function dispose():void
        {
            if (stage)
            {
                stage.removeEventListener(Event.MOUSE_LEAVE, this.OnMouseUp);
            };
            if (ClientApplication.Instance.GameSettings.IsPlaySoundsEnabled)
            {
                Music.Instance.PlaySound(this._onwindowDisposeSound);
            };
            super.dispose();
        }

        public function set OnShowSound(_arg_1:Object):void
        {
            this._onWindowShowSound = _arg_1;
        }

        public function set OnDisposeSound(_arg_1:Object):void
        {
            this._onwindowDisposeSound = _arg_1;
        }


    }
}//package hbm.Game.GUI.Tools

