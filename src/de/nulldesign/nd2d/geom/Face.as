


//de.nulldesign.nd2d.geom.Face

package de.nulldesign.nd2d.geom
{
    import flash.geom.Vector3D;

    public class Face 
    {

        public var idx:uint = 0;
        public var v1:Vertex;
        public var v2:Vertex;
        public var v3:Vertex;
        public var uv1:UV;
        public var uv2:UV;
        public var uv3:UV;

        public function Face(_arg_1:Vertex, _arg_2:Vertex, _arg_3:Vertex, _arg_4:UV=null, _arg_5:UV=null, _arg_6:UV=null)
        {
            this.v1 = _arg_1;
            this.v2 = _arg_2;
            this.v3 = _arg_3;
            this.uv1 = _arg_4;
            this.uv2 = _arg_5;
            this.uv3 = _arg_6;
        }

        public static function getNormalFromVertices(_arg_1:Vertex, _arg_2:Vertex, _arg_3:Vertex):Vector3D
        {
            var _local_4:Vertex;
            var _local_5:Vertex;
            var _local_6:Vector3D;
            _local_4 = new Vertex((_arg_2.x - _arg_1.x), (_arg_2.y - _arg_1.y), (_arg_2.z - _arg_1.z));
            _local_5 = new Vertex((_arg_2.x - _arg_3.x), (_arg_2.y - _arg_3.y), (_arg_2.z - _arg_3.z));
            _local_6 = _local_5.crossProduct(_local_4);
            _local_6.normalize();
            return (_local_6);
        }


        public function getNormal():Vector3D
        {
            return (getNormalFromVertices(this.v1, this.v2, this.v3));
        }

        public function clone():Face
        {
            return (new Face((this.v1.clone() as Vertex), (this.v2.clone() as Vertex), (this.v3.clone() as Vertex), ((this.uv1) ? this.uv1.clone() : null), ((this.uv2) ? this.uv2.clone() : null), ((this.uv3) ? this.uv3.clone() : null)));
        }

        public function toString():String
        {
            return ((((((((((("Face: " + this.v1) + "/") + this.v2) + "/") + this.v3) + " / ") + this.uv1) + " / ") + this.uv2) + " / ") + this.uv3);
        }


    }
}//package de.nulldesign.nd2d.geom

