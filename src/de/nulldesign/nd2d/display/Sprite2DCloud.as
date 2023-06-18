


//de.nulldesign.nd2d.display.Sprite2DCloud

package de.nulldesign.nd2d.display
{
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.geom.Face;
    import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
    import de.nulldesign.nd2d.materials.texture.Texture2D;
    import de.nulldesign.nd2d.geom.Vertex;
    import de.nulldesign.nd2d.geom.UV;
    import de.nulldesign.nd2d.materials.shader.Shader2D;
    import flash.display3D.IndexBuffer3D;
    import flash.display3D.VertexBuffer3D;
    import flash.geom.Matrix3D;
    import de.nulldesign.nd2d.utils.TextureHelper;
    import flash.display3D.Context3D;
    import de.nulldesign.nd2d.utils.StatsObject;
    import de.nulldesign.nd2d.materials.shader.ShaderCache;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import de.nulldesign.nd2d.utils.VectorUtil;
    import flash.display3D.Context3DVertexBufferFormat;
    import flash.display3D.Context3DProgramType;
    import __AS3__.vec.*;

    public class Sprite2DCloud extends Node2D 
    {

        protected const numFloatsPerVertex:uint = 12;
        protected const DEFAULT_VERTEX_SHADER:String = ((("m44 op, va0, vc0   \n" + "mov v0, va1\t\t\n") + "mov v1, va2\t\t\n") + "mov v2, va3\t\t\n");
        protected const DEFAULT_FRAGMENT_SHADER:String = (("tex ft0, v0, fs0 <TEXTURE_SAMPLING_OPTIONS>\n" + "mul ft0, ft0, v1\n") + "add oc, ft0, v2\n");

        protected var faceList:Vector.<Face>;
        protected var spriteSheet:ASpriteSheetBase;
        protected var texture:Texture2D;
        protected var v1:Vertex;
        protected var v2:Vertex;
        protected var v3:Vertex;
        protected var v4:Vertex;
        protected var uv1:UV;
        protected var uv2:UV;
        protected var uv3:UV;
        protected var uv4:UV;
        protected var shaderData:Shader2D;
        protected var indexBuffer:IndexBuffer3D;
        protected var vertexBuffer:VertexBuffer3D;
        protected var mVertexBuffer:Vector.<Number>;
        protected var mIndexBuffer:Vector.<uint>;
        protected var uvInited:Boolean = false;
        protected var maxCapacity:uint;
        protected var isInvalidatedColors:Boolean = false;
        protected var clipSpaceMatrix:Matrix3D = new Matrix3D();

        public function Sprite2DCloud(_arg_1:uint, _arg_2:Texture2D)
        {
            this.texture = _arg_2;
            this.faceList = TextureHelper.generateQuadFromDimensions(2, 2);
            this.v1 = this.faceList[0].v1;
            this.v2 = this.faceList[0].v2;
            this.v3 = this.faceList[0].v3;
            this.v4 = this.faceList[1].v3;
            this.uv1 = this.faceList[0].uv1;
            this.uv2 = this.faceList[0].uv2;
            this.uv3 = this.faceList[0].uv3;
            this.uv4 = this.faceList[1].uv3;
            this.maxCapacity = _arg_1;
            this.mVertexBuffer = new Vector.<Number>(((_arg_1 * this.numFloatsPerVertex) * 4), true);
            this.mIndexBuffer = new Vector.<uint>((_arg_1 * 6), true);
        }

        public function setSpriteSheet(_arg_1:ASpriteSheetBase):void
        {
            this.spriteSheet = _arg_1;
        }

        override public function get numTris():uint
        {
            return (children.length * 2);
        }

        override public function get drawCalls():uint
        {
            return (1);
        }

        override public function addChildAt(_arg_1:Node2D, _arg_2:uint):Node2D
        {
            var _local_3:Sprite2D;
            var _local_4:int;
            if ((_arg_1 is Sprite2DCloud))
            {
                throw (new Error("You can't nest Sprite2DClouds"));
            };
            if (((children.length < this.maxCapacity) || (!(getChildIndex(_arg_1) == -1))))
            {
                super.addChildAt(_arg_1, _arg_2);
                _local_3 = (_arg_1 as Sprite2D);
                if (((this.spriteSheet) && (!(_local_3.spriteSheet))))
                {
                    _local_3.setSpriteSheet(this.spriteSheet.clone());
                };
                if (((this.texture) && (!(_local_3.texture))))
                {
                    _local_3.setTexture(this.texture);
                };
                _local_4 = 0;
                while (_local_4 < children.length)
                {
                    _local_3 = (children[_local_4] as Sprite2D);
                    _local_3.invalidateColors = true;
                    _local_3.invalidateMatrix = true;
                    _local_4++;
                };
                this.uvInited = false;
                return (_arg_1);
            };
            return (null);
        }

        override public function removeChildAt(_arg_1:uint):void
        {
            var _local_2:Sprite2D;
            var _local_3:int;
            if (_arg_1 < children.length)
            {
                super.removeChildAt(_arg_1);
                _local_3 = 0;
                while (_local_3 < children.length)
                {
                    _local_2 = (children[_local_3] as Sprite2D);
                    _local_2.invalidateColors = true;
                    _local_2.invalidateMatrix = true;
                    _local_3++;
                };
                this.uvInited = false;
            };
        }

        override public function swapChildren(_arg_1:Node2D, _arg_2:Node2D):void
        {
            super.swapChildren(_arg_1, _arg_2);
            _arg_1.invalidateColors = true;
            _arg_1.invalidateMatrix = true;
            if (Sprite2D(_arg_1).spriteSheet)
            {
                Sprite2D(_arg_1).spriteSheet.frameUpdated = true;
            };
            _arg_2.invalidateColors = true;
            _arg_2.invalidateMatrix = true;
            if (Sprite2D(_arg_2).spriteSheet)
            {
                Sprite2D(_arg_2).spriteSheet.frameUpdated = true;
            };
        }

        override public function handleDeviceLoss():void
        {
            var _local_1:Sprite2D;
            super.handleDeviceLoss();
            this.texture.texture = null;
            this.shaderData = null;
            this.vertexBuffer = null;
            this.indexBuffer = null;
            this.uvInited = false;
            var _local_2:int;
            while (_local_2 < children.length)
            {
                _local_1 = (children[_local_2] as Sprite2D);
                _local_1.invalidateColors = true;
                _local_1.invalidateMatrix = true;
                _local_2++;
            };
        }

        override public function dispose():void
        {
            super.dispose();
            if (this.vertexBuffer)
            {
                this.vertexBuffer.dispose();
                this.vertexBuffer = null;
            };
            if (this.indexBuffer)
            {
                this.indexBuffer.dispose();
                this.indexBuffer = null;
            };
            if (this.texture)
            {
                this.texture.dispose();
                this.texture = null;
            };
        }

        override internal function drawNode(_arg_1:Context3D, _arg_2:Camera2D, _arg_3:Boolean, _arg_4:StatsObject):void
        {
            if (!visible)
            {
                return;
            };
            var _local_5:Boolean;
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

        override public function updateColors():void
        {
            super.updateColors();
            this.isInvalidatedColors = true;
        }

        override protected function draw(_arg_1:Context3D, _arg_2:Camera2D):void
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_17:Sprite2D;
            var _local_19:Number;
            var _local_20:Number;
            var _local_21:Number;
            var _local_22:Number;
            var _local_23:Number;
            var _local_24:Number;
            var _local_31:Boolean;
            var _local_32:uint;
            var _local_33:uint;
            var _local_34:int;
            if (children.length == 0)
            {
                return;
            };
            this.clipSpaceMatrix.identity();
            this.clipSpaceMatrix.append(worldModelMatrix);
            this.clipSpaceMatrix.append(_arg_2.getViewProjectionMatrix(false));
            if (!this.shaderData)
            {
                this.shaderData = ShaderCache.getInstance().getShader(_arg_1, this, this.DEFAULT_VERTEX_SHADER, this.DEFAULT_FRAGMENT_SHADER, this.numFloatsPerVertex, this.texture.textureOptions);
            };
            var _local_3:uint;
            var _local_12:Rectangle = new Rectangle(0, 0, 1, 1);
            var _local_16:int = -1;
            var _local_18:uint = children.length;
            var _local_25:Boolean;
            var _local_26:Point = new Point();
            var _local_27:Number = (1 / 0xFF);
            var _local_28:Boolean;
            var _local_29:Number = (this.texture.textureWidth >> 1);
            var _local_30:Number = (this.texture.textureHeight >> 1);
            if (invalidateColors)
            {
                this.updateColors();
                this.isInvalidatedColors = true;
            };
            while (++_local_16 < _local_18)
            {
                _local_17 = Sprite2D(children[_local_16]);
                this.spriteSheet = _local_17.spriteSheet;
                _local_28 = false;
                if (((_local_17.invalidateColors) && (!(this.isInvalidatedColors))))
                {
                    _local_17.updateColors();
                    _local_28 = true;
                };
                _local_4 = _local_17.combinedColorTransform.redMultiplier;
                _local_5 = _local_17.combinedColorTransform.greenMultiplier;
                _local_6 = _local_17.combinedColorTransform.blueMultiplier;
                _local_7 = ((_local_17.visible) ? _local_17.combinedColorTransform.alphaMultiplier : 0);
                _local_8 = (_local_17.combinedColorTransform.redOffset * _local_27);
                _local_9 = (_local_17.combinedColorTransform.greenOffset * _local_27);
                _local_10 = (_local_17.combinedColorTransform.blueOffset * _local_27);
                _local_11 = ((_local_17.visible) ? (_local_17.combinedColorTransform.alphaOffset * _local_27) : 0);
                _local_31 = (!(this.uvInited));
                if (this.spriteSheet)
                {
                    _local_19 = (_local_17.scaleX * (this.spriteSheet.spriteWidth >> 1));
                    _local_20 = (_local_17.scaleY * (this.spriteSheet.spriteHeight >> 1));
                    _local_26 = this.spriteSheet.getOffsetForFrame();
                    if (((this.spriteSheet.frameUpdated) || (_local_31)))
                    {
                        this.spriteSheet.frameUpdated = false;
                        _local_12 = this.spriteSheet.getUVRectForFrame(this.texture.textureWidth, this.texture.textureHeight);
                        _local_31 = true;
                    };
                }
                else
                {
                    _local_19 = (_local_17.scaleX * _local_29);
                    _local_20 = (_local_17.scaleY * _local_30);
                    _local_26.x = 0;
                    _local_26.y = 0;
                };
                if (_local_31)
                {
                    this.mVertexBuffer[(_local_3 + 2)] = ((_local_12.width * this.uv1.u) + _local_12.x);
                    this.mVertexBuffer[(_local_3 + 3)] = ((_local_12.height * this.uv1.v) + _local_12.y);
                    this.mVertexBuffer[(_local_3 + 14)] = ((_local_12.width * this.uv2.u) + _local_12.x);
                    this.mVertexBuffer[(_local_3 + 15)] = ((_local_12.height * this.uv2.v) + _local_12.y);
                    this.mVertexBuffer[(_local_3 + 26)] = ((_local_12.width * this.uv3.u) + _local_12.x);
                    this.mVertexBuffer[(_local_3 + 27)] = ((_local_12.height * this.uv3.v) + _local_12.y);
                    this.mVertexBuffer[(_local_3 + 38)] = ((_local_12.width * this.uv4.u) + _local_12.x);
                    this.mVertexBuffer[(_local_3 + 39)] = ((_local_12.height * this.uv4.v) + _local_12.y);
                    _local_25 = true;
                };
                if (_local_17.invalidateMatrix)
                {
                    _local_13 = VectorUtil.deg2rad(_local_17.rotation);
                    _local_14 = Math.cos(_local_13);
                    _local_15 = Math.sin(_local_13);
                    _local_21 = _local_17.pivot.x;
                    _local_22 = _local_17.pivot.y;
                    _local_23 = (_local_17.x + _local_26.x);
                    _local_24 = (_local_17.y + _local_26.y);
                    this.mVertexBuffer[_local_3] = (((((this.v1.x * _local_19) - _local_21) * _local_14) - (((this.v1.y * _local_20) - _local_22) * _local_15)) + _local_23);
                    this.mVertexBuffer[(_local_3 + 1)] = (((((this.v1.x * _local_19) - _local_21) * _local_15) + (((this.v1.y * _local_20) - _local_22) * _local_14)) + _local_24);
                    this.mVertexBuffer[(_local_3 + 12)] = (((((this.v2.x * _local_19) - _local_21) * _local_14) - (((this.v2.y * _local_20) - _local_22) * _local_15)) + _local_23);
                    this.mVertexBuffer[(_local_3 + 13)] = (((((this.v2.x * _local_19) - _local_21) * _local_15) + (((this.v2.y * _local_20) - _local_22) * _local_14)) + _local_24);
                    this.mVertexBuffer[(_local_3 + 24)] = (((((this.v3.x * _local_19) - _local_21) * _local_14) - (((this.v3.y * _local_20) - _local_22) * _local_15)) + _local_23);
                    this.mVertexBuffer[(_local_3 + 25)] = (((((this.v3.x * _local_19) - _local_21) * _local_15) + (((this.v3.y * _local_20) - _local_22) * _local_14)) + _local_24);
                    this.mVertexBuffer[(_local_3 + 36)] = (((((this.v4.x * _local_19) - _local_21) * _local_14) - (((this.v4.y * _local_20) - _local_22) * _local_15)) + _local_23);
                    this.mVertexBuffer[(_local_3 + 37)] = (((((this.v4.x * _local_19) - _local_21) * _local_15) + (((this.v4.y * _local_20) - _local_22) * _local_14)) + _local_24);
                    _local_25 = true;
                };
                if ((((this.isInvalidatedColors) || (_local_28)) || (_local_17.invalidateVisibility)))
                {
                    this.mVertexBuffer[(_local_3 + 4)] = _local_4;
                    this.mVertexBuffer[(_local_3 + 5)] = _local_5;
                    this.mVertexBuffer[(_local_3 + 6)] = _local_6;
                    this.mVertexBuffer[(_local_3 + 7)] = _local_7;
                    this.mVertexBuffer[(_local_3 + 8)] = _local_8;
                    this.mVertexBuffer[(_local_3 + 9)] = _local_9;
                    this.mVertexBuffer[(_local_3 + 10)] = _local_10;
                    this.mVertexBuffer[(_local_3 + 11)] = _local_11;
                    this.mVertexBuffer[(_local_3 + 16)] = _local_4;
                    this.mVertexBuffer[(_local_3 + 17)] = _local_5;
                    this.mVertexBuffer[(_local_3 + 18)] = _local_6;
                    this.mVertexBuffer[(_local_3 + 19)] = _local_7;
                    this.mVertexBuffer[(_local_3 + 20)] = _local_8;
                    this.mVertexBuffer[(_local_3 + 21)] = _local_9;
                    this.mVertexBuffer[(_local_3 + 22)] = _local_10;
                    this.mVertexBuffer[(_local_3 + 23)] = _local_11;
                    this.mVertexBuffer[(_local_3 + 28)] = _local_4;
                    this.mVertexBuffer[(_local_3 + 29)] = _local_5;
                    this.mVertexBuffer[(_local_3 + 30)] = _local_6;
                    this.mVertexBuffer[(_local_3 + 31)] = _local_7;
                    this.mVertexBuffer[(_local_3 + 32)] = _local_8;
                    this.mVertexBuffer[(_local_3 + 33)] = _local_9;
                    this.mVertexBuffer[(_local_3 + 34)] = _local_10;
                    this.mVertexBuffer[(_local_3 + 35)] = _local_11;
                    this.mVertexBuffer[(_local_3 + 40)] = _local_4;
                    this.mVertexBuffer[(_local_3 + 41)] = _local_5;
                    this.mVertexBuffer[(_local_3 + 42)] = _local_6;
                    this.mVertexBuffer[(_local_3 + 43)] = _local_7;
                    this.mVertexBuffer[(_local_3 + 44)] = _local_8;
                    this.mVertexBuffer[(_local_3 + 45)] = _local_9;
                    this.mVertexBuffer[(_local_3 + 46)] = _local_10;
                    this.mVertexBuffer[(_local_3 + 47)] = _local_11;
                    _local_25 = true;
                };
                _local_3 = (_local_3 + 48);
                _local_17.invalidateMatrix = (_local_17.invalidateVisibility = false);
            };
            this.uvInited = true;
            this.isInvalidatedColors = false;
            if (!this.vertexBuffer)
            {
                this.vertexBuffer = _arg_1.createVertexBuffer((this.mVertexBuffer.length / this.numFloatsPerVertex), this.numFloatsPerVertex);
            };
            if (_local_25)
            {
                this.vertexBuffer.uploadFromVector(this.mVertexBuffer, 0, (this.mVertexBuffer.length / this.numFloatsPerVertex));
            };
            if (!this.indexBuffer)
            {
                _local_32 = 0;
                _local_33 = 0;
                _local_34 = -1;
                while (++_local_34 < this.maxCapacity)
                {
                    this.mIndexBuffer[_local_33] = _local_32;
                    this.mIndexBuffer[(_local_33 + 1)] = (_local_32 + 1);
                    this.mIndexBuffer[(_local_33 + 2)] = (_local_32 + 2);
                    this.mIndexBuffer[(_local_33 + 3)] = (_local_32 + 2);
                    this.mIndexBuffer[(_local_33 + 4)] = (_local_32 + 3);
                    this.mIndexBuffer[(_local_33 + 5)] = _local_32;
                    _local_32 = (_local_32 + 4);
                    _local_33 = (_local_33 + 6);
                };
                this.indexBuffer = _arg_1.createIndexBuffer(this.mIndexBuffer.length);
                this.indexBuffer.uploadFromVector(this.mIndexBuffer, 0, this.mIndexBuffer.length);
            };
            _arg_1.setTextureAt(0, this.texture.getTexture(_arg_1));
            _arg_1.setProgram(this.shaderData.shader);
            _arg_1.setVertexBufferAt(0, this.vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
            _arg_1.setVertexBufferAt(1, this.vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_2);
            _arg_1.setVertexBufferAt(2, this.vertexBuffer, 4, Context3DVertexBufferFormat.FLOAT_4);
            _arg_1.setVertexBufferAt(3, this.vertexBuffer, 8, Context3DVertexBufferFormat.FLOAT_4);
            _arg_1.setBlendFactors(blendMode.src, blendMode.dst);
            _arg_1.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, this.clipSpaceMatrix, true);
            _arg_1.drawTriangles(this.indexBuffer, 0, (2 * children.length));
            _arg_1.setTextureAt(0, null);
            _arg_1.setVertexBufferAt(0, null);
            _arg_1.setVertexBufferAt(1, null);
            _arg_1.setVertexBufferAt(2, null);
            _arg_1.setVertexBufferAt(3, null);
        }


    }
}//package de.nulldesign.nd2d.display

