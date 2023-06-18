


//hbm.Engine.Network.Events.FriendVisitEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class FriendVisitEvent extends Event 
    {

        public static const ON_CHECK_FRIEND_VISIT:String = "ON_CHECK_FRIEND_VISIT";
        public static const RESULT_VISIT:uint = 0;
        public static const RESULT_NOT_VISIT:uint = 0x0100;
        public static const RESULT_TIME_ESCAPE:uint = 0x0200;

        private var _result:uint;
        private var _bgIndex:uint;

        public function FriendVisitEvent(_arg_1:uint, _arg_2:uint)
        {
            super(ON_CHECK_FRIEND_VISIT);
            this._result = _arg_1;
            this._bgIndex = _arg_2;
        }

        public function get Result():uint
        {
            return (this._result);
        }

        public function get BGIndex():uint
        {
            return (this._bgIndex);
        }


    }
}//package hbm.Engine.Network.Events

