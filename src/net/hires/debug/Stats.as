package net.hires.debug
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.StyleSheet;
    import flash.display.Bitmap;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import flash.display.BitmapData;
    import flash.events.MouseEvent;
    import flash.utils.getTimer;
    import flash.system.System;

    public class Stats extends Sprite 
    {

        protected const WIDTH:uint = 80;
        protected const HEIGHT:uint = 100;

        protected var xml:XML;
        protected var text:TextField;
        protected var style:StyleSheet;
        protected var timer:uint;
        protected var fps:uint;
        protected var ms:uint;
        protected var ms_prev:uint;
        protected var mem:Number;
        protected var mem_max:Number;
        protected var graph:Bitmap;
        protected var rectangle:Rectangle;
        protected var fps_graph:uint;
        protected var mem_graph:uint;
        protected var mem_max_graph:uint;
        public var measuredFPS:Number = 0;
        public var driverInfo:String;
        protected var driverInfoToggle:Boolean = false;
        protected var theme:Object = {
            "bg":51,
            "fps":0xFFFF00,
            "ms":0xFF00,
            "mem":0xFFFF,
            "memmax":0xFF0070,
            "drawcalls":0xFF9900,
            "tris":43724
        };

        public function Stats():void
        {
            this.mem_max = 0;
            this.xml = <xml>
                <fps>FPS:</fps>
                <ms>MS:</ms>
                <mem>MEM:</mem>
                <memMax>MAX:</memMax>
                <drawCalls>CALLS:</drawCalls>
                <tris>TRIS:</tris>
            </xml>
            ;
            this.style = new StyleSheet();
            this.style.setStyle("xml", {
                "fontSize":"9px",
                "fontFamily":"_sans",
                "leading":"-2px"
            });
            this.style.setStyle("fps", {"color":this.hex2css(this.theme.fps)});
            this.style.setStyle("ms", {"color":this.hex2css(this.theme.ms)});
            this.style.setStyle("mem", {"color":this.hex2css(this.theme.mem)});
            this.style.setStyle("memMax", {"color":this.hex2css(this.theme.memmax)});
            this.style.setStyle("drawCalls", {"color":this.hex2css(this.theme.drawcalls)});
            this.style.setStyle("tris", {"color":this.hex2css(this.theme.tris)});
            this.text = new TextField();
            this.text.width = this.WIDTH;
            this.text.height = 120;
            this.text.styleSheet = this.style;
            this.text.condenseWhite = true;
            this.text.selectable = false;
            this.text.mouseEnabled = false;
            this.text.wordWrap = true;
            this.graph = new Bitmap();
            this.graph.y = 70;
            this.rectangle = new Rectangle((this.WIDTH - 1), 0, 1, (this.HEIGHT - 50));
            addEventListener(Event.ADDED_TO_STAGE, this.init, false, 0, true);
            addEventListener(Event.REMOVED_FROM_STAGE, this.destroy, false, 0, true);
        }

        private function init(_arg_1:Event):void
        {
            graphics.beginFill(this.theme.bg);
            graphics.drawRect(0, 0, this.WIDTH, this.HEIGHT);
            graphics.endFill();
            addChild(this.text);
            this.graph.bitmapData = new BitmapData(this.WIDTH, (this.HEIGHT - 50), false, this.theme.bg);
            addChild(this.graph);
            addEventListener(MouseEvent.CLICK, this.onClick);
        }

        private function destroy(_arg_1:Event):void
        {
            graphics.clear();
            while (numChildren > 0)
            {
                removeChildAt(0);
            };
            this.graph.bitmapData.dispose();
            removeEventListener(MouseEvent.CLICK, this.onClick);
        }

        public function update(_arg_1:int, _arg_2:int):void
        {
            this.timer = getTimer();
            if ((this.timer - 1000) > this.ms_prev)
            {
                this.ms_prev = this.timer;
                this.mem = Number((System.totalMemory * 9.54E-7).toFixed(3));
                this.mem_max = ((this.mem_max > this.mem) ? this.mem_max : this.mem);
                this.measuredFPS = this.fps;
                this.fps_graph = Math.min(this.graph.height, ((this.fps / stage.frameRate) * this.graph.height));
                this.mem_graph = (Math.min(this.graph.height, Math.sqrt(Math.sqrt((this.mem * 5000)))) - 2);
                this.mem_max_graph = (Math.min(this.graph.height, Math.sqrt(Math.sqrt((this.mem_max * 5000)))) - 2);
                this.graph.bitmapData.scroll(-1, 0);
                this.graph.bitmapData.fillRect(this.rectangle, this.theme.bg);
                this.graph.bitmapData.setPixel((this.graph.width - 1), (this.graph.height - this.fps_graph), this.theme.fps);
                this.graph.bitmapData.setPixel((this.graph.width - 1), (this.graph.height - ((this.timer - this.ms) >> 1)), this.theme.ms);
                this.graph.bitmapData.setPixel((this.graph.width - 1), (this.graph.height - this.mem_graph), this.theme.mem);
                this.graph.bitmapData.setPixel((this.graph.width - 1), (this.graph.height - this.mem_max_graph), this.theme.memmax);
                this.xml.fps = ((("FPS: " + this.fps) + " / ") + stage.frameRate);
                this.xml.mem = ("MEM: " + this.mem);
                this.xml.memMax = ("MAX: " + this.mem_max);
                this.xml.drawCalls = ("DRAW: " + _arg_1);
                this.xml.tris = ("TRIS: " + _arg_2);
                this.fps = 0;
            };
            this.fps++;
            this.xml.ms = ("MS: " + (this.timer - this.ms));
            this.ms = this.timer;
            if (this.driverInfoToggle)
            {
                this.text.htmlText = (("<xml><fps>" + this.driverInfo) + "</fps></xml>");
            }
            else
            {
                this.text.htmlText = this.xml;
            };
        }

        private function onClick(_arg_1:MouseEvent):void
        {
            this.driverInfoToggle = (!(this.driverInfoToggle));
            this.graph.visible = (!(this.driverInfoToggle));
        }

        private function hex2css(_arg_1:int):String
        {
            return ("#" + _arg_1.toString(16));
        }


    }
}