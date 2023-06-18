


//hbm.Engine.Actors.CharacterEquipment

package hbm.Engine.Actors
{
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tutorial.HelpManager;

    public class CharacterEquipment 
    {

        public static const MASK_HEAD_LOW:int = 1;
        public static const MASK_RIGHT_HAND:int = 2;
        public static const MASK_ROBE:int = 4;
        public static const MASK_ACCESSARY1:int = 8;
        public static const MASK_BODY:int = 16;
        public static const MASK_LEFT_HAND:int = 32;
        public static const MASK_SHOES:int = 64;
        public static const MASK_ACCESSARY2:int = 128;
        public static const MASK_HEAD_TOP:int = 0x0100;
        public static const MASK_HEAD_MID:int = 0x0200;
        public static const MASK_BELT:int = 0x0400;
        public static const MASK_SOULSHOTS:int = 0x4000;
        public static const MASK_ARROWS:int = 0x8000;
        public static const SLOT_HEAD_LOW:int = 0;
        public static const SLOT_RIGHT_HAND:int = 1;
        public static const SLOT_ROBE:int = 2;
        public static const SLOT_ACCESSARY1:int = 3;
        public static const SLOT_BODY:int = 4;
        public static const SLOT_LEFT_HAND:int = 5;
        public static const SLOT_SHOES:int = 6;
        public static const SLOT_ACCESSARY2:int = 7;
        public static const SLOT_HEAD_TOP:int = 8;
        public static const SLOT_HEAD_MID:int = 9;
        public static const SLOT_BELT:int = 10;
        public static const SLOT_TABARD:int = 11;
        public static const SLOT_MOUNT:int = 12;
        public static const SLOT_SUIT:int = 13;
        public static const SLOT_ARROWS:int = 14;
        public static const SLOT_SOULSHOTS:int = 15;
        public static const SLOT_LAST:int = 16;

        private var _slots:Array;

        public function CharacterEquipment()
        {
            this.Clear();
        }

        public static function GetEquipSlots(_arg_1:int, _arg_2:Boolean=false):Array
        {
            var _local_4:int;
            var _local_3:Array = new Array();
            if (_arg_1 == CharacterEquipment.MASK_ARROWS)
            {
                _local_3.push(ClientApplication.Localization.SLOTS_DESC_WEAPON[SLOT_ARROWS]);
            }
            else
            {
                if (_arg_1 == CharacterEquipment.MASK_SOULSHOTS)
                {
                    _local_3.push(ClientApplication.Localization.SLOTS_DESC_WEAPON[SLOT_SOULSHOTS]);
                }
                else
                {
                    _local_4 = 0;
                    while (_local_4 < SLOT_LAST)
                    {
                        if ((_arg_1 & 0x01))
                        {
                            _local_3.push(((_arg_2) ? ClientApplication.Localization.SLOTS_DESC_RUNE[_local_4] : ClientApplication.Localization.SLOTS_DESC_WEAPON[_local_4]));
                        };
                        _arg_1 = (_arg_1 >> 1);
                        _local_4++;
                    };
                };
            };
            return (_local_3);
        }


        public function Clear():void
        {
            this._slots = new Array();
            var _local_1:int;
            while (_local_1 < SLOT_LAST)
            {
                this._slots[_local_1] = null;
                _local_1++;
            };
        }

        public function EquipItem(_arg_1:ItemData):void
        {
            var _local_2:int;
            var _local_3:int = _arg_1.Equip;
            if (((_local_3 == 8) || (_local_3 == 128)))
            {
                _arg_1.Upgrade = 0;
            };
            if (_local_3 == MASK_ARROWS)
            {
                this._slots[SLOT_ARROWS] = _arg_1;
            }
            else
            {
                if (_local_3 == MASK_SOULSHOTS)
                {
                    this._slots[SLOT_SOULSHOTS] = _arg_1;
                }
                else
                {
                    _local_2 = 0;
                    while (_local_2 < SLOT_LAST)
                    {
                        if ((_local_3 & 0x01))
                        {
                            this._slots[_local_2] = _arg_1;
                        };
                        _local_3 = (_local_3 >> 1);
                        _local_2++;
                    };
                };
            };
            HelpManager.Instance.EquipItem(_arg_1.NameId);
        }

        public function UnEquipItem(_arg_1:ItemData):void
        {
            var _local_2:int;
            var _local_3:int = _arg_1.Equip;
            if (_local_3 == CharacterEquipment.MASK_ARROWS)
            {
                this._slots[SLOT_ARROWS] = null;
            }
            else
            {
                if (_local_3 == CharacterEquipment.MASK_SOULSHOTS)
                {
                    this._slots[SLOT_SOULSHOTS] = null;
                }
                else
                {
                    _local_2 = 0;
                    while (_local_2 < SLOT_LAST)
                    {
                        if ((_local_3 & 0x01))
                        {
                            this._slots[_local_2] = null;
                        };
                        _local_3 = (_local_3 >> 1);
                        _local_2++;
                    };
                };
            };
        }

        public function GetItemBySlotName(_arg_1:int):ItemData
        {
            return (this._slots[_arg_1]);
        }

        public function IsEquipedItem(_arg_1:ItemData):Boolean
        {
            var _local_2:ItemData;
            for each (_local_2 in this._slots)
            {
                if (_local_2 == _arg_1)
                {
                    return (true);
                };
            };
            return (false);
        }


    }
}//package hbm.Engine.Actors

