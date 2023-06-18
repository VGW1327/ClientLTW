package hbm.Game.GUI
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Renderer.RenderSystem;

    public class MovingPerspective extends Sprite 
    {

        private var _frameBox:MovieClip;
        private var _parent:DisplayObjectContainer;

        public function MovingPerspective(_arg_1:DisplayObjectContainer)
        {
            this._parent = _arg_1;
            x = 0;
            y = 0;
            addEventListener(Event.ADDED_TO_STAGE, this.init);
        }

        public function UpdatePosition():void
        {
            var _local_1:uint;
            var _local_2:uint;
            if (ClientApplication.socialPanelVisible)
            {
                this._frameBox.x = (this._frameBox.y = 0);
            }
            else
            {
                if (RenderSystem.Instance)
                {
                    _local_1 = RenderSystem.Instance.ScreenWidth;
                    _local_2 = RenderSystem.Instance.ScreenHeight;
                }
                else
                {
                    _local_1 = ClientApplication.Instance.stage.stageWidth;
                    _local_2 = ClientApplication.Instance.stage.stageHeight;
                };
                this._frameBox.x = ((_local_1 - this._frameBox.width) / 2);
                this._frameBox.y = ((_local_2 - this._frameBox.height) / 2);
            };
        }

        protected function init(_arg_1:Event):void
        {
            if (((this._frameBox) && (this.contains(this._frameBox))))
            {
                removeChild(this._frameBox);
            };
            this._frameBox = new FrameBox();
            this.UpdatePosition();
            addChild(this._frameBox);
        }

        public function Show():void
        {
            if (!this._parent.contains(this))
            {
                this._parent.addChild(this);
            };
        }

        public function Hide():void
        {
            if (this._parent.contains(this))
            {
                this._parent.removeChild(this);
            };
        }

        public function Dispose():void
        {
            if (this._parent.contains(this))
            {
                this._parent.removeChild(this);
            };
            if (this._frameBox)
            {
                this._frameBox.stop();
                this._frameBox = null;
            };
        }


    }
}