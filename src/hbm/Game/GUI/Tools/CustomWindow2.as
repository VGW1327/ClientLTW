


//hbm.Game.GUI.Tools.CustomWindow2

package hbm.Game.GUI.Tools
{
    import org.aswing.JWindow;
    import org.aswing.Container;
    import org.aswing.JPanel;
    import flash.display.Bitmap;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.AssetBackground;
    import org.aswing.BorderLayout;
    import org.aswing.SoftBoxLayout;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import org.aswing.geom.IntPoint;
    import hbm.Engine.Renderer.RenderSystem;

    public class CustomWindow2 extends JWindow 
    {

        private var _container:Container;
        private var _centerHPanel_left:JPanel;
        private var _centerHPanel_center:JPanel;
        private var _centerHPanel_right:JPanel;

        public function CustomWindow2(_arg_1:*=null, _arg_2:Boolean=false, _arg_3:int=100, _arg_4:int=100, _arg_5:Boolean=false)
        {
            var _local_10:Bitmap;
            var _local_12:Bitmap;
            super(_arg_1, _arg_2);
            _arg_3 = (_arg_3 + 10);
            _arg_4 = (_arg_4 + 20);
            var _local_6:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            var _local_7:Bitmap = new WindowSprites.Window2TopLeft();
            var _local_8:Bitmap = new WindowSprites.Window2TopCenter();
            var _local_9:Bitmap = new WindowSprites.Window2TopRight();
            _local_10 = new WindowSprites.Window2CenterLeft();
            var _local_11:Bitmap = new WindowSprites.Window2CenterCenter();
            _local_12 = new WindowSprites.Window2CenterRight();
            var _local_13:Bitmap = new WindowSprites.Window2BottomLeft();
            var _local_14:Bitmap = new WindowSprites.Window2BottomCenter();
            var _local_15:Bitmap = new WindowSprites.Window2BottomRight();
            var _local_16:int = ((_arg_3 + _local_10.width) + _local_12.width);
            setBorder(_local_6);
            var _local_17:JPanel = new JPanel();
            _local_17.setBorder(_local_6);
            _local_17.setBackgroundDecorator(new AssetBackground(_local_7));
            _local_17.setPreferredHeight(_local_7.height);
            _local_17.setPreferredWidth(_local_7.width);
            var _local_18:JPanel = new JPanel(new BorderLayout(0, 0));
            _local_18.setBorder(_local_6);
            _local_18.setBackgroundDecorator(new AssetBackground(_local_8));
            _local_18.setPreferredHeight(_local_8.height);
            _local_18.setPreferredWidth((((_local_16 - _local_7.width) - _local_9.width) + 2));
            var _local_19:JPanel = new JPanel();
            _local_19.setBorder(_local_6);
            _local_19.setBackgroundDecorator(new AssetBackground(_local_9));
            _local_19.setPreferredHeight(_local_9.height);
            _local_19.setPreferredWidth(_local_9.width);
            var _local_20:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_20.setBorder(_local_6);
            _local_20.append(_local_17);
            _local_20.append(_local_18);
            _local_20.append(_local_19);
            this._centerHPanel_left = new JPanel();
            this._centerHPanel_left.setBorder(_local_6);
            this._centerHPanel_left.setBackgroundDecorator(new AssetBackground(_local_10));
            this._centerHPanel_left.setPreferredHeight(_arg_4);
            this._centerHPanel_left.setPreferredWidth(_local_10.width);
            this._centerHPanel_center = new JPanel(new BorderLayout(0, 0));
            this._centerHPanel_center.setBorder(_local_6);
            this._centerHPanel_center.setBackgroundDecorator(new AssetBackground(_local_11));
            this._centerHPanel_center.setPreferredHeight(_arg_4);
            this._centerHPanel_center.setPreferredWidth((_arg_3 + 2));
            this._centerHPanel_right = new JPanel();
            this._centerHPanel_right.setBorder(_local_6);
            this._centerHPanel_right.setBackgroundDecorator(new AssetBackground(_local_12));
            this._centerHPanel_right.setPreferredHeight(_arg_4);
            this._centerHPanel_right.setPreferredWidth(_local_12.width);
            var _local_21:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_21.setBorder(_local_6);
            _local_21.append(this._centerHPanel_left);
            _local_21.append(this._centerHPanel_center);
            _local_21.append(this._centerHPanel_right);
            var _local_22:JPanel = new JPanel();
            _local_22.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            _local_22.setBackgroundDecorator(new AssetBackground(_local_13));
            _local_22.setPreferredHeight(_local_13.height);
            _local_22.setPreferredWidth(_local_13.width);
            var _local_23:JPanel = new JPanel();
            _local_23.setBorder(_local_6);
            _local_23.setBackgroundDecorator(new AssetBackground(_local_14));
            _local_23.setPreferredHeight(_local_14.height);
            _local_23.setPreferredWidth((((_local_16 - _local_13.width) - _local_15.width) + 2));
            var _local_24:JPanel = new JPanel();
            _local_24.setBorder(_local_6);
            _local_24.setBackgroundDecorator(new AssetBackground(_local_15));
            _local_24.setPreferredHeight(_local_15.height);
            _local_24.setPreferredWidth(_local_15.width);
            var _local_25:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_25.setBorder(_local_6);
            _local_25.append(_local_22);
            _local_25.append(_local_23);
            _local_25.append(_local_24);
            this._container = getContentPane();
            this._container.append(_local_20, BorderLayout.PAGE_START);
            this._container.append(_local_21, BorderLayout.CENTER);
            this._container.append(_local_25, BorderLayout.PAGE_END);
            pack();
            setLocationXY(150, 150);
            addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
            _local_17.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown, false, 0, true);
            _local_17.addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
            _local_18.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown, false, 0, true);
            _local_18.addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
            _local_19.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown, false, 0, true);
            _local_19.addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
        }

        private function OnMouseDown(_arg_1:Event):void
        {
            startDrag(false, new Rectangle(0, 0, (stage.stageWidth - this._container.width), (stage.stageHeight - this._container.height)));
        }

        private function OnMouseUp(_arg_1:Event):void
        {
            stopDrag();
        }

        public function get MainPanel():JPanel
        {
            return (this._centerHPanel_center);
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
            super.dispose();
        }


    }
}//package hbm.Game.GUI.Tools

