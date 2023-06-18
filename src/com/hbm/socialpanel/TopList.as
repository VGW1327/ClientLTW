


//com.hbm.socialpanel.TopList

package com.hbm.socialpanel
{
    import flash.display.Sprite;
    import com.hbm.socialmodule.data.TopListModel;
    import com.hbm.socialmodule.SocialModule;
    import com.hbm.socialmodule.data.UserObject;
    import flash.display.DisplayObject;
    import flash.text.TextFieldAutoSize;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.events.ErrorEvent;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.display.SimpleButton;
    import flash.text.TextField;

    public class TopList extends Sprite 
    {

        private const _bottomRowY:int = 144;

        private var _ratingId:uint;
        private var _friends:Boolean;
        private var _topListModel:TopListModel;
        private var _socialModule:SocialModule;
        private var _user:UserObject;
        private var _pagingPanel:PagingPanel;
        private var _refreshButton:RefreshButton;
        private var _showcase:Sprite;
        private var _statusString:StatusTextField = new StatusTextField();
        private var _currentPageOffset:uint = 0;
        private var _currentMaxUsers:uint;
        private var _faceCount:uint;
        private var _pageIncr:uint;
        private var _gap:uint;

        public function TopList(_arg_1:SocialModule, _arg_2:UserObject, _arg_3:uint, _arg_4:int, _arg_5:Boolean=false)
        {
            this._socialModule = _arg_1;
            this._ratingId = _arg_3;
            this._friends = _arg_5;
            this._user = _arg_2;
            var _local_6:DisplayObject = new EmptyUser();
            this._faceCount = (_arg_4 / _local_6.width);
            this._pageIncr = (this._faceCount - 1);
            this._gap = ((_arg_4 % _local_6.width) / this._faceCount);
            this._showcase = new Sprite();
            this._topListModel = new TopListModel();
            this._pagingPanel = new PagingPanel();
            this._pagingPanel._pagesLabel.autoSize = TextFieldAutoSize.RIGHT;
            this._pagingPanel.y = (this._bottomRowY + 2);
            this._pagingPanel._leftButton.addEventListener(MouseEvent.CLICK, this.OnPageBackward);
            this._pagingPanel._rightButton.addEventListener(MouseEvent.CLICK, this.OnPageForward);
            this._pagingPanel._deepRightButton.addEventListener(MouseEvent.CLICK, this.OnPageDeepForward);
            this._pagingPanel._deepLeftButton.addEventListener(MouseEvent.CLICK, this.OnPageDeepBackward);
            this._pagingPanel.visible = false;
            this._refreshButton = new RefreshButton();
            this._refreshButton.y = this._bottomRowY;
            this._refreshButton.x = ((_arg_4 - this._refreshButton.width) / 2);
            this._refreshButton.addEventListener(MouseEvent.CLICK, this.OnRefreshClick);
            this._refreshButton.visible = false;
            this._statusString._statusLabel.autoSize = TextFieldAutoSize.LEFT;
            this._statusString._statusLabel.text = "Ожидание соединения...";
            this._statusString.x = ((_arg_4 - this._statusString._statusLabel.width) / 2);
            this._statusString.y = (this._bottomRowY - 80);
            this._statusString.visible = true;
            addChild(this._pagingPanel);
            addChild(this._refreshButton);
            addChild(this._showcase);
            addChild(this._statusString);
        }

        public function Reload(_arg_1:uint):void
        {
            this._socialModule.TopUsers.addEventListener(Event.COMPLETE, this.OnTopLoaded);
            this._socialModule.TopUsers.addEventListener(ErrorEvent.ERROR, this.OnLoadingError);
            this._socialModule.TopUsers.SendRequest(this._ratingId, this._faceCount, _arg_1, this._friends);
            this._statusString.visible = true;
            this._refreshButton.visible = true;
            this._statusString._statusLabel.text = "Загрузка данных...";
        }

        private function OnTopLoaded(_arg_1:ResponseEvent):void
        {
            var _local_3:uint;
            this._socialModule.TopUsers.removeEventListener(ErrorEvent.ERROR, this.OnLoadingError);
            var _local_2:TopListModel = (_arg_1.data as TopListModel);
            if ((((this._user) && (_local_2.ratingId == this._ratingId)) && (_local_2.isFriends == this._friends)))
            {
                this._topListModel = _local_2;
                _local_3 = 0;
                if (this._friends)
                {
                    _local_3 = this._user.GetRating(this._ratingId).PlaceAmongFriends;
                }
                else
                {
                    _local_3 = this._user.GetRating(this._ratingId).Place;
                };
                this._statusString.visible = false;
                this.FillShowcase(this._topListModel.users, _local_3);
            };
        }

        protected function FillShowcase(_arg_1:Array, _arg_2:uint):void
        {
            var _local_6:DisplayObject;
            var _local_7:DisplayObject;
            while (this._showcase.numChildren)
            {
                this._showcase.removeChildAt(0);
            };
            var _local_3:Boolean;
            var _local_4:String = this._user.Id;
            var _local_5:int;
            while (_local_5 < this._pageIncr)
            {
                if (_local_5 < _arg_1.length)
                {
                    _local_7 = new UserPic(((this._currentPageOffset + _local_5) + 1), _arg_1[_local_5], this._ratingId);
                    if (_arg_1[_local_5].Id == _local_4)
                    {
                        _local_3 = true;
                    };
                }
                else
                {
                    _local_7 = new EmptyUser();
                    _local_7.addEventListener(MouseEvent.CLICK, this.OnInviteClick);
                };
                _local_7.x = (11 + ((this._gap + _local_7.width) * _local_5));
                this._showcase.addChild(_local_7);
                _local_5++;
            };
            if (((_local_3) || (_arg_2 == 0)))
            {
                if (_arg_1.length >= this._faceCount)
                {
                    _local_6 = new UserPic((this._currentPageOffset + this._faceCount), _arg_1[(this._faceCount - 1)], this._ratingId);
                }
                else
                {
                    _local_6 = new EmptyUser();
                    _local_6.addEventListener(MouseEvent.CLICK, this.OnInviteClick);
                };
            }
            else
            {
                _local_6 = new UserPic(_arg_2, this._user, this._ratingId);
            };
            _local_6.x = (11 + ((this._gap + _local_7.width) * this._pageIncr));
            this._showcase.addChild(_local_6);
            this.UpdatePaging();
        }

        private function OnInviteClick(_arg_1:Event):void
        {
            this._socialModule.NetworkApi.CallInviteBox();
        }

        private function OnRefreshClick(_arg_1:Event):void
        {
            this.Reload(0);
        }

        private function UpdatePaging():void
        {
            this._pagingPanel.visible = ((this._topListModel.hasNextPage) || (this._topListModel.hasPreviousPage));
            var _local_1:SimpleButton = this._pagingPanel._leftButton;
            var _local_2:SimpleButton = this._pagingPanel._deepLeftButton;
            var _local_3:SimpleButton = this._pagingPanel._rightButton;
            var _local_4:SimpleButton = this._pagingPanel._deepRightButton;
            var _local_5:TextField = this._pagingPanel._pagesLabel;
            this._currentMaxUsers = this._topListModel.totalUsersCount;
            var _local_6:int = (this._currentMaxUsers % this._pageIncr);
            _local_6 = ((_local_6 == 0) ? 0 : 1);
            _local_5.text = ((((this._currentPageOffset / this._pageIncr) + 1).toString() + "/") + int(((this._currentMaxUsers / this._pageIncr) + _local_6)));
            _local_2.x = 0;
            _local_1.x = ((_local_2.x + _local_2.width) + 2);
            _local_3.x = (_local_1.x + 90);
            _local_4.x = ((_local_3.x + _local_3.width) + 2);
            _local_5.x = ((((_local_3.x - _local_5.width) + _local_1.x) + _local_1.width) / 2);
            this._pagingPanel.x = ((this.getRect(this).right - this._pagingPanel.width) - 15);
            _local_1.visible = this._topListModel.hasPreviousPage;
            _local_3.visible = this._topListModel.hasNextPage;
            _local_4.visible = (((this._currentMaxUsers - this._currentPageOffset) / this._pageIncr) >= (3 - _local_6));
            _local_2.visible = ((this._currentPageOffset / this._pageIncr) >= 2);
        }

        private function OnPageForward(_arg_1:Event):void
        {
            var _local_2:uint = (this._currentPageOffset + this._pageIncr);
            if (this._currentMaxUsers > _local_2)
            {
                this._currentPageOffset = _local_2;
                this._topListModel.currentOffsetIndex = this._currentPageOffset;
                this.Reload(this._currentPageOffset);
            };
        }

        private function OnPageDeepForward(_arg_1:Event):void
        {
            var _local_2:int = (this._currentMaxUsers % this._pageIncr);
            this._currentPageOffset = (this._currentMaxUsers - _local_2);
            if (_local_2 == 0)
            {
                this._currentPageOffset = (this._currentPageOffset - this._pageIncr);
            };
            this._topListModel.currentOffsetIndex = this._currentPageOffset;
            this.Reload(this._currentPageOffset);
        }

        private function OnPageBackward(_arg_1:Event):void
        {
            if (this._currentPageOffset > 0)
            {
                this._currentPageOffset = (this._currentPageOffset - this._pageIncr);
                this._topListModel.currentOffsetIndex = this._currentPageOffset;
                this.Reload(this._currentPageOffset);
            };
        }

        private function OnPageDeepBackward(_arg_1:Event):void
        {
            this._currentPageOffset = 0;
            this._topListModel.currentOffsetIndex = this._currentPageOffset;
            this.Reload(this._currentPageOffset);
        }

        private function OnLoadingError(_arg_1:ErrorEvent):void
        {
            this._socialModule.TopUsers.removeEventListener(Event.COMPLETE, this.OnTopLoaded);
            this._socialModule.TopUsers.removeEventListener(ErrorEvent.ERROR, this.OnLoadingError);
            this._statusString.visible = true;
            this._statusString._statusLabel.text = "Ошибка соединения.";
        }


    }
}//package com.hbm.socialpanel

