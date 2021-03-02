//new instructors can become teachers or its subclasses
public class Teacher extends Instructor {

    //super constructor
    public Teacher(String name, char gender, int age) {
        super(name, gender, age);
    }

    //the techer can teach specialisms 1 or 2
    public boolean canTeach(Subject subject) {
        if (subject.getSpecialism() == 1 || subject.getSpecialism() == 2) {
            return true;
        } else {
            return false;
        }
    }
}
