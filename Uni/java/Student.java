import java.util.*; //used to get arraylists

public class Student extends Person {
    private ArrayList<Integer> certificates = new ArrayList<Integer>(); //arraylist containing all of the subjects the student has completed
    private ArrayList<Course> course = new ArrayList<Course>();

    //constructor uses the constructor for person
    public Student(String name, char gender, int age) {
        super(name, gender, age);
    }

    // adds a subject to the list of subjects the student has completed
    public void graduate(Subject subject) {
        certificates.add(subject.getID());
        for (Course course : getCourse()) { //checks every course if it matches the subject
            if (course.getSubject() == subject) {
                resetCourse(course); //the student leaves the course with the subject they they graduated
            }
        }
    }

    //accessor for subjects the student has completed and for the course currently doing
    public ArrayList<Integer> getCertificates() {
        return certificates;
    }

    //accessor for an array of the courses the student is enrolled in
    public Course[] getCourse() {
        return course.toArray(new Course[course.size()]);
    }

    //checks if the student has completed the course before
    public boolean hasCertificate(Subject subject) {
        return certificates.contains(subject.getID());
    }

    //adds a course to the list of courses the student is doing
    public void assignCourse(Course course) {
        this.course.add(course);
    }

    //removes the inputted course from the list of courses the student is attending
    public void resetCourse(Course course) {
        this.course.remove(course);
    }

    //returns an arraylist containing the ids of the courses the student is enroled in
    public ArrayList<Integer> courseIDs() {
        ArrayList<Integer> ids = new ArrayList<Integer>();
        for (Course course : getCourse()) {
            ids.add(course.getSubject().getID());
        }
        return ids;
    }

    //toString method is used to return a pretty print string with all the important information about the student
    public String toString() {
        String string; //a string is created to hold the information about the student
        string = "Name: " + getName(); //the name is added to the string
        string = string + ", Gender: " + getGender(); //gender is added
        string = string + ", Age: " + getAge(); //age is added
        string = string + ", Courses enroled: ";
        if (getCourse().length == 0) {
            string = string + "None"; //returns none if the student is not enroled into a course
        } else {
            for (Course course : getCourse())
                string = string + course.getSubject().getDescription() + "  "; //adds the subject description if theyre in a course
        }
        string = string + ", Certificates: ";
        if (getCertificates().size() == 0) {
            string = string + "None"; //displays none if the student has no certificates
        }
        for (Integer id : getCertificates().toArray(new Integer[getCertificates().size()])) {
            string = string + id + " "; //adds each id of each course completed
        }
        return string + "\n";
    }
}