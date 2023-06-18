


//hbm.Engine.Collision.MapCollisionData

package hbm.Engine.Collision
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class MapCollisionData 
    {

        private var _width:int = 0;
        private var _height:int = 0;
        private var _mapData:ByteArray;

        public function MapCollisionData(_arg_1:ByteArray)
        {
            this._mapData = _arg_1;
            this._mapData.endian = Endian.LITTLE_ENDIAN;
            this._mapData.uncompress();
            this._width = this._mapData.readUnsignedShort();
            this._height = this._mapData.readUnsignedShort();
        }

        public function get Width():int
        {
            return (this._width);
        }

        public function get Height():int
        {
            return (this._height);
        }

        public function GetValue(_arg_1:int, _arg_2:int):int
        {
            if (this._mapData == null)
            {
                return (-1);
            };
            if (((((_arg_1 < 0) || (_arg_1 >= this._width)) || (_arg_2 < 0)) || (_arg_2 >= this._height)))
            {
                return (-1);
            };
            var _local_3:int = ((4 + (_arg_2 * this._width)) + _arg_1);
            return (this._mapData[_local_3]);
        }


    }
}//package hbm.Engine.Collision

