


//hbm.Game.Utility.ItemTextConvert

package hbm.Game.Utility
{
    import hbm.Application.ClientApplication;

    public class ItemTextConvert 
    {


        public static function ValidateDescriptionText(_arg_1:String, _arg_2:Object):String
        {
            if (_arg_1.indexOf("%attack%") >= 0)
            {
                _arg_1 = _arg_1.replace("%attack%", _arg_2["attack"]);
            };
            if (_arg_1.indexOf("%defence%") >= 0)
            {
                _arg_1 = _arg_1.replace("%defence%", _arg_2["defence"]);
            };
            if (_arg_1.indexOf("%slots%") >= 0)
            {
                _arg_1 = _arg_1.replace("%slots%", _arg_2["slots"]);
            };
            if (_arg_1.indexOf("%range%") >= 0)
            {
                _arg_1 = _arg_1.replace("%range%", _arg_2["range"]);
            };
            return (_arg_1);
        }

        public static function GetJobsText(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):String
        {
            var _local_10:String;
            var _local_11:int;
            var _local_16:String;
            var _local_17:String;
            var _local_5:* = "";
            var _local_6:int;
            var _local_7:int;
            var _local_8:Boolean;
            var _local_9:* = "";
            var _local_12:Boolean;
            var _local_13:Array = ((_arg_1) ? ClientApplication.Localization.JOB_NAMES1 : ClientApplication.Localization.JOB_NAMES0);
            var _local_14:Array = ((_arg_1) ? ClientApplication.Localization.JOB_NAMES_BABY1 : ClientApplication.Localization.JOB_NAMES_BABY0);
            var _local_15:Array = ((_arg_1) ? ClientApplication.Localization.JOB_NAMES_ADV1 : ClientApplication.Localization.JOB_NAMES_ADV0);
            if ((_arg_3 & 0x01))
            {
                for each (_local_10 in _local_13)
                {
                    _local_11 = ((_arg_2 >> _local_6) & 0x01);
                    if (_local_11 == 1)
                    {
                        if (_local_6 < ClientApplication.Localization.JOB_MAP0.length)
                        {
                            if (_arg_1 < 0)
                            {
                                _local_16 = ClientApplication.Localization.JOB_MAP1[_local_6].group;
                                _local_17 = ClientApplication.Localization.JOB_MAP0[_local_6].group;
                                _local_10 = _local_16;
                                if ((((!(_local_6 == 0)) && (!(_local_16 == ""))) && (!(_local_17 == ""))))
                                {
                                    _local_10 = (_local_10 + (", " + _local_17));
                                };
                            }
                            else
                            {
                                _local_10 = String(((_arg_1) ? ClientApplication.Localization.JOB_MAP1[_local_6].group : ClientApplication.Localization.JOB_MAP0[_local_6].group));
                            };
                            if (_local_10.length == 0) continue;
                            if (_local_7 >= 3)
                            {
                                _local_5 = (_local_5 + ",\n");
                                _local_8 = true;
                                _local_7 = 0;
                            };
                            if (_local_8)
                            {
                                _local_8 = false;
                            }
                            else
                            {
                                _local_5 = (_local_5 + _local_9);
                                _local_9 = ", ";
                            };
                            _local_5 = (_local_5 + _local_10);
                            if ((_arg_1 < 0))
                            {
                                _local_7 = (_local_7 + 2);
                            }
                            else
                            {
                                _local_7++;
                            };
                            if (_local_6 == 0)
                            {
                                _local_12 = true;
                                break;
                            };
                        };
                    };
                    _local_6++;
                };
            };
            if (((_arg_3 & 0x02) && (!(_local_12))))
            {
                _local_6 = 0;
                for each (_local_10 in _local_15)
                {
                    _local_11 = ((_arg_2 >> _local_6) & 0x01);
                    if (_local_11 == 1)
                    {
                        if (_local_6 < ClientApplication.Localization.JOB_MAP0.length)
                        {
                            if (_arg_1 < 0)
                            {
                                _local_16 = ClientApplication.Localization.JOB_MAP0[_local_6].advgroup;
                                _local_17 = ClientApplication.Localization.JOB_MAP1[_local_6].advgroup;
                                _local_10 = _local_16;
                                if (((!(_local_16 == "")) && (!(_local_17 == ""))))
                                {
                                    _local_10 = (_local_10 + (", " + _local_17));
                                };
                            }
                            else
                            {
                                _local_10 = String(((_arg_1) ? ClientApplication.Localization.JOB_MAP0[_local_6].advgroup : ClientApplication.Localization.JOB_MAP1[_local_6].advgroup));
                            };
                            if (_local_10.length == 0)
                            {
                                _local_6++;
                                continue;
                            };
                            if (_local_7 >= 3)
                            {
                                _local_5 = (_local_5 + ",\n");
                                _local_8 = true;
                                _local_7 = 0;
                            };
                            if (_local_8)
                            {
                                _local_8 = false;
                            }
                            else
                            {
                                _local_5 = (_local_5 + _local_9);
                                _local_9 = ", ";
                            };
                            _local_5 = (_local_5 + _local_10);
                            if ((_arg_1 < 0))
                            {
                                _local_7 = (_local_7 + 2);
                            }
                            else
                            {
                                _local_7++;
                            };
                            if (_local_6 == 0) break;
                        };
                    };
                    _local_6++;
                };
            };
            if (((_arg_3 & 0x04) && (!(_local_12))))
            {
                _local_6 = 0;
                for each (_local_10 in _local_14)
                {
                    _local_11 = ((_arg_2 >> _local_6) & 0x01);
                    if (_local_11 == 1)
                    {
                        if (_local_6 < ClientApplication.Localization.JOB_MAP0.length)
                        {
                            if (_arg_1 < 0)
                            {
                                _local_16 = ClientApplication.Localization.JOB_MAP0[_local_6].babygroup;
                                _local_17 = ClientApplication.Localization.JOB_MAP1[_local_6].babygroup;
                                _local_10 = _local_16;
                                if (((!(_local_16 == "")) && (!(_local_17 == ""))))
                                {
                                    _local_10 = (_local_10 + (", " + _local_17));
                                };
                            }
                            else
                            {
                                _local_10 = String(((_arg_1) ? ClientApplication.Localization.JOB_MAP0[_local_6].babygroup : ClientApplication.Localization.JOB_MAP1[_local_6].babygroup));
                            };
                            if (_local_10.length == 0)
                            {
                                _local_6++;
                                continue;
                            };
                            if (_local_7 >= 3)
                            {
                                _local_5 = (_local_5 + ",\n");
                                _local_8 = true;
                                _local_7 = 0;
                            };
                            if (_local_8)
                            {
                                _local_8 = false;
                            }
                            else
                            {
                                _local_5 = (_local_5 + _local_9);
                                _local_9 = ", ";
                            };
                            _local_5 = (_local_5 + _local_10);
                            if ((_arg_1 < 0))
                            {
                                _local_7 = (_local_7 + 2);
                            }
                            else
                            {
                                _local_7++;
                            };
                            if (_local_6 == 0) break;
                        };
                    };
                    _local_6++;
                };
            };
            return (_local_5);
        }

        public static function GetEquipmentText(_arg_1:Array, _arg_2:Boolean):String
        {
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:Array;
            var _local_9:String;
            var _local_3:* = "";
            var _local_4:* = "";
            if (_arg_2)
            {
                _local_4 = (_local_4 + (ClientApplication.Localization.INVENTORY_POPUP_INSERTS + " "));
            }
            else
            {
                _local_4 = (_local_4 + (ClientApplication.Localization.INVENTORY_POPUP_DRESSES + " "));
            };
            for each (_local_5 in _arg_1)
            {
                if (_local_5.length != 0)
                {
                    _local_4 = (_local_4 + (_local_3 + _local_5));
                    _local_3 = ", ";
                };
            };
            if (_local_4.length >= 57)
            {
                _local_6 = "";
                _local_7 = "";
                _local_8 = _local_4.split(" ");
                for each (_local_9 in _local_8)
                {
                    if ((_local_7.length + _local_9.length) < 57)
                    {
                        _local_7 = (_local_7 + (" " + _local_9));
                    }
                    else
                    {
                        _local_6 = (_local_6 + (_local_7 + "\n"));
                        _local_7 = _local_9;
                    };
                };
                _local_4 = ((_local_6 + _local_7) + "\n");
            };
            return (_local_4);
        }


    }
}//package hbm.Game.Utility

