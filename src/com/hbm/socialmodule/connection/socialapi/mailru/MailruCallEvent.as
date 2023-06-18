


//com.hbm.socialmodule.connection.socialapi.mailru.MailruCallEvent

package com.hbm.socialmodule.connection.socialapi.mailru
{
    import flash.events.Event;

    public class MailruCallEvent extends Event 
    {

        public static var PERMISSIONS_CHANGED:String = "common.permissionChanged";
        public static var FRIENDS_INVITATION:String = "app.friendsInvitation";
        public static var REVIEW:String = "app.review";
        public static var INCOMING_PAYMENT:String = "app.incomingPayment";
        public static var PAYMENT_DIALOG_STATUS:String = "app.paymentDialogStatus";
        public static var ALBUM_CREATED:String = "common.createAlbum";
        public static var GUESTBOOK_PUBLISH:String = "common.guestbookPublish";
        public static var STREAM_PUBLISH:String = "common.streamPublish";

        public var data:Object;

        public function MailruCallEvent(_arg_1:String, _arg_2:Object)
        {
            super(_arg_1);
            this.data = _arg_2;
        }

        override public function clone():Event
        {
            return (new MailruCallEvent(type, this.data) as Event);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.mailru

