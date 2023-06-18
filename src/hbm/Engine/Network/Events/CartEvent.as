


//hbm.Engine.Network.Events.CartEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class CartEvent extends Event 
    {

        public static const ON_CART_STATUS_UPDATED:String = "ON_CART_STATUS_UPDATED";
        public static const ON_CART_UPDATED:String = "ON_CART_UPDATED";

        public function CartEvent(_arg_1:String)
        {
            super(_arg_1);
        }

    }
}//package hbm.Engine.Network.Events

