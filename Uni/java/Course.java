import java.util.*;

public class Course {
    private Subject subject; //the subject the course will cover
    private int daysUntilStarts; //the number of days until the course will start
    private int daysToRun; //the number of days left for the course to run
    private ArrayList<Student> students = new ArrayList<Student>(); //arraylist of students on the course, max 3
    private Instructor instructor; //stores which instructor is currently teaching the course
    private boolean cancelled = false;

    //constructor for the subject and the number of days until the course starts
    public Course(Subject subject, int daysUntilStarts) {
        this.subject = subject;
        this.daysUntilStarts = daysUntilStarts;
        daysToRun = subject.getDuration(); //the days to run is taken from the subject
    }

    //accessor for the subject
    public Subject getSubject() {
        return subject;
    }

    /*
    if the course hasnt started yet, it will return minus the number of days until it starts
    if it has started, it returns the number of days left
    if it has started and finished, it returns 0
    */
    public int getStatus() {
        if (daysUntilStarts > 0) {
            return -daysUntilStarts;
        }else if(daysToRun > 0) {
            return daysToRun;
        }else {
            return 0;
        }
    }

    /*
    aDayPasses is used to decrease the number of days left till the course by 1
    if the course has started, it decreases the number of days left on the course
    if the number of days left till the course starts is 0 and there are no students or instructors
    the course will be canceled and the students and instructor will be removed from the course
     */
    public void aDayPasses() {
        if (getStatus() < 0) { //counting down the days til the course starts
            daysUntilStarts = daysUntilStarts - 1;

            if (daysUntilStarts == 0 && (!hasInstructor() || (getSize() == 0))) {
                if (hasInstructor()) { //unassigns the instructor if there is one assigned
                    instructor.unassignCourse(this);
                }
                cancelled = true;
                for (Student a : getStudents()) {
                    a.resetCourse(this);
                }
                students = new ArrayList<Student>();
                instructor = null;
            }
        }
        else if (getStatus() > 0) { //course has started
            daysToRun = daysToRun - 1;
        }
        if (getStatus() == 0) { //course has finished
            for (Student a : getStudents()) {
                a.graduate(getSubject());
            }
            cancelled = true;
            instructor.unassignCourse(this);
        }
    }

    /*
    the student is enrolled if the course hasnt started and if there is enough space whithin the course
    the student will also not be enrolled if they are currently on another course, or if the course is cancelled
    returns true if the student is enrolled successfully and false if it fails for any reason
    the student will not be enroled if they are currently on 3 other courses
    or if they are already on a course for this subject
     */
    public boolean enrolStudent(Student student) {
        if (getStatus() < 0 && getSize() < 3 && !(student.courseIDs().contains(getSubject().getID())) && student.getCourse().length < 3 && !student.hasCertificate(subject)) {
            student.assignCourse(this);
            return students.add(student);
        } else {
            return false;
        }
    }

    //returns the number of students in the course
    public int getSize() {
        return students.size();
    }

    //returns an array containing all of the students on the course
    public Student[] getStudents() {
        return students.toArray(new Student[students.size()]);
    }

    /*
    used to set the current instructor
    the instructor will not be set if they cant teach the current subject, are teaching another course
    if this course has been cancelled or if the course has started
    if the instructor is set, it returns true, if it fails for any reason, false
    no instructor will be set if the course already has an instructor
    also the instructor must be teaching less then 2 other courses
     */
    public boolean setInstructor(Instructor instructor) {
        if (!hasInstructor() && instructor.canTeach(getSubject()) && instructor.getAssignedCourse().length < 2 && !isCancelled() && getStatus() < 0) {
            this.instructor = instructor;
            instructor.assignCourse(this);
            return true;
        } else {
            return false;
        }
    }

    //checks if the course has an instructor assigned to it
    public boolean hasInstructor() {
        if (instructor == null) {
            return false;
        } else {
            return true;
        }
    }

    //accessor for the instructor
    public Instructor getInstructor() {
        return instructor;
    }

    //is used to tell if the course has been cancelled or not
    public boolean isCancelled() {
        return cancelled;
    }

    //returns a pretty print string holding all of the information about the course
    public String toString() {
        String string; //string holds the information
        string = "Course subject description: " + getSubject().getDescription(); //adds the description of the subject
        string = string + ", Course subject ID: " + getSubject().getID(); //adds the id of the subject of the course
        string = string + ", Course status: " + getStatus(); //returns how long til or left of the course
        string = string + ", Course instructor: ";
        if (getInstructor() == null) { //if there isnt an instructor, add none
            string = string + "None";
        } else {
            string = string + getInstructor().getName(); //adds the name of the instructor to the string
        }
        string = string + ", Course students: ";
        if (getStudents().length == 0) {
            string = string + "None"; //if there are no students, add none
        } else {
            for (Student student : getStudents()) {
                string = string + student.getName() + "  "; //all students names are added
            }
        }
        return string + "\n";
    }
}