


//hbm.Game.GUI.Tools.CustomTabbedPane

package hbm.Game.GUI.Tools
{
    import org.aswing.JTabbedPane;
    import org.aswing.Insets;
    import org.aswing.Component;
    import org.aswing.Icon;
    import org.aswing.event.InteractiveEvent;

    public class CustomTabbedPane extends JTabbedPane 
    {

        private var _deselectedTabIcons:Array;
        private var _selectedTabIcons:Array;

        public function CustomTabbedPane()
        {
            this._deselectedTabIcons = new Array();
            this._selectedTabIcons = new Array();
            setMargin(new Insets());
            addStateListener(this.OnTabPaneChanged);
        }

        public function AppendCustomTab(_arg_1:Component, _arg_2:Icon=null, _arg_3:Icon=null, _arg_4:String=null):void
        {
            var _local_5:int = getTabCount();
            this._deselectedTabIcons[_local_5] = _arg_2;
            this._selectedTabIcons[_local_5] = _arg_3;
            appendTab(_arg_1, "", _arg_2, _arg_4);
        }

        private function OnTabPaneChanged(_arg_1:InteractiveEvent):void
        {
            this.UpdateSelection();
        }

        public function UpdateSelection():void
        {
            this.SetDeselectedIconToAll();
            var _local_1:int = getSelectedIndex();
            setIconAt(_local_1, this._selectedTabIcons[_local_1]);
        }

        private function SetDeselectedIconToAll():void
        {
            var _local_1:int = getTabCount();
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                setIconAt(_local_2, this._deselectedTabIcons[_local_2]);
                _local_2++;
            };
        }

        public function SetActiveIconTo(_arg_1:Icon, _arg_2:int):void
        {
            if (this.HasIndex(_arg_2))
            {
                this._selectedTabIcons[_arg_2] = _arg_1;
            };
        }

        private function HasIndex(_arg_1:int):Boolean
        {
            return (_arg_1 < getTabCount());
        }

        public function SetInactiveIconTo(_arg_1:Icon, _arg_2:int):void
        {
            if (this.HasIndex(_arg_2))
            {
                this._deselectedTabIcons[_arg_2] = _arg_1;
            };
        }

        override public function removeAll():void
        {
            super.removeAll();
            this._deselectedTabIcons = new Array();
            this._selectedTabIcons = new Array();
        }


    }
}//package hbm.Game.GUI.Tools

