


//com.hbm.socialmodule.rrhandlers.GetPartnershipLinkHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class GetPartnershipLinkHandler extends AbstractRRHandler implements RRHandler 
    {

        public function GetPartnershipLinkHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean, _arg_4:String, _arg_5:String):void
        {
            MethodName = "getPartnerUrlRequest";
            var _local_6:Object = {
                "projectVarNameForUrl":_arg_1,
                "needDynamicParamsToHex":_arg_2,
                "needSignUrl":_arg_3,
                "sigParamName":_arg_4,
                "projectVarNameForSecret":_arg_5
            };
            _local_6 = AddAuthorisationData(_local_6);
            serverHandler.SendRequest(_local_6, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.getPartnerUrlResponse;
            if (CheckServerResponseValidity(_local_2))
            {
                cache = _local_2.url;
                dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_2.url));
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }


    }
}//package com.hbm.socialmodule.rrhandlers

