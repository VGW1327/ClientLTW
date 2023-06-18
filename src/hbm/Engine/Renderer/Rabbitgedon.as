


//hbm.Engine.Renderer.Rabbitgedon

package hbm.Engine.Renderer
{
    import flash.utils.Dictionary;
    import flash.utils.getTimer;
    import hbm.Game.Renderer.CharacterAnimation;
    import flash.geom.Point;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Network.Events.ActorDisplayEvent;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;

    public class Rabbitgedon 
    {

        public static const ID_CRAZY_RABBIT:uint = 3999;
        private static const TIME_DOWN:uint = 700;
        private static var _ids:uint = 200000000;
        private static var _rabbits:Dictionary = new Dictionary(true);


        public static function UpdateCrazyRabbit(anim:CharacterAnimation, pivot:Point):void
        {
            var f:Number;
            if (!(anim in _rabbits))
            {
                _rabbits[anim] = {
                    "time":(getTimer() + TIME_DOWN),
                    "state":0
                };
            };
            var rabbit:Object = _rabbits[anim];
            if (rabbit.state == 0)
            {
                f = ((rabbit.time - getTimer()) / TIME_DOWN);
                if (f < 0)
                {
                    var del:Function = function (_arg_1:CharacterAnimation):void
                    {
                        delete _rabbits[_arg_1];
                    };
                    rabbit.state = 1;
                    Timeout(2, del, anim);
                }
                else
                {
                    pivot.x = (pivot.x + (80 * f));
                    pivot.y = (pivot.y - ((RenderSystem.Instance.ScreenHeight / 2) * (1 - ((1 - f) * (1 - f)))));
                };
            };
        }

        public static function RunRabbitgedon(_arg_1:uint, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:Number=0.5):void
        {
            var _local_6:uint;
            while (_local_6 < _arg_4)
            {
                Timeout(((_local_6 * _arg_5) + (_arg_5 * Math.random())), CreateCrazyRabbit, (_arg_1 + (_arg_3 * (Math.random() - 0.5))), (_arg_2 + (_arg_3 * (Math.random() - 0.5))));
                _local_6++;
            };
        }

        private static function CreateCrazyRabbit(_arg_1:int, _arg_2:int):void
        {
            var _local_3:uint;
            var _local_4:CharacterInfo;
            _local_3 = _ids++;
            _local_4 = ClientApplication.Instance.LocalGameClient.ActorList.GetActor(_local_3);
            _local_4.jobId = ID_CRAZY_RABBIT;
            _local_4.coordinates.x = _arg_1;
            _local_4.coordinates.y = _arg_2;
            _local_4.coordinates.dir = (Math.random() * 8);
            _local_4.isDead = 0;
            _local_4.baseLevel = 1;
            _local_4.isStatusesLoaded = true;
            var _local_5:ActorDisplayEvent = new ActorDisplayEvent(_local_4, ActorDisplayEvent.ON_ACTOR_INFO_UPDATED);
            _local_5.disguiseId = _local_4.jobId;
            ClientApplication.Instance.LocalGameClient.dispatchEvent(_local_5);
            Timeout(0.5, DieCrazyRabbit, _local_3);
        }

        private static function DieCrazyRabbit(characterId:uint):void
        {
            var actor:CharacterInfo;
            var hide:Function = function (_arg_1:uint):void
            {
                var _local_2:CharacterInfo;
                _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetActor(_arg_1);
                var _local_3:ActorDisplayEvent = new ActorDisplayEvent(_local_2, ActorDisplayEvent.ON_ACTOR_DISAPPEAR, ActorDisplayEvent.MOVED_OUT_OF_SIGHT);
                ClientApplication.Instance.LocalGameClient.dispatchEvent(_local_3);
                ClientApplication.Instance.LocalGameClient.ActorList.RemoveActor(_arg_1);
            };
            actor = ClientApplication.Instance.LocalGameClient.ActorList.GetActor(characterId);
            var event:ActorDisplayEvent = new ActorDisplayEvent(actor, ActorDisplayEvent.ON_ACTOR_DISAPPEAR, ActorDisplayEvent.DIED);
            ClientApplication.Instance.LocalGameClient.dispatchEvent(event);
            Timeout(2, hide, characterId);
        }

        private static function Timeout(delay:Number, cb:Function, ... rest):void
        {
            var timerId:uint;
            var result:Function;
            result = function (_arg_1:Array):void
            {
                clearTimeout(timerId);
                cb.apply(null, _arg_1);
            };
            timerId = setTimeout(result, (delay * 1000), rest);
        }


    }
}//package hbm.Engine.Renderer

