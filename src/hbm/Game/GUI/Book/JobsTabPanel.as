


//hbm.Game.GUI.Book.JobsTabPanel

package hbm.Game.GUI.Book
{
    import org.aswing.JPanel;
    import hbm.Engine.Resource.SkillsResourceLibrary;
    import org.aswing.JTree;
    import org.aswing.JTextField;
    import org.aswing.tree.DefaultTreeModel;
    import flash.utils.Dictionary;
    import org.aswing.BorderLayout;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.tree.DefaultMutableTreeNode;
    import hbm.Application.ClientApplication;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Game.Character.Character;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.tree.GeneralTreeCellFactory;
    import org.aswing.JScrollPane;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.SoftBoxLayout;
    import org.aswing.EmptyLayout;
    import org.aswing.geom.IntDimension;
    import flash.events.Event;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import flash.display.DisplayObject;
    import hbm.Engine.Actors.SkillData;
    import flash.utils.getDefinitionByName;
    import org.aswing.AssetBackground;
    import flash.display.Bitmap;
    import hbm.Game.GUI.DndTargets;
    import org.aswing.geom.IntPoint;

    public class JobsTabPanel extends JPanel 
    {

        private static const HUMAN_UNDEAD_JOBS_FIRST:Array = [2, 4, 1, 6, 5, 3];
        private static const HUMAN_UNDEAD_JOBS_SECOND:Array = [9, 8, 7, 14, 17, 10, 11];
        private static const TURON_ORC_JOBS_FIRST:Array = [4024];
        private static const TURON_ORC_JOBS_SECOND:Array = [4037, 4032];

        private var _dataLibrary:SkillsResourceLibrary;
        private var _skillsTree:JTree;
        private var _skillsPanel:JPanel;
        private var _searchBox:JTextField;
        private var _searchValue:String = "";
        private var _theDefaultRoot:DefaultTreeModel;
        private var _theDefaultJobs:Object;
        private var _width:int;
        private var _height:int;
        private var _colorDict:Dictionary;
        private var _clothesColor:int;

        public function JobsTabPanel(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            super(new BorderLayout());
            this._clothesColor = _arg_1;
            this._colorDict = new Dictionary(true);
            this._width = _arg_2;
            this._height = _arg_3;
            if (!this._dataLibrary)
            {
                this._dataLibrary = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            };
            this.InitGUI();
        }

        private function CreateDefaultItemsTree():DefaultTreeModel
        {
            var human_first:DefaultMutableTreeNode;
            var human_second:DefaultMutableTreeNode;
            var turon_first:DefaultMutableTreeNode;
            var turon_second:DefaultMutableTreeNode;
            var undead_first:DefaultMutableTreeNode;
            var undead_second:DefaultMutableTreeNode;
            var orc_first:DefaultMutableTreeNode;
            var orc_second:DefaultMutableTreeNode;
            var CreateItemsTreeForClothes:Function = function (_arg_1:int):void
            {
                var _local_3:int;
                var _local_4:String;
                var _local_5:JobDescription;
                var _local_6:int;
                var _local_7:DefaultMutableTreeNode;
                var _local_2:Array = _dataLibrary.GetJobsID(_arg_1);
                for each (_local_3 in _local_2)
                {
                    _local_4 = ((CharacterStorage.Instance.GetJobName(_arg_1, _local_3)) || (ClientApplication.Localization.UNDER_CONSTRUCTION_MESSAGE));
                    if (_local_4 == "Unknown")
                    {
                        if (_arg_1 == 0)
                        {
                            _local_4 = ClientApplication.Localization.GUILD_WINDOW_SKILLS_TITLE;
                        }
                        else
                        {
                            continue;
                        };
                    };
                    _local_5 = new JobDescription(_local_4, _arg_1, _local_3);
                    _local_6 = Character.GetFraction(_local_3, _arg_1);
                    _local_7 = null;
                    if (HUMAN_UNDEAD_JOBS_FIRST.indexOf(_local_3) >= 0)
                    {
                        _local_7 = ((_local_6 == CharacterInfo.FRACTION_LIGHT) ? human_first : undead_first);
                    }
                    else
                    {
                        if (HUMAN_UNDEAD_JOBS_SECOND.indexOf(_local_3) >= 0)
                        {
                            _local_7 = ((_local_6 == CharacterInfo.FRACTION_LIGHT) ? human_second : undead_second);
                        }
                        else
                        {
                            if (TURON_ORC_JOBS_FIRST.indexOf(_local_3) >= 0)
                            {
                                _local_7 = ((_local_6 == CharacterInfo.FRACTION_LIGHT) ? turon_first : orc_first);
                            }
                            else
                            {
                                if (TURON_ORC_JOBS_SECOND.indexOf(_local_3) >= 0)
                                {
                                    _local_7 = ((_local_6 == CharacterInfo.FRACTION_LIGHT) ? turon_second : orc_second);
                                };
                            };
                        };
                    };
                    if (_local_7)
                    {
                        _local_7.append(_local_5);
                        _theDefaultJobs[_local_4.toLowerCase()] = _local_5;
                    };
                };
            };
            if (this._theDefaultRoot)
            {
                return (this._theDefaultRoot);
            };
            var root:DefaultMutableTreeNode = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_SEARCH_RESULT);
            this._theDefaultJobs = {};
            var light:DefaultMutableTreeNode = new DefaultMutableTreeNode(ClientApplication.Localization.LIGHT);
            var dark:DefaultMutableTreeNode = new DefaultMutableTreeNode(ClientApplication.Localization.DARK);
            root.append(light);
            root.append(dark);
            var human:DefaultMutableTreeNode = new DefaultMutableTreeNode(ClientApplication.Localization.RACE_NAMES[0]);
            var undead:DefaultMutableTreeNode = new DefaultMutableTreeNode(ClientApplication.Localization.RACE_NAMES[1]);
            var orc:DefaultMutableTreeNode = new DefaultMutableTreeNode(ClientApplication.Localization.RACE_NAMES[2]);
            var turon:DefaultMutableTreeNode = new DefaultMutableTreeNode(ClientApplication.Localization.RACE_NAMES[3]);
            light.append(human);
            light.append(turon);
            dark.append(undead);
            dark.append(orc);
            human_first = new DefaultMutableTreeNode(ClientApplication.Localization.FIRST_JOB);
            human_second = new DefaultMutableTreeNode(ClientApplication.Localization.SECOND_JOB);
            human.append(human_first);
            human.append(human_second);
            turon_first = new DefaultMutableTreeNode(ClientApplication.Localization.FIRST_JOB);
            turon_second = new DefaultMutableTreeNode(ClientApplication.Localization.SECOND_JOB);
            turon.append(turon_first);
            turon.append(turon_second);
            undead_first = new DefaultMutableTreeNode(ClientApplication.Localization.FIRST_JOB);
            undead_second = new DefaultMutableTreeNode(ClientApplication.Localization.SECOND_JOB);
            undead.append(undead_first);
            undead.append(undead_second);
            orc_first = new DefaultMutableTreeNode(ClientApplication.Localization.FIRST_JOB);
            orc_second = new DefaultMutableTreeNode(ClientApplication.Localization.SECOND_JOB);
            orc.append(orc_first);
            orc.append(orc_second);
            (CreateItemsTreeForClothes(0));
            (CreateItemsTreeForClothes(1));
            this._theDefaultRoot = new DefaultTreeModel(root);
            return (this._theDefaultRoot);
        }

        private function InitGUI():void
        {
            var _local_1:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            setBorder(_local_1);
            this._skillsTree = new JTree(this.CreateDefaultItemsTree());
            this._skillsTree.setRootVisible(false);
            this._skillsTree.getSelectionModel().setSelectionMode(JTree.SINGLE_TREE_SELECTION);
            this._skillsTree.setCellFactory(new GeneralTreeCellFactory(TMyCellRenderer));
            this._skillsTree.addSelectionListener(this.OnItemSelected);
            var _local_2:JScrollPane = new JScrollPane(this._skillsTree, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_AS_NEEDED);
            _local_2.setBorder(new EmptyBorder(null, new Insets(10, 0, 0, 0)));
            _local_2.setBackgroundDecorator(null);
            this._searchBox = new JTextField();
            var _local_3:CustomButton = new CustomButton(ClientApplication.Localization.BOOK_SEARCH_BUTTON);
            _local_3.setFocusable(false);
            var _local_4:CustomButton = new CustomButton(ClientApplication.Localization.BOOK_CLEAR_SEARCH_BUTTON);
            _local_4.setFocusable(false);
            var _local_5:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            _local_5.setBorder(new EmptyBorder(null, new Insets(0, 4, 0, 0)));
            _local_5.append(_local_3);
            _local_5.append(_local_4);
            var _local_6:JPanel = new JPanel(new BorderLayout());
            _local_6.setBorder(new EmptyBorder(null, new Insets(5, 0, 0, 0)));
            _local_6.append(this._searchBox, BorderLayout.CENTER);
            _local_6.append(_local_5, BorderLayout.EAST);
            _local_3.addActionListener(this.Search, 0, true);
            _local_4.addActionListener(this.Clear, 0, true);
            var _local_7:JPanel = new JPanel(new BorderLayout());
            _local_7.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 10)));
            _local_7.append(_local_2, BorderLayout.CENTER);
            _local_7.append(_local_6, BorderLayout.SOUTH);
            _local_7.setPreferredWidth(((this._width / 2) - 10));
            this._skillsPanel = new JPanel(new EmptyLayout());
            var _local_8:IntDimension = new IntDimension(300, 446);
            this._skillsPanel.setPreferredSize(_local_8);
            this._skillsPanel.setBorder(_local_1);
            var _local_9:JPanel = new JPanel(new BorderLayout());
            _local_9.setBorder(new EmptyBorder(null, new Insets(0, 8, 0, 0)));
            _local_9.append(this._skillsPanel, BorderLayout.CENTER);
            _local_9.setPreferredWidth((this._width / 2));
            var _local_10:JPanel = new JPanel(new BorderLayout());
            _local_10.setBorder(_local_1);
            _local_10.setPreferredHeight(this._height);
            _local_10.setPreferredWidth((this._width + 20));
            _local_10.append(_local_7, BorderLayout.WEST);
            _local_10.append(_local_9, BorderLayout.EAST);
            append(_local_10);
        }

        private function Search(_arg_1:Event):void
        {
            this._skillsPanel.removeAll();
            this._skillsPanel.setBackgroundDecorator(null);
            if (this._searchValue != this._searchBox.getText())
            {
                this._searchValue = this._searchBox.getText().toLowerCase();
                this.Revalidate(this._searchValue);
            };
        }

        private function Clear(_arg_1:Event):void
        {
            this._skillsPanel.removeAll();
            this._skillsPanel.setBackgroundDecorator(null);
            this._searchValue = "";
            this.Revalidate();
        }

        private function RepaintSkills(_arg_1:JobDescription):void
        {
            var _local_5:AdditionalDataResourceLibrary;
            var _local_9:Object;
            var _local_10:Class;
            var _local_11:DisplayObject;
            var _local_12:int;
            var _local_13:SkillData;
            var _local_14:SkillDescription;
            var _local_15:int;
            var _local_16:int;
            this._skillsPanel.removeAll();
            var _local_2:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            var _local_3:JPanel = new JPanel(new EmptyLayout());
            _local_3.setBorder(_local_2);
            var _local_4:String = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills")).GetSkillBackgroundRef(_arg_1.Clothes, _arg_1.JobId);
            if (_local_4 != null)
            {
                _local_10 = (getDefinitionByName(_local_4) as Class);
                _local_11 = new (_local_10)();
                _local_3.setBackgroundDecorator(new AssetBackground(_local_11));
            };
            _local_3.setSizeWH(_local_11.width, _local_11.height);
            _local_3.setLocationXY(7, 30);
            this._skillsPanel.append(_local_3);
            _local_5 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_6:Bitmap = _local_5.GetBitmapAsset("AdditionalData_Item_BookSkillsBorder");
            var _local_7:JPanel = new JPanel(new EmptyLayout());
            _local_7.setBorder(_local_2);
            _local_7.setBackgroundDecorator(new AssetBackground(_local_6));
            _local_7.setSizeWH(_local_6.width, _local_6.height);
            _local_7.setLocationXY(0, 0);
            this._skillsPanel.append(_local_7);
            var _local_8:Dictionary = this._dataLibrary.GetSkillsByJob(_arg_1.Clothes, _arg_1.JobId);
            for each (_local_9 in _local_8)
            {
                _local_12 = int(_local_9["Id"]);
                _local_13 = new SkillData();
                _local_13.Id = int(_local_12);
                _local_13.Disabled = true;
                _local_14 = new SkillDescription(_local_12, _arg_1.Clothes, _arg_1.JobId);
                _local_15 = ((int(_local_9["GuiX"]) * 16) + _local_3.x);
                _local_16 = ((int(_local_9["GuiY"]) * 16) + _local_3.y);
                _local_14.putClientProperty(DndTargets.DND_TYPE, DndTargets.SKILL_ITEM);
                _local_14.setLocation(new IntPoint(_local_15, _local_16));
                this._skillsPanel.append(_local_14);
            };
        }

        private function OnItemSelected(_arg_1:Event):void
        {
            var _local_2:Array = this._skillsTree.getSelectionPaths();
            if (!_local_2)
            {
                return;
            };
            var _local_3:JobDescription = (_local_2[0].getLastPathComponent() as JobDescription);
            if (!_local_3)
            {
                return;
            };
            this.RepaintSkills(_local_3);
        }

        public function Revalidate(_arg_1:String=""):void
        {
            var _local_3:DefaultMutableTreeNode;
            var _local_4:DefaultTreeModel;
            var _local_5:String;
            var _local_6:JobDescription;
            var _local_2:Boolean = ((!(_arg_1 == null)) && (!(_arg_1 == "")));
            if (_local_2)
            {
                _local_3 = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_SEARCH_RESULT);
                _local_4 = new DefaultTreeModel(_local_3);
                this._skillsTree.setModel(_local_4);
                this._skillsTree.setRootVisible(true);
                for (_local_5 in this._theDefaultJobs)
                {
                    if (_local_5.indexOf(_arg_1) >= 0)
                    {
                        _local_6 = this._theDefaultJobs[_local_5];
                        _local_3.append(new JobDescription(_local_5, _local_6.Clothes, _local_6.JobId));
                    };
                };
                this._skillsTree.expandRow(0);
            }
            else
            {
                this._skillsTree.setModel(this._theDefaultRoot);
                this._skillsTree.setRootVisible(false);
            };
        }


    }
}//package hbm.Game.GUI.Book

