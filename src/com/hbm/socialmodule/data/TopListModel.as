


//com.hbm.socialmodule.data.TopListModel

package com.hbm.socialmodule.data
{
    public class TopListModel 
    {

        private var _totalUsersCount:uint;
        private var _elements:Array;
        private var _hasNextPage:Boolean;
        private var _hasPreviousPage:Boolean;
        private var _currentOffsetIndex:uint = 0;
        private var _ratingId:int = -1;
        private var _friends:Boolean;


        public function setList(_arg_1:Array, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:Boolean=false):void
        {
            this._ratingId = _arg_4;
            this._elements = _arg_1;
            this._totalUsersCount = _arg_2;
            this._currentOffsetIndex = _arg_3;
            this._hasNextPage = (((this._currentOffsetIndex + this._elements.length) + 1) < _arg_2);
            this._hasPreviousPage = (this._currentOffsetIndex > 0);
            this._friends = _arg_5;
        }

        public function get hasNextPage():Boolean
        {
            return (this._hasNextPage);
        }

        public function set hasNextPage(_arg_1:Boolean):void
        {
            this._hasNextPage = _arg_1;
        }

        public function get hasPreviousPage():Boolean
        {
            return (this._hasPreviousPage);
        }

        public function set hasPreviousPage(_arg_1:Boolean):void
        {
            this._hasPreviousPage = _arg_1;
        }

        public function get currentOffsetIndex():uint
        {
            return (this._currentOffsetIndex);
        }

        public function set currentOffsetIndex(_arg_1:uint):void
        {
            this._currentOffsetIndex = _arg_1;
        }

        public function get users():Array
        {
            return (this._elements);
        }

        public function get totalUsersCount():uint
        {
            return (this._totalUsersCount);
        }

        public function set totalUsersCount(_arg_1:uint):void
        {
            this._totalUsersCount = _arg_1;
        }

        public function get ratingId():uint
        {
            return (this._ratingId);
        }

        public function get isFriends():Boolean
        {
            return (this._friends);
        }

        public function set isFriends(_arg_1:Boolean):void
        {
            this._friends = _arg_1;
        }


    }
}//package com.hbm.socialmodule.data

