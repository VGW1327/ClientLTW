


//hbm.Engine.Network.TransmissionObject.TransmissionObject

package hbm.Engine.Network.TransmissionObject
{
    import flash.events.EventDispatcher;
    import flash.net.Socket;
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;

    public class TransmissionObject extends EventDispatcher 
    {

        private static var _instance:TransmissionObject;
        public static const ON_CONNECTED:String = "ON_CONNECTED";
        public static const ON_CONNECT_ERROR:String = "ON_CONNECT_ERROR";
        public static const ON_DATAREADY:String = "ON_DATAREADY";
        public static const ON_EXCEPTION:String = "ON_EXCEPTION";

        private var _socket:Socket;
        private var _inputBufferData:ByteArray;

        public function TransmissionObject():void
        {
        }

        public static function get Instance():TransmissionObject
        {
            if (_instance == null)
            {
                _instance = new (TransmissionObject)();
            };
            return (_instance);
        }


        public function Connect(_arg_1:String, _arg_2:int):void
        {
            this._socket = new Socket();
            this._inputBufferData = new ByteArray();
            this.Endian = flash.utils.Endian.LITTLE_ENDIAN;
            this._socket.addEventListener(Event.CLOSE, this.CloseHandler);
            this._socket.addEventListener(Event.CONNECT, this.ConnectHandler);
            this._socket.addEventListener(IOErrorEvent.IO_ERROR, this.IoErrorHandler);
            this._socket.addEventListener(ProgressEvent.SOCKET_DATA, this.SocketDataHandler);
            this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.SecurityErrorHandler);
            this._socket.connect(_arg_1, _arg_2);
        }

        public function Close():void
        {
            try
            {
				//this._socket.removeEventListener(Event.CONNECT, this.ConnectHandler);
                //this._socket.removeEventListener(Event.CLOSE, this.CloseHandler);
                //this._socket.removeEventListener(IOErrorEvent.IO_ERROR, this.IoErrorHandler);
				//this._socket.removeEventListener(ProgressEvent.SOCKET_DATA, this.SocketDataHandler);
                //this._socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.SecurityErrorHandler);
                //this._socket.close();
				this._socket = null;
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
        }

        public function Flush():void
        {
            try
            {
                this._socket.flush();
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
        }

        public function get Endian():String
        {
            return (this._socket.endian);
        }

        public function set Endian(_arg_1:String):void
        {
            this._socket.endian = _arg_1;
            this._inputBufferData.endian = _arg_1;
        }

        public function WriteInt8(value:int):void
        {
            try
            {
                this._socket.writeByte(value);
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
        }

        public function ReadInt8():int
        {
            try
            {
                return (this._inputBufferData.readByte());
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
            return (0);
        }

        public function WriteUInt8(value:uint):void
        {
            try
            {
                this._socket.writeByte(int(value));
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
        }

        public function ReadUInt8():uint
        {
            try
            {
                return (this._inputBufferData.readUnsignedByte());
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
            return (0);
        }

        public function WriteInt16(value:int):void
        {
            try
            {
                this._socket.writeShort(value);
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
        }

        public function ReadInt16():int
        {
            try
            {
                return (this._inputBufferData.readShort());
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
            return (0);
        }

        public function WriteUInt16(value:uint):void
        {
            try
            {
                this._socket.writeShort(int(value));
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
        }

        public function ReadUInt16():uint
        {
            try
            {
                return (this._inputBufferData.readUnsignedShort());
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
            return (0);
        }

        public function WriteInt32(value:int):void
        {
            try
            {
                this._socket.writeInt(value);
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
        }

        public function ReadInt32():int
        {
            try
            {
                return (this._inputBufferData.readInt());
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
            return (0);
        }

        public function WriteUInt32(value:uint):void
        {
            try
            {
                this._socket.writeUnsignedInt(value);
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
        }

        public function ReadUInt32():uint
        {
            try
            {
                return (this._inputBufferData.readUnsignedInt());
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
            return (0);
        }

        public function WriteBytes(value:ByteArray):void
        {
            try
            {
                this._socket.writeBytes(value);
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
        }

        public function ReadBytes(value:ByteArray, offset:uint=0, length:uint=0):void
        {
            try
            {
                this._inputBufferData.readBytes(value, offset, length);
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
        }

        public function WriteString(value:String, length:int=0):void
        {
            var buffer:ByteArray;
            var i:int;
            try
            {
                if (length > 0)
                {
                    buffer = new ByteArray();
                    buffer.endian = flash.utils.Endian.LITTLE_ENDIAN;
                    i = 0;
                    while (i < length)
                    {
                        buffer.writeByte(0);
                        i = (i + 1);
                    };
                    buffer.position = 0;
                    buffer.writeMultiByte(value.substr(0, length), "windows-1251");
                    this._socket.writeBytes(buffer);
                }
                else
                {
                    this._socket.writeMultiByte(value, "windows-1251");
                };
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
        }

        public function ReadString(length:uint):String
        {
            try
            {
                return (this._inputBufferData.readMultiByte(length, "windows-1251"));
            }
            catch(e:Error)
            {
                dispatchEvent(new Event(ON_EXCEPTION));
            };
            return ("");
        }

        public function get BytesAvailable():uint
        {
            return (this._inputBufferData.bytesAvailable);
        }

        public function get IsConnected():Boolean
        {
            if (this._socket == null)
            {
                return (false);
            };
            return (this._socket.connected);
        }

        public function get BufferPosition():uint
        {
            return (this._inputBufferData.position);
        }

        public function set BufferPosition(_arg_1:uint):void
        {
            this._inputBufferData.position = _arg_1;
        }

        public function ClearBuffer():void
        {
            this._inputBufferData = new ByteArray();
            this._inputBufferData.endian = flash.utils.Endian.LITTLE_ENDIAN;
        }

        private function CloseHandler(_arg_1:Event):void
        {
        }

        private function ConnectHandler(_arg_1:Event):void
        {
            dispatchEvent(new Event(ON_CONNECTED));
        }

        private function IoErrorHandler(_arg_1:IOErrorEvent):void
        {
            dispatchEvent(new Event(ON_CONNECT_ERROR));
        }

        private function SecurityErrorHandler(_arg_1:SecurityErrorEvent):void
        {
            dispatchEvent(new Event(ON_EXCEPTION));
        }

        /*public function ByteArrayToHex(_arg_1:ByteArray):String
        {
            var _local_5:String;
            var _local_2:* = "";
            var _local_3:uint = _arg_1.position;
            var _local_4:int = _local_3;
            while (_local_4 < _arg_1.length)
            {
                _local_5 = _arg_1.readUnsignedByte().toString(16);
                if (((_local_4 < (_local_3 + 10)) || (_local_4 > (_arg_1.length - 4))))
                {
                    if (_local_5.length < 2)
                    {
                        _local_5 = ("0" + _local_5);
                    };
                    _local_2 = (_local_2 + (("0x" + _local_5) + " "));
                }
                else
                {
                    if (_local_4 == (_local_3 + 10))
                    {
                        _local_2 = (_local_2 + "... ");
                    };
                };
                _local_4++;
            };
            _arg_1.position = _local_3;
            return (_local_2);
        }*/

        private function SocketDataHandler(_arg_1:ProgressEvent):void
        {
            var _local_2:int = this._socket.bytesAvailable;
            var _local_3:int = this._inputBufferData.position;
            this._socket.readBytes(this._inputBufferData, this._inputBufferData.length, _local_2);
            this._inputBufferData.position = _local_3;
            dispatchEvent(new Event(ON_DATAREADY));
			trace(" SocketDataHandler= " + _local_2, _local_3,  this._inputBufferData );
        }

        private function OnRemove(_arg_1:Event):void
        {
            this._socket.close();
        }


    }
}//package hbm.Engine.Network.TransmissionObject

