


//de.nulldesign.nd2d.materials.Sprite2DBatchMaterial

package de.nulldesign.nd2d.materials
{
    import de.nulldesign.nd2d.geom.Face;
    import __AS3__.vec.Vector;
    import flash.display3D.Context3D;
    import flash.display3D.Context3DVertexBufferFormat;
    import de.nulldesign.nd2d.display.Node2D;
    import de.nulldesign.nd2d.display.Sprite2D;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.display3D.Context3DProgramType;
    import de.nulldesign.nd2d.materials.shader.ShaderCache;
    import de.nulldesign.nd2d.geom.Vertex;
    import de.nulldesign.nd2d.geom.UV;
    import __AS3__.vec.*;

    public class Sprite2DBatchMaterial extends Sprite2DMaterial 
    {

        public static const VERTEX_IDX:String = "PB3D_IDX";

        protected const DEFAULT_VERTEX_SHADER:String = (((((("m44 op, va0, vc[va2.x]             \n" + "mov vt0, va1                       \n") + "mul vt0.xy, vt0.xy, vc[va2.w].zw   \n") + "add vt0.xy, vt0.xy, vc[va2.w].xy   \n") + "mov v0, vt0                        \n") + "mov v1, vc[va2.y]\t                \n") + "mov v2, vc[va2.z]\t                \n");
        protected const DEFAULT_FRAGMENT_SHADER:String = (("tex ft0, v0, fs0 <TEXTURE_SAMPLING_OPTIONS>  \n" + "mul ft0, ft0, v1                               \n") + "add oc, ft0, v2                               \n");
        protected const BATCH_SIZE:uint = (126 / constantsPerSprite);

        protected var constantsPerSprite:uint = 7;
        protected var constantsPerMatrix:uint = 4;
        protected var batchLen:uint = 0;


        override protected function generateBufferData(_arg_1:Context3D, _arg_2:Vector.<Face>):void
        {
            var _local_5:Face;
            var _local_6:Face;
            if (vertexBuffer)
            {
                return;
            };
            var _local_3:Face = _arg_2[0];
            var _local_4:Face = _arg_2[1];
            var _local_7:Vector.<Face> = new Vector.<Face>((this.BATCH_SIZE * 2), true);
            var _local_8:int;
            while (_local_8 < this.BATCH_SIZE)
            {
                _local_5 = _local_3.clone();
                _local_6 = _local_4.clone();
                _local_5.idx = _local_8;
                _local_6.idx = _local_8;
                _local_7[(_local_8 * 2)] = _local_5;
                _local_7[((_local_8 * 2) + 1)] = _local_6;
                _local_8++;
            };
            super.generateBufferData(_arg_1, _local_7);
        }

        override public function render(_arg_1:Context3D, _arg_2:Vector.<Face>, _arg_3:uint, _arg_4:uint):void
        {
            throw (new Error("please call renderBatch for this material"));
        }

        override protected function prepareForRender(_arg_1:Context3D):void
        {
            _arg_1.setProgram(shaderData.shader);
            _arg_1.setBlendFactors(blendMode.src, blendMode.dst);
            _arg_1.setTextureAt(0, texture.getTexture(_arg_1));
            _arg_1.setVertexBufferAt(0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
            _arg_1.setVertexBufferAt(1, vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_2);
            _arg_1.setVertexBufferAt(2, vertexBuffer, 4, Context3DVertexBufferFormat.FLOAT_4);
        }

        public function renderBatch(_arg_1:Context3D, _arg_2:Vector.<Face>, _arg_3:Vector.<Node2D>):void
        {
            drawCalls = 0;
            numTris = 0;
            this.batchLen = 0;
            this.generateBufferData(_arg_1, _arg_2);
            this.prepareForRender(_arg_1);
            this.processAndRenderNodes(_arg_1, _arg_3);
            if (this.batchLen != 0)
            {
                _arg_1.drawTriangles(indexBuffer, 0, (this.batchLen * 2));
                drawCalls++;
            };
            this.clearAfterRender(_arg_1);
        }

        protected function processAndRenderNodes(_arg_1:Context3D, _arg_2:Vector.<Node2D>):void
        {
            var _local_3:Sprite2D;
            var _local_9:Rectangle;
            var _local_10:Point;
            var _local_4:Vector.<Number> = new Vector.<Number>(8, true);
            var _local_5:Vector.<Number> = new Vector.<Number>(4, true);
            var _local_6:int = -1;
            var _local_7:int = _arg_2.length;
            var _local_8:Number = (1 / 0xFF);
            while (++_local_6 < _local_7)
            {
                _local_3 = Sprite2D(_arg_2[_local_6]);
                if (_local_3.visible)
                {
                    if (_local_3.invalidateColors)
                    {
                        _local_3.updateColors();
                    };
                    if (_local_3.invalidateMatrix)
                    {
                        _local_3.updateLocalMatrix();
                    };
                    _local_3.updateWorldMatrix();
                    _local_9 = new Rectangle(0, 0, 1, 1);
                    if (spriteSheet)
                    {
                        _local_9 = _local_3.spriteSheet.getUVRectForFrame(texture.textureWidth, texture.textureHeight);
                        _local_10 = _local_3.spriteSheet.getOffsetForFrame();
                        clipSpaceMatrix.identity();
                        clipSpaceMatrix.appendScale((_local_3.spriteSheet.spriteWidth >> 1), (_local_3.spriteSheet.spriteHeight >> 1), 1);
                        clipSpaceMatrix.appendTranslation(_local_10.x, _local_10.y, 0);
                        clipSpaceMatrix.append(_local_3.worldModelMatrix);
                        clipSpaceMatrix.append(viewProjectionMatrix);
                    }
                    else
                    {
                        clipSpaceMatrix.identity();
                        clipSpaceMatrix.appendScale((texture.textureWidth >> 1), (texture.textureHeight >> 1), 1);
                        clipSpaceMatrix.append(_local_3.worldModelMatrix);
                        clipSpaceMatrix.append(viewProjectionMatrix);
                    };
                    _local_4[0] = _local_3.combinedColorTransform.redMultiplier;
                    _local_4[1] = _local_3.combinedColorTransform.greenMultiplier;
                    _local_4[2] = _local_3.combinedColorTransform.blueMultiplier;
                    _local_4[3] = _local_3.combinedColorTransform.alphaMultiplier;
                    _local_4[4] = (_local_3.combinedColorTransform.redOffset * _local_8);
                    _local_4[5] = (_local_3.combinedColorTransform.greenOffset * _local_8);
                    _local_4[6] = (_local_3.combinedColorTransform.blueOffset * _local_8);
                    _local_4[7] = (_local_3.combinedColorTransform.alphaOffset * _local_8);
                    _local_5[0] = _local_9.x;
                    _local_5[1] = _local_9.y;
                    _local_5[2] = _local_9.width;
                    _local_5[3] = _local_9.height;
                    _arg_1.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, (this.batchLen * this.constantsPerSprite), clipSpaceMatrix, true);
                    _arg_1.setProgramConstantsFromVector(Context3DProgramType.VERTEX, ((this.batchLen * this.constantsPerSprite) + this.constantsPerMatrix), _local_4);
                    _arg_1.setProgramConstantsFromVector(Context3DProgramType.VERTEX, (((this.batchLen * this.constantsPerSprite) + this.constantsPerMatrix) + 2), _local_5);
                    this.batchLen++;
                    numTris = (numTris + 2);
                    if (this.batchLen == this.BATCH_SIZE)
                    {
                        _arg_1.drawTriangles(indexBuffer, 0, (this.batchLen * 2));
                        this.batchLen = 0;
                        drawCalls++;
                    };
                    this.processAndRenderNodes(_arg_1, _local_3.children);
                };
            };
        }

        override protected function clearAfterRender(_arg_1:Context3D):void
        {
            _arg_1.setTextureAt(0, null);
            _arg_1.setVertexBufferAt(0, null);
            _arg_1.setVertexBufferAt(1, null);
            _arg_1.setVertexBufferAt(2, null);
        }

        override protected function initProgram(_arg_1:Context3D):void
        {
            if (!shaderData)
            {
                shaderData = ShaderCache.getInstance().getShader(_arg_1, this, this.DEFAULT_VERTEX_SHADER, this.DEFAULT_FRAGMENT_SHADER, 8, texture.textureOptions);
            };
        }

        override protected function addVertex(_arg_1:Context3D, _arg_2:Vector.<Number>, _arg_3:Vertex, _arg_4:UV, _arg_5:Face):void
        {
            this.fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, VERTEX_POSITION, 2);
            this.fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, VERTEX_UV, 2);
            this.fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, VERTEX_IDX, 4);
        }

        override protected function fillBuffer(_arg_1:Vector.<Number>, _arg_2:Vertex, _arg_3:UV, _arg_4:Face, _arg_5:String, _arg_6:int):void
        {
            if (_arg_5 == VERTEX_IDX)
            {
                _arg_1.push((_arg_4.idx * this.constantsPerSprite));
                _arg_1.push(((_arg_4.idx * this.constantsPerSprite) + this.constantsPerMatrix));
                _arg_1.push((((_arg_4.idx * this.constantsPerSprite) + this.constantsPerMatrix) + 1));
                _arg_1.push((((_arg_4.idx * this.constantsPerSprite) + this.constantsPerMatrix) + 2));
            }
            else
            {
                super.fillBuffer(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            };
        }

        override public function dispose():void
        {
            super.dispose();
        }


    }
}//package de.nulldesign.nd2d.materials

