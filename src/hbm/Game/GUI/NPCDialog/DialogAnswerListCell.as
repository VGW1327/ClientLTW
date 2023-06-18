


//hbm.Game.GUI.NPCDialog.DialogAnswerListCell

package hbm.Game.GUI.NPCDialog
{
    import org.aswing.ListCell;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import org.aswing.JPanel;
    import org.aswing.JTextArea;
    import org.aswing.JLabel;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.EmptyLayout;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;
    import flash.events.MouseEvent;
    import org.aswing.Component;
    import org.aswing.AssetIcon;
    import flash.display.Bitmap;
    import org.aswing.JList;

    public class DialogAnswerListCell implements ListCell 
    {

        public static const HEIGHT:int = 43;
        public static const WIDTH:int = 562;
        public static const ICON_SIZE:int = 32;

        private var _leftOffset:int = 100;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _data:String;
        private var _cellPanel:JPanel;
        private var _contentLabel:JTextArea;
        private var _iconLbl:JLabel;
        private var _background:JPanel;
        private var _icons:Object = {
            "icon":null,
            "icon2":null
        };
        private var _iconName:String;

        public function DialogAnswerListCell()
        {
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this.CreateCell();
        }

        private function CreateCell():void
        {
            this._cellPanel = new JPanel(new EmptyLayout());
            this._cellPanel.setPreferredWidth(WIDTH);
            this._cellPanel.setPreferredHeight(HEIGHT);
            this._cellPanel.buttonMode = true;
            this._background = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            AsWingUtil.SetBackgroundFromAsset(this._background, "NpcDialogAnsOptionBack");
            this._contentLabel = AsWingUtil.CreateTextArea("");
            AsWingUtil.SetBorder(this._contentLabel, 0, 10);
            AsWingUtil.SetSize(this._contentLabel, 500, HEIGHT);
            this._contentLabel.setFont(new ASFont(HtmlText.fontName, 14, false));
            this._contentLabel.mouseChildren = (this._contentLabel.mouseEnabled = false);
            this._iconLbl = new JLabel();
            AsWingUtil.SetSize(this._iconLbl, (this._leftOffset - 5), (ICON_SIZE + 5));
            AsWingUtil.SetBorder(this._iconLbl, ((this._leftOffset - ICON_SIZE) - 5), 5);
            this._background.append(this._iconLbl);
            this._background.append(this._contentLabel);
            this._cellPanel.append(this._background);
            this._cellPanel.addEventListener(MouseEvent.MOUSE_OUT, this.OnMouseOut, false, 0, true);
            this._cellPanel.addEventListener(MouseEvent.MOUSE_OVER, this.OnMouseOver, false, 0, true);
        }

        public function GetIconName():String
        {
            return (this._iconName);
        }

        public function GetIcon():JLabel
        {
            return (this._iconLbl);
        }

        public function getCellValue():*
        {
            return (this._data);
        }

        public function getCellComponent():Component
        {
            return (this._cellPanel);
        }

        public function setCellValue(_arg_1:*):void
        {
            this._data = _arg_1;
            this._icons = this.ParseIcon(this._data);
            if (this._icons.icon != null)
            {
                this._iconLbl.setIcon(new AssetIcon(this._icons.icon));
            };
            this._contentLabel.setHtmlText(this._data);
        }

        private function ParseIcon(_arg_1:String):Object
        {
            var _local_4:Bitmap;
            var _local_5:Bitmap;
            var _local_2:RegExp = /<icon>(.*)<\/icon>/i;
            var _local_3:Object = _local_2.exec(_arg_1);
            if (((!(_local_3 == null)) && (_local_3.length)))
            {
                this._iconName = _local_3[1];
                _local_4 = this._dataLibrary.GetBitmapAsset(("AdditionalData_Item_" + _local_3[1]));
                _local_5 = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_" + _local_3[1]) + "Over"));
                this._data = _arg_1.replace(_local_2, "");
                return ({
                    "icon":_local_4,
                    "icon2":_local_5
                });
            };
            return ({
                "icon":null,
                "icon2":null
            });
        }

        public function setListCellStatus(_arg_1:JList, _arg_2:Boolean, _arg_3:int):void
        {
            var _local_4:String;
            if (_arg_2)
            {
                _local_4 = "NpcDialogAnsOptionBackSelected";
                this._contentLabel.setLocationXY((this._leftOffset + 1), 2);
            }
            else
            {
                _local_4 = "NpcDialogAnsOptionBack";
                this._contentLabel.setLocationXY(this._leftOffset, 0);
            };
            AsWingUtil.SetBackgroundFromAsset(this._background, _local_4);
        }

        private function OnMouseOver(_arg_1:MouseEvent):void
        {
            if (this._icons.icon2 != null)
            {
                this._iconLbl.setIcon(new AssetIcon(this._icons.icon2));
            };
            AsWingUtil.SetBackgroundFromAsset(this._background, "NpcDialogAnsOptionBackSelected");
        }

        private function OnMouseOut(_arg_1:MouseEvent):void
        {
            if (this._icons.icon != null)
            {
                this._iconLbl.setIcon(new AssetIcon(this._icons.icon));
            };
            AsWingUtil.SetBackgroundFromAsset(this._background, "NpcDialogAnsOptionBack");
        }


    }
}//package hbm.Game.GUI.NPCDialog

