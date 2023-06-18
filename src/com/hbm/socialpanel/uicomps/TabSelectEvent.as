


//com.hbm.socialpanel.uicomps.TabSelectEvent

package com.hbm.socialpanel.uicomps
{
    import flash.events.Event;

    public class TabSelectEvent extends Event 
    {

        public static const SELECTED:String = "tab_selected";

        private var _sourceTab:TabPage;

        public function TabSelectEvent(_arg_1:String, _arg_2:TabPage, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._sourceTab = _arg_2;
        }

        public function get SourceTab():TabPage
        {
            return (this._sourceTab);
        }


    }
}//package com.hbm.socialpanel.uicomps

