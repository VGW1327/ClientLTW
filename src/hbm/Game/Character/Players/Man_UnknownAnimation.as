


//hbm.Game.Character.Players.Man_UnknownAnimation

package hbm.Game.Character.Players
{
    import hbm.Game.Renderer.CharacterAnimation;
    import hbm.Game.Renderer.CharacterAnimationState;
    import hbm.Game.Renderer.CharacterAnimationFrame;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class Man_UnknownAnimation extends CharacterAnimation 
    {

        public function Man_UnknownAnimation()
        {
            EnableNewImageFormat();
            SetCharacterName("Man_Unknown");
            AddTexture("Man_UnknownGraphics_Item00_Color", "Man_UnknownGraphics_Item00_Alpha");
            var _local_1:CharacterAnimationState;
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(0, -38), new Point(20, 49), 0, new Rectangle(0, 0, 40, 98)));
            _local_1.AnimationSpeed = 0.3;
            AddAnimationState("Idle/Down", _local_1);
        }

    }
}//package hbm.Game.Character.Players

