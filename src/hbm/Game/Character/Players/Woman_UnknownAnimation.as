


//hbm.Game.Character.Players.Woman_UnknownAnimation

package hbm.Game.Character.Players
{
    import hbm.Game.Renderer.CharacterAnimation;
    import hbm.Game.Renderer.CharacterAnimationState;
    import hbm.Game.Renderer.CharacterAnimationFrame;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class Woman_UnknownAnimation extends CharacterAnimation 
    {

        public function Woman_UnknownAnimation()
        {
            EnableNewImageFormat();
            SetCharacterName("Woman_Unknown");
            AddTexture("Woman_UnknownGraphics_Item00_Color", "Woman_UnknownGraphics_Item00_Alpha");
            var _local_1:CharacterAnimationState;
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(0, -37), new Point(15, 46), 0, new Rectangle(0, 0, 30, 92)));
            _local_1.AnimationSpeed = 0.3;
            AddAnimationState("Idle/Down", _local_1);
        }

    }
}//package hbm.Game.Character.Players

