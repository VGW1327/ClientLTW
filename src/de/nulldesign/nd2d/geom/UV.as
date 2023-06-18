


//de.nulldesign.nd2d.geom.UV

package de.nulldesign.nd2d.geom
{
    public class UV 
    {

        private static var UID_COUNT:uint = 0;

        public const uid:Number = ++UID_COUNT;

        public var u:Number;
        public var v:Number;

        public function UV(_arg_1:Number=0, _arg_2:Number=0)
        {
            this.u = _arg_1;
            this.v = _arg_2;
        }

        public function toString():String
        {
            return ((("UV: " + this.u) + " / ") + this.v);
        }

        public function clone():UV
        {
            return (new UV(this.u, this.v));
        }


    }
}//package de.nulldesign.nd2d.geom

