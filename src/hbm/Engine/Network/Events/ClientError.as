


//hbm.Engine.Network.Events.ClientError

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class ClientError extends Event 
    {

        public static const ON_CLIENT_ERROR:String = "ON_CLIENT_ERROR";

        private var _message:String;
        private var _state:int;
        private var _fullReload:Boolean;

        public function ClientError(_arg_1:String, _arg_2:int=0, _arg_3:Boolean=true)
        {
            super(ON_CLIENT_ERROR);
            this._message = _arg_1;
            this._state = _arg_2;
            this._fullReload = _arg_3;
        }

        public function get Message():String
        {
            return (this._message);
        }

        public function get State():int
        {
            return (this._state);
        }

        public function get fullReload():Boolean
        {
            return (this._fullReload);
        }


    }
}//package hbm.Engine.Network.Events

