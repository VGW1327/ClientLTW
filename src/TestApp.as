


//TestApp

package 
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.events.Event;
    import vk.APIConnection;
    import flash.text.TextFormat;
    import vk.events.CustomEvent;
    import vk.ui.VKButton;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.text.*;
    import vk.events.*;

    public class TestApp extends Sprite 
    {

        private var tf:TextField;

        public function TestApp()
        {
            if (stage)
            {
                init();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, init);
            };
        }

        private function init(e:Event=null):void
        {
            var VK:APIConnection;
            if (e)
            {
                removeEventListener(e.type, init);
            };
            tf = new TextField();
            tf.x = 10;
            tf.y = 50;
            tf.width = 587;
            tf.height = 349;
            tf.border = true;
            tf.borderColor = 14344936;
            tf.background = true;
            tf.backgroundColor = 0xFFFFFF;
            tf.embedFonts = false;
            var format:TextFormat = new TextFormat();
            format.font = "Tahoma";
            format.color = 0;
            format.size = 11;
            tf.defaultTextFormat = format;
            addChild(tf);
            tf.appendText("Application initialized\n");
            var flashVars:Object = (stage.loaderInfo.parameters as Object);
            if (flashVars.api_id)
            {
                tf.appendText("\n// -- Your code for local testing:\n");
                tf.appendText((("flashVars['api_id'] = " + flashVars["api_id"]) + ";\n"));
                tf.appendText((("flashVars['viewer_id'] = " + flashVars["viewer_id"]) + ";\n"));
                tf.appendText((("flashVars['sid'] = \"" + flashVars["sid"]) + '";\n'));
                tf.appendText((("flashVars['secret'] = \"" + flashVars["secret"]) + '";\n'));
                tf.appendText("// -- //\n\n");
            };
            if (!flashVars.api_id)
            {
                tf.appendText("\n[!] Launch application on VK to get your test-code for local testing\n\n");
            };
            VK = new APIConnection(flashVars);
            VK.api("getProfiles", {"uids":flashVars["viewer_id"]}, fetchUserInfo, onApiRequestFail);
            VK.addEventListener("onConnectionInit", function ():void
            {
                tf.appendText("Connection initialized\n");
            });
            VK.addEventListener("onWindowBlur", function ():void
            {
                tf.appendText("Window blur\n");
            });
            VK.addEventListener("onWindowFocus", function ():void
            {
                tf.appendText("Window focus\n");
            });
            VK.addEventListener("onApplicationAdded", function ():void
            {
                tf.appendText("Application added\n");
            });
            VK.addEventListener("onBalanceChanged", function (_arg_1:CustomEvent):void
            {
                tf.appendText((("Balance changed: " + _arg_1.params[0]) + "\n"));
            });
            VK.addEventListener("onSettingsChanged", function (_arg_1:CustomEvent):void
            {
                tf.appendText((("Settings changed: " + _arg_1.params[0]) + "\n"));
            });
            VK.addEventListener("onMerchantPaymentFail", function (_arg_1:CustomEvent):void
            {
                tf.appendText((("Payment fail: " + _arg_1.params[0]) + "\n"));
            });
            VK.addEventListener("onMerchantPaymentSuccess", function (_arg_1:CustomEvent):void
            {
                var _local_2:* = "Successfull payment.";
                if (_arg_1.params[0])
                {
                    _local_2 = (_local_2 + (" Order ID: " + _arg_1.params[0]));
                };
                tf.appendText((_local_2 + "\n"));
            });
            VK.addEventListener("onMerchantPaymentCancel", function ():void
            {
                tf.appendText("Payment cancelled\n");
            });
            var btn:VKButton = new VKButton("Settings");
            btn.x = 15;
            btn.y = 15;
            addChild(btn);
            var btn1:VKButton = new VKButton("Invite friends");
            btn1.x = ((btn.x + btn.width) + 12);
            btn1.y = btn.y;
            addChild(btn1);
            var btn2:VKButton = new VKButton("Install application");
            btn2.x = ((btn1.x + btn1.width) + 12);
            btn2.y = btn1.y;
            addChild(btn2);
            var btn3:VKButton = new VKButton("Add votes");
            btn3.x = ((btn2.x + btn2.width) + 12);
            btn3.y = btn2.y;
            addChild(btn3);
            var btn4:VKButton = new VKButton("Payment box");
            btn4.x = ((btn3.x + btn3.width) + 12);
            btn4.y = btn3.y;
            addChild(btn4);
            btn.addEventListener(MouseEvent.CLICK, function (_arg_1:Event):void
            {
                VK.callMethod("showSettingsBox", 0x0800);
            });
            btn1.addEventListener(MouseEvent.CLICK, function (_arg_1:Event):void
            {
                VK.callMethod("showInviteBox");
            });
            btn2.addEventListener(MouseEvent.CLICK, function (_arg_1:Event):void
            {
                VK.callMethod("showInstallBox");
            });
            btn3.addEventListener(MouseEvent.CLICK, function (_arg_1:Event):void
            {
                VK.callMethod("showPaymentBox", 0);
            });
            btn4.addEventListener(MouseEvent.CLICK, function (_arg_1:Event):void
            {
                VK.callMethod("showMerchantPaymentBox", {
                    "test_mode":1,
                    "merchant_id":11345,
                    "item_id_1":"my_id_1",
                    "item_name_1":"Personal Jet",
                    "item_description_1":"This personal jet is the best way to fly far away.",
                    "item_price_1":"0.99",
                    "item_currency_1":643,
                    "item_quantity_1":1,
                    "item_photo_url_1":"http://vk.com/images/gifts/96/149.png",
                    "item_digital_1":1
                });
            });
        }

        private function onApiRequestFail(_arg_1:Object):void
        {
            tf.appendText((("Error: " + _arg_1.error_msg) + "\n"));
            trace(_arg_1);
        }

        private function fetchUserInfo(_arg_1:Object):void
        {
            var _local_2:String;
            tf.appendText("\n// -- API request result:\n");
            for (_local_2 in _arg_1[0])
            {
                tf.appendText((((_local_2 + "=") + _arg_1[0][_local_2]) + "\n"));
            };
        }


    }
}//package 

