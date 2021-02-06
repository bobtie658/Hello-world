public class Demonstrator extends Instructor {

    //super constructor
    public Demonstrator(String name, char gender, int age) {
        super(name, gender, age);
    }

    //the Demonstrator can teach specialism 2
    public boolean canTeach(Subject subject) {
        if (subject.getSpecialism() == 2) {
            return true;
        } else {
            return false;
        }
    }
}