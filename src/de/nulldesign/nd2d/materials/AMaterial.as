


//de.nulldesign.nd2d.materials.AMaterial

package de.nulldesign.nd2d.materials
{
    import flash.geom.Matrix3D;
    import de.nulldesign.nd2d.utils.NodeBlendMode;
    import flash.display3D.IndexBuffer3D;
    import flash.display3D.VertexBuffer3D;
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.materials.shader.Shader2D;
    import de.nulldesign.nd2d.geom.Face;
    import flash.utils.Dictionary;
    import flash.display3D.Context3D;
    import de.nulldesign.nd2d.geom.Vertex;
    import de.nulldesign.nd2d.geom.UV;
    import __AS3__.vec.*;

    public class AMaterial 
    {

        public static const VERTEX_POSITION:String = "PB3D_POSITION";
        public static const VERTEX_UV:String = "PB3D_UV";
        public static const VERTEX_COLOR:String = "PB3D_COLOR";

        public var viewProjectionMatrix:Matrix3D;
        public var modelMatrix:Matrix3D;
        public var clipSpaceMatrix:Matrix3D = new Matrix3D();
        public var numTris:int = 0;
        public var drawCalls:int = 0;
        public var blendMode:NodeBlendMode = BlendModePresets.NORMAL_PREMULTIPLIED_ALPHA;
        public var needUploadVertexBuffer:Boolean = false;
        protected var indexBuffer:IndexBuffer3D;
        protected var vertexBuffer:VertexBuffer3D;
        protected var mIndexBuffer:Vector.<uint>;
        protected var mVertexBuffer:Vector.<Number>;
        protected var shaderData:Shader2D;
        protected var programConstVector:Vector.<Number> = new Vector.<Number>(4);


        protected function generateBufferData(_arg_1:Context3D, _arg_2:Vector.<Face>):void
        {
            var _local_3:int;
            var _local_5:int;
            var _local_7:String;
            var _local_9:Face;
            if (this.vertexBuffer)
            {
                return;
            };
            this.initProgram(_arg_1);
            var _local_4:int = _arg_2.length;
            this.mIndexBuffer = new Vector.<uint>();
            this.mVertexBuffer = new Vector.<Number>();
            var _local_6:Dictionary = new Dictionary();
            var _local_8:uint;
            _local_3 = 0;
            while (_local_3 < _local_4)
            {
                _local_9 = _arg_2[_local_3];
                _local_7 = ((_local_9.v1.uid + ".") + _local_9.uv1.uid);
                if (_local_6[_local_7] == undefined)
                {
                    this.addVertex(_arg_1, this.mVertexBuffer, _local_9.v1, _local_9.uv1, _local_9);
                    _local_6[_local_7] = _local_8;
                    this.mIndexBuffer.push(_local_8);
                    _local_9.v1.bufferIdx = _local_8;
                    _local_8++;
                }
                else
                {
                    this.mIndexBuffer.push(_local_6[_local_7]);
                };
                _local_7 = ((_local_9.v2.uid + ".") + _local_9.uv2.uid);
                if (_local_6[_local_7] == undefined)
                {
                    this.addVertex(_arg_1, this.mVertexBuffer, _local_9.v2, _local_9.uv2, _local_9);
                    _local_6[_local_7] = _local_8;
                    this.mIndexBuffer.push(_local_8);
                    _local_9.v2.bufferIdx = _local_8;
                    _local_8++;
                }
                else
                {
                    this.mIndexBuffer.push(_local_6[_local_7]);
                };
                _local_7 = ((_local_9.v3.uid + ".") + _local_9.uv3.uid);
                if (_local_6[_local_7] == undefined)
                {
                    this.addVertex(_arg_1, this.mVertexBuffer, _local_9.v3, _local_9.uv3, _local_9);
                    _local_6[_local_7] = _local_8;
                    this.mIndexBuffer.push(_local_8);
                    _local_9.v3.bufferIdx = _local_8;
                    _local_8++;
                }
                else
                {
                    this.mIndexBuffer.push(_local_6[_local_7]);
                };
                _local_3++;
            };
            _local_6 = null;
            _local_5 = int((this.mVertexBuffer.length / this.shaderData.numFloatsPerVertex));
            this.vertexBuffer = _arg_1.createVertexBuffer(_local_5, this.shaderData.numFloatsPerVertex);
            this.vertexBuffer.uploadFromVector(this.mVertexBuffer, 0, _local_5);
            if (!this.indexBuffer)
            {
                this.indexBuffer = _arg_1.createIndexBuffer(this.mIndexBuffer.length);
                this.indexBuffer.uploadFromVector(this.mIndexBuffer, 0, this.mIndexBuffer.length);
                this.numTris = int((this.mIndexBuffer.length / 3));
            };
        }

        protected function prepareForRender(_arg_1:Context3D):void
        {
            _arg_1.setProgram(this.shaderData.shader);
            _arg_1.setBlendFactors(this.blendMode.src, this.blendMode.dst);
            if (this.needUploadVertexBuffer)
            {
                this.needUploadVertexBuffer = false;
                this.vertexBuffer.uploadFromVector(this.mVertexBuffer, 0, (this.mVertexBuffer.length / this.shaderData.numFloatsPerVertex));
            };
        }

        public function handleDeviceLoss():void
        {
            this.indexBuffer = null;
            this.vertexBuffer = null;
            this.mIndexBuffer = null;
            this.mVertexBuffer = null;
            this.shaderData = null;
            this.needUploadVertexBuffer = true;
        }

        public function render(_arg_1:Context3D, _arg_2:Vector.<Face>, _arg_3:uint, _arg_4:uint):void
        {
            this.generateBufferData(_arg_1, _arg_2);
            this.prepareForRender(_arg_1);
            _arg_1.drawTriangles(this.indexBuffer, (_arg_3 * 3), _arg_4);
            this.clearAfterRender(_arg_1);
        }

        protected function clearAfterRender(_arg_1:Context3D):void
        {
            throw (new Error("You have to implement clearAfterRender for your material"));
        }

        protected function initProgram(_arg_1:Context3D):void
        {
            throw (new Error("You have to implement initProgram for your material"));
        }

        protected function refreshClipspaceMatrix():Matrix3D
        {
            this.clipSpaceMatrix.identity();
            this.clipSpaceMatrix.append(this.modelMatrix);
            this.clipSpaceMatrix.append(this.viewProjectionMatrix);
            return (this.clipSpaceMatrix);
        }

        protected function addVertex(_arg_1:Context3D, _arg_2:Vector.<Number>, _arg_3:Vertex, _arg_4:UV, _arg_5:Face):void
        {
            throw (new Error("You have to implement addVertex for your material"));
        }

        protected function fillBuffer(_arg_1:Vector.<Number>, _arg_2:Vertex, _arg_3:UV, _arg_4:Face, _arg_5:String, _arg_6:int):void
        {
            if (_arg_5 == VERTEX_POSITION)
            {
                _arg_1.push(_arg_2.x, _arg_2.y);
                if (_arg_6 >= 3)
                {
                    _arg_1.push(_arg_2.z);
                };
                if (_arg_6 == 4)
                {
                    _arg_1.push(_arg_2.w);
                };
            };
            if (_arg_5 == VERTEX_UV)
            {
                _arg_1.push(_arg_3.u, _arg_3.v);
                if (_arg_6 == 3)
                {
                    _arg_1.push(0);
                };
                if (_arg_6 == 4)
                {
                    _arg_1.push(0, 0);
                };
            };
            if (_arg_5 == VERTEX_COLOR)
            {
                _arg_1.push(_arg_2.r, _arg_2.g, _arg_2.b);
                if (_arg_6 == 4)
                {
                    _arg_1.push(_arg_2.a);
                };
            };
        }

        public function dispose():void
        {
            if (this.indexBuffer)
            {
                this.indexBuffer.dispose();
                this.indexBuffer = null;
            };
            if (this.vertexBuffer)
            {
                this.vertexBuffer.dispose();
                this.vertexBuffer = null;
            };
            if (this.shaderData)
            {
                this.shaderData = null;
            };
        }


    }
}//package de.nulldesign.nd2d.materials

