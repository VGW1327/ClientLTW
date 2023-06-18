


//hbm.Engine.Music.AudioEngine

package hbm.Engine.Music
{
    import flash.utils.Dictionary;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.URLRequest;
    import flash.media.SoundLoaderContext;
    import flash.media.SoundTransform;
    import flash.utils.getQualifiedClassName;

    public class AudioEngine 
    {

        private static var _instance:AudioEngine;
        private static var _allowInstance:Boolean;

        private var _soundsDict:Dictionary;
        private var _sounds:Array;

        public function AudioEngine()
        {
            this._soundsDict = new Dictionary(true);
            this._sounds = new Array();
            if (!AudioEngine._allowInstance)
            {
                throw (new Error("Error: Use SoundManager.getInstance() instead of the new keyword."));
            };
        }

        public static function get Instance():AudioEngine
        {
            if (AudioEngine._instance == null)
            {
                AudioEngine._allowInstance = true;
                AudioEngine._instance = new (AudioEngine)();
                AudioEngine._allowInstance = false;
            };
            return (AudioEngine._instance);
        }


        public function addLibrarySound(_arg_1:*, _arg_2:String):Boolean
        {
            var _local_3:int;
            while (_local_3 < this._sounds.length)
            {
                if (this._sounds[_local_3].name == _arg_2)
                {
                    return (false);
                };
                _local_3++;
            };
            var _local_4:Object = new Object();
            var _local_5:Sound = new (_arg_1)();
            _local_4.name = _arg_2;
            _local_4.sound = _local_5;
            _local_4.channel = new SoundChannel();
            _local_4.position = 0;
            _local_4.paused = true;
            _local_4.volume = 1;
            _local_4.startTime = 0;
            _local_4.loops = 0;
            _local_4.pausedByAll = false;
            this._soundsDict[_arg_2] = _local_4;
            this._sounds.push(_local_4);
            return (true);
        }

        public function addExternalSound(_arg_1:String, _arg_2:String, _arg_3:Number=1000, _arg_4:Boolean=false):Boolean
        {
            var _local_5:int;
            while (_local_5 < this._sounds.length)
            {
                if (this._sounds[_local_5].name == _arg_2)
                {
                    return (false);
                };
                _local_5++;
            };
            var _local_6:Object = new Object();
            var _local_7:Sound = new Sound(new URLRequest(_arg_1), new SoundLoaderContext(_arg_3, _arg_4));
            _local_6.name = _arg_2;
            _local_6.sound = _local_7;
            _local_6.channel = new SoundChannel();
            _local_6.position = 0;
            _local_6.paused = true;
            _local_6.volume = 1;
            _local_6.startTime = 0;
            _local_6.loops = 0;
            _local_6.pausedByAll = false;
            this._soundsDict[_arg_2] = _local_6;
            this._sounds.push(_local_6);
            return (true);
        }

        public function removeSound(_arg_1:String):void
        {
            var _local_2:int;
            while (_local_2 < this._sounds.length)
            {
                if (this._sounds[_local_2].name == _arg_1)
                {
                    this._sounds[_local_2] = null;
                    this._sounds.splice(_local_2, 1);
                };
                _local_2++;
            };
            delete this._soundsDict[_arg_1];
        }

        public function removeAllSounds():void
        {
            var _local_1:int;
            while (_local_1 < this._sounds.length)
            {
                this._sounds[_local_1] = null;
                _local_1++;
            };
            this._sounds = new Array();
            this._soundsDict = new Dictionary(true);
        }

        public function playSound(_arg_1:String, _arg_2:Number=1, _arg_3:Number=0, _arg_4:int=0):void
        {
            var _local_5:Object = this._soundsDict[_arg_1];
            if (!_local_5)
            {
                return;
            };
            _local_5.volume = _arg_2;
            _local_5.startTime = _arg_3;
            _local_5.loops = _arg_4;
            if (_local_5.paused)
            {
                _local_5.channel = _local_5.sound.play(_local_5.position, _local_5.loops, new SoundTransform(_local_5.volume));
            }
            else
            {
                _local_5.channel = _local_5.sound.play(_arg_3, _local_5.loops, new SoundTransform(_local_5.volume));
            };
            _local_5.paused = false;
        }

        public function stopSound(_arg_1:String):void
        {
            var _local_2:Object = this._soundsDict[_arg_1];
            if (!_local_2)
            {
                return;
            };
            _local_2.paused = true;
            _local_2.channel.stop();
            _local_2.position = _local_2.channel.position;
        }

        public function pauseSound(_arg_1:String):void
        {
            var _local_2:Object = this._soundsDict[_arg_1];
            if (!_local_2)
            {
                return;
            };
            _local_2.paused = true;
            _local_2.position = _local_2.channel.position;
            _local_2.channel.stop();
        }

        public function playAllSounds(_arg_1:Boolean=false):void
        {
            var _local_3:String;
            var _local_2:int;
            while (_local_2 < this._sounds.length)
            {
                _local_3 = this._sounds[_local_2].name;
                if (_arg_1)
                {
                    if (this._soundsDict[_local_3].pausedByAll)
                    {
                        this._soundsDict[_local_3].pausedByAll = false;
                        this.playSound(_local_3);
                    };
                }
                else
                {
                    this.playSound(_local_3);
                };
                _local_2++;
            };
        }

        public function stopAllSounds(_arg_1:Boolean=true):void
        {
            var _local_3:String;
            var _local_2:int;
            while (_local_2 < this._sounds.length)
            {
                _local_3 = this._sounds[_local_2].name;
                if (_arg_1)
                {
                    if (!this._soundsDict[_local_3].paused)
                    {
                        this._soundsDict[_local_3].pausedByAll = true;
                        this.stopSound(_local_3);
                    };
                }
                else
                {
                    this.stopSound(_local_3);
                };
                _local_2++;
            };
        }

        public function pauseAllSounds(_arg_1:Boolean=true):void
        {
            var _local_3:String;
            var _local_2:int;
            while (_local_2 < this._sounds.length)
            {
                _local_3 = this._sounds[_local_2].name;
                if (_arg_1)
                {
                    if (!this._soundsDict[_local_3].paused)
                    {
                        this._soundsDict[_local_3].pausedByAll = true;
                        this.pauseSound(_local_3);
                    };
                }
                else
                {
                    this.pauseSound(_local_3);
                };
                _local_2++;
            };
        }

        public function fadeSound(_arg_1:String, _arg_2:Number=0, _arg_3:Number=1):void
        {
            var _local_4:SoundChannel = this._soundsDict[_arg_1].channel;
        }

        public function muteAllSounds():void
        {
            var _local_2:String;
            var _local_1:int;
            while (_local_1 < this._sounds.length)
            {
                _local_2 = this._sounds[_local_1].name;
                this.setSoundVolume(_local_2, 0);
                _local_1++;
            };
        }

        public function unmuteAllSounds():void
        {
            var _local_2:String;
            var _local_3:Object;
            var _local_4:SoundTransform;
            var _local_1:int;
            while (_local_1 < this._sounds.length)
            {
                _local_2 = this._sounds[_local_1].name;
                _local_3 = this._soundsDict[_local_2];
                _local_4 = _local_3.channel.soundTransform;
                _local_4.volume = _local_3.volume;
                _local_3.channel.soundTransform = _local_4;
                _local_1++;
            };
        }

        public function setSoundVolume(_arg_1:String, _arg_2:Number):void
        {
            var _local_3:Object = this._soundsDict[_arg_1];
            if (!_local_3)
            {
                return;
            };
            var _local_4:SoundTransform = _local_3.channel.soundTransform;
            _local_4.volume = _arg_2;
            _local_3.channel.soundTransform = _local_4;
        }

        public function getSoundVolume(_arg_1:String):Number
        {
            return (this._soundsDict[_arg_1].channel.soundTransform.volume);
        }

        public function getSoundPosition(_arg_1:String):Number
        {
            return (this._soundsDict[_arg_1].channel.position);
        }

        public function getSoundDuration(_arg_1:String):Number
        {
            return (this._soundsDict[_arg_1].sound.length);
        }

        public function getSoundObject(_arg_1:String):Sound
        {
            return (this._soundsDict[_arg_1].sound);
        }

        public function isSoundPaused(_arg_1:String):Boolean
        {
            return (this._soundsDict[_arg_1].paused);
        }

        public function isSoundPausedByAll(_arg_1:String):Boolean
        {
            return (this._soundsDict[_arg_1].pausedByAll);
        }

        public function get sounds():Array
        {
            return (this._sounds);
        }

        public function toString():String
        {
            return (getQualifiedClassName(this));
        }


    }
}//package hbm.Engine.Music

