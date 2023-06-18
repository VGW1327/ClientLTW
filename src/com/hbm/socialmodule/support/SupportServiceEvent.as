


//com.hbm.socialmodule.support.SupportServiceEvent

package com.hbm.socialmodule.support
{
    import flash.events.Event;

    public class SupportServiceEvent extends Event 
    {

        public static const MESSAGES_REQUESTED:String = "support_call_messages_requested";
        public static const MESSAGE_SENT:String = "support_call_message_sent";

        private var _call:SupportCall;

        public function SupportServiceEvent(_arg_1:String, _arg_2:SupportCall, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._call = _arg_2;
        }

        public function get call():SupportCall
        {
            return (this._call);
        }


    }
}//package com.hbm.socialmodule.support

