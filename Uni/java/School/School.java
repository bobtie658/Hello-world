import java.util.*;

public class School {
    private String name; //name of the school
    private ArrayList<Student> students = new ArrayList<Student>(); //all students at the school
    private ArrayList<Subject> subjects = new ArrayList<Subject>(); //all subjects at the school
    private ArrayList<Course> courses = new ArrayList<Course>(); //all courses at the school
    private ArrayList<Instructor> instructors = new ArrayList<Instructor>(); //all instructors at the school

    //constructs the school requiring name input
    public School(String name) {
        this.name = name;
    }


    //adder methods for all of the objects, these add the object to their respective araylists
    public boolean addStudent(Student student) {
        if (!students.contains(student)) {
            return students.add(student);
        } else {
            return false;
        }
    }

    public boolean addInstructor(Instructor instructor) {
        if (!instructors.contains(instructor)) {
            return instructors.add(instructor);
        } else {
            return false;
        }
    }

    public boolean addCourse(Course course) {
        if (!courses.contains(course)) {
            return courses.add(course);
        } else {
            return false;
        }
    }

    public boolean addSubject(Subject subject) {
        if (!subjects.contains(subject)) {
            return subjects.add(subject);
        } else {
            return false;
        }
    }

    //remover methods removes an object from their arraylist if it is there
    public boolean removeStudent(Student student) {
        return students.remove(student);
    }

    public boolean removeInstructor(Instructor instructor) {
        return instructors.remove(instructor);
    }

    public boolean removeCourse(Course course) {
        return courses.remove(course);
    }

    public boolean removeSubject(Subject subject) {
        return subjects.remove(subject);
    }

    //getter methods return an array of all the elements in the arraylist
    public Student[] getStudents() {
        return students.toArray(new Student[students.size()]);
    }

    public Instructor[] getInstructors() {
        return instructors.toArray(new Instructor[instructors.size()]);
    }

    public Course[] getCourses() {
        return courses.toArray(new Course[courses.size()]);
    }

    public Subject[] getSubjects() {
        return subjects.toArray(new Subject[subjects.size()]);
    }


    /*
    used to return a pretty-print string of all of the objects within the school
    uses the toString() methods of the other classes to return a full description of the school
    */
    public String toString() {
        String status; //all of the information about the school are stored in status
        status = "School:\n" + name +"\n\n";

        status = status + "Students:\n";
        if (getStudents().length == 0){
            status = status + "None\n"; //displays none if there are no students
        } else {
            for (Student student : getStudents()) { //students are added
                status = status + student.toString();
            }
        }

        status = status + "\n"; //gaps are added between different objects to make it easier to read
        status = status + "Instructors:\n";
        if (getInstructors().length == 0) {
            status = status + "None\n"; //displays none if there are no instructors
        } else {
            for (Instructor instructor : getInstructors()) { //instructors are added
                status = status + instructor.toString();
            }
        }

        status = status + "\n";
        status = status + "Subjects:\n";
        if (getSubjects().length == 0) {
            status = status + "None\n"; //displays none if there are no subjects
        } else {
            for (Subject subject : getSubjects()) { //subjects are added
                status = status + subject.toString();
            }
        }

        status = status + "\n";
        status = status +"Courses:\n";
        if (getCourses().length == 0) {
            status = status + "None\n"; //displays none if there are no courses
        } else {
            for (Course course : getCourses()) { //courses are added
                if (!course.isCancelled()) { //doesnt include cancelled courses
                    status = status + course.toString();
                }
            }
        }
        return status + "\n";
    }

    /*
    aDayAtSchool is used to simulate a single day at school
    new courses are created for all of the subjects which dont currently have a course that is joinable
    an instructor is assigned to any courses without one
    students are enroled into courses that are not already full and they havent already completed
    a day passes
    all of the completed and cancelled courses are deleted
     */
    public void aDayAtSchool() {
        ArrayList<Subject> newCourses = new ArrayList<Subject>(subjects); //variable is used to store subjects which need a course
        for (Course course : getCourses()) {
            if (!(course.isCancelled()) && course.getStatus() < 0) { //selects courses which havent started yet
                newCourses.remove(course.getSubject()); //removes all of the subjects which are joinable
            }
        }
        for (Subject subject : newCourses.toArray(new Subject[newCourses.size()])) {
            addCourse(new Course(subject,2)); //creates a new course for each of the subjects which dont have a joinable course
        }
        for (Course course : getCourses()) {
            if (!(course.isCancelled()) && course.getStatus() < 0) { //cycles through all courses which havent started
                if (!course.hasInstructor()) { //checks if the course has an instructor already
                    for (Instructor instructor : getInstructors()) {
                        //setInstructor goes through every sets each possible instructor, until it stops at the last one
                        course.setInstructor(instructor);
                    }
                }
                //if statement checks if course is full (enrolStudent checks aswell, this just optimises the process)
                if (course.getSize() < 3) {
                    for (Student student : getStudents()) {
                        course.enrolStudent(student); //adds new students to the course, unless it becomes full
                    }
                }
            }
            course.aDayPasses();
            if (course.isCancelled()) {
                courses.remove(course); //removes completed or cancelled courses
            }
        }
    }
}