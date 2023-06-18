


//hbm.Game.GUI.Tools.CustomBookWindow

package hbm.Game.GUI.Tools
{
    import org.aswing.JWindow;
    import org.aswing.Container;
    import org.aswing.JPanel;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import flash.display.Bitmap;
    import org.aswing.SoftBoxLayout;
    import org.aswing.BorderLayout;
    import org.aswing.AssetBackground;
    import org.aswing.EmptyLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.geom.IntPoint;
    import org.aswing.AssetIcon;
    import org.aswing.StyleTune;
    import hbm.Application.ClientApplication;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.events.Event;

    public class CustomBookWindow extends JWindow 
    {

        public static const CUSTOM_WINDOW_CLOSED:String = "CUSTOM_WINDOW_CLOSED";

        private var _container:Container;
        private var _centerContentPanel:JPanel;
        private var _closeWindowButton:CustomButton;

        public function CustomBookWindow(_arg_1:*=null, _arg_2:String=null, _arg_3:Boolean=false, _arg_4:Boolean=false, _arg_5:Boolean=true)
        {
            super(_arg_1, _arg_3);
            var _local_6:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            var _local_7:Bitmap = new WindowSprites.BookWindowTopLeft();
            var _local_8:Bitmap = new WindowSprites.BookWindowTopRight();
            var _local_9:Bitmap = new WindowSprites.BookWindowCenterLeft();
            var _local_10:Bitmap = new WindowSprites.BookWindowCenterCenter();
            var _local_11:Bitmap = new WindowSprites.BookWindowCenterRight();
            var _local_12:Bitmap = new WindowSprites.BookWindowBottom();
            setBorder(_local_6);
            var _local_13:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_13.setBorder(_local_6);
            var _local_14:JPanel = new JPanel(new BorderLayout(0, 0));
            _local_14.setBorder(_local_6);
            _local_14.setBackgroundDecorator(new AssetBackground(_local_7));
            _local_14.setPreferredHeight(_local_7.height);
            _local_14.setPreferredWidth(_local_7.width);
            var _local_15:JPanel = new JPanel(new BorderLayout(0, 0));
            _local_15.setBorder(_local_6);
            _local_15.setBackgroundDecorator(new AssetBackground(_local_8));
            _local_15.setPreferredHeight(_local_8.height);
            _local_15.setPreferredWidth(_local_8.width);
            _local_13.append(_local_14);
            _local_13.append(_local_15);
            var _local_16:JPanel = new JPanel(new EmptyLayout());
            _local_16.setBorder(_local_6);
            _local_16.setBackgroundDecorator(new AssetBackground(_local_9));
            _local_16.setPreferredHeight(_local_9.height);
            _local_16.setPreferredWidth(_local_9.width);
            var _local_17:JPanel = new JPanel(new BorderLayout(0, 0));
            _local_17.setBorder(_local_6);
            _local_17.setBackgroundDecorator(new AssetBackground(_local_10));
            _local_17.setPreferredHeight(_local_10.height);
            _local_17.setPreferredWidth(_local_10.width);
            var _local_18:JPanel = new JPanel(new EmptyLayout());
            _local_18.setBorder(_local_6);
            _local_18.setBackgroundDecorator(new AssetBackground(_local_11));
            _local_18.setPreferredHeight(_local_11.height);
            _local_18.setPreferredWidth(_local_11.width);
            var _local_19:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_19.setBorder(_local_6);
            _local_19.append(_local_16);
            _local_19.append(_local_17);
            _local_19.append(_local_18);
            var _local_20:JPanel = new JPanel(new EmptyLayout());
            _local_20.setBorder(_local_6);
            _local_20.setBackgroundDecorator(new AssetBackground(_local_12));
            _local_20.setPreferredHeight(_local_12.height);
            _local_20.setPreferredWidth(_local_12.width);
            var _local_21:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.LEFT));
            _local_21.setBorder(_local_6);
            _local_21.append(_local_19);
            _local_21.append(_local_20);
            _local_21.setSize(new IntDimension(((_local_9.width + _local_10.width) + _local_11.width), (_local_10.height + _local_12.height)));
            _local_21.setLocation(new IntPoint(0, 0));
            this._centerContentPanel = new JPanel(new BorderLayout(0, 0));
            this._centerContentPanel.setBorder(_local_6);
            this._centerContentPanel.setSize(new IntDimension(((_local_9.width + _local_10.width) + _local_11.width), (_local_10.height + _local_12.height)));
            this._centerContentPanel.setLocation(new IntPoint(0, 0));
            var _local_22:JPanel = new JPanel(new EmptyLayout());
            _local_22.setBorder(_local_6);
            _local_22.setPreferredWidth(((_local_9.width + _local_10.width) + _local_11.width));
            _local_22.setPreferredHeight((_local_10.height + _local_12.height));
            _local_22.append(_local_21);
            _local_22.append(this._centerContentPanel);
            var _local_23:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_23.setBorder(_local_6);
            _local_23.append(_local_22);
            this._closeWindowButton = new CustomButton(null);
            var _local_24:Bitmap = new WindowSprites.WindowCloseButton();
            var _local_25:Bitmap = new WindowSprites.WindowCloseButtonSelected();
            var _local_26:Bitmap = new WindowSprites.WindowCloseButtonPressed();
            this._closeWindowButton.setIcon(new AssetIcon(_local_24));
            this._closeWindowButton.setRollOverIcon(new AssetIcon(_local_25));
            this._closeWindowButton.setPressedIcon(new AssetIcon(_local_26));
            this._closeWindowButton.setStyleTune(new StyleTune(0.18, 0.05, 0.2, 0.2, 20));
            this._closeWindowButton.setPreferredWidth(35);
            this._closeWindowButton.setPreferredHeight(35);
            this._closeWindowButton.setBackgroundDecorator(null);
            this._closeWindowButton.addActionListener(this.OnClosePressed, 0, true);
            _local_15.append(this._closeWindowButton, BorderLayout.LINE_END);
            this._closeWindowButton.visible = _arg_4;
            this._closeWindowButton.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            this._container = getContentPane();
            this._container.append(_local_13, BorderLayout.PAGE_START);
            this._container.append(_local_23, BorderLayout.CENTER);
            pack();
            setLocationXY(150, 150);
            _local_14.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown, false, 0, true);
            _local_14.addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
        }

        private function OnMouseDown(_arg_1:Event):void
        {
            startDrag(false, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
        }

        private function OnMouseUp(_arg_1:Event):void
        {
            stopDrag();
        }

        private function OnClosePressed(_arg_1:Event):void
        {
            dispatchEvent(new Event(CUSTOM_WINDOW_CLOSED));
            dispose();
        }

        public function get MainPanel():JPanel
        {
            return (this._centerContentPanel);
        }

        public function SetClosable(_arg_1:Boolean):void
        {
            this._closeWindowButton.visible = _arg_1;
        }


    }
}//package hbm.Game.GUI.Tools

