


//hbm.Game.Renderer.SkillUnitManager

package hbm.Game.Renderer
{
    import flash.utils.Dictionary;
    import hbm.Engine.Renderer.RenderObject;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Game.Character.CharacterStorage;

    public class SkillUnitManager 
    {

        private static var _isSingletonLock:Boolean = false;
        private static var _singleton:SkillUnitManager = null;

        private var _statusItemList:Dictionary;
        private var _storage:Array = null;

        public function SkillUnitManager()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access. Use BattleLogManager.Instance."));
            };
            this._statusItemList = new Dictionary(true);
            this._storage = new Array();
        }

        public static function get Instance():SkillUnitManager
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (SkillUnitManager)();
                _isSingletonLock = false;
            };
            return (_singleton);
        }


        public function Clear():void
        {
            var _local_3:RenderObject;
            if (this._statusItemList != null)
            {
                for each (_local_3 in this._statusItemList)
                {
                    RenderSystem.Instance.RemoveRenderObject(_local_3);
                };
            };
            this._statusItemList = new Dictionary(true);
            var _local_1:uint = this._storage.length;
            var _local_2:uint;
            while (_local_2 < _local_1)
            {
                this._storage[_local_2] = null;
                _local_2++;
            };
        }

        public function IsExist(_arg_1:int):Boolean
        {
            var _local_2:SkillUnitObject = (this._statusItemList[_arg_1] as SkillUnitObject);
            return (!(_local_2 == null));
        }

        public function AddSkillUnit(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            var _local_10:SkillUnitObject;
            var _local_11:Boolean;
            var _local_12:AnimatedSkillUnitObject;
            var _local_13:uint;
            var _local_14:uint;
            var _local_6:* = "";
            var _local_7:Boolean;
            var _local_8:Number = 0;
            var _local_9:Boolean;
            if (_arg_1 >= 0)
            {
                this.RemoveSkillUnit(_arg_1);
            };
            switch (_arg_2)
            {
                case 144:
                case 145:
                case 147:
                case 148:
                case 149:
                case 150:
                case 151:
                case 152:
                    _local_6 = "AdditionalData_Item_Trap";
                    break;
                case 133:
                    _local_6 = "AdditionalData_Item_Pneuma";
                    break;
                case 142:
                    _local_6 = "AdditionalData_Item_Swamp";
                    break;
                case 157:
                    _local_6 = "AdditionalData_Item_LandTotem";
                    break;
                case 160:
                    _local_6 = "AdditionalData_Item_CurseTotem";
                    break;
                case 166:
                    _local_6 = "AdditionalData_Item_RageTotem";
                    break;
                case 134:
                    switch (_arg_3)
                    {
                        case 2:
                            _local_6 = "Stormgust";
                            _local_7 = true;
                            break;
                        case 3:
                            _local_6 = "Smerch";
                            _local_7 = true;
                            _local_8 = 0.7;
                            break;
                        case 4:
                            _local_6 = "Meteorit";
                            _local_7 = true;
                            _local_8 = 1.1;
                            break;
                        case 5:
                            _local_6 = "Powerwind";
                            _local_7 = true;
                            _local_8 = 0.4;
                            break;
                        case 6:
                            _local_6 = "Alone";
                            _local_7 = true;
                            _local_8 = 0.7;
                            break;
                        case 7:
                            _local_6 = "Terraforming";
                            _local_7 = true;
                            _local_8 = 0.7;
                            break;
                        case 8:
                            _local_6 = "Stormcall";
                            _local_7 = true;
                            _local_8 = 0.6;
                            break;
                        case 9:
                            _local_6 = "Heal";
                            _local_7 = true;
                            _local_8 = 0.7;
                            break;
                        case 10:
                            _local_6 = "Resurrection";
                            _local_7 = true;
                            _local_8 = 0.7;
                            break;
                        case 11:
                            _local_6 = "Concentration";
                            _local_7 = true;
                            _local_8 = 0.6;
                            break;
                        case 13:
                            _local_6 = "Powerhamer";
                            _local_7 = true;
                            _local_8 = 0.6;
                            break;
                        case 14:
                            _local_6 = "Imprecation";
                            _local_7 = true;
                            _local_8 = 1;
                            break;
                        case 20:
                            _local_6 = "CursorWalkTo";
                            _local_7 = true;
                            _local_8 = 1;
                            _local_9 = true;
                            break;
                        case 21:
                            _local_6 = "CursorNoWay";
                            _local_7 = true;
                            _local_8 = 1;
                            _local_9 = true;
                            break;
                    };
                    break;
                default:
                    return;
            };
            if (!_local_7)
            {
                _local_10 = new SkillUnitObject(_arg_4, _arg_5, _arg_2, _local_6);
                RenderSystem.Instance.AddRenderObject(_local_10);
                this._statusItemList[_arg_1] = _local_10;
            }
            else
            {
                _local_11 = CharacterStorage.Instance.IsEnableSkillAnimation;
                if (((!(_local_11)) && (!(_local_9))))
                {
                    return;
                };
                _local_12 = new AnimatedSkillUnitObject(_arg_4, _arg_5, _arg_3, _local_6, _local_8);
                RenderSystem.Instance.AddRenderObject(_local_12);
                if (((_arg_1 >= 0) && (_local_8 == 0)))
                {
                    this._statusItemList[_arg_1] = _local_12;
                }
                else
                {
                    _local_13 = this._storage.length;
                    _local_14 = 0;
                    while (_local_14 < _local_13)
                    {
                        if (this._storage[_local_14] == null)
                        {
                            this._storage[_local_14] = _local_12;
                            return;
                        };
                        _local_14++;
                    };
                    this._storage.push(_local_12);
                };
            };
        }

        public function RemoveSkillUnit(_arg_1:int):void
        {
            var _local_2:RenderObject = this._statusItemList[_arg_1];
            if (_local_2 != null)
            {
                RenderSystem.Instance.RemoveRenderObject(_local_2);
            };
            delete this._statusItemList[_arg_1];
        }

        public function Update(_arg_1:Number):void
        {
            var _local_4:AnimatedSkillUnitObject;
            var _local_2:uint = this._storage.length;
            var _local_3:uint;
            while (_local_3 < _local_2)
            {
                _local_4 = (this._storage[_local_3] as AnimatedSkillUnitObject);
                if (_local_4 != null)
                {
                    if (!_local_4.IsValid)
                    {
                        RenderSystem.Instance.RemoveRenderObject(_local_4);
                        this._storage[_local_3] = null;
                    }
                    else
                    {
                        _local_4.Update(_arg_1);
                    };
                };
                _local_3++;
            };
        }


    }
}//package hbm.Game.Renderer

