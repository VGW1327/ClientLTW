


//de.nulldesign.nd2d.materials.Sprite2DMaterial

package de.nulldesign.nd2d.materials
{
    import de.nulldesign.nd2d.materials.texture.Texture2D;
    import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
    import flash.geom.ColorTransform;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.display3D.textures.Texture;
    import flash.display3D.Context3DVertexBufferFormat;
    import flash.display3D.Context3DProgramType;
    import flash.display3D.Context3D;
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.geom.Vertex;
    import de.nulldesign.nd2d.geom.UV;
    import de.nulldesign.nd2d.geom.Face;
    import de.nulldesign.nd2d.materials.shader.ShaderCache;

    public class Sprite2DMaterial extends AMaterial 
    {

        protected const VERTEX_SHADER:String = (((("m44 op, va0, vc0   \n" + "mov vt0, va1  \n") + "mul vt0.xy, vt0.xy, vc4.zw   \n") + "add vt0.xy, vt0.xy, vc4.xy   \n") + "mov v0, vt0 \n");
        protected const FRAGMENT_SHADER:String = (("tex ft0, v0, fs0 <TEXTURE_SAMPLING_OPTIONS>\n" + "mul ft0, ft0, fc0\n") + "add oc, ft0, fc1\n");

        public var texture:Texture2D;
        public var spriteSheet:ASpriteSheetBase;
        public var colorTransform:ColorTransform;
        public var uvOffsetX:Number = 0;
        public var uvOffsetY:Number = 0;
        public var uvScaleX:Number = 1;
        public var uvScaleY:Number = 1;

        public function Sprite2DMaterial()
        {
            drawCalls = 1;
        }

        override protected function prepareForRender(_arg_1:Context3D):void
        {
            var _local_5:Point;
            super.prepareForRender(_arg_1);
            var _local_2:Rectangle = new Rectangle(0, 0, 1, 1);
            var _local_3:Texture = this.texture.getTexture(_arg_1);
            if (this.spriteSheet)
            {
                _local_2 = this.spriteSheet.getUVRectForFrame(this.texture.textureWidth, this.texture.textureHeight);
                _local_5 = this.spriteSheet.getOffsetForFrame();
                clipSpaceMatrix.identity();
                clipSpaceMatrix.appendScale((this.spriteSheet.spriteWidth >> 1), (this.spriteSheet.spriteHeight >> 1), 1);
                clipSpaceMatrix.appendTranslation(_local_5.x, _local_5.y, 0);
                clipSpaceMatrix.append(modelMatrix);
                clipSpaceMatrix.append(viewProjectionMatrix);
            }
            else
            {
                clipSpaceMatrix.identity();
                clipSpaceMatrix.appendScale((this.texture.textureWidth >> 1), (this.texture.textureHeight >> 1), 1);
                clipSpaceMatrix.append(modelMatrix);
                clipSpaceMatrix.append(viewProjectionMatrix);
            };
            _arg_1.setTextureAt(0, _local_3);
            _arg_1.setVertexBufferAt(0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
            _arg_1.setVertexBufferAt(1, vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_2);
            _arg_1.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, clipSpaceMatrix, true);
            programConstVector[0] = (_local_2.x + this.uvOffsetX);
            programConstVector[1] = (_local_2.y + this.uvOffsetY);
            programConstVector[2] = (_local_2.width * this.uvScaleX);
            programConstVector[3] = (_local_2.height * this.uvScaleY);
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, programConstVector);
            var _local_4:Number = (1 / 0xFF);
            programConstVector[0] = this.colorTransform.redMultiplier;
            programConstVector[1] = this.colorTransform.greenMultiplier;
            programConstVector[2] = this.colorTransform.blueMultiplier;
            programConstVector[3] = this.colorTransform.alphaMultiplier;
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, programConstVector);
            programConstVector[0] = (this.colorTransform.redOffset * _local_4);
            programConstVector[1] = (this.colorTransform.greenOffset * _local_4);
            programConstVector[2] = (this.colorTransform.blueOffset * _local_4);
            programConstVector[3] = (this.colorTransform.alphaOffset * _local_4);
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1, programConstVector);
        }

        override protected function clearAfterRender(_arg_1:Context3D):void
        {
            _arg_1.setTextureAt(0, null);
            _arg_1.setVertexBufferAt(0, null);
            _arg_1.setVertexBufferAt(1, null);
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
                shaderData = ShaderCache.getInstance().getShader(_arg_1, this, this.VERTEX_SHADER, this.FRAGMENT_SHADER, 4, this.texture.textureOptions);
            };
        }

        public function modifyVertexInBuffer(_arg_1:uint, _arg_2:Number, _arg_3:Number):void
        {
            if (((!(mVertexBuffer)) || (mVertexBuffer.length == 0)))
            {
                return;
            };
            var _local_4:uint = (_arg_1 * shaderData.numFloatsPerVertex);
            mVertexBuffer[_local_4] = _arg_2;
            mVertexBuffer[(_local_4 + 1)] = _arg_3;
            needUploadVertexBuffer = true;
        }


    }
}//package de.nulldesign.nd2d.materials

