


//com.hbm.socialmodule.rrhandlers.abstracts.RRHandler

package com.hbm.socialmodule.rrhandlers.abstracts
{
    public interface RRHandler 
    {

        function ProcessResponse(_arg_1:Object):void;
        function NotifyError(_arg_1:Error):void;
        function get MethodName():String;
        function get Cache():Object;

    }
}//package com.hbm.socialmodule.rrhandlers.abstracts

