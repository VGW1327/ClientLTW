


//hbm.Game.GUI.CashShopNew.WindowPrototype

package hbm.Game.GUI.CashShopNew
{
    import org.aswing.JWindow;
    import org.aswing.Container;
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import flash.display.Bitmap;
    import org.aswing.SoftBoxLayout;
    import org.aswing.AssetBackground;
    import org.aswing.BorderLayout;
    import org.aswing.AssetIcon;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Application.ClientApplication;
    import flash.events.MouseEvent;
    import org.aswing.ASFont;
    import org.aswing.CenterLayout;
    import org.aswing.ASColor;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import org.aswing.geom.IntPoint;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Game.Music.Music;
    import org.aswing.*;
    import org.aswing.border.*;

    public class WindowPrototype extends JWindow 
    {

        public static const CUSTOM_WINDOW_CLOSED:String = "CUSTOM_WINDOW_CLOSED";

        protected var _container:Container;
        protected var _closeWindowButton:ButtonPrototype;
        protected var _closeWindowButton2:ButtonPrototype;
        protected var _bodyArea:JPanel;
        protected var _header:JPanel = null;
        protected var _body:JPanel = null;
        protected var _bottom:JPanel = null;
        private var _windowTitleLabel:JLabel;
        protected var _width:int;
        protected var _height:int;
        protected var _title:String = null;
        protected var _closable:Boolean;
        protected var _needTopPanel:Boolean;

        public function WindowPrototype(_arg_1:*=null, _arg_2:String=null, _arg_3:Boolean=false, _arg_4:int=100, _arg_5:int=100, _arg_6:Boolean=true, _arg_7:Boolean=true)
        {
            super(_arg_1, _arg_3);
            Assets.Init();
            this._windowTitleLabel = new JLabel(_arg_2);
            this._container = getContentPane();
            this._width = _arg_4;
            this._height = _arg_5;
            this._title = _arg_2;
            this._closable = _arg_6;
            this._needTopPanel = _arg_7;
            this.InitUI();
            this.show();
        }

        protected function InitUI():void
        {
            var _local_22:Bitmap;
            var _local_23:Bitmap;
            var _local_24:Bitmap;
            var _local_25:JPanel;
            var _local_26:JPanel;
            var _local_27:JPanel;
            var _local_28:Bitmap;
            var _local_29:Bitmap;
            setSizeWH(this._width, this._height);
            this._container.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            var _local_1:Bitmap = Assets.TopLeft();
            var _local_2:Bitmap = Assets.Top();
            var _local_3:Bitmap = ((this._closable) ? Assets.TopRight() : Assets.TopRightNoClose());
            var _local_4:Bitmap = Assets.TopLeft2();
            var _local_5:Bitmap = ((this._closable) ? Assets.TopRight2() : Assets.TopRight2NoClose());
            var _local_6:Bitmap = Assets.LeftBorder();
            var _local_7:Bitmap = Assets.RightBorder();
            var _local_8:Bitmap = Assets.BottomLeft();
            var _local_9:Bitmap = Assets.Bottom();
            var _local_10:Bitmap = Assets.BottomRight();
            var _local_11:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            var _local_12:JPanel = new JPanel();
            _local_12.setPreferredWidth(_local_1.width);
            _local_12.setPreferredHeight(_local_1.height);
            _local_12.setBackgroundDecorator(new AssetBackground(_local_1));
            _local_11.append(_local_12);
            var _local_13:Number = (this.width - (_local_1.width + _local_3.width));
            var _local_14:JPanel = new JPanel(new BorderLayout());
            _local_14.setPreferredWidth(_local_13);
            _local_14.setPreferredHeight(_local_2.height);
            _local_14.setBackgroundDecorator(new AssetBackground(_local_2));
            _local_11.append(_local_14);
            this.TitleBuilder(_local_14);
            var _local_15:JPanel = new JPanel(new BorderLayout());
            _local_15.setPreferredWidth(_local_3.width);
            _local_15.setPreferredHeight(_local_3.height);
            _local_15.setBackgroundDecorator(new AssetBackground(_local_3));
            _local_11.append(_local_15);
            if (this._closable)
            {
                this._closeWindowButton = new ButtonPrototype(null);
                _local_22 = Assets.CloseButton();
                _local_23 = Assets.CloseButtonOver();
                _local_24 = Assets.CloseButtonPressed();
                this._closeWindowButton.setIcon(new AssetIcon(_local_22));
                this._closeWindowButton.setRollOverIcon(new AssetIcon(_local_23));
                this._closeWindowButton.setPressedIcon(new AssetIcon(_local_24));
                this._closeWindowButton.setSizeWH(21, 21);
                this._closeWindowButton.setBackgroundDecorator(null);
                this._closeWindowButton.setBorder(new EmptyBorder(null, new Insets(16, 0, 0, 15)));
                this._closeWindowButton.addActionListener(this.OnClosePressed, 0, true);
                _local_15.append(this._closeWindowButton, BorderLayout.LINE_END);
            };
            if (this._needTopPanel)
            {
                _local_25 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
                _local_26 = new JPanel();
                _local_26.setPreferredWidth(_local_4.width);
                _local_26.setPreferredHeight(_local_4.height);
                _local_26.setBackgroundDecorator(new AssetBackground(_local_4));
                _local_25.append(_local_26);
                _local_13 = (this.width - (_local_4.width + _local_5.width));
                this._header = new JPanel();
                this._header.setPreferredWidth(_local_13);
                this._header.setPreferredHeight(_local_4.height);
                this._header.setBackgroundDecorator(new AssetBackground(Assets.HeaderBack()));
                _local_25.append(this._header);
                _local_27 = new JPanel();
                _local_27.setPreferredWidth(_local_5.width);
                _local_27.setPreferredHeight(_local_5.height);
                _local_27.setBackgroundDecorator(new AssetBackground(_local_5));
                _local_25.append(_local_27);
            };
            this._bodyArea = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            var _local_16:JPanel = new JPanel();
            _local_16.setPreferredWidth(_local_6.width);
            _local_16.setPreferredHeight(_local_6.height);
            _local_16.setBackgroundDecorator(new AssetBackground(_local_6));
            this._bodyArea.append(_local_16);
            this._body = new JPanel();
            _local_13 = ((this.width - ((_local_6.width + _local_7.width) + 5)) + ((this._closable) ? 0 : 1));
            var _local_17:Number = (this.height - ((_local_8.height + _local_1.height) + _local_4.height));
            this._body.setPreferredWidth(_local_13);
            this._body.setPreferredHeight(_local_17);
            this._body.width = _local_13;
            this._body.height = _local_17;
            this._body.setBackgroundDecorator(new AssetBackground(Assets.Background()));
            this._bodyArea.append(this._body);
            var _local_18:JPanel = new JPanel();
            _local_18.setPreferredWidth(_local_7.width);
            _local_18.setPreferredHeight(_local_7.height);
            _local_18.setBackgroundDecorator(new AssetBackground(_local_7));
            this._bodyArea.append(_local_18);
            var _local_19:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            var _local_20:JPanel = new JPanel();
            _local_20.setPreferredWidth(_local_8.width);
            _local_20.setPreferredHeight(_local_8.height);
            _local_20.setBackgroundDecorator(new AssetBackground(_local_8));
            _local_19.append(_local_20);
            _local_13 = ((this.width - (_local_8.width + _local_10.width)) + ((this._closable) ? 0 : 1));
            this._bottom = new JPanel(new BorderLayout());
            this._bottom.setPreferredWidth(_local_13);
            this._bottom.setPreferredHeight(_local_9.height);
            this._bottom.setBackgroundDecorator(new AssetBackground(_local_9));
            _local_19.append(this._bottom);
            var _local_21:JPanel = new JPanel();
            _local_21.setPreferredWidth(_local_10.width);
            _local_21.setPreferredHeight(_local_10.height);
            _local_21.setBackgroundDecorator(new AssetBackground(_local_10));
            _local_19.append(_local_21);
            if (this._closable)
            {
                this._closeWindowButton2 = new ButtonPrototype(ClientApplication.Localization.BUTTON_CLOSE);
                _local_28 = Assets.BottomCloseButton();
                _local_29 = Assets.BottomCloseButtonOver();
                this._closeWindowButton2.setIconTextGap(-70);
                this._closeWindowButton2.setIcon(new AssetIcon(_local_28));
                this._closeWindowButton2.setRollOverIcon(new AssetIcon(_local_29));
                this._closeWindowButton2.setSizeWH(_local_28.width, _local_28.height);
                this._closeWindowButton2.setBackgroundDecorator(null);
                this._closeWindowButton2.addActionListener(this.OnClosePressed, 0, true);
                this._bottom.append(this._closeWindowButton2, BorderLayout.LINE_END);
            };
            this._container.append(_local_11);
            if (this._needTopPanel)
            {
                this._container.append(_local_25);
            };
            this._container.append(this._bodyArea);
            this._container.append(_local_19);
            _local_11.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown, false, 0, true);
            _local_11.addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
            addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
        }

        protected function TitleBuilder(_arg_1:JPanel):void
        {
            var _local_4:ASFont;
            if (this._title == null)
            {
                return;
            };
            _arg_1.setLayout(new CenterLayout());
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.CENTER));
            _local_2.setBorder(new EmptyBorder(null, new Insets(0, 13)));
            var _local_3:JPanel = new JPanel();
            _local_3.setBackgroundDecorator(new AssetBackground(Assets.Clapboard()));
            _local_3.setPreferredWidth(12);
            _local_3.setBorder(new EmptyBorder(null, new Insets(5, 0, 3, 0)));
            _local_2.append(_local_3);
            _local_4 = getFont();
            var _local_5:ASFont = new ASFont(_local_4.getName(), 14, false);
            this._windowTitleLabel.setFont(_local_5);
            this._windowTitleLabel.setForeground(new ASColor(16772788));
            _local_2.append(this._windowTitleLabel);
            var _local_6:JPanel = new JPanel();
            _local_6.setBackgroundDecorator(new AssetBackground(Assets.Clapboard()));
            _local_6.setPreferredWidth(12);
            _local_6.setBorder(new EmptyBorder(null, new Insets(5, 0, 3, 0)));
            _local_2.append(_local_6);
            _arg_1.append(_local_2);
        }

        protected function OnMouseDown(_arg_1:Event):void
        {
            startDrag(false, new Rectangle(0, 0, (stage.stageWidth - this._container.width), (stage.stageHeight - this._container.height)));
        }

        protected function OnMouseUp(_arg_1:Event):void
        {
            stopDrag();
        }

        protected function OnClosePressed(_arg_1:Event):void
        {
            dispatchEvent(new Event(CUSTOM_WINDOW_CLOSED));
            this.dispose();
        }

        override public function show():void
        {
            var _local_1:Rectangle;
            var _local_2:IntPoint;
            var _local_3:Rectangle;
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
                Music.Instance.PlaySound(Music.MenuZoomOutSound);
            };
            super.dispose();
        }

        protected function get Top():Container
        {
            return (this._header);
        }

        protected function get Body():Container
        {
            return (this._body);
        }

        protected function get Bottom():Container
        {
            return (this._bottom);
        }

        public function SetWindowTitle(_arg_1:String):void
        {
            this._windowTitleLabel.setText(_arg_1);
        }


    }
}//package hbm.Game.GUI.CashShopNew

