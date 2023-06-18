


//com.hbm.socialpanel.Utilities

package com.hbm.socialpanel
{
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.DisplayObjectContainer;

    public class Utilities 
    {

        private static const logger:ILogger = getLogger(Utilities);


        public static function ShowMessageDialog(title:String, message:String, x:int, y:int, owner:DisplayObjectContainer):void
        {
            var dialog:DialogBox;
            dialog = new DialogBox(title, message, DialogBox.MESSAGE_BOX);
            dialog._rightButton.visible = false;
            dialog.x = x;
            dialog.y = y;
            var button:Sprite = dialog._leftButton;
            button.x = ((dialog.width - button.width) / 2);
            button.addEventListener(MouseEvent.CLICK, function (_arg_1:Event):void
            {
                owner.removeChild(dialog);
            });
            owner.addChild(dialog);
        }


    }
}//package com.hbm.socialpanel

