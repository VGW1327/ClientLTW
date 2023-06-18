


//de.nulldesign.nd2d.materials.Sprite2DMaskMaterial

package de.nulldesign.nd2d.materials
{
    import flash.geom.Matrix3D;
    import de.nulldesign.nd2d.materials.texture.Texture2D;
    import flash.geom.Point;
    import flash.display3D.Context3DVertexBufferFormat;
    import flash.geom.Rectangle;
    import flash.display3D.Context3DProgramType;
    import flash.display3D.Context3D;
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.geom.Vertex;
    import de.nulldesign.nd2d.geom.UV;
    import de.nulldesign.nd2d.geom.Face;
    import de.nulldesign.nd2d.materials.shader.ShaderCache;

    public class Sprite2DMaskMaterial extends Sprite2DMaterial 
    {

        protected const DEFAULT_VERTEX_SHADER:String = ((((((((("m44 vt0, va0, vc0              \n" + "m44 vt1, vt0, vc4              \n") + "add vt1.xy, vt1.xy, vc8.xy     \n") + "div vt1.xy, vt1.xy, vc8.zw     \n") + "mov vt2, va1                   \n") + "mul vt2.xy, vt2.xy, vc9.zw     \n") + "add vt2.xy, vt2.xy, vc9.xy     \n") + "mov v0, vt2                    \n") + "mov v1, vt1                    \n") + "mov op, vt0                    \n");
        protected const DEFAULT_FRAGMENT_SHADER:String = ((((((((("tex ft0, v0, fs0 <TEXTURE_SAMPLING_OPTIONS>  \n" + "mul ft0, ft0, fc0                              \n") + "add ft0, ft0, fc1                              \n") + "tex ft1, v1, fs1 <2d,miplinear,linear,clamp>   \n") + "sub ft2, fc2, ft1                              \n") + "mov ft3, fc3                                   \n") + "sub ft3, fc2, ft3                              \n") + "mul ft3, ft2, ft3                              \n") + "add ft3, ft1, ft3                              \n") + "mul oc, ft0, ft3                               \n");

        public var maskModelMatrix:Matrix3D;
        public var maskTexture:Texture2D;
        public var maskAlpha:Number;
        protected var maskDimensions:Point;
        protected var maskClipSpaceMatrix:Matrix3D = new Matrix3D();


        override public function handleDeviceLoss():void
        {
            super.handleDeviceLoss();
            this.maskTexture.texture = null;
            shaderData = null;
        }

        override protected function prepareForRender(_arg_1:Context3D):void
        {
            var _local_4:Point;
            super.prepareForRender(_arg_1);
            _arg_1.setTextureAt(0, texture.getTexture(_arg_1));
            _arg_1.setTextureAt(1, this.maskTexture.getTexture(_arg_1));
            _arg_1.setVertexBufferAt(0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
            _arg_1.setVertexBufferAt(1, vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_2);
            var _local_2:Rectangle = new Rectangle(0, 0, 1, 1);
            if (spriteSheet)
            {
                _local_2 = spriteSheet.getUVRectForFrame(texture.textureWidth, texture.textureHeight);
                _local_4 = spriteSheet.getOffsetForFrame();
                clipSpaceMatrix.identity();
                clipSpaceMatrix.appendScale((spriteSheet.spriteWidth >> 1), (spriteSheet.spriteHeight >> 1), 1);
                clipSpaceMatrix.appendTranslation(_local_4.x, _local_4.y, 0);
                clipSpaceMatrix.append(modelMatrix);
                clipSpaceMatrix.append(viewProjectionMatrix);
            }
            else
            {
                clipSpaceMatrix.identity();
                clipSpaceMatrix.appendScale((texture.textureWidth >> 1), (texture.textureHeight >> 1), 1);
                clipSpaceMatrix.append(modelMatrix);
                clipSpaceMatrix.append(viewProjectionMatrix);
            };
            this.maskClipSpaceMatrix.identity();
            this.maskClipSpaceMatrix.append(this.maskModelMatrix);
            this.maskClipSpaceMatrix.append(viewProjectionMatrix);
            this.maskClipSpaceMatrix.invert();
            _arg_1.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, clipSpaceMatrix, true);
            _arg_1.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, this.maskClipSpaceMatrix, true);
            programConstVector[0] = (this.maskTexture.textureWidth >> 1);
            programConstVector[1] = (this.maskTexture.textureHeight >> 1);
            programConstVector[2] = this.maskTexture.textureWidth;
            programConstVector[3] = this.maskTexture.textureHeight;
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 8, programConstVector);
            programConstVector[0] = _local_2.x;
            programConstVector[1] = _local_2.y;
            programConstVector[2] = _local_2.width;
            programConstVector[3] = _local_2.height;
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 9, programConstVector);
            programConstVector[0] = colorTransform.redMultiplier;
            programConstVector[1] = colorTransform.greenMultiplier;
            programConstVector[2] = colorTransform.blueMultiplier;
            programConstVector[3] = colorTransform.alphaMultiplier;
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, programConstVector);
            var _local_3:Number = (1 / 0xFF);
            programConstVector[0] = (colorTransform.redOffset * _local_3);
            programConstVector[1] = (colorTransform.greenOffset * _local_3);
            programConstVector[2] = (colorTransform.blueOffset * _local_3);
            programConstVector[3] = (colorTransform.alphaOffset * _local_3);
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1, programConstVector);
            programConstVector[0] = 1;
            programConstVector[1] = 1;
            programConstVector[2] = 1;
            programConstVector[3] = 1;
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, programConstVector);
            programConstVector[0] = this.maskAlpha;
            programConstVector[1] = this.maskAlpha;
            programConstVector[2] = this.maskAlpha;
            programConstVector[3] = this.maskAlpha;
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 3, programConstVector);
        }

        override protected function clearAfterRender(_arg_1:Context3D):void
        {
            _arg_1.setTextureAt(0, null);
            _arg_1.setTextureAt(1, null);
            _arg_1.setVertexBufferAt(0, null);
            _arg_1.setVertexBufferAt(1, null);
            _arg_1.setVertexBufferAt(2, null);
        }

        override protected function addVertex(_arg_1:Context3D, _arg_2:Vector.<Number>, _arg_3:Vertex, _arg_4:UV, _arg_5:Face):void
        {
            fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, VERTEX_POSITION, 2);
            fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, VERTEX_UV, 2);
        }

        override protected function initProgram(_arg_1:Context3D):void
        {
            if (!shaderData)
            {
                shaderData = ShaderCache.getInstance().getShader(_arg_1, this, this.DEFAULT_VERTEX_SHADER, this.DEFAULT_FRAGMENT_SHADER, 4, texture.textureOptions);
            };
        }

        override public function dispose():void
        {
            super.dispose();
            if (this.maskTexture)
            {
                this.maskTexture.dispose();
                this.maskTexture = null;
            };
        }


    }
}//package de.nulldesign.nd2d.materials

