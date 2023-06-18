


//com.hbm.socialmodule.data.UserRating

package com.hbm.socialmodule.data
{
    public class UserRating 
    {

        private var _ratingId:uint;
        private var _rating:int;
        private var _place:uint;
        private var _placeAmongFriends:uint;

        public function UserRating(_arg_1:uint, _arg_2:int, _arg_3:uint=0, _arg_4:uint=0)
        {
            this._ratingId = _arg_1;
            this._rating = _arg_2;
            this._place = _arg_3;
            this._placeAmongFriends = _arg_4;
        }

        public function get RatingId():uint
        {
            return (this._ratingId);
        }

        public function get Rating():int
        {
            return (this._rating);
        }

        public function get Place():uint
        {
            return (this._place);
        }

        public function get PlaceAmongFriends():uint
        {
            return (this._placeAmongFriends);
        }

        public function set RatingId(_arg_1:uint):void
        {
            this._ratingId = _arg_1;
        }

        public function set Rating(_arg_1:int):void
        {
            this._rating = _arg_1;
        }

        public function set Place(_arg_1:uint):void
        {
            this._place = _arg_1;
        }

        public function set PlaceAmongFriends(_arg_1:uint):void
        {
            this._placeAmongFriends = _arg_1;
        }


    }
}//package com.hbm.socialmodule.data

