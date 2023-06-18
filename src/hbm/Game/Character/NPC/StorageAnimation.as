


//hbm.Game.Character.NPC.StorageAnimation

package hbm.Game.Character.NPC
{
    import hbm.Game.Renderer.CharacterAnimation;
    import hbm.Game.Renderer.CharacterAnimationState;
    import hbm.Game.Renderer.CharacterAnimationFrame;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class StorageAnimation extends CharacterAnimation 
    {

        public function StorageAnimation()
        {
            EnableNewImageFormat();
            SetCharacterName("Storage");
            AddTexture("StorageGraphics_Item00_Color", "StorageGraphics_Item00_Alpha");
            var _local_1:CharacterAnimationState;
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-1, -30), new Point(55, 44), 0, new Rectangle(0, 0, 110, 88)));
            _local_1.AnimationSpeed = 0.3;
            AddAnimationState("Idle/Down", _local_1);
        }

    }
}//package hbm.Game.Character.NPC

