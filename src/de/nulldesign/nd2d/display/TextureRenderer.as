


//de.nulldesign.nd2d.display.TextureRenderer

package de.nulldesign.nd2d.display
{
    import de.nulldesign.nd2d.materials.texture.Texture2D;
    import flash.display3D.Context3D;
    import de.nulldesign.nd2d.utils.StatsObject;

    public class TextureRenderer extends Node2D 
    {

        protected var renderNode:Node2D;
        protected var texCamera:Camera2D = new Camera2D(1, 1);
        public var texture:Texture2D;
        private var cameraOffsetX:Number;
        private var cameraOffsetY:Number;

        public function TextureRenderer(_arg_1:Node2D, _arg_2:Texture2D, _arg_3:Number=NaN, _arg_4:Number=NaN)
        {
            this.texture = _arg_2;
            this.renderNode = _arg_1;
            _width = _arg_2.bitmapWidth;
            _height = _arg_2.bitmapHeight;
            this.cameraOffsetX = _arg_3;
            this.cameraOffsetY = _arg_4;
            this.texCamera.resizeCameraStage(width, height);
        }

        override public function handleDeviceLoss():void
        {
            super.handleDeviceLoss();
            this.texture.texture = null;
        }

        override internal function drawNode(_arg_1:Context3D, _arg_2:Camera2D, _arg_3:Boolean, _arg_4:StatsObject):void
        {
            _arg_1.setRenderToTexture(this.texture.getTexture(_arg_1), false, 2, 0);
            _arg_1.clear(0, 0, 0, 0);
            if (((!(isNaN(this.cameraOffsetX))) && (!(isNaN(this.cameraOffsetY)))))
            {
                this.texCamera.x = this.cameraOffsetX;
                this.texCamera.y = this.cameraOffsetY;
            }
            else
            {
                this.texCamera.x = (this.renderNode.x - (width >> 1));
                this.texCamera.y = (this.renderNode.y - (height >> 1));
            };
            var _local_5:Boolean = this.renderNode.visible;
            this.renderNode.visible = true;
            this.renderNode.drawNode(_arg_1, this.texCamera, _arg_3, _arg_4);
            this.renderNode.visible = _local_5;
            _arg_1.setRenderToBackBuffer();
        }

        override public function dispose():void
        {
            super.dispose();
            if (this.texture)
            {
                this.texture.dispose();
                this.texture = null;
            };
        }


    }
}//package de.nulldesign.nd2d.display

