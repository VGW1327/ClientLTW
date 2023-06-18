


//hbm.Game.GUI.Guild.EmblemWindow

package hbm.Game.GUI.Guild
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Application.ClientApplication;
    import org.aswing.BorderLayout;

    public class EmblemWindow extends CustomWindow 
    {

        private const _width:int = 220;
        private const _height:int = 220;

        protected var _emblemPanel:EmblemPanel;

        public function EmblemWindow()
        {
            super(null, ClientApplication.Localization.GUILD_EMBLEM_WINDOW_TITLE, true, this._width, this._height, true);
            this.InitUI();
            pack();
            setLocationXY(200, 250);
        }

        private function InitUI():void
        {
            this._emblemPanel = new EmblemPanel();
            MainPanel.append(this._emblemPanel, BorderLayout.CENTER);
            pack();
        }

        public function Revalidate():void
        {
            this._emblemPanel.Clear();
            var _local_1:int;
            while (_local_1 < 64)
            {
                this._emblemPanel.AddEmblemItem(new EmblemItem(_local_1));
                _local_1++;
            };
        }


    }
}//package hbm.Game.GUI.Guild

