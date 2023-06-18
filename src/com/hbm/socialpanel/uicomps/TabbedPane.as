


//com.hbm.socialpanel.uicomps.TabbedPane

package com.hbm.socialpanel.uicomps
{
    import flash.display.Sprite;
    import uicomps.*;

    public class TabbedPane extends Sprite 
    {

        private var _tabList:Array = [];
        private var _leftTabPosX:int = 18;
        private var _tabShift:int = 43;
        private var _selectedTab:TabPage;


        public function AddTab(_arg_1:TabPage):void
        {
            this._tabList.push(_arg_1);
            _arg_1.Header.x = this._leftTabPosX;
            this._leftTabPosX = (this._leftTabPosX + (_arg_1.Header.width - this._tabShift));
            _arg_1.body.visible = false;
            _arg_1.Position = (this._tabList.length - 1);
            _arg_1.addEventListener(TabSelectEvent.SELECTED, this.OnTabClicked);
            addChild(_arg_1);
            this.SelectTab(_arg_1);
        }

        public function RemoveTab(_arg_1:TabPage):void
        {
            removeChild(_arg_1);
            _arg_1.removeEventListener(TabSelectEvent.SELECTED, this.OnTabClicked);
            this._tabList.splice(this._tabList.indexOf(_arg_1), 1);
            var _local_2:int;
            while (_local_2 < this._tabList.length)
            {
                this._tabList[_local_2].Position = _local_2;
                _local_2++;
            };
            this.SortTabs();
            if (this.Tabs.length > 0)
            {
                this.SelectTab(this.Tabs[0]);
            };
        }

        public function SelectTab(_arg_1:TabPage):void
        {
            this.SortTabs();
            _arg_1.body.visible = true;
            _arg_1.EnableHeader(true);
            if (this._selectedTab)
            {
                this._selectedTab.body.visible = false;
            };
            this._selectedTab = _arg_1;
            this.setChildIndex(_arg_1, (numChildren - 1));
        }

        public function SetSize(_arg_1:int, _arg_2:int):void
        {
            var _local_4:TabPage;
            var _local_3:int = (this._leftTabPosX + 25);
            if (_arg_1 < _local_3)
            {
                _arg_1 = _local_3;
            };
            for each (_local_4 in this._tabList)
            {
                _local_4.SetSize(_arg_1, _arg_2);
            };
        }

        public function get Tabs():Array
        {
            return (this._tabList);
        }

        private function SortTabs():void
        {
            var _local_1:TabPage;
            for each (_local_1 in this._tabList)
            {
                _local_1.EnableHeader(false);
                setChildIndex(_local_1, _local_1.Position);
            };
        }

        private function OnTabClicked(_arg_1:TabSelectEvent):void
        {
            var _local_2:TabPage = _arg_1.SourceTab;
            if (_local_2 != this._selectedTab)
            {
                this.SelectTab(_local_2);
            };
        }


    }
}//package com.hbm.socialpanel.uicomps

