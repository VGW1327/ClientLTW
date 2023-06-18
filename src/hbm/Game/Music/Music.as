


//hbm.Game.Music.Music

package hbm.Game.Music
{
    import hbm.Engine.Music.AudioEngine;
    import hbm.Application.ClientApplication;

    public class Music 
    {

        private static var _instance:Music;
        public static var LevelupSound:Object = {
            "sound":"levelup",
            "volume":1
        };
        public static var ClickSound:Object = {
            "sound":"sfx_click",
            "volume":0.4
        };
        public static var MenuZoomInSound:Object = {
            "sound":"sfx_menu_zoomin",
            "volume":0.25
        };
        public static var MenuZoomOutSound:Object = {
            "sound":"sfx_menu_zoomout",
            "volume":0.25
        };
        public static var MapSound:Object = {
            "sound":"sfx_map",
            "volume":0.25
        };
        public static var SwordSound1:Object = {
            "sound":"sfx_sword1",
            "volume":0.3
        };
        public static var SwordSound2:Object = {
            "sound":"sfx_sword2",
            "volume":0.3
        };
        public static var BowSound1:Object = {
            "sound":"sfx_bow1",
            "volume":0.3
        };
        public static var BowSound2:Object = {
            "sound":"sfx_bow2",
            "volume":0.3
        };
        public static var ScriptSounds:Array = new Array();

        private var _idleMusic:String;
        private var _battleMusic:String;
        private var _currentMusic:String;
        private var _isMusicEnabled:Boolean = false;
        private var _isSoundsEnabled:Boolean = false;


        public static function get Instance():Music
        {
            if (_instance == null)
            {
                _instance = new (Music)();
                ScriptSounds["sfx_box"] = {
                    "sound":"sfx_box",
                    "volume":0.4
                };
                ScriptSounds["sfx_spell"] = {
                    "sound":"sfx_spell",
                    "volume":0.4
                };
                ScriptSounds["sfx_scroll"] = {
                    "sound":"sfx_scroll",
                    "volume":0.4
                };
                ScriptSounds["sfx_potion"] = {
                    "sound":"sfx_potion",
                    "volume":0.4
                };
                ScriptSounds["pm_lever"] = {
                    "sound":"pm_lever",
                    "volume":0.5
                };
                ScriptSounds["pm_card"] = {
                    "sound":"pm_card",
                    "volume":0.4
                };
            };
            return (_instance);
        }


        public function LoadLocationMusic(_arg_1:String, _arg_2:String):void
        {
            if ((((!(this._idleMusic == null)) && (this._idleMusic == _arg_1)) && (this._battleMusic == _arg_2)))
            {
                return;
            };
            this._idleMusic = _arg_1;
            this._battleMusic = _arg_2;
            this.Load(this._idleMusic);
            this.Load(this._battleMusic);
            if (this._currentMusic != null)
            {
                AudioEngine.Instance.stopSound(this._currentMusic);
                this._currentMusic = null;
            };
        }

        public function PlayIdle(_arg_1:Boolean=false):void
        {
            this.PlayMusic(this._idleMusic, _arg_1);
        }

        public function PlayBattle(_arg_1:Boolean=false):void
        {
            if (this._battleMusic)
            {
                this.PlayMusic(this._battleMusic, _arg_1);
            };
        }

        public function LoadSound(_arg_1:Object):void
        {
            this.Load(_arg_1.sound);
        }

        public function PlaySound(_arg_1:Object):void
        {
            if (((!(_arg_1 == null)) && (!(_arg_1.sound == null))))
            {
                AudioEngine.Instance.playSound(_arg_1.sound, _arg_1.volume, 0, 1);
            };
        }

        private function PlayMusic(_arg_1:String, _arg_2:Boolean=false):void
        {
            if ((((_arg_1 == this._currentMusic) || ((this._currentMusic == this._battleMusic) && (!(this._currentMusic == null)))) && (!(_arg_2))))
            {
                return;
            };
            if (this._currentMusic != null)
            {
                AudioEngine.Instance.stopSound(this._currentMusic);
            };
            if (_arg_1 != null)
            {
                AudioEngine.Instance.playSound(_arg_1, 1, 0, 999);
            };
            this._currentMusic = _arg_1;
        }

        private function Load(_arg_1:String):void
        {
            var _local_2:String;
            if (_arg_1 != null)
            {
                _local_2 = ClientApplication.Instance.Config.GetFileURL(_arg_1);
                _local_2 = _local_2.replace(/(\.zip)|(\.swf)/i, ".mp3");
                AudioEngine.Instance.addExternalSound(_local_2, _arg_1);
            };
        }

        public function StopCurrentMusic():void
        {
            if (this._currentMusic != null)
            {
                AudioEngine.Instance.stopSound(this._currentMusic);
                this._currentMusic = null;
            };
        }

        public function get MusicEnabled():Boolean
        {
            return (this._isMusicEnabled);
        }

        public function set MusicEnabled(_arg_1:Boolean):void
        {
            this._isMusicEnabled = _arg_1;
        }

        public function get SoundsEnabled():Boolean
        {
            return (this._isSoundsEnabled);
        }

        public function set SoundsEnabled(_arg_1:Boolean):void
        {
            this._isSoundsEnabled = _arg_1;
        }


    }
}//package hbm.Game.Music

