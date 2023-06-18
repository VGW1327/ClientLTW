


//hbm.Game.Logic.GameLogic

package hbm.Game.Logic
{
    import hbm.Game.Renderer.BattleLogManager;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Game.Renderer.ArrowManager;
    import hbm.Game.Renderer.SkillUnitManager;

    public class GameLogic 
    {

        private static var _singleton:GameLogic = null;
        private static var _isSingletonLock:Boolean = false;

        public function GameLogic()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access. Use GameLogic.Instance."));
            };
        }

        public static function get Instance():GameLogic
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (GameLogic)();
                _isSingletonLock = false;
            };
            return (_singleton);
        }


        public function OnChangeMap():void
        {
            BattleLogManager.Instance.Clear();
            CharacterStorage.Instance.OnChangeMap();
        }

        public function Update(_arg_1:Number):void
        {
            BattleLogManager.Instance.Update(_arg_1);
            ArrowManager.Instance.Update(_arg_1);
            SkillUnitManager.Instance.Update(_arg_1);
            CharacterStorage.Instance.Update(_arg_1);
        }


    }
}//package hbm.Game.Logic

