


//hbm.Engine.Resource.ItemsResourceLibrary

package hbm.Engine.Resource
{
    import flash.utils.Dictionary;
    import hbm.Application.ClientApplication;
    import flash.events.Event;
    import mx.core.BitmapAsset;
    import org.aswing.AttachIcon;
    import hbm.Engine.Actors.ItemData;

    public class ItemsResourceLibrary extends ResourceLibrary 
    {

        private var _dictionary:Dictionary;
        private var _array:Array;


        override public function GetLibraryFileName():String
        {
            return (ClientApplication.Instance.Config.GetFileURL("Items"));
        }

        override protected function OnResourceLoaded(_arg_1:Event):void
        {
            super.OnResourceLoaded(_arg_1);
        }

        public function GetItemAttachIcon(_arg_1:int):AttachIcon
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:BitmapAsset;
            if (IsLoaded)
            {
                _local_2 = _arg_1.toString();
                while (_local_2.length < 5)
                {
                    _local_2 = ("0" + _local_2);
                };
                _local_3 = ("Items_Item_" + _local_2);
                _local_4 = GetBitmapAsset(_local_3);
                if (_local_4 == null)
                {
                    return (new AttachIcon("Items_Item_00000"));
                };
                return (new AttachIcon(_local_3));
            };
            return (null);
        }

        public function GetItemBitmapAsset(_arg_1:int):BitmapAsset
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:BitmapAsset;
            if (IsLoaded)
            {
                _local_2 = _arg_1.toString();
                while (_local_2.length < 5)
                {
                    _local_2 = ("0" + _local_2);
                };
                _local_3 = ("Items_Item_" + _local_2);
                _local_4 = GetBitmapAsset(_local_3);
                if (_local_4 == null)
                {
                    return (GetBitmapAsset("Items_Item_00000"));
                };
                return (_local_4);
            };
            return (null);
        }

        public function GetItemView(_arg_1:int):int
        {
            var _local_2:Object = this._dictionary[_arg_1];
            if (((_local_2 == null) || (_local_2["view"] == null)))
            {
                return (0);
            };
            return (_local_2["view"] as int);
        }

        public function GetItemMaxDurability(_arg_1:int):int
        {
            var _local_2:Object = this._dictionary[_arg_1];
            if (_local_2 == null)
            {
                return (0);
            };
            var _local_3:int = (_local_2["type"] as int);
            if (((_local_3 == ItemData.IT_ARMOR) || (_local_3 == ItemData.IT_WEAPON)))
            {
                return (_local_2["durability"] as int);
            };
            return (0);
        }

        public function GetItemDescription(_arg_1:int):String
        {
            var _local_2:String = ((this._dictionary[_arg_1]) ? this._dictionary[_arg_1]["Description"] : null);
            return ((_local_2 == null) ? (_arg_1.toString() + "???") : _local_2);
        }

        public function GetItemCooldown(_arg_1:int):Number
        {
            var _local_2:Object = ((this._dictionary[_arg_1]) ? this._dictionary[_arg_1]["cooldown"] : null);
            return (((_local_2) && (_local_2 is Number)) ? (_local_2 as Number) : -1);
        }

        public function GetItemTypeEquip(_arg_1:int):int
        {
            return ((this._dictionary[_arg_1]) ? this._dictionary[_arg_1]["equip_locations"] : 0);
        }

        public function GetItemColorType(_arg_1:int):int
        {
            var _local_2:int = ((this._dictionary[_arg_1]) ? this._dictionary[_arg_1]["equip_genders"] : 0);
            return (_local_2 & 0xFFFC);
        }

        public function GetItemTradeMask(_arg_1:int):int
        {
            return ((this._dictionary[_arg_1]) ? this._dictionary[_arg_1]["trade_mask"] : 0);
        }

        public function GetPremiumPackType(_arg_1:int):int
        {
            return (((this._dictionary[_arg_1]) && (this._dictionary[_arg_1]["premium_pack_type"])) ? this._dictionary[_arg_1]["premium_pack_type"] : 0);
        }

        public function GetItemFullName(_arg_1:int):String
        {
            var _local_2:* = this._dictionary[_arg_1];
            return (((!(_local_2 == null)) && (!(_local_2["loc_name"] == null))) ? _local_2["loc_name"] : ("Unknown item" + _arg_1.toString()));
        }

        public function GetServerDescriptionObject(_arg_1:int):Object
        {
            return (this._dictionary[_arg_1]);
        }

        public function GetItemsData():Array
        {
            return (this._array);
        }

        private function LoadItemsDescriptions():void
        {
            var _local_1:int;
            var _local_2:Object;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_3:Object = GetJSON("Items_ItemsJson");
            if (_local_3 != null)
            {
                this._dictionary = new Dictionary(true);
                this._array = _local_3.ItemsList;
                _local_6 = this._array.length;
                _local_1 = 0;
                while (_local_1 < _local_6)
                {
                    this._dictionary[this._array[_local_1].id] = this._array[_local_1];
                    _local_1++;
                };
            };
            var _local_4:Object = GetJSON("Items_ItemTradeJson");
            if (((!(_local_4 == null)) && (!(this._dictionary == null))))
            {
                _local_7 = _local_4.ItemTradeList.length;
                _local_1 = 0;
                while (_local_1 < _local_7)
                {
                    _local_2 = this._dictionary[_local_4.ItemTradeList[_local_1].id];
                    if (_local_2 != null)
                    {
                        _local_2["trade_mask"] = _local_4.ItemTradeList[_local_1].trade_mask;
                    };
                    _local_1++;
                };
            };
            var _local_5:Object = GetJSON("Items_PremiumPackItemJson");
            if (((!(_local_5 == null)) && (!(this._dictionary == null))))
            {
                _local_8 = _local_5.PremiumPackItem.length;
                _local_1 = 0;
                while (_local_1 < _local_8)
                {
                    _local_2 = this._dictionary[_local_5.PremiumPackItem[_local_1]["id"]];
                    if (_local_2 != null)
                    {
                        _local_2["premium_pack_type"] = _local_5.PremiumPackItem[_local_1]["type"];
                    };
                    _local_1++;
                };
            };
        }

        public function LoadLocalizedData():void
        {
            var _local_1:int;
            var _local_3:Object;
            var _local_4:Object;
            var _local_5:int;
            this.LoadItemsDescriptions();
            var _local_2:ResourceLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            if (((!(_local_2 == null)) && (_local_2.IsLoaded)))
            {
                _local_3 = GetJSON("Localization_Data_ClientItems");
                if (((!(_local_3 == null)) && (!(this._dictionary == null))))
                {
                    _local_5 = _local_3.ClientItemList.length;
                    _local_1 = 0;
                    while (_local_1 < _local_5)
                    {
                        _local_4 = this._dictionary[_local_3.ClientItemList[_local_1].id];
                        if (_local_4 != null)
                        {
                            _local_4["Description"] = _local_3.ClientItemList[_local_1]["Description"];
                            _local_4["cooldown"] = _local_3.ClientItemList[_local_1]["cooldown"];
                            _local_4["title_color"] = _local_3.ClientItemList[_local_1]["title_color"];
                            _local_4["view_index"] = _local_3.ClientItemList[_local_1]["view_index"];
                            _local_4["view_name"] = _local_3.ClientItemList[_local_1]["view_name"];
                            _local_4["book_type"] = _local_3.ClientItemList[_local_1]["book_type"];
                            _local_4["loc_name"] = _local_3.ClientItemList[_local_1]["loc_name"];
                        };
                        _local_1++;
                    };
                };
            };
        }


    }
}//package hbm.Engine.Resource

