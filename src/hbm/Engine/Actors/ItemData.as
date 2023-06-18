package hbm.Engine.Actors
{
    import __AS3__.vec.Vector;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;

    public class ItemData 
    {

        public static const MAX_SLOTS:int = 10;
        public static const CASHSHOP:int = 0;
        public static const KAFRASHOP:int = 1;
        public static const STORAGE:int = 1;
        public static const CART:int = 2;
        public static const VENDER:int = 3;
        public static const CASH:int = 4;
        public static const QUEST:int = 5;
        public static const NPCSHOP:int = 6;
        public static const KAFRA:int = 7;
        public static const ZENY:int = 8;
        public static const IT_HEALING:int = 0;
        public static const IT_UNKNOWN:int = 1;
        public static const IT_USABLE:int = 2;
        public static const IT_ETC:int = 3;
        public static const IT_WEAPON:int = 4;
        public static const IT_ARMOR:int = 5;
        public static const IT_CARD:int = 6;
        public static const IT_PETEGG:int = 7;
        public static const IT_PETARMOR:int = 8;
        public static const IT_UNKNOWN2:int = 9;
        public static const IT_AMMO:int = 10;
        public static const IT_DELAYCONSUME:int = 11;
        public static const IT_SOULSHOT:int = 12;
        public static const ICT_GRAY:int = 0;
        public static const ICT_GREEN:int = 4;
        public static const ICT_BLUE:int = 8;
        public static const ICT_VIOLET:int = 12;
        public static const ICT_ORANGE:int = 16;
        public static const ICT_SILVER:int = 20;
        public static const ICT_GOLD:int = 24;
        public static const ICT_RED:int = 28;
        public static const ICT_KAFRA:int = 32;
        public static const ICT_VIP:int = 36;
        public static const ICT_VIP2:int = 40;
        public static const ICT_INDIGO:int = 44;
        public static const ITEM_ATTRIBUTE_BREAK:int = 1;
        public static const ITEM_ATTRIBUTE_FRACTION:int = 2;
        public static const ITEM_ATTRIBUTE_RENT:int = 16;
        public static const ITEM_ATTRIBUTE_KAFRA:int = 32;
        public static const ITEM_ATTRIBUTE_SOULBOND:int = 64;
        public static const MAX_INVENTORY:int = 100;

        public var Id:int;
        public var NameId:int;
        public var Amount:int;
        public var Equip:uint;
        public var Identified:int;
        public var Cards:Vector.<int> = new <int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        public var Type:int;
        public var TypeEquip:int;
        public var Attr:int;
        public var Upgrade:int;
        public var Price:int;
        public var Origin:int;


        public function PrintDebugInfo():void
        {
            var _local_1:String = ItemsResourceLibrary(ResourceManager.Instance.Library("Items")).GetItemFullName(this.NameId);
        }


    }
}