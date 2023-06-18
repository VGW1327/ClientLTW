


//hbm.Engine.Collision.MapCollisionManager

package hbm.Engine.Collision
{
    import flash.utils.Dictionary;
    import hbm.Engine.PathFinding.WalkPathSolver;
    import flash.utils.ByteArray;
    import flash.geom.Point;
    import hbm.Engine.Network.Packet.Coordinates;

    public class MapCollisionManager 
    {

        private static var _isSingletonLock:Boolean = false;
        private static var _singleton:MapCollisionManager = null;

        private var _collisionMaps:Dictionary;
        private var _currentMap:MapCollisionData;
        private var _pathFinder:WalkPathSolver;
        private var _lastPathLength:Number;

        public function MapCollisionManager()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access. Use MapCollisionManager.Instance."));
            };
            this._lastPathLength = 0;
            this._collisionMaps = new Dictionary(true);
        }

        public static function get Instance():MapCollisionManager
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (MapCollisionManager)();
                _isSingletonLock = false;
            };
            return (_singleton);
        }


        public function SetCollisionData(_arg_1:String, _arg_2:ByteArray):void
        {
            var _local_3:MapCollisionData = new MapCollisionData(_arg_2);
            this._collisionMaps[_arg_1] = _local_3;
            this._pathFinder = new WalkPathSolver(_local_3);
        }

        public function LastPathLength():Number
        {
            return (this._lastPathLength);
        }

        public function FindPath(_arg_1:Coordinates):Array
        {
            var _local_8:Boolean;
            var _local_9:int;
            var _local_10:Number;
            if (this._pathFinder == null)
            {
                return (null);
            };
            var _local_2:Boolean = this._pathFinder.Search(_arg_1);
            if (!_local_2)
            {
                return (null);
            };
            var _local_3:int = this._pathFinder.Length;
            if (_local_3 <= 0)
            {
                return (null);
            };
            var _local_4:Array = new Array(_local_3);
            var _local_5:int = _arg_1.x;
            var _local_6:int = _arg_1.y;
            this._lastPathLength = 0;
            var _local_7:int;
            while (_local_7 < _local_3)
            {
                _local_8 = true;
                _local_9 = this._pathFinder.Steps[_local_7];
                if (((_local_7 == 0) && (_local_3 > 1)))
                {
                    _local_8 = false;
                };
                if (_local_8)
                {
                    _local_10 = (((_local_9 & 0x01) > 0) ? 1.414213562373 : 1);
                    this._lastPathLength = (this._lastPathLength + _local_10);
                };
                switch (_local_9)
                {
                    case 0:
                        _local_6++;
                        break;
                    case 1:
                        _local_5--;
                        _local_6++;
                        break;
                    case 2:
                        _local_5--;
                        break;
                    case 3:
                        _local_5--;
                        _local_6--;
                        break;
                    case 4:
                        _local_6--;
                        break;
                    case 5:
                        _local_5++;
                        _local_6--;
                        break;
                    case 6:
                        _local_5++;
                        break;
                    case 7:
                        _local_5++;
                        _local_6++;
                        break;
                };
                _local_4[_local_7] = new Point(_local_5, _local_6);
                _local_7++;
            };
            return (_local_4);
        }

        public function GetMapCollisionByName(_arg_1:String):MapCollisionData
        {
            return (this._collisionMaps[_arg_1] as MapCollisionData);
        }

        public function SelectCurrentMap(_arg_1:String):void
        {
            this._currentMap = this.GetMapCollisionByName(_arg_1);
            this._pathFinder = new WalkPathSolver(this._currentMap);
        }

        public function get CurrentMap():MapCollisionData
        {
            return (this._currentMap);
        }


    }
}//package hbm.Engine.Collision

