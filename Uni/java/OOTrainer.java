public class OOTrainer extends Teacher {

    //super constructor
    public OOTrainer(String name, char gender, int age) {
        super(name, gender, age);
    }

    /*
    OOTrainers can teach subjects with specialism 3, they can also teach the same subjects as teachers
    therefore if the specialism isnt 3, it checks if a teacher can teach the subject
     */
    public boolean canTeach(Subject subject) {
        if (subject.getSpecialism() == 3) {
            return true;
        } else {
            return super.canTeach(subject);
        }
    }
}