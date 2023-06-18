


//hbm.Engine.Network.Client.CharServerInfo

package hbm.Engine.Network.Client
{
    import hbm.Engine.Network.TransmissionObject.TransmissionObject;

    public class CharServerInfo 
    {

        private var _address1:int;
        private var _address2:int;
        private var _address3:int;
        private var _address4:int;
        private var _ipAddress:String;
        private var _port:int;
        private var _name:String;
        private var _users:int;
        private var _maintenance:int;
        private var _new:int;


        public function ReadFromStream():Boolean
        {
			trace("ReadFromStream");
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 32)
            {
                return (false);
            };
            this._address1 = TransmissionObject.Instance.ReadUInt8();
			trace("_address1 = " + this._address1);
            this._address2 = TransmissionObject.Instance.ReadUInt8();
            this._address3 = TransmissionObject.Instance.ReadUInt8();
            this._address4 = TransmissionObject.Instance.ReadUInt8();
            this._port = TransmissionObject.Instance.ReadUInt16();
            this._name = TransmissionObject.Instance.ReadString(20);
            this._users = TransmissionObject.Instance.ReadUInt16();
            this._maintenance = TransmissionObject.Instance.ReadUInt16();
            this._new = TransmissionObject.Instance.ReadUInt16();
            this._ipAddress = ((((((this._address1 + ".") + this._address2) + ".") + this._address3) + ".") + this._address4);
			trace("CharServerInfo ReadFromStream= " + this._ipAddress, this._port, this._name, this._users, this._maintenance, this._new);
            return (true);
        }

        public function get ipAddress():String
        {
            return (this._ipAddress);
        }

        public function get port():int
        {
            return (this._port);
        }

        public function get name():String
        {
            return (this._name);
        }


    }
}//package hbm.Engine.Network.Client

