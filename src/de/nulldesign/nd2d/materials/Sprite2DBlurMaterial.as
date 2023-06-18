


//de.nulldesign.nd2d.materials.Sprite2DBlurMaterial

package de.nulldesign.nd2d.materials
{
    import flash.display.Stage;
    import de.nulldesign.nd2d.materials.shader.Shader2D;
    import flash.display3D.textures.Texture;
    import de.nulldesign.nd2d.display.Camera2D;
    import __AS3__.vec.Vector;
    import flash.display3D.Context3DProgramType;
    import flash.display3D.Context3DTextureFormat;
    import flash.display3D.Context3D;
    import flash.geom.Matrix3D;
    import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
    import de.nulldesign.nd2d.geom.Face;
    import de.nulldesign.nd2d.materials.shader.ShaderCache;
    import __AS3__.vec.*;

    public class Sprite2DBlurMaterial extends Sprite2DMaterial 
    {

        public static var stageRef:Stage;

        protected const HORIZONTAL_FRAGMENT_SHADER:String = ((((((((((((((((((((((((((((((((((((("mov ft0, v0\t\t\t\t\t\t\t\t\n" + "sub ft0.x, ft0.x, fc3.y\t\t\t\t\t\n") + "tex ft1, ft0, fs0 <TEXTURE_SAMPLING_OPTIONS>\t\t\n") + "mul ft1, ft1, fc2.x\t\t\t\t\t\t\n") + "add ft0.x, ft0.x, fc3.z\t\t\t\t\t\n") + "tex ft2, ft0, fs0 <TEXTURE_SAMPLING_OPTIONS>\t\t\n") + "mul ft2, ft2, fc2.y\t\t\t\t\t\t\n") + "add ft1, ft1, ft2\t\t\t\t\t\t\t\n") + "add ft0.x, ft0.x, fc3.z\t\t\t\t\t\n") + "tex ft2, ft0, fs0 <TEXTURE_SAMPLING_OPTIONS>\t\t\n") + "mul ft2, ft2, fc2.z\t\t\t\t\t\t\n") + "add ft1, ft1, ft2\t\t\t\t\t\t\t\n") + "add ft0.x, ft0.x, fc3.z\t\t\t\t\t\n") + "tex ft2, ft0, fs0 <TEXTURE_SAMPLING_OPTIONS>\t\t\n") + "mul ft2, ft2, fc2.w\t\t\t\t\t\t\n") + "add ft1, ft1, ft2\t\t\t\t\t\t\t\n") + "add ft0.x, ft0.x, fc3.z\t\t\t\t\t\n") + "tex ft2, ft0, fs0 <TEXTURE_SAMPLING_OPTIONS>\t\t\n") + "mul ft2, ft2, fc3.x\t\t\t\t\t\t\n") + "add ft1, ft1, ft2\t\t\t\t\t\t\t\n") + "add ft0.x, ft0.x, fc3.z\t\t\t\t\t\n") + "tex ft2, ft0, fs0 <TEXTURE_SAMPLING_OPTIONS>\t\t\n") + "mul ft2, ft2, fc2.w\t\t\t\t\t\t\n") + "add ft1, ft1, ft2\t\t\t\t\t\t\t\n") + "add ft0.x, ft0.x, fc3.z\t\t\t\t\t\n") + "tex ft2, ft0, fs0 <TEXTURE_SAMPLING_OPTIONS>\t\t\n") + "mul ft2, ft2, fc2.z\t\t\t\t\t\t\n") + "add ft1, ft1, ft2\t\t\t\t\t\t\t\n") + "add ft0.x, ft0.x, fc3.z\t\t\t\t\t\n") + "tex ft2, ft0, fs0 <TEXTURE_SAMPLING_OPTIONS>\t\t\n") + "mul ft2, ft2, fc2.y\t\t\t\t\t\t\n") + "add ft1, ft1, ft2\t\t\t\t\t\t\t\n") + "add ft0.x, ft0.x, fc3.z\t\t\t\t\t\n") + "tex ft2, ft0, fs0 <TEXTURE_SAMPLING_OPTIONS>\t\t\n") + "mul ft2, ft2, fc2.x\t\t\t\t\t\t\n") + "add ft1, ft1, ft2\t\t\t\t\t\t\t\n") + "mul ft1, ft1, fc0\t\t\t\t\t\t\t\n") + "add oc, ft1, fc1\t\t\t\t\t\t\t\n");
        protected const MAX_BLUR:uint = 4;
        protected const BLUR_DIRECTION_HORIZONTAL:uint = 0;
        protected const BLUR_DIRECTION_VERTICAL:uint = 1;

        protected var VERTICAL_FRAGMENT_SHADER:String;
        protected var horizontalShader:Shader2D;
        protected var verticalShader:Shader2D;
        protected var blurredTexture:Texture;
        protected var blurredTexture2:Texture;
        protected var blurredTextureCam:Camera2D = new Camera2D(1, 1);
        protected var activeRenderToTexture:Texture;
        protected var blurX:uint;
        protected var blurY:uint;
        protected var fragmentData:Vector.<Number>;

        public function Sprite2DBlurMaterial(_arg_1:uint=4, _arg_2:uint=4)
        {
            this.VERTICAL_FRAGMENT_SHADER = this.HORIZONTAL_FRAGMENT_SHADER.replace("sub ft0.x, ft0.x, fc3.y", "sub ft0.y, ft0.y, fc3.y");
            var _local_3:RegExp = /add ft0.x, ft0.x, fc3.z/g;
            this.VERTICAL_FRAGMENT_SHADER = this.VERTICAL_FRAGMENT_SHADER.replace(_local_3, "add ft0.y, ft0.y, fc3.z");
            this.fragmentData = new Vector.<Number>(8, true);
            this.setBlur(_arg_1, _arg_2);
        }

        public function setBlur(_arg_1:uint=4, _arg_2:uint=4):void
        {
            this.blurX = _arg_1;
            this.blurY = _arg_2;
            drawCalls = Math.max(1, (Math.ceil((_arg_1 / this.MAX_BLUR)) + Math.ceil((_arg_2 / this.MAX_BLUR))));
        }

        protected function updateBlurKernel(_arg_1:uint, _arg_2:uint):void
        {
            var _local_11:Number;
            this.fragmentData[0] = 0;
            this.fragmentData[1] = 0;
            this.fragmentData[2] = 0;
            this.fragmentData[3] = 0;
            this.fragmentData[4] = 1;
            this.fragmentData[5] = (4 * (1 / ((_arg_2 == this.BLUR_DIRECTION_HORIZONTAL) ? texture.textureWidth : texture.textureHeight)));
            this.fragmentData[6] = (1 * (1 / ((_arg_2 == this.BLUR_DIRECTION_HORIZONTAL) ? texture.textureWidth : texture.textureHeight)));
            this.fragmentData[7] = 0;
            if (_arg_1 == 0)
            {
                return;
            };
            var _local_3:uint = ((_arg_1 * 2) + 1);
            var _local_4:Number = -(_arg_1);
            var _local_5:Array = [];
            var _local_6:Number = (1 / ((2 * _arg_1) * _arg_1));
            var _local_7:Number = (1 / (Math.sqrt((2 * Math.PI)) * _arg_1));
            var _local_8:Number = 0;
            var _local_9:int;
            _local_9 = 0;
            while (_local_9 < _local_3)
            {
                _local_11 = (_local_4 * _local_4);
                _local_5[_local_9] = (_local_7 * Math.exp((-(_local_11) * _local_6)));
                _local_4++;
                _local_8 = (_local_8 + _local_5[_local_9]);
                _local_9++;
            };
            _local_9 = 0;
            while (_local_9 < _local_3)
            {
                _local_5[_local_9] = (_local_5[_local_9] / _local_8);
                _local_9++;
            };
            var _local_10:uint = 4;
            _local_9 = int((_local_3 / 2));
            while (_local_9 >= 0)
            {
                var _local_12:* = _local_10--;
                this.fragmentData[_local_12] = _local_5[_local_9];
                _local_9--;
            };
        }

        override protected function prepareForRender(_arg_1:Context3D):void
        {
            super.prepareForRender(_arg_1);
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, this.fragmentData, 2);
            if (!this.blurredTexture)
            {
                this.blurredTexture = _arg_1.createTexture(texture.textureWidth, texture.textureHeight, Context3DTextureFormat.BGRA, true);
            };
            if (!this.blurredTexture2)
            {
                this.blurredTexture2 = _arg_1.createTexture(texture.textureWidth, texture.textureHeight, Context3DTextureFormat.BGRA, true);
            };
        }

        protected function renderBlur(_arg_1:Context3D, _arg_2:uint, _arg_3:uint):void
        {
            this.activeRenderToTexture = ((this.activeRenderToTexture == this.blurredTexture) ? this.blurredTexture2 : this.blurredTexture);
            _arg_1.setRenderToTexture(this.activeRenderToTexture, false, 2, 0);
            _arg_1.clear(0, 0, 0, 0);
            _arg_1.drawTriangles(indexBuffer, (_arg_2 * 3), _arg_3);
            _arg_1.setTextureAt(0, this.activeRenderToTexture);
        }

        override public function render(_arg_1:Context3D, _arg_2:Vector.<Face>, _arg_3:uint, _arg_4:uint):void
        {
            var _local_8:int;
            var _local_9:uint;
            generateBufferData(_arg_1, _arg_2);
            this.blurredTextureCam.resizeCameraStage(texture.textureWidth, texture.textureHeight);
            this.blurredTextureCam.x = (-(texture.textureWidth) * 0.5);
            this.blurredTextureCam.y = (-(texture.textureHeight) * 0.5);
            var _local_5:Matrix3D = viewProjectionMatrix;
            var _local_6:ASpriteSheetBase = spriteSheet;
            var _local_7:Matrix3D = modelMatrix;
            viewProjectionMatrix = this.blurredTextureCam.getViewProjectionMatrix();
            spriteSheet = null;
            modelMatrix = new Matrix3D();
            this.updateBlurKernel(this.MAX_BLUR, this.BLUR_DIRECTION_HORIZONTAL);
            this.prepareForRender(_arg_1);
            this.activeRenderToTexture = null;
            _local_8 = int(Math.floor((this.blurX / this.MAX_BLUR)));
            _local_9 = 0;
            while (_local_9 < _local_8)
            {
                this.renderBlur(_arg_1, _arg_3, _arg_4);
                _local_9++;
            };
            if ((this.blurX % this.MAX_BLUR) != 0)
            {
                this.updateBlurKernel((this.blurX % this.MAX_BLUR), this.BLUR_DIRECTION_HORIZONTAL);
                _arg_1.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, this.fragmentData, 2);
                this.renderBlur(_arg_1, _arg_3, _arg_4);
            };
            _arg_1.setProgram(this.verticalShader.shader);
            this.updateBlurKernel(this.MAX_BLUR, this.BLUR_DIRECTION_VERTICAL);
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, this.fragmentData, 2);
            _local_8 = int(Math.floor((this.blurY / this.MAX_BLUR)));
            _local_9 = 0;
            while (_local_9 < _local_8)
            {
                this.renderBlur(_arg_1, _arg_3, _arg_4);
                _local_9++;
            };
            if ((this.blurY % this.MAX_BLUR) != 0)
            {
                this.updateBlurKernel((this.blurY % this.MAX_BLUR), this.BLUR_DIRECTION_VERTICAL);
                _arg_1.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, this.fragmentData, 2);
                this.renderBlur(_arg_1, _arg_3, _arg_4);
            };
            _arg_1.setRenderToBackBuffer();
            viewProjectionMatrix = _local_5;
            spriteSheet = _local_6;
            modelMatrix = _local_7;
            this.updateBlurKernel(0, this.BLUR_DIRECTION_HORIZONTAL);
            this.prepareForRender(_arg_1);
            if (((this.blurX == 0) && (this.blurY == 0)))
            {
                this.activeRenderToTexture = texture.getTexture(_arg_1);
            };
            _arg_1.setTextureAt(0, this.activeRenderToTexture);
            _arg_1.drawTriangles(indexBuffer, (_arg_3 * 3), _arg_4);
            clearAfterRender(_arg_1);
        }

        override public function dispose():void
        {
            super.dispose();
            if (this.blurredTexture)
            {
                this.blurredTexture.dispose();
                this.blurredTexture = null;
            };
            if (this.blurredTexture2)
            {
                this.blurredTexture2.dispose();
                this.blurredTexture2 = null;
            };
        }

        override public function handleDeviceLoss():void
        {
            super.handleDeviceLoss();
            this.blurredTexture = null;
            this.blurredTexture2 = null;
        }

        override protected function initProgram(_arg_1:Context3D):void
        {
            if (!shaderData)
            {
                this.horizontalShader = ShaderCache.getInstance().getShader(_arg_1, this, VERTEX_SHADER, this.HORIZONTAL_FRAGMENT_SHADER, 4, texture.textureOptions, 0);
                this.verticalShader = ShaderCache.getInstance().getShader(_arg_1, this, VERTEX_SHADER, this.VERTICAL_FRAGMENT_SHADER, 4, texture.textureOptions, 1000);
                shaderData = this.horizontalShader;
            };
        }


    }
}//package de.nulldesign.nd2d.materials

