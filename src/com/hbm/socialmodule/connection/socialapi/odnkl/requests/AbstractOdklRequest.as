


//com.hbm.socialmodule.connection.socialapi.odnkl.requests.AbstractOdklRequest

package com.hbm.socialmodule.connection.socialapi.odnkl.requests
{
    import com.hbm.socialmodule.connection.socialapi.AbstractSSRequest;
    import com.adobe.crypto.MD5;

    public class AbstractOdklRequest extends AbstractSSRequest 
    {

        public function AbstractOdklRequest(_arg_1:Object)
        {
            super(_arg_1);
        }

        protected function SetRequestCode(_arg_1:String):void
        {
            var _local_2:String = MD5.hash(_arg_1);
            _variables.sig = _local_2.toLowerCase();
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.odnkl.requests

