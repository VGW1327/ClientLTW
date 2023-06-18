


//hbm.Engine.Resource.SkillsResourceLibrary

package hbm.Engine.Resource
{
    import flash.utils.Dictionary;
    import hbm.Application.ClientApplication;
    import flash.events.Event;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Actors.SkillData;

    public class SkillsResourceLibrary extends ResourceLibrary 
    {

        public static const TARGET_PASSIVE:int = 0;
        public static const TARGET_CHARACTER:int = 1;
        public static const TARGET_COORDINATES:int = 8;

        private var _advancedJobs:Array;
        private var _skillsC0:Dictionary;
        private var _skillsC1:Dictionary;
        private var _skillCasts:Dictionary;


        override public function GetLibraryFileName():String
        {
            return (ClientApplication.Instance.Config.GetFileURL("Skills"));
        }

        override protected function OnResourceLoaded(_arg_1:Event):void
        {
            super.OnResourceLoaded(_arg_1);
        }

        public function GetJobsID(_arg_1:int):Array
        {
            var _local_4:String;
            var _local_2:Dictionary = ((_arg_1) ? this._skillsC1 : this._skillsC0);
            if (_local_2 == null)
            {
                return (null);
            };
            var _local_3:Array = [];
            for (_local_4 in _local_2)
            {
                _local_3.push(int(_local_4));
            };
            return (_local_3);
        }

        public function GetSkillsData(_arg_1:int, _arg_2:int, _arg_3:int):Object
        {
            var _local_4:Dictionary = ((_arg_1) ? this._skillsC1 : this._skillsC0);
            if (((_local_4 == null) || (_local_4[_arg_2] == null)))
            {
                return (null);
            };
            return (_local_4[_arg_2][_arg_3]);
        }

        public function GetSkillTargetType(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int;
            var _local_5:Object = this.GetSkillsData(_arg_1, _arg_2, _arg_3);
            if (_local_5 != null)
            {
                _local_4 = _local_5["Target"];
            };
            return (_local_4);
        }

        public function GetSkillBackgroundRef(_arg_1:int, _arg_2:int):String
        {
            return (this.GetSkillRef(_arg_1, _arg_2, 4));
        }

        public function GetSkillIconRef(_arg_1:int, _arg_2:int):String
        {
            return (this.GetSkillRef(_arg_1, _arg_2, 5));
        }

        private function GetSkillRef(_arg_1:int, _arg_2:int, _arg_3:int):String
        {
            if (!IsLoaded)
            {
                return (null);
            };
            var _local_4:String = _arg_2.toString();
            while (_local_4.length < _arg_3)
            {
                _local_4 = ("0" + _local_4);
            };
            var _local_5:String = ("Skills_Item_" + _local_4);
            if (_arg_1 > 0)
            {
                _local_5 = (_local_5 + "c");
            };
            return (_local_5);
        }

        public function GetSkillsByJob(_arg_1:int, _arg_2:int):Dictionary
        {
            var _local_3:Dictionary = ((_arg_1) ? this._skillsC1 : this._skillsC0);
            if (_local_3 == null)
            {
                return (null);
            };
            var _local_4:Dictionary = _local_3[_arg_2];
            if (_local_4 == null)
            {
                _local_4 = new Dictionary(true);
                _local_3[_arg_2] = _local_4;
            };
            return (_local_4);
        }

        public function JobIsAdvanced(_arg_1:int):Boolean
        {
            return ((this._advancedJobs) && (this._advancedJobs.indexOf(_arg_1) >= 0));
        }

        private function LoadSkillsData():void
        {
            var _local_1:Object;
            var _local_2:int;
            var _local_5:Object;
            var _local_6:Object;
            var _local_7:int;
            var _local_8:int;
            var _local_9:Dictionary;
            var _local_3:ResourceLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            if (((!(_local_3 == null)) && (_local_3.IsLoaded)))
            {
                _local_5 = GetJSON("Localization_Data_SkillsInfo");
                this._skillsC0 = new Dictionary(true);
                this._skillsC1 = new Dictionary(true);
                this._advancedJobs = ((_local_5.AdvancedJobs) ? _local_5.AdvancedJobs.concat() : []);
                for each (_local_6 in _local_5.SkillsInfo)
                {
                    _local_7 = _local_6["ClothesColor"];
                    _local_8 = _local_6["JobId"];
                    _local_2 = _local_6["Id"];
                    _local_9 = this.GetSkillsByJob(_local_7, _local_8);
                    _local_9[_local_2] = _local_6;
                };
            };
            var _local_4:Object = GetJSON("Skills_Data_SkillCasts");
            if (_local_4 != null)
            {
                this._skillCasts = new Dictionary(true);
                for each (_local_1 in _local_4.SkillCastsList)
                {
                    _local_2 = _local_1["id"];
                    this._skillCasts[_local_2] = _local_1;
                };
            };
        }

        public function GetSkillCooldown(_arg_1:int):Number
        {
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:CharacterInfo;
            var _local_7:SkillData;
            var _local_2:Number = 0;
            var _local_3:Object = this._skillCasts[_arg_1];
            if (_local_3)
            {
                _local_4 = String(_local_3.casting_time).split(":");
                _local_5 = String(_local_3.after_cast_delay).split(":");
                if (((_local_4.length > 1) || (_local_5.length > 1)))
                {
                    _local_6 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                    _local_7 = _local_6.Skills[_arg_1];
                    if (_local_7 != null)
                    {
                        if (_local_5.length > 1)
                        {
                            _local_2 = (_local_5[(_local_7.Lv - 1)] / 1000);
                        };
                    };
                };
                if (_local_5.length == 1)
                {
                    _local_2 = (_local_5[0] / 1000);
                };
            };
            return (_local_2);
        }

        public function LoadLocalizedData():void
        {
            this.LoadSkillsData();
        }


    }
}//package hbm.Engine.Resource

