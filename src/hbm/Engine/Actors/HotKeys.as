


//hbm.Engine.Actors.HotKeys

package hbm.Engine.Actors
{
    import flash.utils.Dictionary;

    public class HotKeys 
    {

        public static const HOTKEY_EMPTY:int = -1;
        public static const HOTKEY_ITEM:int = 0;
        public static const HOTKEY_SKILL:int = 1;
        public static const HOTKEY_SETTINGS:int = 2;
        public static const MAX_HOTKEYS:int = 27;
        public static const HOTKEYS:int = 11;

        private var _hotKeys:Dictionary;
        private var _player:CharacterInfo;

        public function HotKeys(_arg_1:CharacterInfo)
        {
            this._hotKeys = new Dictionary(true);
            this._player = _arg_1;
        }

        public function SetHotKey(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            if (_arg_3 > 0)
            {
                this._hotKeys[_arg_1] = {
                    "Type":_arg_2,
                    "ItemId":_arg_3,
                    "Lv":_arg_4
                };
            };
        }

        public function GetHotKeyType(_arg_1:int):int
        {
            var _local_2:Object = this._hotKeys[_arg_1];
            if (_local_2 != null)
            {
                return (_local_2["Type"]);
            };
            return (HOTKEY_EMPTY);
        }

        public function GetSettings():int
        {
            var _local_1:Object = this._hotKeys[(MAX_HOTKEYS - 1)];
            if (_local_1 != null)
            {
                return (_local_1["ItemId"]);
            };
            return (HOTKEY_EMPTY);
        }

        public function SetSettings(_arg_1:int):void
        {
            this.SetHotKey((MAX_HOTKEYS - 1), HOTKEY_SETTINGS, _arg_1, 0);
        }

        private function GetItemByNameId(_arg_1:int):ItemData
        {
            var _local_2:ItemData;
            for each (_local_2 in this._player.Items)
            {
                if (_arg_1 == _local_2.NameId)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function GetHotKeyObject(_arg_1:int):*
        {
            var _local_4:Object;
            var _local_2:int = this.GetHotKeyType(_arg_1);
            if (_local_2 == -1)
            {
                return (null);
            };
            var _local_3:Object = this._hotKeys[_arg_1];
            var _local_5:int = _local_3["ItemId"];
            switch (_local_2)
            {
                case 0:
                    _local_4 = this.GetItemByNameId(_local_3["ItemId"]);
                    break;
                case 1:
                    _local_4 = this._player.Skills[_local_5];
                    if (((_local_4 == null) && (_local_5 >= 10000)))
                    {
                        _local_4 = -1;
                    };
                    break;
            };
            if (_local_4 == null)
            {
                this.RemoveHotKey(_arg_1);
            };
            return (_local_4);
        }

        public function GetHotKeyLv(_arg_1:int):int
        {
            var _local_2:Object = this._hotKeys[_arg_1];
            if (_local_2 != null)
            {
                return (_local_2["Lv"]);
            };
            return (HOTKEY_EMPTY);
        }

        public function RemoveHotKey(_arg_1:int):void
        {
            delete this._hotKeys[_arg_1];
        }


    }
}//package hbm.Engine.Actors

