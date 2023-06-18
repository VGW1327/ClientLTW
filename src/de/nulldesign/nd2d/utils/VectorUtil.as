


//de.nulldesign.nd2d.utils.VectorUtil

package de.nulldesign.nd2d.utils
{
    import flash.geom.Vector3D;
    import de.nulldesign.nd2d.display.Node2D;

    public class VectorUtil 
    {

        public static const RAD_2_DEG:Number = (180 / Math.PI);//57.2957795130823
        public static const DEG_2_RAD:Number = (Math.PI / 180);//0.0174532925199433


        public static function rad2deg(_arg_1:Number):Number
        {
            return (_arg_1 * RAD_2_DEG);
        }

        public static function deg2rad(_arg_1:Number):Number
        {
            return (_arg_1 * DEG_2_RAD);
        }

        public static function rotationFromVector(_arg_1:Number, _arg_2:Number):Number
        {
            return (Math.atan2(_arg_2, _arg_1) * RAD_2_DEG);
        }

        public static function distance(_arg_1:Node2D, _arg_2:Node2D):Number
        {
            var _local_3:Vector3D;
            var _local_4:Vector3D;
            _local_3 = _arg_1.position;
            _local_4 = _arg_2.position;
            var _local_5:Number = (_local_3.x - _local_4.x);
            var _local_6:Number = (_local_3.y - _local_4.y);
            return (Math.sqrt(((_local_5 * _local_5) + (_local_6 * _local_6))));
        }


    }
}//package de.nulldesign.nd2d.utils

