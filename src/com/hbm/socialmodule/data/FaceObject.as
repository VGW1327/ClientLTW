


//com.hbm.socialmodule.data.FaceObject

package com.hbm.socialmodule.data
{
    import com.hbm.socialmodule.*;

    public class FaceObject 
    {

        private var _name:String;
        private var _id:String;
        private var _photo:String;
        private var _ratings:Array;

        public function FaceObject(_arg_1:String=null, _arg_2:String=null, _arg_3:String=null)
        {
            this._ratings = [];
            this._name = _arg_1;
            this._id = _arg_2;
            this._photo = _arg_3;
        }

        public function get Name():String
        {
            return (this._name);
        }

        public function set Name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function get Id():String
        {
            return (this._id);
        }

        public function set Id(_arg_1:String):void
        {
            this._id = _arg_1;
        }

        public function get Photo():String
        {
            return (this._photo);
        }

        public function set Photo(_arg_1:String):void
        {
            this._photo = _arg_1;
        }

        public function get Ratings():Array
        {
            return (this._ratings);
        }

        public function SetRating(_arg_1:UserRating):void
        {
            this._ratings[_arg_1.RatingId] = _arg_1;
        }

        public function GetRating(_arg_1:uint):UserRating
        {
            return (this._ratings[_arg_1]);
        }


    }
}//package com.hbm.socialmodule.data

