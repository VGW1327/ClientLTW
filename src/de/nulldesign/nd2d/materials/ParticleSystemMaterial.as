


//de.nulldesign.nd2d.materials.ParticleSystemMaterial

package de.nulldesign.nd2d.materials
{
    import de.nulldesign.nd2d.materials.texture.Texture2D;
    import flash.geom.Point;
    import flash.display3D.Context3DVertexBufferFormat;
    import flash.display3D.Context3DProgramType;
    import flash.display3D.Context3D;
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.geom.Vertex;
    import de.nulldesign.nd2d.geom.UV;
    import de.nulldesign.nd2d.geom.Face;
    import de.nulldesign.nd2d.geom.ParticleVertex;
    import de.nulldesign.nd2d.materials.shader.ShaderCache;

    public class ParticleSystemMaterial extends AMaterial 
    {

        private const BURST_SHADER_PART:String = "";
        private const REPEAT_SHADER_PART:String = "frc vt0, vt0 \n";
        private const VERTEX_SHADER:String = ((((((((((((((((((((("sub vt0, vc4, va2.x        \n" + "div vt0, vt0, va2.y        \n") + "[PARTICLES_REPEAT]") + "sat vt0, vt0               \n") + "mov vt1.xy, va3.xy         \n") + "mul vt2 vc5.xy, vt0        \n") + "add vt1.xy, vt1.xy, vt2.xy \n") + "mul vt1.xy, vt1.xy, vt0.xy \n") + "sub vt2.x, va0.w, vt0.x    \n") + "mul vt3.x va2.z, vt2.x     \n") + "mul vt2.x, va2.w, vt0.x    \n") + "add vt3.x, vt3.x, vt2.x    \n") + "mov vt2, va0               \n") + "mul vt2.xy, vt2.xy, vt3.x  \n") + "add vt2.xy, vt2.xy, va3.zw \n") + "add vt2.xy, vt2.xy, vt1.xy \n") + "m44 op, vt2, vc0           \n") + "mov v0, va1                \n") + "sub vt2.x, va0.w, vt0.x    \n") + "mul vt3, va4, vt2.x        \n") + "mul vt4, va5, vt0.x        \n") + "add v1, vt3, vt4           \n");
        private const PREMULTIPLIED_ALPHA_PART:String = ("mul ft0, ft0, v1\t\n" + "mul oc, ft0, v1.w  \n");
        private const NON_PREMULTIPLIED_ALPHA_PART:String = "mul oc, ft0, v1 \n";
        private const FRAGMENT_SHADER:String = ("tex ft0, v0, fs0 <TEXTURE_SAMPLING_OPTIONS>  \n" + "[PARTICLES_COLOR_CALCULATION]");

        protected var texture:Texture2D;
        public var gravity:Point;
        public var currentTime:Number;
        protected var burst:Boolean;

        public function ParticleSystemMaterial(_arg_1:Texture2D, _arg_2:Boolean)
        {
            this.texture = _arg_1;
            this.drawCalls = 1;
            this.burst = _arg_2;
        }

        override public function handleDeviceLoss():void
        {
            super.handleDeviceLoss();
            this.texture.texture = null;
            shaderData = null;
        }

        override protected function prepareForRender(_arg_1:Context3D):void
        {
            super.prepareForRender(_arg_1);
            refreshClipspaceMatrix();
            _arg_1.setTextureAt(0, this.texture.getTexture(_arg_1));
            _arg_1.setVertexBufferAt(0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
            _arg_1.setVertexBufferAt(1, vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_2);
            _arg_1.setVertexBufferAt(2, vertexBuffer, 4, Context3DVertexBufferFormat.FLOAT_4);
            _arg_1.setVertexBufferAt(3, vertexBuffer, 8, Context3DVertexBufferFormat.FLOAT_4);
            _arg_1.setVertexBufferAt(4, vertexBuffer, 12, Context3DVertexBufferFormat.FLOAT_4);
            _arg_1.setVertexBufferAt(5, vertexBuffer, 16, Context3DVertexBufferFormat.FLOAT_4);
            _arg_1.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, clipSpaceMatrix, true);
            programConstVector[0] = this.currentTime;
            programConstVector[1] = this.currentTime;
            programConstVector[2] = this.currentTime;
            programConstVector[3] = this.currentTime;
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, programConstVector);
            programConstVector[0] = this.gravity.x;
            programConstVector[1] = this.gravity.y;
            programConstVector[2] = 0;
            programConstVector[3] = 1;
            _arg_1.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 5, programConstVector);
        }

        override protected function clearAfterRender(_arg_1:Context3D):void
        {
            _arg_1.setTextureAt(0, null);
            _arg_1.setVertexBufferAt(0, null);
            _arg_1.setVertexBufferAt(1, null);
            _arg_1.setVertexBufferAt(2, null);
            _arg_1.setVertexBufferAt(3, null);
            _arg_1.setVertexBufferAt(4, null);
            _arg_1.setVertexBufferAt(5, null);
        }

        override protected function addVertex(_arg_1:Context3D, _arg_2:Vector.<Number>, _arg_3:Vertex, _arg_4:UV, _arg_5:Face):void
        {
            this.fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, VERTEX_POSITION, 2);
            this.fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, VERTEX_UV, 2);
            this.fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, "PB3D_MISC", 4);
            this.fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, "PB3D_VELOCITY", 4);
            this.fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, "PB3D_STARTCOLOR", 4);
            this.fillBuffer(_arg_2, _arg_3, _arg_4, _arg_5, "PB3D_ENDCOLOR", 4);
        }

        override protected function fillBuffer(_arg_1:Vector.<Number>, _arg_2:Vertex, _arg_3:UV, _arg_4:Face, _arg_5:String, _arg_6:int):void
        {
            super.fillBuffer(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            var _local_7:ParticleVertex = ParticleVertex(_arg_2);
            if (_arg_5 == "PB3D_VELOCITY")
            {
                _arg_1.push(_local_7.vx, _local_7.vy, _local_7.startX, _local_7.startY);
            };
            if (_arg_5 == "PB3D_MISC")
            {
                _arg_1.push(_local_7.startTime, _local_7.life, _local_7.startSize, _local_7.endSize);
            };
            if (_arg_5 == "PB3D_ENDCOLOR")
            {
                _arg_1.push(_local_7.endColorR, _local_7.endColorG, _local_7.endColorB, _local_7.endAlpha);
            };
            if (_arg_5 == "PB3D_STARTCOLOR")
            {
                _arg_1.push(_local_7.startColorR, _local_7.startColorG, _local_7.startColorB, _local_7.startAlpha);
            };
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

        override protected function initProgram(_arg_1:Context3D):void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:uint;
            if (!shaderData)
            {
                if (this.burst)
                {
                    _local_4 = 1000;
                    _local_2 = this.VERTEX_SHADER.replace("[PARTICLES_REPEAT]", this.BURST_SHADER_PART);
                }
                else
                {
                    _local_4 = 2000;
                    _local_2 = this.VERTEX_SHADER.replace("[PARTICLES_REPEAT]", this.REPEAT_SHADER_PART);
                };
                if (this.texture.hasPremultipliedAlpha)
                {
                    _local_4 = (_local_4 + 100);
                    _local_3 = this.FRAGMENT_SHADER.replace("[PARTICLES_COLOR_CALCULATION]", this.PREMULTIPLIED_ALPHA_PART);
                }
                else
                {
                    _local_4 = (_local_4 + 200);
                    _local_3 = this.FRAGMENT_SHADER.replace("[PARTICLES_COLOR_CALCULATION]", this.NON_PREMULTIPLIED_ALPHA_PART);
                };
                shaderData = ShaderCache.getInstance().getShader(_arg_1, this, _local_2, _local_3, 20, this.texture.textureOptions, _local_4);
            };
        }


    }
}//package de.nulldesign.nd2d.materials

