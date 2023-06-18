


//hbm.Engine.Actors.IgnoreInfo

package hbm.Engine.Actors
{
    public class IgnoreInfo 
    {

        private var _ignore:Array;

        public function IgnoreInfo()
        {
            this.ClearIgnoreList();
        }

        public function get Ignore():int
        {
            return (this._ignore.length);
        }

        public function get ignore():Array
        {
            return (this._ignore);
        }

        public function GetIgnore(_arg_1:int):String
        {
            var _local_2:String = (this._ignore[_arg_1] as String);
            if (_local_2 == null)
            {
                _local_2 = (this._ignore[_arg_1] = new String());
            };
            return (_local_2);
        }

        public function RemoveIgnore(_arg_1:int):void
        {
            var _local_2:String = (this._ignore[_arg_1] as String);
            if (_local_2 != null)
            {
                delete this._ignore[_arg_1];
            };
        }

        public function FindIgnoreByName(_arg_1:String):String
        {
            var _local_2:String;
            for each (_local_2 in this._ignore)
            {
                if (_local_2 != null)
                {
                    if (_local_2 == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function ClearIgnoreList():void
        {
            this._ignore = new Array();
        }


    }
}//package hbm.Engine.Actors

