


//hbm.Game.Renderer.StatusManager

package hbm.Game.Renderer
{
    import hbm.Engine.Network.Events.ActorActiveStatusEvent;
    import flash.utils.Dictionary;
    import hbm.Engine.Renderer.RenderObject;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import org.aswing.JWindow;
    import flash.events.MouseEvent;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import flash.geom.Point;

    public class StatusManager 
    {

        private static var _isSingletonLock:Boolean = false;
        private static var _singleton:StatusManager = null;
        public static var startY:int = 70;
        public static var startX:int = 95;
        private static const _negativeStatusList:Array = new Array(ActorActiveStatusEvent.SI_ENCPOISON, ActorActiveStatusEvent.SI_QUAGMIRE, ActorActiveStatusEvent.SI_DECREASEAGI, ActorActiveStatusEvent.SI_SLOWPOISON, ActorActiveStatusEvent.SI_WEIGHT50, ActorActiveStatusEvent.SI_WEIGHT90, ActorActiveStatusEvent.SI_STRIPWEAPON, ActorActiveStatusEvent.SI_STRIPSHIELD, ActorActiveStatusEvent.SI_STRIPARMOR, ActorActiveStatusEvent.SI_STRIPHELM, ActorActiveStatusEvent.SI_STOP, ActorActiveStatusEvent.SI_BLEEDING, ActorActiveStatusEvent.SI_CRITICALWOUND, ActorActiveStatusEvent.SI_BREAKRIB, ActorActiveStatusEvent.SI_JAILED, ActorActiveStatusEvent.SI_ETERNALCHAOS, ActorActiveStatusEvent.SI_DECMATKRATE, ActorActiveStatusEvent.SI_DECATKRATE, ActorActiveStatusEvent.SI_COMA, ActorActiveStatusEvent.SI_CONFUSION, ActorActiveStatusEvent.SI_DECDEFRATE, ActorActiveStatusEvent.SI_DECMDEFRATE, ActorActiveStatusEvent.SI_DECFLEERATE, ActorActiveStatusEvent.SI_DECHITRATE, ActorActiveStatusEvent.SI_FREEZE, ActorActiveStatusEvent.SI_SLEEP, ActorActiveStatusEvent.SI_STONE, ActorActiveStatusEvent.SI_STUN, ActorActiveStatusEvent.SI_POISON, ActorActiveStatusEvent.SI_SILENCE, ActorActiveStatusEvent.SI_BLIND, ActorActiveStatusEvent.SI_DPOISON, ActorActiveStatusEvent.SI_CURSE, ActorActiveStatusEvent.SI_LADDER, ActorActiveStatusEvent.SI_BREAKHEAD, ActorActiveStatusEvent.SI_DURABILITY5, ActorActiveStatusEvent.SI_DURABILITY30);
        private static const _clickableStatusList:Array = new Array(ActorActiveStatusEvent.SI_DEATHFEAR, ActorActiveStatusEvent.SI_MANNER);
        private static const _noNeedDrawTime:Array = new Array(ActorActiveStatusEvent.SI_QUAGMIRE, ActorActiveStatusEvent.SI_ETERNALCHAOS, ActorActiveStatusEvent.SI_AUTOBERSERK, ActorActiveStatusEvent.SI_GUILDAURA, ActorActiveStatusEvent.SI_JAILED, ActorActiveStatusEvent.SI_MDEFAURA);

        private var _lastFrameTickTime:uint = 0;
        private var _statusItemList:Dictionary;
        private var _statusRectList:Dictionary;
        private var _tooltipList:Dictionary;

        public function StatusManager()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access. Use BattleLogManager.Instance."));
            };
            this._statusItemList = new Dictionary(true);
            this._statusRectList = new Dictionary(true);
            this._tooltipList = new Dictionary(true);
        }

        public static function get Instance():StatusManager
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (StatusManager)();
                _isSingletonLock = false;
            };
            return (_singleton);
        }


        public function Clear():void
        {
            var _local_1:StatusItemObject;
            var _local_2:RenderObject;
            var _local_3:int;
            var _local_4:CustomToolTip;
            for each (_local_1 in this._statusItemList)
            {
                if (_local_1 != null)
                {
                    _local_3 = _local_1.StatusType;
                    _local_4 = this._tooltipList[_local_3];
                    if (_local_4 != null)
                    {
                        _local_4.disposeToolTip();
                        _local_4.setTargetComponent(null);
                        delete this._tooltipList[_local_3];
                    };
                };
            };
            for each (_local_2 in this._statusItemList)
            {
                RenderSystem.Instance.RemoveRenderObject(_local_2);
            };
            this._statusItemList = new Dictionary(true);
            this._statusRectList = new Dictionary(true);
            this._tooltipList = new Dictionary(true);
        }

        public function IsExist(_arg_1:int):Boolean
        {
            var _local_2:StatusItemObject = (this._statusItemList[_arg_1] as StatusItemObject);
            return (!(_local_2 == null));
        }

        public function ChangeStatusItem(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            if (_arg_3 > 0)
            {
                this.OnStatusItem(_arg_1, _arg_2, _arg_3);
            }
            else
            {
                this.OffStatusItem(_arg_2);
            };
        }

        public function OnStatusItem(_arg_1:int, _arg_2:int, _arg_3:int=-1):void
        {
            var _local_10:AdditionalDataResourceLibrary;
            var _local_4:StatusItemObject = (this._statusItemList[_arg_2] as StatusItemObject);
            if (_local_4 != null)
            {
                _local_4.TimeAmount = _arg_3;
                return;
            };
            var _local_5:* = "AdditionalData_Item_";
            if (_arg_2 < 10)
            {
                _local_5 = (_local_5 + "000");
            }
            else
            {
                if (_arg_2 < 100)
                {
                    _local_5 = (_local_5 + "00");
                }
                else
                {
                    if (_arg_2 < 1000)
                    {
                        _local_5 = (_local_5 + "0");
                    };
                };
            };
            _local_5 = (_local_5 + _arg_2.toString());
            var _local_6:int;
            var _local_7:int = _negativeStatusList.indexOf(_arg_2);
            if (_local_7 >= 0)
            {
                _local_6 = 1;
            }
            else
            {
                _local_7 = _clickableStatusList.indexOf(_arg_2);
                if (_local_7 >= 0)
                {
                    _local_6 = 2;
                };
            };
            var _local_8:StatusItemObject = new StatusItemObject(_arg_1, _arg_2, _local_5, _local_6, _arg_3);
            RenderSystem.Instance.AddRenderObject(_local_8);
            _local_7 = _noNeedDrawTime.indexOf(_arg_2);
            _local_8.NeedDrawTime = (_local_7 < 0);
            this._statusItemList[_arg_2] = _local_8;
            var _local_9:JWindow = new JWindow();
            _local_9.setSizeWH(22, 22);
            if (_local_6 == 2)
            {
                _local_9.putClientProperty("statusType", _arg_2);
                _local_9.addEventListener(MouseEvent.CLICK, this.OnMouseClick, false, 0, true);
            };
            _local_9.show();
            this._statusRectList[_arg_2] = _local_9;
            _local_10 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_11:Object = _local_10.GetStatusData(_arg_1, _arg_2.toString());
            if (_local_11)
            {
                this._tooltipList[_arg_2] = new CustomToolTip(this._statusRectList[_arg_2], _local_11.Description, 250, _local_11.windowHeight);
            };
            this.Update(0, true);
        }

        public function OffStatusItem(_arg_1:int):void
        {
            var _local_2:StatusItemObject = this._statusItemList[_arg_1];
            if (_local_2 != null)
            {
                RenderSystem.Instance.RemoveRenderObject(_local_2);
            };
            delete this._statusItemList[_arg_1];
            var _local_3:CustomToolTip = this._tooltipList[_arg_1];
            if (_local_3 != null)
            {
                _local_3.disposeToolTip();
                _local_3.setTargetComponent(null);
                delete this._tooltipList[_arg_1];
            };
            var _local_4:JWindow = this._statusRectList[_arg_1];
            if (_local_4 != null)
            {
                _local_4.dispose();
                delete this._statusRectList[_arg_1];
            };
        }

        private function OnMouseClick(currentEvent:MouseEvent):void
        {
            var rect:JWindow;
            var statusType:int;
            var player:CharacterInfo;
            var price:int;
            var priceInCols:String;
            if ((currentEvent.currentTarget is JWindow))
            {
                rect = (currentEvent.currentTarget as JWindow);
                statusType = rect.getClientProperty("statusType");
                player = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                price = 0;
                if (statusType == ActorActiveStatusEvent.SI_DEATHFEAR)
                {
                    if (player.baseLevel < 50)
                    {
                        price = 0;
                    }
                    else
                    {
                        if (player.baseLevel < 60)
                        {
                            price = 10000;
                        }
                        else
                        {
                            if (player.baseLevel < 70)
                            {
                                price = 20000;
                            }
                            else
                            {
                                if (player.baseLevel < 80)
                                {
                                    price = 30000;
                                }
                                else
                                {
                                    if (player.baseLevel < 90)
                                    {
                                        price = 40000;
                                    }
                                    else
                                    {
                                        if (player.baseLevel < 100)
                                        {
                                            price = 50000;
                                        };
                                    };
                                };
                            };
                        };
                    };
                    if (price > 0)
                    {
                        new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((ClientApplication.Localization.ZENY_CLEAR_DEATHFEAR_MESSAGE + " ") + price), function OnOperationAccepted (_arg_1:int):void
                        {
                            if (_arg_1 == JOptionPane.YES)
                            {
                                ClientApplication.Instance.LocalGameClient.SendClearDeathFear();
                            };
                        }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
                    };
                }
                else
                {
                    if (statusType == ActorActiveStatusEvent.SI_MANNER)
                    {
                        price = (player.manner * 10);
                        priceInCols = price.toString();
                        new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((ClientApplication.Localization.CASH_CLEAR_MUTE_MESSAGE + " ") + priceInCols), function OnOperationAccepted (_arg_1:int):void
                        {
                            if (_arg_1 == JOptionPane.YES)
                            {
                                ClientApplication.Instance.LocalGameClient.SendChatMessage("@cashunmute");
                            };
                        }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
                    };
                };
            };
        }

        public function GetCollidedItem(_arg_1:Point):StatusItemObject
        {
            var _local_3:StatusItemObject;
            var _local_2:Boolean;
            for each (_local_3 in this._statusItemList)
            {
                if (_local_3 != null)
                {
                    _local_2 = _local_3.IsCollided(_arg_1);
                    if (_local_2)
                    {
                        return (_local_3);
                    };
                };
            };
            return (null);
        }

        public function Update(_arg_1:uint, _arg_2:Boolean=false):void
        {
            var _local_3:Number;
            var _local_11:JWindow;
            var _local_13:StatusItemObject;
            if (_arg_2)
            {
                _local_3 = 0;
            }
            else
            {
                _local_3 = (Number((_arg_1 - this._lastFrameTickTime)) / 1000);
                this._lastFrameTickTime = _arg_1;
            };
            var _local_4:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_5:int = 23;
            var _local_6:int = 23;
            var _local_7:* = 260;
            var _local_8:* = 350;
            var _local_9:int = startX;
            var _local_10:int = startY;
            var _local_12:int;
            for each (_local_13 in this._statusItemList)
            {
                if (_local_13 != null)
                {
                    if (_local_13.TypeEffect == 0)
                    {
                        _local_13.TimeAmount = (_local_13.TimeAmount - _local_3);
                        _local_13.Position.x = _local_9;
                        _local_13.Position.y = _local_10;
                        if ((_local_9 + _local_5) > (startX + ((_local_12 > 0) ? _local_8 : _local_7)))
                        {
                            _local_9 = (startX - (_local_5 * 4));
                            _local_10 = (_local_10 + _local_6);
                            _local_12++;
                        }
                        else
                        {
                            _local_9 = (_local_9 + _local_5);
                        };
                        _local_11 = this._statusRectList[_local_13.StatusType];
                        if (_local_11 != null)
                        {
                            _local_11.setLocationXY(_local_13.Position.x, _local_13.Position.y);
                        };
                    };
                };
            };
            for each (_local_13 in this._statusItemList)
            {
                if (_local_13 != null)
                {
                    if (!((!(_local_13.TypeEffect == 1)) && (!(_local_13.TypeEffect == 2))))
                    {
                        switch (_local_13.StatusType)
                        {
                            case ActorActiveStatusEvent.SI_DEATHFEAR:
                                _local_13.TimeAmount = _local_4.deathfear;
                                break;
                            case ActorActiveStatusEvent.SI_BREAKRIB:
                                _local_13.TimeAmount = _local_4.breakrib;
                                break;
                            case ActorActiveStatusEvent.SI_MANNER:
                                _local_13.TimeAmount = (_local_4.manner * 60);
                                break;
                            case ActorActiveStatusEvent.SI_LADDER:
                                _local_13.TimeAmount = (_local_4.arenapunish * 60);
                                break;
                            case ActorActiveStatusEvent.SI_BREAKHEAD:
                                _local_13.TimeAmount = _local_4.breakhead;
                                break;
                            default:
                                _local_13.TimeAmount = (_local_13.TimeAmount - _local_3);
                        };
                        _local_13.Position.x = _local_9;
                        _local_13.Position.y = _local_10;
                        if ((_local_9 + _local_5) > (startX + ((_local_12 > 0) ? _local_8 : _local_7)))
                        {
                            _local_9 = (startX - (_local_5 * 4));
                            _local_10 = (_local_10 + _local_6);
                            _local_12++;
                        }
                        else
                        {
                            _local_9 = (_local_9 + _local_5);
                        };
                        _local_11 = this._statusRectList[_local_13.StatusType];
                        if (_local_11 != null)
                        {
                            _local_11.setLocationXY(_local_13.Position.x, _local_13.Position.y);
                        };
                    };
                };
            };
        }


    }
}//package hbm.Game.Renderer

