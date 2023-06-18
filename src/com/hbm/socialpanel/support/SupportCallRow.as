


//com.hbm.socialpanel.support.SupportCallRow

package com.hbm.socialpanel.support
{
    import support.SupportCallLabel;
    import com.hbm.socialmodule.support.SupportCall;
    import flash.events.MouseEvent;
    import com.hbm.socialmodule.support.SupportServiceEvent;

    public class SupportCallRow extends SupportCallLabel 
    {

        private var _data:SupportCall;

        public function SupportCallRow(_arg_1:SupportCall)
        {
            this._data = _arg_1;
            _topicName.text = _arg_1.theme;
            _topicName.selectable = false;
            _dateLabel.text = _arg_1.date;
            _dateLabel.selectable = false;
            _msgCount.text = _arg_1.messageCount;
            _msgCount.selectable = false;
            buttonMode = true;
            if (_arg_1.isReaded)
            {
                gotoAndStop(1);
            }
            else
            {
                gotoAndStop(2);
            };
            addEventListener(MouseEvent.CLICK, this.OnMouseClick);
        }

        private function OnMouseClick(_arg_1:MouseEvent):void
        {
            dispatchEvent(new SupportServiceEvent(SupportServiceEvent.MESSAGES_REQUESTED, this._data));
        }


    }
}//package com.hbm.socialpanel.support

