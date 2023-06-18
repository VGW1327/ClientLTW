


//com.hbm.socialmodule.connection.socialapi.AbstractSSRequest

package com.hbm.socialmodule.connection.socialapi
{
    import flash.net.URLVariables;

    public class AbstractSSRequest 
    {

        protected var _flashVars:Object;
        protected var _variables:URLVariables;

        public function AbstractSSRequest(_arg_1:Object)
        {
            this._flashVars = _arg_1;
            this._variables = new URLVariables();
        }

    }
}//package com.hbm.socialmodule.connection.socialapi

