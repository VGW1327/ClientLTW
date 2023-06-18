


//de.nulldesign.nd2d.materials.texture.TextureOption

package de.nulldesign.nd2d.materials.texture
{
    public class TextureOption 
    {

        public static const MIPMAP_DISABLE:uint = 1;
        public static const MIPMAP_NEAREST:uint = 2;
        public static const MIPMAP_LINEAR:uint = 4;
        public static const FILTERING_NEAREST:uint = 8;
        public static const FILTERING_LINEAR:uint = 16;
        public static const REPEAT_NORMAL:uint = 32;
        public static const REPEAT_CLAMP:uint = 64;
        public static const QUALITY_LOW:uint = ((MIPMAP_DISABLE | FILTERING_NEAREST) | REPEAT_NORMAL);
        public static const QUALITY_MEDIUM:uint = ((MIPMAP_DISABLE | FILTERING_LINEAR) | REPEAT_NORMAL);
        public static const QUALITY_HIGH:uint = ((MIPMAP_NEAREST | FILTERING_LINEAR) | REPEAT_NORMAL);
        public static const QUALITY_ULTRA:uint = ((MIPMAP_LINEAR | FILTERING_LINEAR) | REPEAT_NORMAL);


    }
}//package de.nulldesign.nd2d.materials.texture

