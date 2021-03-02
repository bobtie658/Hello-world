import java.util.*;

// abstract class instructor is used as a superclass for all other instructors
public abstract class Instructor extends Person {
    protected ArrayList<Course> assignedCourse = new ArrayList<Course>(); //stores the course the instructor is currently on

    //super constructor
    public Instructor(String name, char gender, int age) {
        super(name,gender,age);
    }

    //assigns the instructor a course
    public void assignCourse(Course course) {
        assignedCourse.add(course);
    }

    //removes the inputted course from the courses the instructor is teaching
    public void unassignCourse(Course course) {
        assignedCourse.remove(course);
    }

    //accessor for the assigned courses array
    public Course[] getAssignedCourse() {
        return assignedCourse.toArray(new Course[assignedCourse.size()]);
    }

    //abstract method other instructors each have courses they can teach
    public abstract boolean canTeach(Subject subject);

    //toString returns a pretty print string of all of the information about the instructor
    public String toString() {
        String string; //string is the variable which holds the information
        string = "Name: " + getName(); //name of the instructor is added
        string = string + ", Gender: " + getGender(); //gender is added to the string
        string = string + ", Age: " + getAge(); //age is added to the string
        string = string + ", Instructor type: " + getClass().getSimpleName(); //what type of instructor is added
        string = string + ", Courses asigned: ";
        if (getAssignedCourse() == null) {
            string = string + "None\n"; //if the instructor doesnt have a course asigned, it will return none
        } else {
            for (Course course : getAssignedCourse())
                string = string + course.getSubject().getDescription() + "  "; //adds the description of the course
        }
        return string + "\n";
    }

}