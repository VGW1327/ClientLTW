


//com.hbm.socialmodule.connection.ResponseEvent

package com.hbm.socialmodule.connection
{
    import flash.events.Event;

    public class ResponseEvent extends Event 
    {

        public static const LOGIN:String = "login_response";
        public static const CREATE_ACCOUNT:String = "create_account_response";
        public static const SAVE_GAME_SESSION:String = "send_game_session_response";
        public static const SEND_RATING:String = "send_rating_response";
        public static const GET_TOP:String = "get_top_response";
        public static const GET_TOP_FRIENDS:String = "get_top_friends_response";
        public static const GET_DAILY_TOP:String = "get_daily_top_response";
        public static const GET_MONTHLY_TOP:String = "get_monthly_top_response";
        public static const GET_RICH_TOP:String = "get_rich_top_response";
        public static const GET_GUILD_TOP:String = "get_guild_top_response";
        public static const GET_RATING:String = "get_score_response";
        public static const FRIENDS_UPDATE:String = "friends_update_response";
        public static const LOAD_BANNERS:String = "load_banners_response";
        public static const BANNER_FEEDBACK:String = "banner_feedback_response";
        public static const APP_STATUS:String = "app_status_response";
        public static const INFO_ADVT:String = "info_advt_response";
        public static const SUPPORT_NEW_CALL:String = "support_call_response";
        public static const SUPPORT_MSGS:String = "support_call_msgs_response";
        public static const SUPPORT_CALL_LIST:String = "support_call_list_response";
        public static const SUPPORT_SEND_MSG:String = "support_call_message_sent";
        public static const PAYMENT:String = "payment_response";
        public static const GET_STORE_ITEMS:String = "get_store_items_response";
        public static const GET_USER_ITEMS:String = "get_user_items_response";
        public static const ONLINE_BILLING:String = "online_billing_response";
        public static const GET_FRIENDS:String = "get_friends_response";
        public static const GET_USER_INFO:String = "get_user_info_response";
        public static const GET_PROFILES:String = "get_profiles_response";
        public static const GET_LOCATION_INFO:String = "get_location_info_response";
        public static const WALL_POST:String = "wall_post_response";
        public static const INSTALLED:String = "application_installed_response";
        public static const INVITE:String = "application_friends_invited_response";
        public static const SETTINGS_CHANGED:String = "application_settings_changed_response";
        public static const UNKNOWN:String = "unknown_response";

        private var _data:Object;

        public function ResponseEvent(_arg_1:String, _arg_2:Object)
        {
            super(_arg_1);
            this._data = _arg_2;
        }

        override public function clone():Event
        {
            return (new ResponseEvent(this.type, this._data));
        }

        public function get data():Object
        {
            return (this._data);
        }


    }
}//package com.hbm.socialmodule.connection

