public class GUITrainer extends Teacher {

    //super constructor
    public GUITrainer(String name, char gender, int age) {
        super(name, gender, age);
    }

    /*
    GUITrainers can teach subjects with specialism 4, they can also teach the same subjects as teachers
    therefore if the specialism isnt 4, it checks if a teacher can teach the subject
     */
    public boolean canTeach(Subject subject) {
        if (subject.getSpecialism() == 4) {
            return true;
        } else {
            return super.canTeach(subject);
        }
    }
}