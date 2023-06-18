


//hbm.Engine.Network.Events.BuyCahsEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class BuyCahsEvent extends Event 
    {

        public static const ON_ZENY_PACKS:String = "ON_ZENY_PACKS";

        private var _packs:Array;

        public function BuyCahsEvent(_arg_1:Array)
        {
            super(ON_ZENY_PACKS);
            this._packs = _arg_1;
        }

        public function get Packs():Array
        {
            return (this._packs);
        }


    }
}//package hbm.Engine.Network.Events

