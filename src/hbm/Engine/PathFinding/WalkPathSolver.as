


//hbm.Engine.PathFinding.WalkPathSolver

package hbm.Engine.PathFinding
{
    import hbm.Engine.Collision.MapCollisionData;
    import hbm.Engine.Network.Packet.Coordinates;

    public class WalkPathSolver 
    {

        public static const MAX_WALKPATH:int = 32;
        public static const MAX_HEAP:int = 150;
        private static const walk_choices:Array = [1, 0, 7, 2, -1, 6, 3, 4, 5];

        private var _path:WalkPathData;
        private var _collision:MapCollisionData;
        private var _heap:Array = new Array((MAX_HEAP + 1));
        private var _tmpPath:Array = new Array((MAX_WALKPATH * MAX_WALKPATH));

        public function WalkPathSolver(_arg_1:MapCollisionData)
        {
            this._collision = _arg_1;
        }

        private function push_heap_path(_arg_1:Array, _arg_2:Array, _arg_3:int):void
        {
            var _local_4:int;
            var _local_5:int;
            _local_5 = _arg_1[0];
            _arg_1[0]++;
            _local_4 = int(((_local_5 - 1) / 2));
            while (((_local_5 > 0) && (_arg_2[_arg_3].cost < _arg_2[_arg_1[(_local_4 + 1)]].cost)))
            {
                _arg_1[(_local_5 + 1)] = _arg_1[(_local_4 + 1)];
                _local_5 = _local_4;
                _local_4 = int(((_local_5 - 1) / 2));
            };
            _arg_1[(_local_5 + 1)] = _arg_3;
        }

        private function update_heap_path(_arg_1:Array, _arg_2:Array, _arg_3:int):void
        {
            var _local_4:int;
            var _local_5:int;
            _local_5 = 0;
            while (_local_5 < _arg_1[0])
            {
                if (_arg_1[(_local_5 + 1)] == _arg_3) break;
                _local_5++;
            };
            if (_local_5 == _arg_1[0])
            {
            };
            _local_4 = int(((_local_5 - 1) / 2));
            while (((_local_5 > 0) && (_arg_2[_arg_3].cost < _arg_2[_arg_1[(_local_4 + 1)]].cost)))
            {
                _arg_1[(_local_5 + 1)] = _arg_1[(_local_4 + 1)];
                _local_5 = _local_4;
                _local_4 = int(((_local_5 - 1) / 2));
            };
            _arg_1[(_local_5 + 1)] = _arg_3;
        }

        private function pop_heap_path(_arg_1:Array, _arg_2:Array):int
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            if (_arg_1[0] <= 0)
            {
                return (-1);
            };
            _local_6 = _arg_1[1];
            _local_7 = _arg_1[_arg_1[0]];
            _arg_1[0]--;
            _local_4 = 0;
            _local_5 = 2;
            while (_local_5 < _arg_1[0])
            {
                if (_arg_2[_arg_1[(_local_5 + 1)]].cost > _arg_2[_arg_1[_local_5]].cost)
                {
                    _local_5--;
                };
                _arg_1[(_local_4 + 1)] = _arg_1[(_local_5 + 1)];
                _local_4 = _local_5;
                _local_5 = ((_local_5 * 2) + 2);
            };
            if (_local_5 == _arg_1[0])
            {
                _arg_1[(_local_4 + 1)] = _arg_1[_local_5];
                _local_4 = (_local_5 - 1);
            };
            _local_3 = int(((_local_4 - 1) / 2));
            while (((_local_4 > 0) && (_arg_2[_arg_1[(_local_3 + 1)]].cost > _arg_2[_local_7].cost)))
            {
                _arg_1[(_local_4 + 1)] = _arg_1[(_local_3 + 1)];
                _local_4 = _local_3;
                _local_3 = int(((_local_4 - 1) / 2));
            };
            _arg_1[(_local_4 + 1)] = _local_7;
            return (_local_6);
        }

        private function calc_cost(_arg_1:WalkPathTempPath, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int = Math.abs((_arg_2 - _arg_1.x));
            var _local_5:int = Math.abs((_arg_3 - _arg_1.y));
            return (((_local_4 + _local_5) * 10) + _arg_1.dist);
        }

        private function add_path(_arg_1:Array, _arg_2:Array, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int):int
        {
            var _local_8:int;
            _local_8 = ((_arg_3 + (_arg_4 * MAX_WALKPATH)) & ((MAX_WALKPATH * MAX_WALKPATH) - 1));
            if (((_arg_2[_local_8].x == _arg_3) && (_arg_2[_local_8].y == _arg_4)))
            {
                if (_arg_2[_local_8].dist > _arg_5)
                {
                    _arg_2[_local_8].dist = _arg_5;
                    _arg_2[_local_8].before = _arg_6;
                    _arg_2[_local_8].cost = _arg_7;
                    if (_arg_2[_local_8].flag != 0)
                    {
                        this.push_heap_path(_arg_1, _arg_2, _local_8);
                    }
                    else
                    {
                        this.update_heap_path(_arg_1, _arg_2, _local_8);
                    };
                    _arg_2[_local_8].flag = 0;
                };
                return (0);
            };
            if (((!(_arg_2[_local_8].x == 0)) || (!(_arg_2[_local_8].y == 0))))
            {
                return (1);
            };
            _arg_2[_local_8].x = _arg_3;
            _arg_2[_local_8].y = _arg_4;
            _arg_2[_local_8].dist = _arg_5;
            _arg_2[_local_8].before = _arg_6;
            _arg_2[_local_8].cost = _arg_7;
            _arg_2[_local_8].flag = 0;
            this.push_heap_path(_arg_1, _arg_2, _local_8);
            return (0);
        }

        private function path_search(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean):Boolean
        {
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:Array;
            var _local_25:int;
            var _local_26:int;
            var _local_27:int;
            var _local_6:int;
            while (_local_6 <= MAX_HEAP)
            {
                this._heap[_local_6] = 0;
                _local_6++;
            };
            var _local_7:int = (MAX_WALKPATH * MAX_WALKPATH);
            var _local_8:int;
            while (_local_8 < _local_7)
            {
                this._tmpPath[_local_8] = new WalkPathTempPath();
                _local_8++;
            };
            this._path = new WalkPathData();
            if (this._collision == null)
            {
                return (false);
            };
            if (((_arg_3 >= this._collision.Width) || (_arg_4 >= this._collision.Height)))
            {
                return (false);
            };
            if (this._collision.GetValue(_arg_3, _arg_4) == 1)
            {
                return (false);
            };
            _local_14 = (_arg_3 - _arg_1);
            _local_14 = ((_local_14 < 0) ? -1 : ((_local_14 == 0) ? 0 : 1));
            _local_15 = (_arg_4 - _arg_2);
            _local_15 = ((_local_15 < 0) ? -1 : ((_local_15 == 0) ? 0 : 1));
            _local_12 = _arg_1;
            _local_13 = _arg_2;
            _local_9 = 0;
            while (_local_9 < this._path.path.Length)
            {
                this._path.path[_local_9] = walk_choices[(((_local_14 + 1) * 3) + (-(_local_15) + 1))];
                _local_9++;
                _local_12 = (_local_12 + _local_14);
                _local_13 = (_local_13 + _local_15);
                if (_local_12 == _arg_3)
                {
                    _local_14 = 0;
                };
                if (_local_13 == _arg_4)
                {
                    _local_15 = 0;
                };
                if (((_local_14 == 0) && (_local_15 == 0))) break;
                if (this._collision.GetValue(_local_12, _local_13) == 1) break;
            };
            if (((_local_12 == _arg_3) && (_local_13 == _arg_4)))
            {
                this._path.path_len = _local_9;
                this._path.path_pos = 0;
                this._path.easy = true;
                return (true);
            };
            if (_arg_5)
            {
                return (false);
            };
            _local_9 = ((_arg_1 + (_arg_2 * MAX_WALKPATH)) & ((MAX_WALKPATH * MAX_WALKPATH) - 1));
            this._tmpPath[_local_9].x = _arg_1;
            this._tmpPath[_local_9].y = _arg_2;
            this._tmpPath[_local_9].dist = 0;
            this._tmpPath[_local_9].before = 0;
            this._tmpPath[_local_9].cost = this.calc_cost(this._tmpPath[_local_9], _arg_3, _arg_4);
            this._tmpPath[_local_9].flag = 0;
            this._heap[0] = 0;
            this.push_heap_path(this._heap, this._tmpPath, _local_9);
            _local_17 = (this._collision.Width - 1);
            _local_18 = (this._collision.Height - 1);
            while (true)
            {
                _local_20 = 0;
                _local_21 = 0;
                _local_24 = [0, 0, 0, 0];
                if (this._heap[0] == 0)
                {
                    return (false);
                };
                _local_16 = this.pop_heap_path(this._heap, this._tmpPath);
                _local_12 = this._tmpPath[_local_16].x;
                _local_13 = this._tmpPath[_local_16].y;
                _local_22 = (this._tmpPath[_local_16].dist + 10);
                _local_23 = this._tmpPath[_local_16].cost;
                if (((_local_12 == _arg_3) && (_local_13 == _arg_4))) break;
                if (((_local_13 < _local_18) && (this._collision.GetValue(_local_12, (_local_13 + 1)) == 0)))
                {
                    _local_21 = (_local_21 | 0x01);
                    _local_24[0] = ((_local_13 >= _arg_4) ? 20 : 0);
                    _local_20 = (_local_20 + this.add_path(this._heap, this._tmpPath, _local_12, (_local_13 + 1), _local_22, _local_16, (_local_23 + _local_24[0])));
                };
                if (((_local_12 > 0) && (this._collision.GetValue((_local_12 - 1), _local_13) == 0)))
                {
                    _local_21 = (_local_21 | 0x02);
                    _local_24[1] = ((_local_12 <= _arg_3) ? 20 : 0);
                    _local_20 = (_local_20 + this.add_path(this._heap, this._tmpPath, (_local_12 - 1), _local_13, _local_22, _local_16, (_local_23 + _local_24[1])));
                };
                if (((_local_13 > 0) && (this._collision.GetValue(_local_12, (_local_13 - 1)) == 0)))
                {
                    _local_21 = (_local_21 | 0x04);
                    _local_24[2] = ((_local_13 <= _arg_4) ? 20 : 0);
                    _local_20 = (_local_20 + this.add_path(this._heap, this._tmpPath, _local_12, (_local_13 - 1), _local_22, _local_16, (_local_23 + _local_24[2])));
                };
                if (((_local_12 < _local_17) && (this._collision.GetValue((_local_12 + 1), _local_13) == 0)))
                {
                    _local_21 = (_local_21 | 0x08);
                    _local_24[3] = ((_local_12 >= _arg_3) ? 20 : 0);
                    _local_20 = (_local_20 + this.add_path(this._heap, this._tmpPath, (_local_12 + 1), _local_13, _local_22, _local_16, (_local_23 + _local_24[3])));
                };
                if ((((_local_21 & (2 + 1)) == (2 + 1)) && (this._collision.GetValue((_local_12 - 1), (_local_13 + 1)) == 0)))
                {
                    _local_20 = (_local_20 + this.add_path(this._heap, this._tmpPath, (_local_12 - 1), (_local_13 + 1), (_local_22 + 4), _local_16, (((_local_23 + _local_24[1]) + _local_24[0]) - 6)));
                };
                if ((((_local_21 & (2 + 4)) == (2 + 4)) && (this._collision.GetValue((_local_12 - 1), (_local_13 - 1)) == 0)))
                {
                    _local_20 = (_local_20 + this.add_path(this._heap, this._tmpPath, (_local_12 - 1), (_local_13 - 1), (_local_22 + 4), _local_16, (((_local_23 + _local_24[1]) + _local_24[2]) - 6)));
                };
                if ((((_local_21 & (8 + 4)) == (8 + 4)) && (this._collision.GetValue((_local_12 + 1), (_local_13 - 1)) == 0)))
                {
                    _local_20 = (_local_20 + this.add_path(this._heap, this._tmpPath, (_local_12 + 1), (_local_13 - 1), (_local_22 + 4), _local_16, (((_local_23 + _local_24[3]) + _local_24[2]) - 6)));
                };
                if ((((_local_21 & (8 + 1)) == (8 + 1)) && (this._collision.GetValue((_local_12 + 1), (_local_13 + 1)) == 0)))
                {
                    _local_20 = (_local_20 + this.add_path(this._heap, this._tmpPath, (_local_12 + 1), (_local_13 + 1), (_local_22 + 4), _local_16, (((_local_23 + _local_24[3]) + _local_24[0]) - 6)));
                };
                this._tmpPath[_local_16].flag = 1;
                if (((!(_local_20 == 0)) || (this._heap[0] >= (MAX_HEAP - 5))))
                {
                    return (false);
                };
            };
            if (!((_local_12 == _arg_3) && (_local_13 == _arg_4)))
            {
                return (false);
            };
            var _local_19:int;
            _local_11 = 0;
            _local_9 = _local_16;
            while (((_local_11 < 100) && (!(_local_9 == ((_arg_1 + (_arg_2 * MAX_WALKPATH)) & ((MAX_WALKPATH * MAX_WALKPATH) - 1))))))
            {
                _local_19++;
                _local_9 = this._tmpPath[_local_9].before;
                _local_11++;
            };
            if (((_local_11 == 100) || (_local_11 >= this._path.path.Length)))
            {
                return (false);
            };
            this._path.path_len = _local_11;
            this._path.path_pos = 0;
            _local_9 = _local_16;
            _local_10 = (_local_11 - 1);
            while (_local_10 >= 0)
            {
                _local_25 = (this._tmpPath[_local_9].x - this._tmpPath[this._tmpPath[_local_9].before].x);
                _local_26 = (this._tmpPath[_local_9].y - this._tmpPath[this._tmpPath[_local_9].before].y);
                if (_local_25 == 0)
                {
                    _local_27 = ((_local_26 > 0) ? 0 : 4);
                }
                else
                {
                    if (_local_25 > 0)
                    {
                        _local_27 = ((_local_26 == 0) ? 6 : ((_local_26 < 0) ? 5 : 7));
                    }
                    else
                    {
                        _local_27 = ((_local_26 == 0) ? 2 : ((_local_26 > 0) ? 1 : 3));
                    };
                };
                this._path.path[_local_10] = _local_27;
                _local_9 = this._tmpPath[_local_9].before;
                _local_10--;
            };
            return (true);
        }

        public function Search(_arg_1:Coordinates):Boolean
        {
            return (this.path_search(_arg_1.x, _arg_1.y, _arg_1.x1, _arg_1.y1, false));
        }

        public function get Length():int
        {
            return ((this._path != null) ? this._path.path_len : 0);
        }

        public function get Steps():Array
        {
            return ((this._path != null) ? this._path.path : null);
        }

        public function get Easy():Boolean
        {
            return ((this._path != null) ? this._path.easy : false);
        }


    }
}//package hbm.Engine.PathFinding

