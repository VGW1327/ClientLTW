


//de.nulldesign.nd2d.materials.BlendModePresets

package de.nulldesign.nd2d.materials
{
    import de.nulldesign.nd2d.utils.NodeBlendMode;
    import flash.display3D.Context3DBlendFactor;

    public class BlendModePresets 
    {

        public static const BLEND:NodeBlendMode = new NodeBlendMode(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
        public static const FILTER:NodeBlendMode = new NodeBlendMode(Context3DBlendFactor.DESTINATION_COLOR, Context3DBlendFactor.ZERO);
        public static const MODULATE:NodeBlendMode = new NodeBlendMode(Context3DBlendFactor.DESTINATION_COLOR, Context3DBlendFactor.ZERO);
        public static const NORMAL_PREMULTIPLIED_ALPHA:NodeBlendMode = new NodeBlendMode(Context3DBlendFactor.ONE, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
        public static const NORMAL_NO_PREMULTIPLIED_ALPHA:NodeBlendMode = new NodeBlendMode(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
        public static const ADD_NO_PREMULTIPLIED_ALPHA:NodeBlendMode = new NodeBlendMode(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE);
        public static const ADD_PREMULTIPLIED_ALPHA:NodeBlendMode = new NodeBlendMode(Context3DBlendFactor.ONE, Context3DBlendFactor.ONE);


    }
}//package de.nulldesign.nd2d.materials

