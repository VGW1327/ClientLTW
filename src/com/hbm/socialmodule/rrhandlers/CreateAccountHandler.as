


//com.hbm.socialmodule.rrhandlers.CreateAccountHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.data.SocialNetworkState;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class CreateAccountHandler extends AbstractRRHandler implements RRHandler 
    {

        public function CreateAccountHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String=null):void
        {
            MethodName = "createUserAccountRequest";
            var _local_6:String = (SocialNetworkState.Instance.ServerIdPrefix + apiVars.viewerId);
            var _local_7:Object = {
                "login":_local_6,
                "passHash":apiVars.authenticationKey,
                "displayName":_arg_1,
                "isActivated":"true"
            };
            if (((_arg_2) && (!(_arg_2 == "null"))))
            {
                _local_7.sex = _arg_2;
            };
            if (((_arg_3) && (!(_arg_3 == "null"))))
            {
                _local_7.birthDate = _arg_3;
            };
            if (((_arg_4) && (!(_arg_4 == "null"))))
            {
                _local_7.city = _arg_4;
            };
            if (_arg_5)
            {
                _local_7.referer1 = _arg_5;
            };
            serverHandler.SendRequest(_local_7, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.createUserAccountResponse;
            if (CheckServerResponseValidity(_local_2))
            {
                dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_2.result));
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }


    }
}//package com.hbm.socialmodule.rrhandlers

