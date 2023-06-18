


//hbm.Game.GUI.Book.BookWindow

package hbm.Game.GUI.Book
{
    import hbm.Game.GUI.Tools.CustomBookWindow;
    import org.aswing.JTabbedPane;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.JScrollPane;
    import org.aswing.AssetIcon;
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;

    public class BookWindow extends CustomBookWindow 
    {

        private var _tabbedPane:JTabbedPane = new JTabbedPane();
        protected var _itemsPanel:ItemsTabPanel;
        protected var _skillsPanel:JobsTabPanel;

        public function BookWindow()
        {
            super(null, "", false, true);
            this.InitUI();
            pack();
            setLocationXY(40, 60);
        }

        private function InitUI():void
        {
            var _local_1:AdditionalDataResourceLibrary;
            _local_1 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_2:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_BookItemsTabItem");
            var _local_3:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_BookItemsTabSkill");
            var _local_4:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            this._tabbedPane.setTabPlacement(JTabbedPane.LEFT);
            this._itemsPanel = new ItemsTabPanel(((_local_4) ? _local_4.clothesColor : 0), 610, 440);
            if (this._itemsPanel != null)
            {
                this._tabbedPane.appendTab(new JScrollPane(this._itemsPanel), null, new AssetIcon(_local_2), ClientApplication.Instance.GetPopupText(181));
            };
            this._skillsPanel = new JobsTabPanel(((_local_4) ? _local_4.clothesColor : 0), 610, 440);
            if (this._skillsPanel != null)
            {
                this._tabbedPane.appendTab(new JScrollPane(this._skillsPanel), null, new AssetIcon(_local_3), ClientApplication.Localization.WINDOW_CHARACTER_SKILLS_TITLE);
            };
            var _local_5:JPanel = new JPanel(new BorderLayout());
            _local_5.setBorder(new EmptyBorder(null, new Insets(5, 0, 100, 15)));
            _local_5.append(this._tabbedPane, BorderLayout.CENTER);
            MainPanel.append(_local_5, BorderLayout.CENTER);
            this.Revalidate();
            pack();
        }

        override public function show():void
        {
            super.show();
            ClientApplication.Instance.SetShortcutsEnabled(false);
        }

        override public function dispose():void
        {
            super.dispose();
            ClientApplication.Instance.SetShortcutsEnabled(true);
        }

        public function Revalidate():void
        {
            if (this._itemsPanel)
            {
                this._itemsPanel.Revalidate();
            };
            if (this._skillsPanel)
            {
                this._skillsPanel.Revalidate();
            };
        }


    }
}//package hbm.Game.GUI.Book

