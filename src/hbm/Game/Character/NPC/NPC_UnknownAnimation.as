


//hbm.Game.Character.NPC.NPC_UnknownAnimation

package hbm.Game.Character.NPC
{
    import hbm.Game.Renderer.CharacterAnimation;
    import hbm.Game.Renderer.CharacterAnimationState;
    import hbm.Game.Renderer.CharacterAnimationFrame;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class NPC_UnknownAnimation extends CharacterAnimation 
    {

        public function NPC_UnknownAnimation()
        {
            EnableNewImageFormat();
            SetCharacterName("NPC_Unknown");
            AddTexture("NPC_UnknownGraphics_Item00_Color", "NPC_UnknownGraphics_Item00_Alpha");
            var _local_1:CharacterAnimationState;
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(0, -5), new Point(9, 8), 0, new Rectangle(0, 0, 18, 16)));
            _local_1.AnimationSpeed = 0.3;
            AddAnimationState("Idle/Down", _local_1);
        }

    }
}//package hbm.Game.Character.NPC

