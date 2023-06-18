


//hbm.Game.Character.Monsters.DeadSkeletonAnimation

package hbm.Game.Character.Monsters
{
    import hbm.Game.Renderer.CharacterAnimation;
    import hbm.Game.Renderer.CharacterAnimationState;
    import hbm.Game.Renderer.CharacterAnimationFrame;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class DeadSkeletonAnimation extends CharacterAnimation 
    {

        public function DeadSkeletonAnimation()
        {
            EnableNewImageFormat();
            SetCharacterName("DeadSkeleton");
            AddTexture("DeadSkeletonGraphics_Item00_Color", "DeadSkeletonGraphics_Item00_Alpha");
            var _local_1:CharacterAnimationState;
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-2, 0), new Point(50, 47), 0, new Rectangle(0, 0, 100, 94)));
            _local_1.AnimationSpeed = 0.3;
            AddAnimationState("Idle/Down", _local_1);
        }

    }
}//package hbm.Game.Character.Monsters

