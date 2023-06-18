


//hbm.Game.GUI.Book.ItemsTabPanel

package hbm.Game.GUI.Book
{
    import org.aswing.JPanel;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import org.aswing.JTree;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import org.aswing.JTextField;
    import org.aswing.tree.DefaultMutableTreeNode;
    import flash.utils.Dictionary;
    import org.aswing.BorderLayout;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.tree.DefaultTreeModel;
    import org.aswing.tree.GeneralTreeCellFactory;
    import org.aswing.JScrollPane;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Application.ClientApplication;
    import org.aswing.SoftBoxLayout;
    import flash.events.Event;
    import org.aswing.AttachIcon;
    import org.aswing.JLabel;
    import org.aswing.JTextArea;
    import flash.text.TextFormat;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.JButton;
    import flash.text.TextFormatAlign;
    import hbm.Game.Utility.ItemTextConvert;
    import hbm.Engine.Actors.CharacterEquipment;
    import org.aswing.geom.IntDimension;
    import hbm.Game.Character.Character;

    public class ItemsTabPanel extends JPanel 
    {

        private var _dataLibrary:ItemsResourceLibrary;
        private var _itemsTree:JTree;
        private var _itemPanel:JPanel;
        private var _curItemLink:InventoryItem;
        private var _searchBox:JTextField;
        private var _searchValue:String = "";
        private var _theroot:DefaultMutableTreeNode;
        private var _crossbows:DefaultMutableTreeNode;
        private var _dswords:DefaultMutableTreeNode;
        private var _daxes:DefaultMutableTreeNode;
        private var _spears:DefaultMutableTreeNode;
        private var _swords:DefaultMutableTreeNode;
        private var _hummers:DefaultMutableTreeNode;
        private var _knifes:DefaultMutableTreeNode;
        private var _staffs:DefaultMutableTreeNode;
        private var _axes:DefaultMutableTreeNode;
        private var _katars:DefaultMutableTreeNode;
        private var _acc_amulets:DefaultMutableTreeNode;
        private var _acc_rings:DefaultMutableTreeNode;
        private var _leather_shoes:DefaultMutableTreeNode;
        private var _metal_shoes:DefaultMutableTreeNode;
        private var _rag_shoes:DefaultMutableTreeNode;
        private var _leather_armors:DefaultMutableTreeNode;
        private var _metal_armors:DefaultMutableTreeNode;
        private var _rag_armors:DefaultMutableTreeNode;
        private var _potions:DefaultMutableTreeNode;
        private var _scrolls:DefaultMutableTreeNode;
        private var _leather_heads:DefaultMutableTreeNode;
        private var _metal_heads:DefaultMutableTreeNode;
        private var _rag_heads:DefaultMutableTreeNode;
        private var _shields:DefaultMutableTreeNode;
        private var _cloaks:DefaultMutableTreeNode;
        private var _timbrels:DefaultMutableTreeNode;
        private var _belts:DefaultMutableTreeNode;
        private var _artefacts:DefaultMutableTreeNode;
        private var _ammunitions:DefaultMutableTreeNode;
        private var _gifts:DefaultMutableTreeNode;
        private var _books:DefaultMutableTreeNode;
        private var _foods1:DefaultMutableTreeNode;
        private var _foods2:DefaultMutableTreeNode;
        private var _boxes:DefaultMutableTreeNode;
        private var _tools:DefaultMutableTreeNode;
        private var _chests:DefaultMutableTreeNode;
        private var _drops:DefaultMutableTreeNode;
        private var _runes:DefaultMutableTreeNode;
        private var _gems:DefaultMutableTreeNode;
        private var _relics:DefaultMutableTreeNode;
        private var _schemes:DefaultMutableTreeNode;
        private var _patterns:DefaultMutableTreeNode;
        private var _recipes:DefaultMutableTreeNode;
        private var _crafts:DefaultMutableTreeNode;
        private var _quests:DefaultMutableTreeNode;
        private var _moneys:DefaultMutableTreeNode;
        private var _width:int;
        private var _height:int;
        private var _colorDict:Dictionary;
        private var _clothesColor:int;

        public function ItemsTabPanel(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            super(new BorderLayout());
            this._clothesColor = _arg_1;
            this._colorDict = new Dictionary(true);
            this._width = _arg_2;
            this._height = _arg_3;
            if (!this._dataLibrary)
            {
                this._dataLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            };
            var _local_4:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            setBorder(_local_4);
            var _local_5:DefaultTreeModel = new DefaultTreeModel(this.CreateItemsTree());
            this._itemsTree = new JTree(_local_5);
            this._itemsTree.setRootVisible(false);
            this._itemsTree.getSelectionModel().setSelectionMode(JTree.SINGLE_TREE_SELECTION);
            this._itemsTree.addSelectionListener(this.OnItemSelected);
            this._itemsTree.setCellFactory(new GeneralTreeCellFactory(TMyCellRenderer));
            var _local_6:JScrollPane = new JScrollPane(this._itemsTree, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_AS_NEEDED);
            _local_6.setBorder(new EmptyBorder(null, new Insets(10, 0, 0, 0)));
            _local_6.setBackgroundDecorator(null);
            this._searchBox = new JTextField();
            var _local_7:CustomButton = new CustomButton(ClientApplication.Localization.BOOK_SEARCH_BUTTON);
            _local_7.setFocusable(false);
            var _local_8:CustomButton = new CustomButton(ClientApplication.Localization.BOOK_CLEAR_SEARCH_BUTTON);
            _local_8.setFocusable(false);
            var _local_9:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            _local_9.setBorder(new EmptyBorder(null, new Insets(0, 4, 0, 0)));
            _local_9.append(_local_7);
            _local_9.append(_local_8);
            var _local_10:JPanel = new JPanel(new BorderLayout());
            _local_10.setBorder(new EmptyBorder(null, new Insets(5, 0, 0, 0)));
            _local_10.append(this._searchBox, BorderLayout.CENTER);
            _local_10.append(_local_9, BorderLayout.EAST);
            var _local_11:JPanel = new JPanel(new BorderLayout());
            _local_11.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 10)));
            _local_11.append(_local_6, BorderLayout.CENTER);
            _local_11.append(_local_10, BorderLayout.SOUTH);
            _local_11.setPreferredWidth(((this._width / 2) - 10));
            this._itemPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.LEFT));
            this._itemPanel.setBorder(_local_4);
            var _local_12:JPanel = new JPanel(new BorderLayout());
            _local_12.setBorder(new EmptyBorder(null, new Insets(0, 20, 0, 0)));
            _local_12.append(this._itemPanel, BorderLayout.CENTER);
            _local_12.setPreferredWidth((this._width / 2));
            var _local_13:JPanel = new JPanel(new BorderLayout());
            _local_13.setBorder(_local_4);
            _local_13.setPreferredHeight(this._height);
            _local_13.setPreferredWidth((this._width + 20));
            _local_13.append(_local_11, BorderLayout.WEST);
            _local_13.append(_local_12, BorderLayout.EAST);
            append(_local_13);
            _local_7.addActionListener(this.Search, 0, true);
            _local_8.addActionListener(this.Clear, 0, true);
        }

        private function CreateItemsTree(_arg_1:Boolean=false):DefaultMutableTreeNode
        {
            var _local_2:DefaultMutableTreeNode;
            var _local_3:DefaultMutableTreeNode;
            var _local_4:DefaultMutableTreeNode;
            var _local_5:DefaultMutableTreeNode;
            var _local_6:DefaultMutableTreeNode;
            var _local_7:DefaultMutableTreeNode;
            this._theroot = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_SEARCH_RESULT);
            if (!_arg_1)
            {
                _local_2 = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_WEAPONS_TREE);
                _local_3 = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_EQUIPMENTS_TREE);
                _local_4 = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_USABLE_TREE);
                _local_5 = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_DROPS_TREE);
                _local_6 = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_CRAFTS_TREE);
                _local_7 = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_RARITY_TREE);
                this._theroot.append(_local_2);
                this._theroot.append(_local_3);
                this._theroot.append(_local_4);
                this._theroot.append(_local_5);
                this._theroot.append(_local_6);
                this._theroot.append(_local_7);
                this._crossbows = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_CROSSBOWS);
                this._dswords = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_DOUBLE_SWORDS);
                this._daxes = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_DOUBLE_AXES);
                this._spears = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_SPEARS);
                this._swords = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_SWORDS);
                this._hummers = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_HUMMERS);
                this._knifes = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_KNIFES);
                this._staffs = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_STAFFS);
                this._axes = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_AXES);
                this._katars = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_KATARS);
                _local_2.append(this._crossbows);
                _local_2.append(this._dswords);
                _local_2.append(this._daxes);
                _local_2.append(this._spears);
                _local_2.append(this._swords);
                _local_2.append(this._hummers);
                _local_2.append(this._knifes);
                _local_2.append(this._staffs);
                _local_2.append(this._axes);
                this._acc_amulets = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_ACCESSORIES_AMULETS);
                this._acc_rings = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_ACCESSORIES_RINGS);
                this._leather_shoes = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_LEATHER_SHOES);
                this._metal_shoes = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_METAL_SHOES);
                this._rag_shoes = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_RAG_SHOES);
                this._leather_armors = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_LEATHER_ARMORS);
                this._metal_armors = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_METAL_ARMORS);
                this._rag_armors = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_RAG_ARMORS);
                this._leather_heads = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_LEATHER_HEADS);
                this._metal_heads = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_METAL_HEADS);
                this._rag_heads = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_RAG_HEADS);
                this._shields = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_SHIELDS);
                this._timbrels = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_TIMBRELS);
                this._belts = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_BELTS);
                this._cloaks = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_CLOAKS);
                this._artefacts = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_ARTEFACTS);
                this._ammunitions = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_AMMUNITIONS);
                _local_3.append(this._acc_amulets);
                _local_3.append(this._acc_rings);
                _local_3.append(this._leather_shoes);
                _local_3.append(this._metal_shoes);
                _local_3.append(this._rag_shoes);
                _local_3.append(this._leather_armors);
                _local_3.append(this._metal_armors);
                _local_3.append(this._rag_armors);
                _local_3.append(this._leather_heads);
                _local_3.append(this._metal_heads);
                _local_3.append(this._rag_heads);
                _local_3.append(this._shields);
                _local_3.append(this._timbrels);
                _local_3.append(this._belts);
                _local_3.append(this._cloaks);
                _local_3.append(this._artefacts);
                _local_3.append(this._ammunitions);
                this._potions = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_POTIONS);
                this._scrolls = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_SCROLLS);
                this._gifts = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_GIFTS);
                this._books = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_BOOKS);
                this._foods1 = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_FOODS1);
                this._foods2 = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_FOODS2);
                this._boxes = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_BOXES);
                this._chests = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_CHESTS);
                _local_4.append(this._potions);
                _local_4.append(this._scrolls);
                _local_4.append(this._gifts);
                _local_4.append(this._books);
                _local_4.append(this._foods1);
                _local_4.append(this._foods2);
                _local_4.append(this._boxes);
                _local_4.append(this._chests);
                this._drops = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_DROPS);
                this._crafts = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_CRAFTS);
                this._quests = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_QUESTS);
                _local_5.append(this._drops);
                _local_5.append(this._crafts);
                _local_5.append(this._quests);
                this._tools = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_TOOLS);
                this._schemes = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_SCHEMES);
                this._patterns = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_PATTERNS);
                this._recipes = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_RECIPES);
                _local_6.append(this._tools);
                _local_6.append(this._schemes);
                _local_6.append(this._patterns);
                _local_6.append(this._recipes);
                this._runes = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_RUNES);
                this._gems = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_GEMS);
                this._relics = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_RELICS);
                this._moneys = new DefaultMutableTreeNode(ClientApplication.Localization.BOOK_TREE_ITEM_MONEYS);
                _local_7.append(this._runes);
                _local_7.append(this._moneys);
                _local_7.append(this._relics);
                _local_7.append(this._moneys);
            };
            return (this._theroot);
        }

        private function Search(_arg_1:Event):void
        {
            this._itemPanel.removeAll();
            if (this._searchValue != this._searchBox.getText())
            {
                this._searchValue = this._searchBox.getText().toLowerCase();
                this.Revalidate(this._searchValue);
            };
        }

        private function Clear(_arg_1:Event):void
        {
            this._itemPanel.removeAll();
            this._searchValue = "";
            this.Revalidate();
        }

        private function OnItemSelected(_arg_1:Event):void
        {
            var _local_3:ItemDescription;
            var _local_4:AttachIcon;
            var _local_5:JLabel;
            var _local_6:JPanel;
            var _local_7:Object;
            var _local_8:String;
            var _local_9:String;
            var _local_10:JTextArea;
            var _local_11:TextFormat;
            var _local_12:String;
            var _local_13:int;
            var _local_14:JTextArea;
            var _local_15:int;
            var _local_16:JPanel;
            var _local_17:int;
            var _local_18:int;
            var _local_19:String;
            var _local_20:int;
            var _local_21:JTextArea;
            var _local_22:JScrollPane;
            var _local_23:ItemData;
            var _local_24:CharacterInfo;
            var _local_25:int;
            var _local_26:JButton;
            var _local_27:Boolean;
            var _local_28:Array;
            var _local_2:Array = this._itemsTree.getSelectionPaths();
            if (_local_2)
            {
                if ((_local_2[0].getLastPathComponent() is ItemDescription))
                {
                    _local_3 = (_local_2[0].getLastPathComponent() as ItemDescription);
                    _local_4 = this._dataLibrary.GetItemAttachIcon(_local_3.Id);
                    _local_5 = new JLabel("", _local_4);
                    _local_5.setPreferredWidth(34);
                    _local_5.setPreferredHeight(34);
                    _local_6 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.CENTER));
                    _local_6.setBorder(new EmptyBorder(null, new Insets(20, ((200 - 30) / 2), 0, 0)));
                    _local_6.setPreferredWidth(200);
                    _local_6.append(_local_5);
                    _local_7 = this._dataLibrary.GetServerDescriptionObject(_local_3.Id);
                    _local_8 = this._dataLibrary.GetItemDescription(_local_3.Id);
                    _local_9 = _local_3.Name;
                    if (_local_7)
                    {
                        _local_9 = (((("<font color='" + _local_7["title_color"]) + "'><b>") + _local_9) + "</b></font>");
                    };
                    _local_10 = new JTextArea();
                    _local_10.setHtmlText(_local_9);
                    _local_10.setEditable(false);
                    _local_10.setBackgroundDecorator(null);
                    _local_10.setPreferredWidth(200);
                    _local_10.getTextField().selectable = false;
                    _local_11 = _local_10.getTextFormat();
                    _local_11.align = TextFormatAlign.CENTER;
                    _local_10.setTextFormat(_local_11);
                    _local_12 = ((ClientApplication.Localization.INVENTORY_POPUP_MIN_LEVEL2 + " ") + ((_local_7) ? _local_7["equip_level"] : "?"));
                    _local_13 = int(((_local_7) ? _local_7["equip_level"] : -1));
                    _local_14 = new JTextArea();
                    _local_15 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().baseLevel;
                    if (((_local_13 > 0) && (_local_15 < _local_13)))
                    {
                        _local_12 = (("<font color='#FF0000'>" + _local_12) + "</font>");
                    };
                    _local_14.setHtmlText(_local_12);
                    _local_14.setEditable(false);
                    _local_14.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
                    _local_14.setBackgroundDecorator(null);
                    _local_14.getTextField().selectable = false;
                    _local_11 = _local_14.getTextFormat();
                    _local_11.size = 11;
                    _local_14.setTextFormat(_local_11);
                    _local_16 = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.TOP));
                    _local_16.setPreferredWidth(200);
                    _local_16.append(_local_6);
                    _local_16.append(_local_10);
                    _local_16.append(_local_14);
                    if (_local_7)
                    {
                        _local_17 = int(_local_7["equip_jobs"]);
                        _local_18 = int(_local_7["equip_upper"]);
                        _local_19 = ItemTextConvert.GetJobsText(this._clothesColor, _local_17, _local_18, ItemData.QUEST);
                        if (_local_19.length > 0)
                        {
                            _local_8 = (_local_8 + ((("\n\n" + ClientApplication.Localization.INVENTORY_POPUP_JOBS) + " ") + _local_19));
                        };
                        _local_20 = int(_local_7["equip_locations"]);
                        if (_local_20 > 0)
                        {
                            _local_27 = (int(_local_7["type"]) == 6);
                            _local_28 = CharacterEquipment.GetEquipSlots(_local_20, _local_27);
                            _local_8 = (_local_8 + ("\n\n" + ItemTextConvert.GetEquipmentText(_local_28, _local_27)));
                        };
                        _local_21 = new JTextArea();
                        _local_21.setHtmlText(ItemTextConvert.ValidateDescriptionText(_local_8, _local_7));
                        _local_11 = _local_21.getTextFormat();
                        _local_11.size = 11;
                        _local_21.setTextFormat(_local_11);
                        _local_21.setEditable(false);
                        _local_21.setWordWrap(true);
                        _local_21.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
                        _local_21.setBackgroundDecorator(null);
                        _local_21.getTextField().selectable = false;
                        _local_22 = new JScrollPane(_local_21);
                        _local_22.setPreferredSize(new IntDimension(210, 305));
                        _local_16.append(_local_22);
                        _local_23 = new ItemData();
                        _local_23.Identified = 1;
                        _local_23.Origin = ItemData.QUEST;
                        _local_23.NameId = _local_3.Id;
                        _local_23.Cards = new <int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        _local_24 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                        _local_25 = Character.GetFraction(_local_24.jobId, _local_24.clothesColor);
                        _local_23.Attr = _local_25;
                        _local_23.Upgrade = 0;
                        _local_23.Type = _local_7["type"];
                        this._curItemLink = new InventoryItem(_local_23);
                        _local_26 = new JButton(ClientApplication.Localization.INVENTORY_POPUP_COPY_TO_CHAT);
                        _local_26.addActionListener(this.OnAddToChatLink, 0, true);
                        _local_16.append(_local_26);
                    };
                    this._itemPanel.removeAll();
                    this._itemPanel.append(_local_16);
                };
            };
        }

        private function OnAddToChatLink(_arg_1:Event):void
        {
            if (!this._curItemLink)
            {
                return;
            };
            ClientApplication.Instance.ChatHUD.GetLeftBar.SendItemLink(this._curItemLink);
        }

        public function Revalidate(_arg_1:String=""):void
        {
            var _local_2:Boolean;
            var _local_4:int;
            var _local_6:String;
            var _local_7:int;
            var _local_8:Object;
            var _local_9:DefaultMutableTreeNode;
            if (!this._dataLibrary)
            {
                this._dataLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            };
            _local_2 = ((!(_arg_1 == null)) && (!(_arg_1 == "")));
            var _local_3:DefaultTreeModel = new DefaultTreeModel(this.CreateItemsTree(_local_2));
            this._itemsTree.setModel(_local_3);
            this._itemsTree.setRootVisible(_local_2);
            this._itemsTree.getSelectionModel().setSelectionMode(JTree.SINGLE_TREE_SELECTION);
            this._itemsTree.setCellFactory(new GeneralTreeCellFactory(TMyCellRenderer));
            var _local_5:Array = this._dataLibrary.GetItemsData();
            if (_local_5)
            {
                _local_7 = _local_5.length;
                _local_4 = 0;
                _loop_1:
                for (;_local_4 < _local_7;_local_4++)
                {
                    _local_8 = _local_5[_local_4];
                    if (((_local_8["book_type"]) && (_local_8["book_type"] > 0)))
                    {
                        if (_local_2)
                        {
                            _local_6 = (_local_8["name_japanese"] as String).toLowerCase();
                            if (_local_6.indexOf(_arg_1) < 0) continue;
                        };
                        if (_local_2)
                        {
                            _local_9 = this._theroot;
                        }
                        else
                        {
                            switch (_local_8["book_type"])
                            {
                                case 1:
                                    _local_9 = this._crossbows;
                                    break;
                                case 2:
                                    _local_9 = this._dswords;
                                    break;
                                case 3:
                                    _local_9 = this._daxes;
                                    break;
                                case 4:
                                    _local_9 = this._spears;
                                    break;
                                case 5:
                                    _local_9 = this._swords;
                                    break;
                                case 6:
                                    _local_9 = this._hummers;
                                    break;
                                case 7:
                                    _local_9 = this._knifes;
                                    break;
                                case 8:
                                    _local_9 = this._staffs;
                                    break;
                                case 9:
                                    _local_9 = this._axes;
                                    break;
                                case 10:
                                    _local_9 = this._acc_amulets;
                                    break;
                                case 11:
                                    _local_9 = this._leather_shoes;
                                    break;
                                case 12:
                                    _local_9 = this._metal_shoes;
                                    break;
                                case 13:
                                    _local_9 = this._rag_shoes;
                                    break;
                                case 14:
                                    _local_9 = this._leather_armors;
                                    break;
                                case 15:
                                    _local_9 = this._metal_armors;
                                    break;
                                case 16:
                                    _local_9 = this._rag_armors;
                                    break;
                                case 17:
                                    _local_9 = this._acc_rings;
                                    break;
                                case 18:
                                    _local_9 = this._potions;
                                    break;
                                case 19:
                                    _local_9 = this._scrolls;
                                    break;
                                case 20:
                                    _local_9 = this._leather_heads;
                                    break;
                                case 21:
                                    _local_9 = this._shields;
                                    break;
                                case 22:
                                    _local_9 = this._cloaks;
                                    break;
                                case 23:
                                    _local_9 = this._artefacts;
                                    break;
                                case 24:
                                    _local_9 = this._ammunitions;
                                    break;
                                case 25:
                                    _local_9 = this._gifts;
                                    break;
                                case 26:
                                    _local_9 = this._books;
                                    break;
                                case 27:
                                    _local_9 = this._foods1;
                                    break;
                                case 28:
                                    _local_9 = this._foods2;
                                    break;
                                case 29:
                                    _local_9 = this._timbrels;
                                    break;
                                case 30:
                                    _local_9 = this._boxes;
                                    break;
                                case 31:
                                    _local_9 = this._belts;
                                    break;
                                case 32:
                                    _local_9 = this._chests;
                                    break;
                                case 33:
                                    _local_9 = this._drops;
                                    break;
                                case 34:
                                    _local_9 = this._runes;
                                    break;
                                case 35:
                                    _local_9 = this._gems;
                                    break;
                                case 36:
                                    _local_9 = this._relics;
                                    break;
                                case 37:
                                    _local_9 = this._tools;
                                    break;
                                case 38:
                                    _local_9 = this._schemes;
                                    break;
                                case 39:
                                    _local_9 = this._patterns;
                                    break;
                                case 40:
                                    _local_9 = this._recipes;
                                    break;
                                case 41:
                                    _local_9 = this._crafts;
                                    break;
                                case 42:
                                    _local_9 = this._quests;
                                    break;
                                case 43:
                                    _local_9 = this._moneys;
                                    break;
                                case 44:
                                    _local_9 = this._metal_heads;
                                    break;
                                case 45:
                                    _local_9 = this._rag_heads;
                                    break;
                                default:
                                    continue _loop_1;
                            };
                        };
                        _local_9.append(new ItemDescription(_local_8["name_japanese"], _local_8["id"], _local_8["book_type"], 0));
                    };
                };
            };
            if (_local_2)
            {
                _local_4 = 0;
                while (_local_4 < this._itemsTree.getRowCount())
                {
                    this._itemsTree.expandRow(_local_4);
                    _local_4++;
                };
            };
        }


    }
}//package hbm.Game.GUI.Book

