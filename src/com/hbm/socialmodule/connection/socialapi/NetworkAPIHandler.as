


//com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler

package com.hbm.socialmodule.connection.socialapi
{
    import com.hbm.socialmodule.rrhandlers.SpendMoneyHandler;

    public interface NetworkAPIHandler 
    {

        function GetFriends():void;
        function GetUserInfo():void;
        function GetProfiles(_arg_1:Array):void;
        function GetExternalVars():ExtVarsAdapter;
        function GetAccessSettings():AccessSettings;
        function CallInviteBox():void;
        function CallInstallBox():void;
        function CallSettingsBox():void;
        function WallPost(_arg_1:Object=null):void;
        function get Result():Object;
        function GetHBMGroupURL():String;
        function GetGamePassword():String;
        function GetInviterId():String;
        function PerformPayment(_arg_1:SpendMoneyHandler):void;
        function addListener(_arg_1:String, _arg_2:Function):void;
        function removeListener(_arg_1:String, _arg_2:Function):void;

    }
}//package com.hbm.socialmodule.connection.socialapi

