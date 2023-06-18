


//hbm.Game.GUI.JobSelectorPanel

package hbm.Game.GUI
{
    import org.aswing.JPanel;
    import org.aswing.JComboBox;
    import org.aswing.JCheckBox;
    import hbm.Application.ClientApplication;
    import org.aswing.JLabel;
    import org.aswing.FlowLayout;
    import org.aswing.ASFont;
    import org.aswing.ASColor;

    public class JobSelectorPanel extends JPanel 
    {

        private var _jobList:Array;
        private var _babyJobList:Array;
        private var _comboBoxJobs:JComboBox;
        private var _cBox:JCheckBox;
        private var _isBaby:Boolean;

        public function JobSelectorPanel(_arg_1:int, _arg_2:Boolean=false)
        {
            this._jobList = new Array({
                "jobId":0,
                "name":ClientApplication.Localization.GENDERS_SHORT[2],
                "selected":true
            }, {
                "jobId":1,
                "name":((_arg_1) ? ClientApplication.Localization.JOB_MAP1[1].group : ClientApplication.Localization.JOB_MAP0[1].group),
                "selected":false
            }, {
                "jobId":2,
                "name":((_arg_1) ? ClientApplication.Localization.JOB_MAP1[2].group : ClientApplication.Localization.JOB_MAP0[2].group),
                "selected":false
            }, {
                "jobId":3,
                "name":((_arg_1) ? ClientApplication.Localization.JOB_MAP1[3].group : ClientApplication.Localization.JOB_MAP0[3].group),
                "selected":false
            }, {
                "jobId":4,
                "name":((_arg_1) ? ClientApplication.Localization.JOB_MAP1[4].group : ClientApplication.Localization.JOB_MAP0[4].group),
                "selected":false
            }, {
                "jobId":5,
                "name":((_arg_1) ? ClientApplication.Localization.JOB_MAP1[5].group : ClientApplication.Localization.JOB_MAP0[5].group),
                "selected":false
            }, {
                "jobId":6,
                "name":((_arg_1) ? ClientApplication.Localization.JOB_MAP1[6].group : ClientApplication.Localization.JOB_MAP0[6].group),
                "selected":false
            });
            this._babyJobList = new Array({
                "jobId":0,
                "name":ClientApplication.Localization.GENDERS_SHORT[2],
                "selected":true
            }, {
                "jobId":1,
                "name":((_arg_1) ? ClientApplication.Localization.JOB_MAP1[1].babygroup : ClientApplication.Localization.JOB_MAP0[1].babygroup),
                "selected":false
            }, {
                "jobId":14,
                "name":((_arg_1) ? ClientApplication.Localization.JOB_MAP1[14].babygroup : ClientApplication.Localization.JOB_MAP0[14].babygroup),
                "selected":false
            }, {
                "jobId":9,
                "name":((_arg_1) ? ClientApplication.Localization.JOB_MAP1[9].babygroup : ClientApplication.Localization.JOB_MAP0[9].babygroup),
                "selected":false
            });
            this.InitUI(_arg_2);
        }

        private function InitUI(_arg_1:Boolean):void
        {
            var _local_3:JLabel;
            var _local_6:Object;
            var _local_7:JLabel;
            var _local_2:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 2));
            _local_3 = new JLabel("");
            var _local_4:ASFont = new ASFont(_local_3.getFont().getName(), _local_3.getFont().getSize(), true);
            this._isBaby = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerIsBabyClass();
            var _local_5:Array = [];
            for each (_local_6 in ((this._isBaby) ? this._babyJobList : this._jobList))
            {
                _local_5.push(_local_6["name"]);
            };
            if (_local_5.length > 0)
            {
                this._comboBoxJobs = new JComboBox();
                this._comboBoxJobs.setPreferredWidth(150);
                this._comboBoxJobs.setForeground(new ASColor(13421796));
                this._comboBoxJobs.setBackground(new ASColor(6974063));
                this._comboBoxJobs.getPopupList().setForeground(new ASColor(0x5D5D5D));
                this._comboBoxJobs.getPopupList().setBackground(new ASColor(0xEAEAEA));
                this._comboBoxJobs.setListData(_local_5);
                this._comboBoxJobs.setSelectedIndex(0);
                _local_2.append(this._comboBoxJobs);
            };
            if (_arg_1)
            {
                this._cBox = new JCheckBox();
                this._cBox.setSelected(false);
                this._cBox.setPreferredWidth(20);
                _local_2.append(this._cBox);
                _local_7 = new JLabel(ClientApplication.Localization.JOB_SELECTOR_GOLD);
                _local_7.setFont(_local_4);
                _local_2.append(_local_7);
            };
            this.append(_local_2);
        }

        public function get JobsList():JComboBox
        {
            return (this._comboBoxJobs);
        }

        public function get GoldCheckBox():JCheckBox
        {
            return (this._cBox);
        }

        public function Index2JobId(_arg_1:int):int
        {
            var _local_2:Array = ((this._isBaby) ? this._babyJobList : this._jobList);
            return (_local_2[_arg_1]["jobId"]);
        }


    }
}//package hbm.Game.GUI

