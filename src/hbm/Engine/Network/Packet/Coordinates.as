


//hbm.Engine.Network.Packet.Coordinates

package hbm.Engine.Network.Packet
{
    import flash.utils.ByteArray;

    public class Coordinates 
    {

        public static const CONVERT_DIR_SERVER:Array = [0, 7, 6, 5, 4, 3, 2, 1];

        private var _x:uint;
        private var _y:uint;
        private var _dir:uint;
        private var _x1:uint;
        private var _y1:uint;
        private var _sx0:uint;
        private var _sy0:uint;
        private var _isNeedFindPath:Boolean = true;
        private var _syncTime:uint;


        public function SetEncoded3(_arg_1:ByteArray):void
        {
            this._x = (((_arg_1[0] << 2) | (_arg_1[1] >> 6)) & 0x03FF);
            this._y = (((_arg_1[1] << 4) | (_arg_1[2] >> 4)) & 0x03FF);
            this._dir = CONVERT_DIR_SERVER[(_arg_1[2] & 0x0F)];
        }

        public function SetEncoded6(_arg_1:ByteArray):void
        {
            this._x = (((_arg_1[0] << 2) | (_arg_1[1] >> 6)) & 0x03FF);
            this._y = (((_arg_1[1] << 4) | (_arg_1[2] >> 4)) & 0x03FF);
            this._x1 = (((_arg_1[2] << 6) | (_arg_1[3] >> 2)) & 0x03FF);
            this._y1 = (((_arg_1[3] << 8) | _arg_1[4]) & 0x03FF);
            this._sx0 = ((_arg_1[5] >> 4) & 0x0F);
            this._sy0 = (_arg_1[5] & 0x0F);
        }

        public function GetEncoded3():ByteArray
        {
            var _local_1:ByteArray = new ByteArray();
            _local_1.writeByte((this._x >> 2));
            _local_1.writeByte(((this._x << 6) | ((this._y >> 4) & 0x3F)));
            _local_1.writeByte(((this._y << 4) | (CONVERT_DIR_SERVER[this.dir] & 0x0F)));
            return (_local_1);
        }

        public function GetEncoded6():ByteArray
        {
            var _local_1:ByteArray = new ByteArray();
            _local_1.writeByte((this._x >> 2));
            _local_1.writeByte(((this._x << 6) | ((this._y >> 4) & 0x3F)));
            _local_1.writeByte(((this._y << 4) | ((this._x1 >> 6) & 0x0F)));
            _local_1.writeByte(((this._x1 << 2) | ((this._y1 >> 8) & 0x03)));
            _local_1.writeByte(this._y1);
            _local_1.writeByte(((this._sx0 << 4) | (this._sy0 & 0x0F)));
            return (_local_1);
        }

        public function From():String
        {
            return (((("at (" + this.x) + ":") + this.y) + ")");
        }

        public function To():String
        {
            return (((("to (" + this.x1) + ":") + this.y1) + ")");
        }

        public function get x():uint
        {
            return (this._x);
        }

        public function set x(_arg_1:uint):void
        {
            this._x = (_arg_1 & 0x03FF);
        }

        public function get y():uint
        {
            return (this._y);
        }

        public function set y(_arg_1:uint):void
        {
            this._y = (_arg_1 & 0x03FF);
        }

        public function get dir():uint
        {
            return (this._dir);
        }

        public function set dir(_arg_1:uint):void
        {
            this._dir = (_arg_1 & 0x0F);
        }

        public function get x1():uint
        {
            return (this._x1);
        }

        public function set x1(_arg_1:uint):void
        {
            this._x1 = (_arg_1 & 0x03FF);
        }

        public function get y1():uint
        {
            return (this._y1);
        }

        public function set y1(_arg_1:uint):void
        {
            this._y1 = (_arg_1 & 0x03FF);
        }

        public function get isNeedFindPath():Boolean
        {
            return (this._isNeedFindPath);
        }

        public function set isNeedFindPath(_arg_1:Boolean):void
        {
            this._isNeedFindPath = _arg_1;
        }

        public function get syncTime():uint
        {
            return (this._syncTime);
        }

        public function set syncTime(_arg_1:uint):void
        {
            this._syncTime = _arg_1;
        }


    }
}//package hbm.Engine.Network.Packet

