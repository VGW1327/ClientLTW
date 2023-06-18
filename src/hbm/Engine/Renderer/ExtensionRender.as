


//hbm.Engine.Renderer.ExtensionRender

package hbm.Engine.Renderer
{
    import flash.display.Sprite;
    import __AS3__.vec.Vector;
    import flash.geom.ColorTransform;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.display.BlendMode;
    import hbm.Game.Utility.AsWingUtil;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Game.Character.Character;
    import hbm.Application.ClientApplication;
    import flash.events.Event;
    import __AS3__.vec.*;

    public class ExtensionRender 
    {

        private static const DISABLE_NIGHT:uint = 0;
        private static const ENABLE_DARK:uint = 1;
        private static const ENABLE_NIGHT:uint = 2;
        private static const _instance:ExtensionRender = new (ExtensionRender)();
        private static var _singletone:Boolean = false;

        private var _disable:Boolean = true;
        private var _container:Sprite;
        private var _lightingLayers:Array;
        private var _typeLocation:Object;
        private var _heroLighting:ExtensionLight;
        private var _lights:Vector.<ExtensionLight>;
        private var _dark:ColorTransform;
        private var _timerNight:Timer = new Timer((10 * 60000));

        public function ExtensionRender()
        {
            if (_singletone)
            {
                throw ("Can't create class ExtensionRender!");
            };
            _singletone = true;
            this._container = new Sprite();
            this._container.mouseEnabled = (this._container.mouseChildren = false);
            this._timerNight.addEventListener(TimerEvent.TIMER, this.OnTimerNight, false, 0, true);
        }

        public static function get Instance():ExtensionRender
        {
            return (_instance);
        }


        public function Enable(_arg_1:Boolean):void
        {
            this._disable = (!(_arg_1));
            if (((_arg_1) && (!(this._lightingLayers))))
            {
                this._lightingLayers = [new Sprite(), new Sprite()];
                this._lightingLayers[0].blendMode = BlendMode.OVERLAY;
                this._lightingLayers[1].blendMode = BlendMode.OVERLAY;
                this._container.addChild(this._lightingLayers[0]);
                this._container.addChild(this._lightingLayers[1]);
                this.ChangeMap();
            };
        }

        public function get RenderContainer():Sprite
        {
            return (this._container);
        }

        public function ChangeMap():void
        {
            var _local_1:String;
            var _local_2:Object;
            var _local_4:Array;
            var _local_5:ExtensionLight;
            if (this._disable)
            {
                return;
            };
            this._lights = new Vector.<ExtensionLight>();
            this.ClearLayers();
            _local_1 = this.CurrentLocation();
            _local_2 = AsWingUtil.AdditionalData.GetExtensionRenderMaps();
            var _local_3:Object = ((_local_2[_local_1]) || ({}));
            this._typeLocation = ((_local_3["type"]) || (DISABLE_NIGHT));
            this._timerNight.stop();
            this._timerNight.reset();
            if (this._typeLocation != DISABLE_NIGHT)
            {
                this._dark = this.GetDarkness();
                if (this._typeLocation == ENABLE_NIGHT)
                {
                    this._timerNight.start();
                };
                this._heroLighting = new ExtensionLight(300);
                this.AddLight(this._heroLighting);
                for each (_local_4 in _local_3["lights"])
                {
                    if (((_local_4) && (_local_4.length >= 3)))
                    {
                        _local_5 = new ExtensionLight(_local_4[2]);
                        _local_5.SetLocationPosition(_local_4[0], _local_4[1]);
                        this.AddLight(_local_5);
                    };
                };
            };
        }

        public function Update():void
        {
            var _local_3:Point;
            var _local_4:Camera;
            var _local_5:Rectangle;
            var _local_6:ExtensionLight;
            if ((((this._disable) || (this._typeLocation == DISABLE_NIGHT)) || (!(this._dark))))
            {
                return;
            };
            var _local_1:BitmapData = RenderSystem.Instance.BackBuffer;
            if (!_local_1)
            {
                return;
            };
            _local_1.colorTransform(new Rectangle(0, 0, RenderSystem.Instance.ScreenWidth, RenderSystem.Instance.ScreenHeight), this._dark);
            var _local_2:Character = CharacterStorage.Instance.LocalPlayerCharacter;
            if (_local_2)
            {
                _local_3 = _local_2.Position;
                this._heroLighting.SetAbsolutePosition(_local_3.x, _local_3.y);
                _local_4 = RenderSystem.Instance.MainCamera;
                _local_5 = new Rectangle(0, 0, RenderSystem.Instance.ScreenWidth, RenderSystem.Instance.ScreenHeight);
                for each (_local_6 in this._lights)
                {
                    if (_local_5.contains((_local_6.Position.x - _local_4.TopLeftPoint.x), ((RenderSystem.Instance.MainCamera.MaxHeight - _local_6.Position.y) - _local_4.TopLeftPoint.y)))
                    {
                        _local_6.Show(this._lightingLayers);
                    }
                    else
                    {
                        _local_6.Hide();
                    };
                };
            };
        }

        public function AddLight(_arg_1:ExtensionLight):void
        {
            if (this._lights.indexOf(_arg_1) < 0)
            {
                this._lights.push(_arg_1);
            };
        }

        private function CurrentLocation():String
        {
            return (ClientApplication.Instance.LocalGameClient.MapName.replace(/(\w+)\.gat/i, "$1"));
        }

        private function ClearLayers():void
        {
            while (this._lightingLayers[0].numChildren)
            {
                this._lightingLayers[0].removeChildAt(0);
            };
            while (this._lightingLayers[1].numChildren)
            {
                this._lightingLayers[1].removeChildAt(0);
            };
        }

        private function OnTimerNight(_arg_1:Event):void
        {
            this._dark = this.GetDarkness();
            if (!this._dark)
            {
                this.ClearLayers();
            };
        }

        private function GetDarkness():ColorTransform
        {
            var _local_4:Number;
            if (this._typeLocation == ENABLE_DARK)
            {
                return (new ColorTransform(0.3, 0.3, 0.3));
            };
            var _local_1:Date = new Date();
            _local_1.setTime((ClientApplication.Instance.timeOnServer * 1000));
            var _local_2:int = (_local_1.getUTCHours() + 4);
            if (_local_2 >= 24)
            {
                _local_2 = (_local_2 - 24);
            };
            var _local_3:uint = _local_1.getUTCMinutes();
            if (_local_2 < 6)
            {
                _local_4 = 0.3;
            }
            else
            {
                if (_local_2 < 9)
                {
                    _local_4 = (1 - (((((9 - _local_2) * 60) - _local_3) / 180) * 0.7));
                }
                else
                {
                    if (_local_2 < 19)
                    {
                        _local_4 = 0;
                    }
                    else
                    {
                        _local_4 = (0.3 + (((((24 - _local_2) * 60) - _local_3) / 300) * 0.7));
                    };
                };
            };
            if (_local_4 > 0)
            {
                this._container.alpha = (1 - ((_local_4 - 0.3) / 0.7));
                return (new ColorTransform(_local_4, _local_4, _local_4));
            };
            this._container.alpha = 1;
            return (null);
        }


    }
}//package hbm.Engine.Renderer

