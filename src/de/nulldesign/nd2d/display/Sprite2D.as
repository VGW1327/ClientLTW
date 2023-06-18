


//de.nulldesign.nd2d.display.Sprite2D

package de.nulldesign.nd2d.display
{
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.geom.Face;
    import de.nulldesign.nd2d.materials.texture.Texture2D;
    import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
    import de.nulldesign.nd2d.materials.Sprite2DMaterial;
    import de.nulldesign.nd2d.utils.TextureHelper;
    import de.nulldesign.nd2d.materials.BlendModePresets;
    import de.nulldesign.nd2d.materials.Sprite2DMaskMaterial;
    import flash.display3D.Context3D;

    public class Sprite2D extends Node2D 
    {

        protected var faceList:Vector.<Face>;
        protected var mask:Sprite2D;
        public var texture:Texture2D;
        public var spriteSheet:ASpriteSheetBase;
        public var material:Sprite2DMaterial;
        public var isBatchNode:Boolean = false;

        public function Sprite2D(_arg_1:Texture2D=null)
        {
            this.faceList = TextureHelper.generateQuadFromDimensions(2, 2);
            if (_arg_1)
            {
                this.setMaterial(new Sprite2DMaterial());
                this.setTexture(_arg_1);
            };
        }

        public function setSpriteSheet(_arg_1:ASpriteSheetBase):void
        {
            this.spriteSheet = _arg_1;
            if (this.spriteSheet)
            {
                _width = this.spriteSheet.spriteWidth;
                _height = this.spriteSheet.spriteHeight;
            };
        }

        public function setTexture(_arg_1:Texture2D):void
        {
            if (this.texture)
            {
                this.texture.dispose();
            };
            this.texture = _arg_1;
            if (((this.texture) && (!(this.spriteSheet))))
            {
                _width = this.texture.bitmapWidth;
                _height = this.texture.bitmapHeight;
            };
            if (this.texture)
            {
                hasPremultipliedAlphaTexture = this.texture.hasPremultipliedAlpha;
                blendMode = ((this.texture.hasPremultipliedAlpha) ? BlendModePresets.NORMAL_PREMULTIPLIED_ALPHA : BlendModePresets.NORMAL_NO_PREMULTIPLIED_ALPHA);
            };
        }

        public function setMaterial(_arg_1:Sprite2DMaterial):void
        {
            if (this.material)
            {
                this.material.dispose();
            };
            this.material = _arg_1;
        }

        public function setMask(_arg_1:Sprite2D):void
        {
            this.mask = _arg_1;
            if (_arg_1)
            {
                this.setMaterial(new Sprite2DMaskMaterial());
            }
            else
            {
                this.setMaterial(new Sprite2DMaterial());
            };
        }

        override public function get numTris():uint
        {
            return (2);
        }

        override public function get drawCalls():uint
        {
            return ((this.material) ? this.material.drawCalls : 0);
        }

        override internal function stepNode(_arg_1:Number, _arg_2:Number):void
        {
            super.stepNode(_arg_1, _arg_2);
            if (this.spriteSheet)
            {
                this.spriteSheet.update(_arg_2);
                _width = this.spriteSheet.spriteWidth;
                _height = this.spriteSheet.spriteHeight;
            };
        }

        override public function handleDeviceLoss():void
        {
            super.handleDeviceLoss();
            if (this.material)
            {
                this.material.handleDeviceLoss();
            };
            if (this.texture)
            {
                this.texture.texture = null;
            };
        }

        override public function addChildAt(_arg_1:Node2D, _arg_2:uint):Node2D
        {
            var _local_3:Sprite2D;
            _arg_1 = super.addChildAt(_arg_1, _arg_2);
            if (this.isBatchNode)
            {
                _local_3 = (_arg_1 as Sprite2D);
                _local_3.isBatchNode = true;
                if (((this.spriteSheet) && (!(_local_3.spriteSheet))))
                {
                    _local_3.setSpriteSheet(this.spriteSheet.clone());
                };
                if (((this.texture) && (!(_local_3.texture))))
                {
                    _local_3.setTexture(this.texture);
                };
            };
            return (_arg_1);
        }

        override protected function draw(_arg_1:Context3D, _arg_2:Camera2D):void
        {
            var _local_3:Sprite2DMaskMaterial;
            this.material.blendMode = blendMode;
            this.material.modelMatrix = worldModelMatrix;
            this.material.viewProjectionMatrix = _arg_2.getViewProjectionMatrix(false);
            this.material.colorTransform = combinedColorTransform;
            this.material.spriteSheet = this.spriteSheet;
            this.material.texture = this.texture;
            if (this.mask)
            {
                if (this.mask.invalidateMatrix)
                {
                    this.mask.updateLocalMatrix();
                };
                _local_3 = Sprite2DMaskMaterial(this.material);
                _local_3.maskTexture = this.mask.texture;
                _local_3.maskModelMatrix = this.mask.localModelMatrix;
                _local_3.maskAlpha = this.mask.alpha;
            };
            this.material.render(_arg_1, this.faceList, 0, this.faceList.length);
        }

        override public function dispose():void
        {
            if (this.material)
            {
                this.material.dispose();
                this.material = null;
            };
            if (this.mask)
            {
                this.mask.dispose();
                this.mask = null;
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

