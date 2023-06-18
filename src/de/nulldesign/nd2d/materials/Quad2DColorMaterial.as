


//de.nulldesign.nd2d.materials.Quad2DColorMaterial

package de.nulldesign.nd2d.materials
{
    import flash.display3D.Context3DVertexBufferFormat;
    import flash.display3D.Context3DProgramType;
    import flash.display3D.Context3D;
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.geom.Vertex;
    import de.nulldesign.nd2d.geom.UV;
    import de.nulldesign.nd2d.geom.Face;
    import de.nulldesign.nd2d.materials.shader.ShaderCache;

    public class Quad2DColorMaterial extends AMaterial 
    {

        private const VERTEX_SHADER:String = ("m44 op, va0, vc0   \n" + "mov v0, va1\t\t\n");
        private const FRAGMENT_SHADER:String = "mov oc, v0\t\t\n";

        public function Quad2DColorMaterial()
        {
            drawCalls = 1;
        }

        override protected function prepareForRender(_arg_1:Context3D):void
        {
            super.prepareForRender(_arg_1);
            clipSpaceMatrix.identity();
            clipSpaceMatrix.append(modelMatrix);
            clipSpaceMatrix.append(viewProjectionMatrix);
            _arg_1.setVertexBufferAt(0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
            _arg_1.setVertexBufferAt(1, vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_4);
            _arg_1.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, clipSpaceMatrix, true);
        }

        override protected function clearAfterRender(_arg_1:Context3D):void
        {
            _arg_1.setVertexBufferAt(0, null);
            _arg_1.setVertexBufferAt(1, null);
        }

        override protected function addVertex(_arg_1:Context3D, _arg_2:Vector.<Number>, _arg_3:Vertex, _arg_4:UV, _arg_5:Face):void
        {
            fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, VERTEX_POSITION, 2);
            fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, VERTEX_COLOR, 4);
        }

        override protected function initProgram(_arg_1:Context3D):void
        {
            if (!shaderData)
            {
                shaderData = ShaderCache.getInstance().getShader(_arg_1, this, this.VERTEX_SHADER, this.FRAGMENT_SHADER, 6, 0);
            };
        }

        public function modifyColorInBuffer(_arg_1:uint, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number):void
        {
            if (((!(mVertexBuffer)) || (mVertexBuffer.length == 0)))
            {
                return;
            };
            var _local_6:uint = (_arg_1 * shaderData.numFloatsPerVertex);
            mVertexBuffer[(_local_6 + 2)] = _arg_2;
            mVertexBuffer[(_local_6 + 3)] = _arg_3;
            mVertexBuffer[(_local_6 + 4)] = _arg_4;
            mVertexBuffer[(_local_6 + 5)] = _arg_5;
            needUploadVertexBuffer = true;
        }


    }
}//package de.nulldesign.nd2d.materials

