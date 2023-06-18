


//de.nulldesign.nd2d.materials.shader.ShaderCache

package de.nulldesign.nd2d.materials.shader
{
    import flash.utils.getQualifiedClassName;
    import flash.display3D.Context3D;

    public class ShaderCache 
    {

        private static var instance:ShaderCache;

        private var cacheObj:Object = {};


        public static function getInstance():ShaderCache
        {
            if (!instance)
            {
                instance = new (ShaderCache)();
            };
            return (instance);
        }


        public function getShader(_arg_1:Context3D, _arg_2:Object, _arg_3:String, _arg_4:String, _arg_5:uint, _arg_6:uint, _arg_7:uint=0):Shader2D
        {
            var _local_9:Shader2D;
            var _local_8:String = getQualifiedClassName(_arg_2);
            if (((this.cacheObj[_local_8]) && (this.cacheObj[_local_8][(_arg_6 + _arg_7)])))
            {
                return (this.cacheObj[_local_8][(_arg_6 + _arg_7)]);
            };
            _local_9 = new Shader2D(_arg_1, _arg_3, _arg_4, _arg_5, _arg_6);
            if (!this.cacheObj[_local_8])
            {
                this.cacheObj[_local_8] = {};
            };
            this.cacheObj[_local_8][(_arg_6 + _arg_7)] = _local_9;
            return (_local_9);
        }

        public function handleDeviceLoss():void
        {
            this.cacheObj = {};
        }


    }
}//package de.nulldesign.nd2d.materials.shader

