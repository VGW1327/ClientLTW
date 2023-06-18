


//hbm.Game.GUI.CashShopNew.PrimaryAlertPane

package hbm.Game.GUI.CashShopNew
{
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.ASFont;
    import hbm.Engine.Renderer.RenderSystem;
    import org.aswing.JLabel;
    import org.aswing.AttachIcon;
    import org.aswing.SoftBoxLayout;
    import org.aswing.AssetIcon;
    import org.aswing.CenterLayout;
    import flash.events.Event;

    public class PrimaryAlertPane extends WindowPrototype 
    {

        public static const CUSTOM_OPTION_PANE_CLOSED:String = "CUSTOM_OPTION_PANE_CLOSED";

        private const _debugBorder:LineBorder = new LineBorder(null, new ASColor(0xFF0000));

        private var _handler:Function;

        public function PrimaryAlertPane(_arg_1:String, _arg_2:String, _arg_3:Function)
        {
            var _local_7:ASFont;
            var _local_4:* = 300;
            var _local_5:* = 180;
            this._handler = _arg_3;
            super(owner, _arg_1, true, _local_4, _local_5, false);
            setLocationXY(((RenderSystem.Instance.ScreenWidth - _local_4) / 2), ((RenderSystem.Instance.ScreenHeight - _local_5) / 2));
            var _local_6:JLabel = new JLabel(_arg_2, new AttachIcon("AchtungIcon"));
            _local_7 = getFont();
            var _local_8:ASFont = new ASFont(_local_7.getName(), 12, true);
            _local_6.setFont(_local_8);
            _body.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            _body.append(_local_6);
            var _local_9:ButtonPrototype = new ButtonPrototype("Ok");
            _local_9.addActionListener(this.OnButton);
            _local_9.setMaximumWidth(62);
            _local_9.setMaximumHeight(24);
            _local_9.setPreferredWidth(62);
            _local_9.setPreferredHeight(24);
            _local_9.setBackgroundDecorator(null);
            _local_9.setIcon(new AssetIcon(Assets.BottomOkButton()));
            _local_9.setRollOverIcon(new AssetIcon(Assets.BottomOkButtonOver()));
            _bottom.removeAll();
            _bottom.setLayout(new CenterLayout());
            _bottom.append(_local_9);
            _body.append(_local_6);
            show();
        }

        private function OnButton(_arg_1:Event):void
        {
            this._handler(0);
            dispose();
        }


    }
}//package hbm.Game.GUI.CashShopNew

