


//hbm.Engine.Network.Events.InstanceEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class InstanceEvent extends Event 
    {

        public static const ON_INSTANCE_UPDATE_MAP:String = "ON_INSTANCE_UPDATE_MAP";
        public static const ON_INSTANCE_JOIN:String = "ON_INSTANCE_JOIN";
        public static const ON_INSTANCE_LEAVE:String = "ON_INSTANCE_LEAVE";
        public static const ON_INSTANCE_TIMEOUT:String = "ON_INSTANCE_TIMEOUT";
        public static const ON_INSTANCE_ERROR:String = "ON_INSTANCE_ERROR";

        private var _flag:uint;
        private var _name:String;
        private var _progress:uint;
        private var _idle:uint;

        public function InstanceEvent(_arg_1:String)
        {
            super(_arg_1);
        }

        public function get Flag():uint
        {
            return (this._flag);
        }

        public function set Flag(_arg_1:uint):void
        {
            this._flag = _arg_1;
        }

        public function get Name():String
        {
            return (this._name);
        }

        public function set Name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function get Idle():uint
        {
            return (this._idle);
        }

        public function set Idle(_arg_1:uint):void
        {
            this._idle = _arg_1;
        }

        public function get Progress():uint
        {
            return (this._progress);
        }

        public function set Progress(_arg_1:uint):void
        {
            this._progress = _arg_1;
        }


    }
}//package hbm.Engine.Network.Events

