


//com.hbm.socialpanel.uicomps.TabPage

package com.hbm.socialpanel.uicomps
{
    import flash.display.Sprite;
    import tabpane.TabHeader;
    import tabpane.HeaderbackBody;
    import tabpane.HeaderbackLeftPlug;
    import tabpane.HeaderbackRightPlug;
    import tabpane.HeaderbackDevider;
    import flash.text.TextFieldAutoSize;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.display.DisplayObject;
    import flash.events.Event;

    public class TabPage extends Sprite 
    {

        private var _body:ResizablePanel = new ResizablePanel();
        private var _header:TabHeader = new TabHeader();
        private var _container:Sprite = new Sprite();
        private var _position:uint;
        private var _titleMargin:int = 12;
        private var _tabHeaderBack:HeaderbackBody = new HeaderbackBody();
        private var _tabHeaderLeftPlug:HeaderbackLeftPlug = new HeaderbackLeftPlug();
        private var _tabHeaderRightPlug:HeaderbackRightPlug = new HeaderbackRightPlug();
        private var _tabHeaderbackDevider:HeaderbackDevider = new HeaderbackDevider();

        public function TabPage()
        {
            this.Init();
        }

        private function Init():void
        {
            this._container.y = 25;
            this._container.x = 0;
            this._header._title.autoSize = TextFieldAutoSize.LEFT;
            this._header.addEventListener(MouseEvent.CLICK, this.OnTabClick);
            this._body.x = 0;
            this._body.y = 19;
            this._tabHeaderBack.gotoAndStop(0);
            this._tabHeaderBack.x = (this._header._middle.x - 2);
            this._tabHeaderBack.y = (this._header._middle.y + 4);
            this._tabHeaderBack.scaleX = (this._header._middle.width / this._tabHeaderBack.width);
            this._tabHeaderbackDevider.x = this._tabHeaderBack.x;
            this._tabHeaderbackDevider.y = this._tabHeaderBack.y;
            this._tabHeaderLeftPlug.gotoAndStop(0);
            this._tabHeaderLeftPlug.x = (this._tabHeaderBack.x - 7);
            this._tabHeaderLeftPlug.y = this._tabHeaderBack.y;
            this._tabHeaderRightPlug.gotoAndStop(0);
            this._tabHeaderRightPlug.x = ((this._tabHeaderBack.x + this._tabHeaderBack.width) - 8);
            this._tabHeaderRightPlug.y = this._tabHeaderBack.y;
            this._header.addChildAt(this._tabHeaderBack, 0);
            this._header.addChildAt(this._tabHeaderbackDevider, 1);
            this._header.addChildAt(this._tabHeaderRightPlug, 3);
            this._header.addEventListener(MouseEvent.MOUSE_OVER, this.OnMouseOver);
            this._header.addEventListener(MouseEvent.MOUSE_OUT, this.OnMouseOut);
            addChild(this._body);
            addChild(this._header);
            addChild(this._container);
        }

        public function EnableHeader(_arg_1:Boolean):void
        {
            this._header._middle.visible = _arg_1;
            this._header._leftEdge.visible = _arg_1;
            this._header._rightEdge.visible = _arg_1;
            if (_arg_1)
            {
                this._header._title.textColor = 0x111111;
            }
            else
            {
                this._header._title.textColor = 0xDDDDDD;
            };
        }

        public function SetSize(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int = (this._header.getRect(this).right + 20);
            if (_arg_1 < _local_3)
            {
                _arg_1 = _local_3;
            };
            this._body.SetSize(_arg_1, _arg_2);
        }

        public function get Container():Sprite
        {
            return (this._container);
        }

        public function setTitle(_arg_1:String):void
        {
            var _local_2:TextField = this._header._title;
            _local_2.text = _arg_1;
            var _local_3:DisplayObject = this._header._middle;
            _local_3.scaleX = ((_local_2.width + (this._titleMargin * 2)) / _local_3.width);
            _local_2.x = (_local_3.x + this._titleMargin);
            this._tabHeaderBack.scaleX = (this._header._middle.width / this._tabHeaderBack.width);
            this._tabHeaderRightPlug.x = ((this._tabHeaderBack.x + this._tabHeaderBack.width) - 8);
            this._tabHeaderbackDevider.x = this._tabHeaderBack.x;
            this._tabHeaderbackDevider.y = this._tabHeaderBack.y;
            this._header._rightEdge.x = ((_local_3.x + _local_3.width) - 1);
        }

        public function getTitle():String
        {
            return (this._header._title.text);
        }

        internal function get Header():TabHeader
        {
            return (this._header);
        }

        internal function set Header(_arg_1:TabHeader):void
        {
            this._header = _arg_1;
        }

        public function get Position():uint
        {
            return (this._position);
        }

        public function set Position(_arg_1:uint):void
        {
            if (_arg_1 == 0)
            {
                this._header.addChildAt(this._tabHeaderLeftPlug, 2);
            }
            else
            {
                if (this._tabHeaderLeftPlug.parent != null)
                {
                    this._header.removeChild(this._tabHeaderLeftPlug);
                };
            };
            this._position = _arg_1;
        }

        internal function get body():Sprite
        {
            return (this._body);
        }

        protected function OnTabClick(_arg_1:Event):void
        {
            dispatchEvent(new TabSelectEvent(TabSelectEvent.SELECTED, this));
        }

        private function OnMouseOver(_arg_1:MouseEvent):void
        {
            this._tabHeaderBack.gotoAndStop("_active");
            this._tabHeaderLeftPlug.gotoAndStop("_active");
            this._tabHeaderRightPlug.gotoAndStop("_active");
        }

        private function OnMouseOut(_arg_1:MouseEvent):void
        {
            this._tabHeaderBack.gotoAndStop("_inactive");
            this._tabHeaderLeftPlug.gotoAndStop("_inactive");
            this._tabHeaderRightPlug.gotoAndStop("_inactive");
        }


    }
}//package com.hbm.socialpanel.uicomps

