


//hbm.Game.GUI.IngameMail.MailListItem

package hbm.Game.GUI.IngameMail
{
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import org.aswing.BorderLayout;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import org.aswing.AssetIcon;
    import org.aswing.Icon;
    import org.aswing.BoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.Component;
    import hbm.Application.ClientApplication;
    import org.aswing.AssetBackground;

    public class MailListItem extends JPanel 
    {

        private var _mailId:int;
        private var _mailPic:JLabel;
        private var _sender:JLabel;
        private var _title:JLabel;
        private var _time:JLabel;
        private var _graphicsLib:AdditionalDataResourceLibrary;

        public function MailListItem()
        {
            super(new BorderLayout());
            this._graphicsLib = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this.InitUI();
        }

        private static function addZero(_arg_1:int):String
        {
            var _local_2:String;
            return ((_arg_1 < 10) ? ("0" + _arg_1) : _arg_1.toString());
        }


        private function InitUI():void
        {
            this._mailPic = new JLabel();
            this._mailPic.setIcon(this.GetADIcon("IngameMailMailIconInactive"));
            append(this._mailPic, BorderLayout.WEST);
            append(this.CreateTitlePanel(), BorderLayout.CENTER);
        }

        private function GetADIcon(_arg_1:String):Icon
        {
            var _local_2:Bitmap = this._graphicsLib.GetBitmapAsset(("AdditionalData_Item_" + _arg_1));
            return (new AssetIcon(_local_2));
        }

        private function CreateTitlePanel():Component
        {
            var _local_1:JPanel = new JPanel(new BoxLayout(BoxLayout.Y_AXIS));
            _local_1.setBorder(new EmptyBorder(null, new Insets(10, 0, 10)));
            this._sender = new JLabel("");
            this._sender.setHorizontalAlignment(JLabel.LEFT);
            this._title = new JLabel("");
            this._title.setHorizontalAlignment(JLabel.LEFT);
            this._time = new JLabel("");
            this._time.setHorizontalAlignment(JLabel.LEFT);
            _local_1.append(this._sender);
            _local_1.append(this._title);
            _local_1.append(this._time);
            return (_local_1);
        }

        public function SetStatus(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                this._mailPic.setIcon(this.GetADIcon("IngameMailMailIconActive"));
            }
            else
            {
                this._mailPic.setIcon(this.GetADIcon("IngameMailMailIconInactive"));
            };
        }

        public function SetSelected(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                setBackgroundDecorator(this.GetBackgroundDecorator("IngameMailListItemBackgroundActive"));
            }
            else
            {
                setBackgroundDecorator(this.GetBackgroundDecorator("IngameMailListItemBackground"));
            };
        }

        public function SetSender(_arg_1:String):void
        {
            this._sender.setText(((ClientApplication.Localization.MAIL_WINDOW_SENDER + " ") + _arg_1));
        }

        public function SetTitle(_arg_1:String):void
        {
            this._title.setText(((ClientApplication.Localization.MAIL_WINDOW_TITLE + " ") + _arg_1));
        }

        public function SetTime(_arg_1:uint):void
        {
            var _local_2:Date;
            _local_2 = new Date();
            _local_2.setTime((_arg_1 * 1000));
            var _local_3:String = ((((((((((addZero(_local_2.date) + ".") + addZero((_local_2.month + 1))) + ".") + _local_2.fullYear) + " ") + addZero(_local_2.hours)) + ":") + addZero(_local_2.minutes)) + ":") + addZero(_local_2.seconds));
            this._time.setText(((ClientApplication.Localization.MAIL_WINDOW_TIME + " ") + _local_3));
        }

        public function SetMailId(_arg_1:int):void
        {
            this._mailId = _arg_1;
        }

        private function GetBackgroundDecorator(_arg_1:String):AssetBackground
        {
            var _local_2:Bitmap = this._graphicsLib.GetBitmapAsset(("AdditionalData_Item_" + _arg_1));
            return (new AssetBackground(_local_2));
        }


    }
}//package hbm.Game.GUI.IngameMail

