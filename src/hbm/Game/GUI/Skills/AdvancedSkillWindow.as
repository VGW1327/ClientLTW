


//hbm.Game.GUI.Skills.AdvancedSkillWindow

package hbm.Game.GUI.Skills
{
    import org.aswing.geom.IntDimension;

    public class AdvancedSkillWindow extends SkillWindow 
    {

        public function AdvancedSkillWindow(_arg_1:Boolean=true)
        {
            super(_arg_1);
        }

        override protected function get SizeBG():IntDimension
        {
            return (new IntDimension(480, 416));
        }

        override protected function get WidthWindow():int
        {
            return (470);
        }

        override protected function get HeightWindow():int
        {
            return (427);
        }


    }
}//package hbm.Game.GUI.Skills

