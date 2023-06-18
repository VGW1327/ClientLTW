


//de.nulldesign.nd2d.materials.shader.Shader2D

package de.nulldesign.nd2d.materials.shader
{
    import flash.display3D.Program3D;
    import de.nulldesign.nd2d.materials.texture.TextureOption;
    import com.adobe.utils.AGALMiniAssembler;
    import flash.display3D.Context3DProgramType;
    import flash.display3D.Context3D;

    public class Shader2D 
    {

        public var shader:Program3D;
        public var numFloatsPerVertex:int;

        public function Shader2D(_arg_1:Context3D, _arg_2:String, _arg_3:String, _arg_4:uint, _arg_5:uint)
        {
            var _local_6:Array = ["2d"];
            var _local_7:Boolean;
            if ((_arg_5 & TextureOption.MIPMAP_DISABLE))
            {
                _local_6.push("mipnone");
            }
            else
            {
                if ((_arg_5 & TextureOption.MIPMAP_NEAREST))
                {
                    _local_6.push("mipnearest");
                }
                else
                {
                    if ((_arg_5 & TextureOption.MIPMAP_LINEAR))
                    {
                        _local_6.push("miplinear");
                    }
                    else
                    {
                        _local_7 = true;
                    };
                };
            };
            if ((_arg_5 & TextureOption.FILTERING_LINEAR))
            {
                _local_6.push("linear");
            }
            else
            {
                if ((_arg_5 & TextureOption.FILTERING_NEAREST))
                {
                    _local_6.push("nearest");
                }
                else
                {
                    _local_7 = true;
                };
            };
            if ((_arg_5 & TextureOption.REPEAT_CLAMP))
            {
                _local_6.push("clamp");
            }
            else
            {
                if ((_arg_5 & TextureOption.REPEAT_NORMAL))
                {
                    _local_6.push("repeat");
                }
                else
                {
                    _local_7 = true;
                };
            };
            if (((_local_7) && (_arg_5 > 0)))
            {
                throw (new Error("you need to specify all three texture option components. for example: myOption = MIPMAP_NEAREST | FILTERING_NEAREST | REPEAT_NORMAL;"));
            };
            var _local_8:RegExp = /TEXTURE_SAMPLING_OPTIONS/g;
            var _local_9:String = _arg_3.replace(_local_8, _local_6.join(","));
            var _local_10:AGALMiniAssembler = new AGALMiniAssembler();
            _local_10.assemble(Context3DProgramType.VERTEX, _arg_2);
            var _local_11:AGALMiniAssembler = new AGALMiniAssembler();
            _local_11.assemble(Context3DProgramType.FRAGMENT, _local_9);
            this.shader = _arg_1.createProgram();
            this.shader.upload(_local_10.agalcode, _local_11.agalcode);
            this.numFloatsPerVertex = _arg_4;
        }

    }
}//package de.nulldesign.nd2d.materials.shader

