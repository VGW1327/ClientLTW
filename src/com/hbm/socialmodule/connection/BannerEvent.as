


//com.hbm.socialmodule.connection.BannerEvent

package com.hbm.socialmodule.connection
{
    import flash.events.Event;
    import com.hbm.socialmodule.data.AdvBannerObject;

    public class BannerEvent extends Event 
    {

        public static const ON_BANNER_ERROR:String = "banner_error_event";
        public static const ON_BANNER_LOADED:String = "banner_loaded_event";
        public static const CLICK:String = "banner_click";
        public static const VIEW:String = "banner_view";

        private var _banner:AdvBannerObject;

        public function BannerEvent(_arg_1:String, _arg_2:AdvBannerObject)
        {
            super(_arg_1);
            this._banner = _arg_2;
        }

        public function get banner():AdvBannerObject
        {
            return (this._banner);
        }


    }
}//package com.hbm.socialmodule.connection

