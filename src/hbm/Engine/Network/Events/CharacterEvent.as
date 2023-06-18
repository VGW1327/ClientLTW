


//hbm.Engine.Network.Events.CharacterEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Actors.ItemData;

    public class CharacterEvent extends Event 
    {

        public static const ON_STATS_CHANGED:String = "CE_ON_STATS_CHANGED";
        public static const ON_STATS_NOT_ENOUGH:String = "CE_ON_STATS_NOT_ENOUGH";
        public static const ON_ITEMS_CHANGED:String = "CE_ON_ITEMS_CHANGED";
        public static const ON_ITEM_EQUIPPED:String = "CE_ON_ITEM_EQUIPPED";
        public static const ON_SKILLS_CHANGED:String = "CE_ON_SKILLS_CHANGED";
        public static const ON_SKILL_POINTS_CHANGED:String = "CE_ON_SKILL_POINTS_CHANGED";
        public static const ON_GUILD_SKILLS_CHANGED:String = "CE_ON_GUILD_SKILLS_CHANGED";
        public static const ON_SKILL_CHANGED:String = "CE_ON_SKILL_CHANGED";
        public static const ON_CANT_EQUIP_ITEM:String = "CE_ON_CANT_EQUIP_ITEM";
        public static const ON_CANT_USE_ITEM:String = "CE_ON_CANT_USE_ITEM";
        public static const ON_AMMUNITION_EMPTY:String = "CE_ON_AMMUNITION_EMPTY";
        public static const ON_HOTKEYS_RECEIVED:String = "CE_ON_HOTKEYS_RECEIVED";
        public static const ON_SKILL_USE_FAILED:String = "CE_ON_SKILL_USE_FAILED";
        public static const ON_PET_UPDATED:String = "CE_ON_PET_UPDATED";
        public static const ON_PET_FOOD_RESULT:String = "CE_PET_FOOD_RESULT";
        public static const ON_MANNER_UPDATED:String = "CE_ON_MANNER_UPDATED";
        public static const ON_DEATHFEAR_UPDATED:String = "CE_ON_DEATHFEAR_UPDATED";
        public static const ON_ARENAPUNISH_UPDATED:String = "CE_ON_ARENAPUNISH_UPDATED";
        public static const ON_BREAKRIB_UPDATED:String = "CE_ON_BREAKRIB_UPDATED";

        private var _player:CharacterInfo;
        private var _info:String;
        private var _item:ItemData;
        public var Result:int;

        public function CharacterEvent(_arg_1:String, _arg_2:CharacterInfo=null, _arg_3:String=null, _arg_4:ItemData=null)
        {
            super(_arg_1);
            this._player = _arg_2;
            this._info = _arg_3;
            this._item = _arg_4;
        }

        public function get Player():CharacterInfo
        {
            return (this._player);
        }

        public function get Info():String
        {
            return (this._info);
        }

        public function get Item():ItemData
        {
            return (this._item);
        }

        public function set Item(_arg_1:ItemData):void
        {
            this._item = _arg_1;
        }


    }
}//package hbm.Engine.Network.Events

