


//hbm.Game.Character.Customizations.WomanOrcAnimation

package hbm.Game.Character.Customizations
{
    import hbm.Game.Renderer.CharacterAnimation;
    import hbm.Game.Renderer.CharacterAnimationState;
    import hbm.Game.Renderer.CharacterAnimationFrame;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class WomanOrcAnimation extends CharacterAnimation 
    {

        public function WomanOrcAnimation()
        {
            EnableNewImageFormat();
            SetCharacterName("WomanOrc");
            AddTexture("WomanOrcGraphics_Item00_Color", "WomanOrcGraphics_Item00_Alpha");
            var _local_1:CharacterAnimationState;
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(4, -2), new Point(37, 104), 0, new Rectangle(0, 0, 74, 208)));
            AddAnimationState("Background", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(7, -39), new Point(39, 52), 0, new Rectangle(428, 490, 78, 104)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(3, -49), new Point(43, 48), 0, new Rectangle(464, 594, 86, 96)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(7, -42), new Point(35, 40), 0, new Rectangle(796, 692, 70, 80)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(9, -37), new Point(42, 50), 0, new Rectangle(642, 490, 84, 100)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(7, -39), new Point(39, 52), 0, new Rectangle(272, 490, 78, 104)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, -35), new Point(36, 48), 0, new Rectangle(550, 594, 72, 96)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(0, -41), new Point(46, 49), 0, new Rectangle(910, 490, 92, 98)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(7, -36), new Point(40, 49), 0, new Rectangle(82, 594, 80, 98)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(10, -44), new Point(38, 44), 0, new Rectangle(188, 692, 76, 88)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(10, -44), new Point(38, 44), 0, new Rectangle(264, 692, 76, 88)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(4, -36), new Point(41, 49), 0, new Rectangle(0, 594, 82, 98)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(9, -34), new Point(42, 47), 0, new Rectangle(742, 594, 84, 94)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(3, -39), new Point(42, 37), 0, new Rectangle(0, 784, 84, 74)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(6, -33), new Point(35, 46), 0, new Rectangle(118, 692, 70, 92)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(8, -42), new Point(44, 38), 0, new Rectangle(866, 692, 88, 76)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(15, -41), new Point(42, 41), 0, new Rectangle(712, 692, 84, 82)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(7, 3), new Point(40, 80), 0, new Rectangle(372, 0, 80, 160)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, 1), new Point(36, 82), 0, new Rectangle(300, 0, 72, 164)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(18, 6), new Point(49, 79), 0, new Rectangle(612, 0, 98, 158)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, 7), new Point(37, 84), 0, new Rectangle(152, 0, 74, 168)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, 9), new Point(37, 84), 0, new Rectangle(226, 0, 74, 168)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(3, 7), new Point(39, 84), 0, new Rectangle(74, 0, 78, 168)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, 4), new Point(36, 79), 0, new Rectangle(862, 0, 72, 158)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(7, 3), new Point(40, 80), 0, new Rectangle(532, 0, 80, 160)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(7, -39), new Point(39, 52), 0, new Rectangle(350, 490, 78, 104)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(7, 3), new Point(40, 80), 0, new Rectangle(452, 0, 80, 160)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(6, -41), new Point(40, 56), 0, new Rectangle(746, 352, 80, 112)));
            AddAnimationState("Body", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(6, -25), new Point(27, 49), 0, new Rectangle(356, 594, 54, 98)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(3, -23), new Point(34, 51), 0, new Rectangle(506, 490, 68, 102)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, -17), new Point(33, 56), 0, new Rectangle(892, 352, 66, 112)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(6, -25), new Point(33, 49), 0, new Rectangle(162, 594, 66, 98)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(6, -25), new Point(33, 49), 0, new Rectangle(228, 594, 66, 98)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, -17), new Point(33, 56), 0, new Rectangle(826, 352, 66, 112)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(4, -24), new Point(33, 50), 0, new Rectangle(726, 490, 66, 100)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(6, -25), new Point(27, 49), 0, new Rectangle(410, 594, 54, 98)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(3, -23), new Point(34, 51), 0, new Rectangle(574, 490, 68, 102)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(7, -24), new Point(31, 49), 0, new Rectangle(294, 594, 62, 98)));
            AddAnimationState("Cloak", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, -86), new Point(14, 22), 0, new Rectangle(118, 858, 28, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(1, -87), new Point(27, 23), 0, new Rectangle(662, 784, 54, 46)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, -89), new Point(16, 21), 0, new Rectangle(202, 858, 32, 42)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(4, -89), new Point(14, 18), 0, new Rectangle(620, 858, 28, 36)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-3, -87), new Point(30, 22), 0, new Rectangle(848, 784, 60, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(2, -83), new Point(22, 19), 0, new Rectangle(356, 858, 44, 38)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(1, -85), new Point(19, 19), 0, new Rectangle(440, 858, 38, 38)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, -86), new Point(14, 22), 0, new Rectangle(174, 858, 28, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(1, -87), new Point(17, 19), 0, new Rectangle(478, 858, 34, 38)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, -90), new Point(18, 18), 0, new Rectangle(584, 858, 36, 36)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(4, -89), new Point(14, 18), 0, new Rectangle(648, 858, 28, 36)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(4, -86), new Point(21, 20), 0, new Rectangle(278, 858, 42, 40)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(0, -88), new Point(22, 22), 0, new Rectangle(0, 858, 44, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(1, -87), new Point(17, 19), 0, new Rectangle(0x0200, 858, 34, 38)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(7, -89), new Point(19, 18), 0, new Rectangle(546, 858, 38, 36)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(0, -85), new Point(18, 20), 0, new Rectangle(320, 858, 36, 40)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(0, -87), new Point(22, 23), 0, new Rectangle(760, 784, 44, 46)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(1, -85), new Point(25, 24), 0, new Rectangle(612, 784, 50, 48)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-2, -89), new Point(22, 20), 0, new Rectangle(234, 858, 44, 40)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(10, -91), new Point(20, 19), 0, new Rectangle(400, 858, 40, 38)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(0, -87), new Point(22, 23), 0, new Rectangle(804, 784, 44, 46)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(3, -87), new Point(29, 22), 0, new Rectangle(908, 784, 58, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(3, -85), new Point(18, 22), 0, new Rectangle(82, 858, 36, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(4, -85), new Point(20, 25), 0, new Rectangle(572, 784, 40, 50)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, -86), new Point(14, 22), 0, new Rectangle(146, 858, 28, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(0, -87), new Point(22, 23), 0, new Rectangle(716, 784, 44, 46)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(1, -85), new Point(26, 25), 0, new Rectangle(478, 784, 52, 50)));
            AddAnimationState("Head", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-3, 85), new Point(29, 17), 0, new Rectangle(792, 858, 58, 34)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-4, 81), new Point(28, 22), 0, new Rectangle(966, 784, 56, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-4, 88), new Point(30, 15), 0, new Rectangle(0, 902, 60, 30)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-3, 85), new Point(29, 17), 0, new Rectangle(676, 858, 58, 34)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-5, 87), new Point(29, 16), 0, new Rectangle(908, 858, 58, 32)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-5, 87), new Point(29, 16), 0, new Rectangle(850, 858, 58, 32)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-4, 87), new Point(28, 16), 0, new Rectangle(966, 858, 56, 32)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-5, 87), new Point(29, 15), 0, new Rectangle(60, 902, 58, 30)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-2, 31), new Point(38, 79), 0, new Rectangle(786, 0, 76, 158)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-2, 31), new Point(38, 79), 0, new Rectangle(710, 0, 76, 158)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-2, 34), new Point(31, 69), 0, new Rectangle(0, 352, 62, 138)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-2, 39), new Point(38, 71), 0, new Rectangle(262, 208, 76, 142)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-5, 38), new Point(35, 69), 0, new Rectangle(546, 208, 70, 138)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-1, 37), new Point(33, 69), 0, new Rectangle(954, 208, 66, 138)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-2, 38), new Point(33, 70), 0, new Rectangle(480, 208, 66, 140)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-1, 37), new Point(33, 68), 0, new Rectangle(130, 352, 66, 136)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-1, 36), new Point(34, 69), 0, new Rectangle(820, 208, 68, 138)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-1, 36), new Point(34, 69), 0, new Rectangle(752, 208, 68, 138)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-3, 36), new Point(39, 74), 0, new Rectangle(934, 0, 78, 148)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-2, 36), new Point(33, 69), 0, new Rectangle(888, 208, 66, 138)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(1, 35), new Point(35, 72), 0, new Rectangle(0, 208, 70, 144)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(2, 39), new Point(37, 70), 0, new Rectangle(338, 208, 74, 140)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-1, 37), new Point(34, 68), 0, new Rectangle(62, 352, 68, 136)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-4, 35), new Point(34, 70), 0, new Rectangle(412, 208, 68, 140)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-3, 85), new Point(29, 17), 0, new Rectangle(734, 858, 58, 34)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-1, 36), new Point(34, 69), 0, new Rectangle(616, 208, 68, 138)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-1, 32), new Point(34, 69), 0, new Rectangle(684, 208, 68, 138)));
            AddAnimationState("Leg", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-74, 28), new Point(74, 56), 0, new Rectangle(598, 352, 148, 112)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-73, 35), new Point(60, 47), 0, new Rectangle(622, 594, 120, 94)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-60, 39), new Point(96, 71), 0, new Rectangle(70, 208, 192, 142)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-60, 18), new Point(68, 63), 0, new Rectangle(332, 352, 136, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-64, 21), new Point(65, 62), 0, new Rectangle(468, 352, 130, 124)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-60, 18), new Point(68, 63), 0, new Rectangle(196, 352, 136, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-76, 33), new Point(66, 43), 0, new Rectangle(340, 692, 132, 86)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-63, 27), new Point(64, 46), 0, new Rectangle(826, 594, 128, 92)));
            AddAnimationState("Weapon/Blade2H", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-74, 23), new Point(60, 32), 0, new Rectangle(306, 784, 120, 64)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-74, 30), new Point(61, 41), 0, new Rectangle(590, 692, 122, 82)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-76, 20), new Point(69, 52), 0, new Rectangle(0, 490, 138, 104)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-73, 23), new Point(59, 46), 0, new Rectangle(0, 692, 118, 92)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-76, 24), new Point(59, 49), 0, new Rectangle(792, 490, 118, 98)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-79, 40), new Point(67, 52), 0, new Rectangle(138, 490, 134, 104)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-74, 24), new Point(59, 42), 0, new Rectangle(472, 692, 118, 84)));
            AddAnimationState("Weapon/Mace", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(35, 19), new Point(19, 22), 0, new Rectangle(44, 858, 38, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(35, 20), new Point(21, 25), 0, new Rectangle(530, 784, 42, 50)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(35, 33), new Point(26, 36), 0, new Rectangle(148, 784, 52, 72)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(39, 24), new Point(26, 26), 0, new Rectangle(426, 784, 52, 52)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(30, 26), new Point(27, 33), 0, new Rectangle(200, 784, 54, 66)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(33, 29), new Point(26, 33), 0, new Rectangle(254, 784, 52, 66)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(31, 24), new Point(32, 36), 0, new Rectangle(84, 784, 64, 72)));
            AddAnimationState("Weapon/Tambourine", _local_1);
        }

    }
}//package hbm.Game.Character.Customizations

