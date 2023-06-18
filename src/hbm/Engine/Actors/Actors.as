


//hbm.Engine.Actors.Actors

package hbm.Engine.Actors
{
    import flash.utils.Dictionary;
    import hbm.Game.Character.Character;

    public class Actors 
    {

        private var _actors:Dictionary;
        private var _playerID:uint;

        public function Actors()
        {
            this._actors = new Dictionary(true);
        }

        public function AddActor(_arg_1:uint, _arg_2:CharacterInfo):void
        {
            this._actors[_arg_1] = _arg_2;
        }

        public function GetActor(_arg_1:uint):CharacterInfo
        {
            var _local_2:CharacterInfo = (this._actors[_arg_1] as CharacterInfo);
            if (_local_2 == null)
            {
                _local_2 = new CharacterInfo();
                _local_2.characterId = _arg_1;
                this._actors[_arg_1] = _local_2;
            };
            return (_local_2);
        }

        public function RemoveActor(_arg_1:uint):void
        {
            if (_arg_1 != this._playerID)
            {
                delete this._actors[_arg_1];
            };
        }

        public function get actors():Dictionary
        {
            return (this._actors);
        }

        public function set playerID(_arg_1:uint):void
        {
            this._playerID = _arg_1;
        }

        public function GetPlayer():CharacterInfo
        {
            return (this._actors[this._playerID]);
        }

        public function GetPlayerFraction():int
        {
            var _local_1:CharacterInfo = this.GetPlayer();
            return (Character.GetFraction(_local_1.jobId, _local_1.clothesColor));
        }

        public function GetPlayerRace():uint
        {
            var _local_1:CharacterInfo = this.GetPlayer();
            return (Character.GetPlayerRace(_local_1.jobId, _local_1.clothesColor));
        }

        public function GetPlayerIsTrader():Boolean
        {
            var _local_1:CharacterInfo = this.GetPlayer();
            return ((_local_1.jobId == 5) || (_local_1.jobId == 10));
        }

        public function GetPlayerIsBabyClass():Boolean
        {
            var _local_1:CharacterInfo = this.GetPlayer();
            return (Character.IsBabyClass(_local_1.jobId));
        }

        public function GetCustomization(_arg_1:uint):CharacterInfo
        {
            var _local_2:CharacterInfo = (this._actors[_arg_1] as CharacterInfo);
            if (_local_2 == null)
            {
                _local_2 = new CharacterInfo();
                _local_2.characterId = _arg_1;
                _local_2.showName = false;
                _local_2.drawShadow = false;
                _local_2.needDraw = false;
                this._actors[_arg_1] = _local_2;
            };
            return (_local_2);
        }

        public function DebugPrint():void
        {
            var _local_2:CharacterInfo;
            var _local_1:int;
            for each (_local_2 in this._actors)
            {
                if (_local_2 != null)
                {
                    _local_1++;
                };
            };
        }


    }
}//package hbm.Engine.Actors

