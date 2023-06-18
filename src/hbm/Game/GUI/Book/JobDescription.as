


//hbm.Game.GUI.Book.JobDescription

package hbm.Game.GUI.Book
{
    import org.aswing.tree.DefaultMutableTreeNode;

    public class JobDescription extends DefaultMutableTreeNode 
    {

        public function JobDescription(_arg_1:String, _arg_2:int, _arg_3:int)
        {
            super({
                "name":_arg_1,
                "clothes":_arg_2,
                "jobId":_arg_3
            });
        }

        override public function toString():String
        {
            return (this.Name);
        }

        public function get JobId():int
        {
            return (getUserObject().jobId);
        }

        public function get Name():String
        {
            return (getUserObject().name);
        }

        public function get Clothes():int
        {
            return (getUserObject().clothes);
        }


    }
}//package hbm.Game.GUI.Book

