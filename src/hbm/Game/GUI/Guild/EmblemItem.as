


//hbm.Game.GUI.Guild.EmblemItem

package hbm.Game.GUI.Guild
{
    import org.aswing.JLabelButton;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import org.aswing.event.AWEvent;

    public class EmblemItem extends JLabelButton 
    {

        private var _emblemId:int = -1;

        public function EmblemItem(_arg_1:int)
        {
            var _local_2:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._emblemId = _arg_1;
            setIcon(_local_2.GetAttachIcon("guild", _arg_1.toString()));
            addActionListener(this.OnEmblemButtonPressed, 0, true);
        }

        protected function OnEmblemButtonPressed(_arg_1:AWEvent):void
        {
            var _local_2:String;
            if (this._emblemId > 0)
            {
                if (this._emblemId < 32)
                {
                    _local_2 = ClientApplication.Localization.GUILD_EMBLEM_WINDOW_CHANGE_MESSAGE;
                }
                else
                {
                    _local_2 = (((ClientApplication.Localization.GUILD_EMBLEM_WINDOW_CHANGE_GOLD_MESSAGE + " ") + 1000) + ".");
                };
            }
            else
            {
                _local_2 = ClientApplication.Localization.GUILD_EMBLEM_WINDOW_CLEAR_MESSAGE;
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, _local_2, this.OnChangeApproved, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            ClientApplication.Instance.CloseEmblemWindow();
        }

        private function OnChangeApproved(_arg_1:int):void
        {
            if (_arg_1 == JOptionPane.YES)
            {
                if (this._emblemId > 0)
                {
                    ClientApplication.Instance.LocalGameClient.SendChangeGuildEmblemId(this._emblemId);
                }
                else
                {
                    ClientApplication.Instance.LocalGameClient.SendChangeGuildEmblemId(0);
                };
            };
        }


    }
}//package hbm.Game.GUI.Guild

