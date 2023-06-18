


//hbm.Game.GUI.QuestBook.QuestsPanelController

package hbm.Game.GUI.QuestBook
{
    import org.aswing.JWindow;
    import org.aswing.JButton;
    import flash.utils.Dictionary;
    import org.aswing.JPanel;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.Container;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.GUI.Tools.FlashCustomButton;
    import flash.events.MouseEvent;
    import org.aswing.BorderLayout;
    import flash.display.DisplayObject;
    import hbm.Application.ClientApplication;
    import mx.core.BitmapAsset;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import flash.events.Event;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;

    public class QuestsPanelController extends JWindow 
    {

        private static const QUESTS_PER_PAGE:uint = 3;

        private var _upScroll:JButton;
        private var _downScroll:JButton;
        private var _icons:Array;
        private var _quests:Array;
        private var _questsIdHash:Dictionary;
        private var _curPageIndex:int;

        public function QuestsPanelController()
        {
            var _local_3:QuestFrame;
            var _local_4:JPanel;
            super();
            AsWingUtil.SetBorder(this);
            setLocationXY(0, 195);
            setFocusable(false);
            var _local_1:Container = getContentPane();
            _local_1.setFocusable(false);
            _local_1.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.TOP));
            this._upScroll = new FlashCustomButton(QuestUpButton, this.OnScrollUp);
            _local_1.append(this._upScroll);
            this._icons = [];
            var _local_2:uint;
            while (_local_2 < QUESTS_PER_PAGE)
            {
                _local_3 = new QuestFrame();
                _local_3.addEventListener(MouseEvent.CLICK, this.OnQuestClick, false, 0, true);
                _local_4 = new JPanel(new BorderLayout());
                AsWingUtil.SetSize(_local_4, _local_3.width, _local_3.height);
                _local_4.addChild(_local_3);
                _local_4.buttonMode = true;
                _local_1.append(_local_4);
                this._icons.push(_local_3);
                _local_2++;
            };
            this._downScroll = new FlashCustomButton(QuestDownButton, this.OnScrollDown);
            _local_1.append(this._downScroll);
            pack();
        }

        public function GetQuestIcon(_arg_1:uint):DisplayObject
        {
            var _local_2:Object;
            var _local_3:int;
            for (_local_2 in this._questsIdHash)
            {
                if (this._questsIdHash[_local_2] == _arg_1)
                {
                    _local_3 = (this._quests.indexOf(_local_2) - this._curPageIndex);
                    if (_local_3 < 0)
                    {
                        return (null);
                    };
                    return (this._icons[_local_3]);
                };
            };
            return (null);
        }

        private function OnQuestClick(_arg_1:MouseEvent):void
        {
            var _local_2:int = this._icons.indexOf(_arg_1.currentTarget);
            if (_local_2 < 0)
            {
                return;
            };
            var _local_3:Object = this._quests[(this._curPageIndex + _local_2)];
            ClientApplication.Instance.ShowQuestsWindow(this._questsIdHash[_local_3]);
        }

        public function Update():void
        {
            var _local_1:Object;
            _local_1 = AsWingUtil.AdditionalData.GetMapsData(ClientApplication.Instance.LocalGameClient.MapName);
            var _local_2:* = (!((_local_1) && (_local_1["LockQuestLog"] == 1)));
            ClientApplication.Instance.TopHUD.GetTopHUD._questsButton.visible = (ClientApplication.Instance.TopHUD.GetTopHUD._questsNotifyButton.visible = _local_2);
            this.Revalidate();
            if (this._quests.length)
            {
                this._curPageIndex = Math.min((this._quests.length - QUESTS_PER_PAGE), this._curPageIndex);
                this._curPageIndex = Math.max(0, this._curPageIndex);
                this.UpdateArrows();
                this.UpdateIcons();
                if (!isShowing())
                {
                    show();
                };
            }
            else
            {
                hide();
            };
        }

        private function UpdateIcons():void
        {
            var _local_5:QuestFrame;
            var _local_6:Object;
            var _local_7:String;
            var _local_8:BitmapAsset;
            var _local_9:uint;
            var _local_10:JPanel;
            var _local_11:String;
            var _local_1:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_2:uint;
            var _local_3:uint = Math.min((this._curPageIndex + QUESTS_PER_PAGE), this._quests.length);
            var _local_4:uint = this._curPageIndex;
            while (_local_4 < (this._curPageIndex + QUESTS_PER_PAGE))
            {
                _local_5 = this._icons[(_local_4 - this._curPageIndex)];
                _local_5.visible = (_local_4 < _local_3);
                _local_5.parent.mouseChildren = (_local_5.parent.mouseEnabled = _local_5.visible);
                if (_local_5.visible)
                {
                    _local_2++;
                    _local_6 = this._quests[_local_4];
                    _local_7 = ((_local_6.Icon) || ("questicon01"));
                    _local_8 = AsWingUtil.GetAsset(_local_7);
                    _local_8.x = ((_local_5.width - _local_8.width) / 2);
                    _local_8.y = ((_local_5.height - _local_8.height) / 2);
                    while (_local_5._avatar.numChildren)
                    {
                        _local_5._avatar.removeChildAt(0);
                    };
                    _local_5._avatar.addChild(_local_8);
                    _local_9 = this._questsIdHash[_local_6];
                    _local_5._stamp.visible = (_local_6.Complete == _local_1.QuestStates[_local_9]);
                    _local_5._compass.visible = (_local_9 == HelpManager.Instance.GetRoadAtlas().QuestId);
                    _local_10 = (_local_5.parent as JPanel);
                    if (_local_10)
                    {
                        _local_11 = ((_local_6.Name) || (ClientApplication.Localization.QUEST_WINDOW_UNKNOWN_NAME));
                        if (_local_5._compass.visible)
                        {
                            _local_11 = (_local_11 + ("\n" + ClientApplication.Instance.GetPopupText(279)));
                        };
                        if (_local_5._stamp.visible)
                        {
                            _local_11 = (_local_11 + ("\n" + ClientApplication.Instance.GetPopupText(276)));
                        };
                        _local_10.setToolTipText(_local_11);
                    };
                };
                _local_4++;
            };
            if (_local_2 < 3)
            {
                AsWingUtil.SetSize(this, 60, (20 + (62 * _local_2)));
            }
            else
            {
                AsWingUtil.SetSize(this, 60, (40 + (62 * 3)));
            };
        }

        private function OnScrollDown(_arg_1:Event):void
        {
            this._curPageIndex = Math.min((this._quests.length - QUESTS_PER_PAGE), (this._curPageIndex + 1));
            this.UpdateArrows();
            this.UpdateIcons();
        }

        private function OnScrollUp(_arg_1:Event):void
        {
            this._curPageIndex = Math.max(0, (this._curPageIndex - 1));
            this.UpdateArrows();
            this.UpdateIcons();
        }

        private function UpdateArrows():void
        {
            if (this._curPageIndex == 0)
            {
                this._upScroll.alpha = 0;
                this._upScroll.mouseEnabled = (this._upScroll.buttonMode = false);
            }
            else
            {
                this._upScroll.alpha = 1;
                this._upScroll.mouseEnabled = (this._upScroll.buttonMode = true);
            };
            if (this._curPageIndex >= (this._quests.length - QUESTS_PER_PAGE))
            {
                this._downScroll.alpha = 0;
                this._downScroll.mouseEnabled = (this._downScroll.buttonMode = false);
            }
            else
            {
                this._downScroll.alpha = 1;
                this._downScroll.mouseEnabled = (this._downScroll.buttonMode = true);
            };
        }

        private function Revalidate():void
        {
            var _local_4:*;
            var _local_5:int;
            var _local_6:Object;
            var _local_7:Object;
            var _local_1:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_2:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._quests = [];
            this._questsIdHash = new Dictionary();
            var _local_3:String = this.CurrentLocation();
            for (_local_4 in _local_1.QuestStates)
            {
                if (_local_4 != 254)
                {
                    _local_5 = _local_1.QuestStates[_local_4];
                    if (((_local_5 > 0) && (_local_5 < 100)))
                    {
                        _local_6 = _local_2.GetQuestsData(_local_4);
                        if (_local_6)
                        {
                            _local_7 = _local_2.GetNpcDataFromId(_local_6.NpcId[0]);
                            if ((((_local_6.Locations) && (_local_6.Locations.indexOf(_local_3) >= 0)) || ((_local_7) && (_local_7.MapName.indexOf(_local_3) >= 0))))
                            {
                                this._quests.push(_local_6);
                                this._questsIdHash[_local_6] = _local_4;
                            };
                        };
                    };
                };
            };
        }

        private function CurrentLocation():String
        {
            return (ClientApplication.Instance.LocalGameClient.MapName.replace(/(\w+)\.gat/i, "$1"));
        }


    }
}//package hbm.Game.GUI.QuestBook

