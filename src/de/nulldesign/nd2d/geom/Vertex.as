


//de.nulldesign.nd2d.geom.Vertex

package de.nulldesign.nd2d.geom
{
    import flash.geom.Vector3D;

    public class Vertex extends Vector3D 
    {

        private static var UID_COUNT:uint = 0;

        public const uid:Number = ++UID_COUNT;

        public var color:uint = 0xFFFFFFFF;
        public var bufferIdx:int = -1;

        public function Vertex(_arg_1:Number=0, _arg_2:Number=0, _arg_3:Number=0)
        {
            super(_arg_1, _arg_2, _arg_3, 1);
        }

        public function get a():Number
        {
            return (((this.color >> 24) & 0xFF) / 0xFF);
        }

        public function get r():Number
        {
            return (((this.color >> 16) & 0xFF) / 0xFF);
        }

        public function get g():Number
        {
            return (((this.color >> 8) & 0xFF) / 0xFF);
        }

        public function get b():Number
        {
            return ((this.color & 0xFF) / 0xFF);
        }

        override public function clone():Vector3D
        {
            var _local_1:Vertex = new Vertex(x, y, z);
            _local_1.color = this.color;
            return (_local_1);
        }


    }
}//package de.nulldesign.nd2d.geom

