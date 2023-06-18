


//hbm.Game.GUI.Tools.ShadowWindow

package hbm.Game.GUI.Tools
{
    import org.aswing.JWindow;
    import org.aswing.Container;
    import org.aswing.JPanel;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.EmptyLayout;
    import hbm.Application.ClientApplication;
    import flash.events.Event;
    import caurina.transitions.Tweener;
    import hbm.Engine.Renderer.RenderSystem;

    public class ShadowWindow extends JWindow 
    {

        private static const TIME_ANIMATION_SHOW:Number = 0.5;
        private static const TIME_ANIMATION_HIDE:Number = 0.5;

        private var _content:Container;
        protected var _window:JPanel;

        public function ShadowWindow(_arg_1:*=null)
        {
            super(_arg_1, false);
            this.InitUI();
            pack();
        }

        protected function InitUI():void
        {
            this.alpha = 0;
            AsWingUtil.SetBorder(this);
            AsWingUtil.SetBackgroundColor(this, 0, 0.6);
            this._content = getContentPane();
            this._content.setLayout(new EmptyLayout());
            this._window = new JPanel(new EmptyLayout());
            this._content.append(this._window);
        }

        override public function show():void
        {
            ClientApplication.Instance.stage.addEventListener(Event.RESIZE, this.OnStageResize, false, 0, true);
            this.OnStageResize();
            super.show();
            ClientApplication.Instance.SetShortcutsEnabled(false);
        }

        override public function dispose():void
        {
            Tweener.removeTweens(this);
            this.alpha = 0;
            ClientApplication.Instance.stage.removeEventListener(Event.RESIZE, this.OnStageResize);
            super.dispose();
            ClientApplication.Instance.SetShortcutsEnabled(true);
        }

        protected function OnStageResize(_arg_1:Event=null):void
        {
            AsWingUtil.SetSize(this, ClientApplication.Instance.stage.stageWidth, ClientApplication.Instance.stage.stageHeight);
            this._window.setLocationXY((((RenderSystem.Instance.ScreenWidth - this._window.width) / 2) - 69), (RenderSystem.Instance.ScreenHeight - this._window.height));
        }

        public function ShowWithAnimation():void
        {
            Tweener.removeTweens(this);
            this.show();
            if (this.alpha == 1)
            {
                return;
            };
            Tweener.addTween(this, {
                "alpha":1,
                "time":(TIME_ANIMATION_SHOW * (1 - this.alpha)),
                "transition":"easeInOutCubic"
            });
        }

        public function CloseWithAnimation():void
        {
            Tweener.removeTweens(this);
            if (this.alpha == 0)
            {
                this.dispose();
                return;
            };
            Tweener.addTween(this, {
                "alpha":0,
                "time":(TIME_ANIMATION_HIDE * this.alpha),
                "transition":"easeInOutCubic",
                "onComplete":this.dispose
            });
        }


    }
}//package hbm.Game.GUI.Tools

