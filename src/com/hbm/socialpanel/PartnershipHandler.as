


//com.hbm.socialpanel.PartnershipHandler

package com.hbm.socialpanel
{
    import flash.events.EventDispatcher;
    import com.hbm.socialmodule.SocialModule;
    import flash.events.Event;
    import com.hbm.socialmodule.connection.socialapi.vkontakte.VkoAPIHandler;
    import com.hbm.socialmodule.data.UserObject;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import com.hbm.socialmodule.data.UserRating;

    public class PartnershipHandler extends EventDispatcher 
    {

        private var _dataModel:SocialModule;
        private var _partnershipServerVarName:String;
        private var _secretServerVarName:String;
        private var _userStatusServerVarName:String;
        private var _sigUrlName:String;
        private var _parameterHex:Boolean;
        private var _signatureRequired:Boolean;

        public function PartnershipHandler(_arg_1:SocialModule)
        {
            this._dataModel = _arg_1;
            if (this.CompatibleNetworkType())
            {
                this._dataModel.RetrieveUserInfo.addEventListener(Event.COMPLETE, this.OnUserDataReceived);
            };
        }

        private function CompatibleNetworkType():Boolean
        {
            return (this._dataModel.NetworkApi is VkoAPIHandler);
        }

        private function OnUserDataReceived(_arg_1:ResponseEvent):void
        {
            if (((this.UserConditions((_arg_1.data as UserObject))) && (this.CheckRandomFactor())))
            {
                this.CheckUserStatusAndCallLink();
            };
        }

        private function UserConditions(_arg_1:UserObject):Boolean
        {
            var _local_2:UserRating = _arg_1.GetRating(1);
            if (_local_2 != null)
            {
                return (_local_2.Rating >= 30);
            };
            return (false);
        }

        private function CheckRandomFactor():Boolean
        {
            return (Math.random() < 0.2);
        }

        private function CheckUserStatusAndCallLink():void
        {
            this._dataModel.GetServerVariable.addEventListener(Event.COMPLETE, function (_arg_1:ResponseEvent):void
            {
                var _local_2:String;
                _local_2 = (_arg_1.data as String);
                if (_local_2 == "true")
                {
                    GetLink();
                };
            });
            this._dataModel.GetServerVariable.SendRequest(this._userStatusServerVarName);
        }

        private function GetLink():void
        {
            this._dataModel.GetPartnersLink.addEventListener(Event.COMPLETE, this.OnLinkAcquired);
            this._dataModel.GetPartnersLink.SendRequest(this._partnershipServerVarName, this._parameterHex, this._signatureRequired, this._sigUrlName, this._secretServerVarName);
        }

        private function OnLinkAcquired(_arg_1:ResponseEvent):void
        {
            dispatchEvent(_arg_1.clone());
        }


    }
}//package com.hbm.socialpanel

