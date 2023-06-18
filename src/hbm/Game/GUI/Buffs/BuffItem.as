


//hbm.Game.GUI.Buffs.BuffItem

package hbm.Game.GUI.Buffs
{
    import org.aswing.JLabelButton;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.JPanel;
    import hbm.Game.GUI.DndTargets;
    import hbm.Application.ClientApplication;
    import hbm.Game.Statistic.StatisticManager;
    import org.aswing.event.AWEvent;

    public class BuffItem extends JLabelButton 
    {

        private var _buffId:int = -1;
        private var _cooldown:Number = -1;

        public function BuffItem(_arg_1:Object)
        {
            var _local_3:CustomToolTip;
            super();
            var _local_2:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            if (_arg_1)
            {
                this._buffId = int(_arg_1.iconId);
                this._cooldown = ((_arg_1.cooldown) ? Number(_arg_1.cooldown) : -1);
                _local_3 = new CustomToolTip(this, _arg_1.description, 240, _arg_1.windowHeight);
                setIcon(_local_2.GetAttachIcon("buff", _arg_1.iconId));
            };
            addActionListener(this.OnBuffButtonPressed, 0, true);
        }

        public function get Cooldown():Number
        {
            return (this._cooldown);
        }

        protected function OnBuffButtonPressed(_arg_1:AWEvent):void
        {
            var _local_2:JPanel;
            var _local_3:int;
            if (this._buffId > 0)
            {
                _local_2 = getClientProperty(DndTargets.DND_SLOT);
                if (_local_2 != null)
                {
                    _local_3 = _local_2.getClientProperty(DndTargets.DND_INDEX);
                    ClientApplication.Instance.BuffWindowInstance.BuffPanelInstance.UseBuff(_local_3, this._buffId);
                    StatisticManager.Instance.SendEvent(("GoldBaffUse" + this._buffId));
                };
            };
        }


    }
}//package hbm.Game.GUI.Buffs

