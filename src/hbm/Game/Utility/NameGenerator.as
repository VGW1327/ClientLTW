


//hbm.Game.Utility.NameGenerator

package hbm.Game.Utility
{
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;

    public class NameGenerator 
    {

        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _data:Object;

        public function NameGenerator()
        {
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._data = this._dataLibrary.GetNameGeneratorData();
        }

        public function Generate(_arg_1:Boolean):String
        {
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_11:int;
            if (((((((this._data == null) || (this._data["Start"] == null)) || (this._data["Start"].length < 1)) || (this._data["Middle"] == null)) || (this._data["Middle"].length < 1)) || ((_arg_1) ? ((this._data["EndM"] == null) || (this._data["EndM"].length < 1)) : ((this._data["EndF"] == null) || (this._data["EndF"].length < 1)))))
            {
                return ("");
            };
            var _local_2:int = int((Math.random() * this._data["Start"].length));
            var _local_3:String = this._data["Start"][_local_2];
            var _local_4:* = "";
            var _local_9:int = int((Math.random() * 2));
            _local_5 = _local_3;
            var _local_10:int;
            while (_local_10 < _local_9)
            {
                _local_11 = 0;
                while (_local_11 < 10)
                {
                    _local_2 = int((Math.random() * this._data["Middle"].length));
                    _local_4 = this._data["Middle"][_local_2];
                    if (_local_5 != _local_4)
                    {
                        _local_7 = _local_5.charAt((_local_5.length - 1));
                        _local_8 = _local_4.charAt(0);
                        if (_local_7 != _local_8) break;
                    };
                    _local_11++;
                };
                _local_5 = _local_4;
                _local_3 = (_local_3 + _local_4);
                _local_10++;
            };
            _local_10 = 0;
            while (_local_10 < 10)
            {
                _local_2 = int((Math.random() * ((_arg_1) ? this._data["EndM"].length : this._data["EndF"].length)));
                _local_6 = ((_arg_1) ? this._data["EndM"][_local_2] : this._data["EndF"][_local_2]);
                _local_7 = _local_3.charAt((_local_3.length - 1));
                _local_8 = _local_6.charAt(0);
                if (_local_7 != _local_8) break;
                _local_10++;
            };
            return (_local_3 + _local_6);
        }


    }
}//package hbm.Game.Utility

