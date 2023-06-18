


//com.hbm.socialmodule.rrhandlers.PerformBillPaymentHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class PerformBillPaymentHandler extends AbstractRRHandler implements RRHandler 
    {

        public function PerformBillPaymentHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest(_arg_1:uint, _arg_2:uint, _arg_3:uint, _arg_4:String):void
        {
            MethodName = "startOnlineDengiPaymentRequest";
            var _local_5:Object = {
                "amount":_arg_1,
                "comment":_arg_4,
                "paymentSystemCode":_arg_3,
                "onlineDengiProjectId":_arg_2
            };
            _local_5 = AddAuthorisationData(_local_5);
            serverHandler.SendRequest(_local_5, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }


    }
}//package com.hbm.socialmodule.rrhandlers

