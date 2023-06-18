


//de.nulldesign.nd2d.display.Sprite2DBatch

package de.nulldesign.nd2d.display
{
    import de.nulldesign.nd2d.materials.Sprite2DBatchMaterial;
    import de.nulldesign.nd2d.materials.texture.Texture2D;
    import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.geom.Face;
    import de.nulldesign.nd2d.utils.TextureHelper;
    import flash.display3D.Context3D;
    import de.nulldesign.nd2d.utils.StatsObject;

    public class Sprite2DBatch extends Node2D 
    {

        private var material:Sprite2DBatchMaterial;
        private var texture:Texture2D;
        private var spriteSheet:ASpriteSheetBase;
        private var faceList:Vector.<Face>;

        public function Sprite2DBatch(_arg_1:Texture2D)
        {
            this.material = new Sprite2DBatchMaterial();
            this.faceList = TextureHelper.generateQuadFromDimensions(2, 2);
            this.texture = _arg_1;
        }

        override public function get numTris():uint
        {
            return (this.material.numTris);
        }

        override public function get drawCalls():uint
        {
            return (this.material.drawCalls);
        }

        public function setSpriteSheet(_arg_1:ASpriteSheetBase):void
        {
            this.spriteSheet = _arg_1;
        }

        override public function addChildAt(_arg_1:Node2D, _arg_2:uint):Node2D
        {
            if ((_arg_1 is Sprite2DBatch))
            {
                throw (new Error("You can't nest Sprite2DBatches"));
            };
            var _local_3:Sprite2D = (_arg_1 as Sprite2D);
            _local_3.isBatchNode = true;
            if (((this.spriteSheet) && (!(_local_3.spriteSheet))))
            {
                _local_3.setSpriteSheet(this.spriteSheet.clone());
            };
            if (((this.texture) && (!(_local_3.texture))))
            {
                _local_3.setTexture(this.texture);
            };
            return (super.addChildAt(_arg_1, _arg_2));
        }

        override internal function stepNode(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Node2D;
            this.timeSinceStartInSeconds = _arg_2;
            step(_arg_1);
            for each (_local_3 in children)
            {
                _local_3.stepNode(_arg_1, _arg_2);
            };
        }

        override internal function drawNode(_arg_1:Context3D, _arg_2:Camera2D, _arg_3:Boolean, _arg_4:StatsObject):void
        {
            var _local_5:Boolean;
            if (!visible)
            {
                return;
            };
            if (invalidateColors)
            {
                updateColors();
            };
            if (invalidateMatrix)
            {
                updateLocalMatrix();
                _local_5 = true;
            };
            if (((_arg_3) || (_local_5)))
            {
                updateWorldMatrix();
            };
            this.draw(_arg_1, _arg_2);
            _arg_4.totalDrawCalls = (_arg_4.totalDrawCalls + this.drawCalls);
            _arg_4.totalTris = (_arg_4.totalTris + this.numTris);
        }

        override public function handleDeviceLoss():void
        {
            super.handleDeviceLoss();
            this.material.handleDeviceLoss();
        }

        override protected function draw(_arg_1:Context3D, _arg_2:Camera2D):void
        {
            this.material.blendMode = blendMode;
            this.material.modelMatrix = worldModelMatrix;
            this.material.viewProjectionMatrix = _arg_2.getViewProjectionMatrix(false);
            this.material.texture = this.texture;
            this.material.spriteSheet = this.spriteSheet;
            this.material.renderBatch(_arg_1, this.faceList, children);
        }

        override public function dispose():void
        {
            if (this.material)
            {
                this.material.dispose();
                this.material = null;
            };
            if (this.texture)
            {
                this.texture.dispose();
                this.texture = null;
            };
            super.dispose();
        }


    }
}//package de.nulldesign.nd2d.display

