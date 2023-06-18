


//com.hbm.socialmodule.data.UserObject

package com.hbm.socialmodule.data
{
    public class UserObject extends FaceObject 
    {

        public static const FEMALE:String = "female";
        public static const MALE:String = "male";
        public static const UNDEFINED_GENDER:String = "null";

        private var _lastName:String;
        private var _birthDate:String = "";
        private var _sex:String = "";
        private var _city:String = "";
        private var _link:String = "";

        public function UserObject(_arg_1:String=null, _arg_2:String=null, _arg_3:String=null, _arg_4:String=null)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._lastName = _arg_2;
        }

        public function get BirthDate():String
        {
            return (this._birthDate);
        }

        public function set BirthDate(_arg_1:String):void
        {
            this._birthDate = _arg_1;
        }

        public function get Sex():String
        {
            return (this._sex);
        }

        public function set Sex(_arg_1:String):void
        {
            this._sex = _arg_1;
        }

        public function get City():String
        {
            return (this._city);
        }

        public function set City(_arg_1:String):void
        {
            this._city = _arg_1;
        }

        public function get LastName():String
        {
            return (this._lastName);
        }

        public function set LastName(_arg_1:String):void
        {
            this._lastName = _arg_1;
        }

        public function get Link():String
        {
            return (this._link);
        }

        public function set Link(_arg_1:String):void
        {
            this._link = _arg_1;
        }

        public function get ServerId():String
        {
            return (SocialNetworkState.Instance.ServerIdPrefix + Id);
        }

        public function set ServerId(_arg_1:String):void
        {
            var _local_2:uint = SocialNetworkState.Instance.ServerIdPrefix.length;
            Id = _arg_1.substr(_local_2);
        }


    }
}//package com.hbm.socialmodule.data

