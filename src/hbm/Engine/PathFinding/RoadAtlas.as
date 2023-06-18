


//hbm.Engine.PathFinding.RoadAtlas

package hbm.Engine.PathFinding
{
    import hbm.Game.Utility.HelpArrow;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.events.Event;
    import hbm.Application.ClientApplication;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Engine.Renderer.RenderSystem;

    public class RoadAtlas 
    {

        public static const FAIL_FIND:uint = 0;
        public static const SUCCESS_FIND:uint = 1;
        public static const COMPLETE_FIND:uint = 2;

        private const _helpArrow:HelpArrow = new HelpArrow();

        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _running:Boolean = false;
        private var _pathsLocation:Array = [];
        private var _npcIdFromLocation:String;
        private var _questId:uint;

        public function RoadAtlas()
        {
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._helpArrow.addEventListener(Event.COMPLETE, this.OnComplete, false, 0, true);
        }

        public function HelpMoveToMap(_arg_1:String, _arg_2:String="", _arg_3:uint=0):uint
        {
            if (this._running)
            {
                this.Reset();
            };
            this._questId = _arg_3;
            if (this._questId)
            {
                ClientApplication.Instance.TopHUD.QuestsPanel.Update();
            };
            this._npcIdFromLocation = _arg_2;
            var _local_4:String = this.CurrentLocation();
            this._pathsLocation = this.GetPathLocations(_local_4, _arg_1);
            if (((this._pathsLocation.length < 1) && (this._npcIdFromLocation.length < 1)))
            {
                this.Reset();
                return (FAIL_FIND);
            };
            this._running = true;
            this.Update();
            if (this._running)
            {
                return (SUCCESS_FIND);
            };
            return (COMPLETE_FIND);
        }

        public function get NpcId():String
        {
            return (this._npcIdFromLocation);
        }

        public function get QuestId():uint
        {
            return (this._questId);
        }

        private function OnComplete(_arg_1:Event):void
        {
            this.Reset();
        }

        public function Update():void
        {
            var _local_2:String;
            var _local_5:Object;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:String;
            var _local_9:String;
            var _local_10:Object;
            var _local_11:Number;
            var _local_12:Number;
            if (!this._running)
            {
                return;
            };
            var _local_1:Object = this._dataLibrary.GetRoadAtlasData();
            _local_2 = this.CurrentLocation();
            var _local_3:* = (_local_2 == this._pathsLocation[0]);
            var _local_4:uint = this._pathsLocation.length;
            if (((_local_4 < 1) || ((_local_3) && (_local_4 == 1))))
            {
                if (((this._npcIdFromLocation) && (this._npcIdFromLocation.length)))
                {
                    _local_5 = this._dataLibrary.GetNpcDataFromId(this._npcIdFromLocation);
                    if (((_local_5.PositionX > -1) && (_local_5.PositionY > -1)))
                    {
                        _local_6 = (_local_5.PositionX * CharacterStorage.CELL_SIZE);
                        _local_7 = (RenderSystem.Instance.MainCamera.MaxHeight - (_local_5.PositionY * CharacterStorage.CELL_SIZE));
                        this._helpArrow.Detach();
                        this._helpArrow.AttachToCameraPoint(_local_6, _local_7, true);
                        this._running = false;
                    }
                    else
                    {
                        this.Reset();
                    };
                }
                else
                {
                    this.Reset();
                };
                return;
            };
            if (_local_3)
            {
                this._pathsLocation.shift();
                _local_8 = this._pathsLocation[0];
                _local_9 = _local_1[_local_2][_local_8][0];
                _local_10 = this._dataLibrary.GetNpcDataFromName(_local_9);
                if (((_local_10.PositionX > -1) && (_local_10.PositionY > -1)))
                {
                    _local_11 = (_local_10.PositionX * CharacterStorage.CELL_SIZE);
                    _local_12 = (RenderSystem.Instance.MainCamera.MaxHeight - (_local_10.PositionY * CharacterStorage.CELL_SIZE));
                    this._helpArrow.Detach();
                    this._helpArrow.AttachToCameraPoint(_local_11, _local_12);
                }
                else
                {
                    this.Reset();
                    return;
                };
            }
            else
            {
                this.HelpMoveToMap(this._pathsLocation.pop(), this._npcIdFromLocation, this._questId);
            };
        }

        public function Reset():void
        {
            this._helpArrow.Detach();
            this._pathsLocation = [];
            this._running = false;
            this._npcIdFromLocation = "";
            if (this._questId)
            {
                this._questId = 0;
                ClientApplication.Instance.TopHUD.QuestsPanel.Update();
            };
        }

        private function GetPathLocations(_arg_1:String, _arg_2:String):Array
        {
            var _local_5:Object;
            var _local_7:Object;
            var _local_8:Object;
            var _local_9:String;
            var _local_10:Number;
            var _local_11:Array;
            var _local_3:Object = this._dataLibrary.GetRoadAtlasData();
            if (!((_arg_1 in _local_3) && (_arg_2 in _local_3)))
            {
                return ([]);
            };
            if (_arg_1 == _arg_2)
            {
                return ([{
                    "parent":null,
                    "location":_arg_1
                }]);
            };
            var _local_4:Object = {};
            _local_5 = {
                "parent":null,
                "location":_arg_1,
                "priority":0
            };
            var _local_6:Array = [_local_5];
            _local_4[_arg_1] = _local_5;
            while (_local_6.length)
            {
                _local_7 = _local_6.shift();
                _local_8 = _local_3[_local_7.location];
                for (_local_9 in _local_8)
                {
                    _local_10 = (_local_7.priority + _local_8[_local_9][1]);
                    if (((_local_9 in _local_3) && (!((_local_9 in _local_4) && (_local_4[_local_9].priority < _local_10)))))
                    {
                        _local_5 = {
                            "parent":_local_7,
                            "location":_local_9,
                            "priority":_local_10
                        };
                        _local_6.push(_local_5);
                        _local_4[_local_9] = _local_5;
                        if (_local_9 == _arg_2)
                        {
                            _local_11 = [];
                            while (_local_5.parent)
                            {
                                _local_11.unshift(_local_5.location);
                                _local_5 = _local_5.parent;
                            };
                            _local_11.unshift(_local_5.location);
                            return (_local_11);
                        };
                    };
                };
                _local_6.sortOn("priority");
            };
            return ([]);
        }

        private function CurrentLocation():String
        {
            return (ClientApplication.Instance.LocalGameClient.MapName.replace(/(\w+)\.gat/i, "$1"));
        }


    }
}//package hbm.Engine.PathFinding

