


//com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent

package com.hbm.socialmodule.rrhandlers.abstracts
{
    import flash.events.Event;

    public class RRHandlerEvent extends Event 
    {

        public static const DONE:String = "rrhandling_done";

        public function RRHandlerEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}//package com.hbm.socialmodule.rrhandlers.abstracts

