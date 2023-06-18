


//hbm.Game.Character.Monsters.Monster_UnknownAnimation

package hbm.Game.Character.Monsters
{
    import hbm.Game.Renderer.CharacterAnimation;
    import hbm.Game.Renderer.CharacterAnimationState;
    import hbm.Game.Renderer.CharacterAnimationFrame;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class Monster_UnknownAnimation extends CharacterAnimation 
    {

        public function Monster_UnknownAnimation()
        {
            EnableNewImageFormat();
            SetCharacterName("Monster_Unknown");
            AddTexture("Monster_UnknownGraphics_Item00_Color", "Monster_UnknownGraphics_Item00_Alpha");
            var _local_1:CharacterAnimationState;
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, -12), new Point(22, 19), 0, new Rectangle(0, 0, 44, 38)));
            _local_1.AnimationSpeed = 0.3;
            AddAnimationState("Idle/Down", _local_1);
        }

    }
}//package hbm.Game.Character.Monsters

