


//com.hbm.socialmodule.rrhandlers.RetrieveUserInfoHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import com.hbm.socialmodule.data.UserObject;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class RetrieveUserInfoHandler extends AbstractRRHandler implements RRHandler 
    {

        public function RetrieveUserInfoHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest():void
        {
            apiHandler.addListener(ResponseEvent.GET_USER_INFO, this.OnGetUserInfo);
            apiHandler.GetUserInfo();
        }

        private function OnGetUserInfo(_arg_1:ResponseEvent):void
        {
            apiHandler.removeListener(ResponseEvent.GET_USER_INFO, this.OnGetUserInfo);
            var _local_2:UserObject = UserObject(apiHandler.Result);
            cache = _local_2;
            dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_2));
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }

        public function ProcessResponse(_arg_1:Object):void
        {
        }


    }
}//package com.hbm.socialmodule.rrhandlers

