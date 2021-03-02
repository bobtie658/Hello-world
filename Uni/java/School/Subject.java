public class Subject {
    private int id; //unique id of subject
    private int specialism; //which teachers can teach this subject
    private int duration; //how many days the subject lasts
    private String description; //the description of the subject

    //constructor for setting the id, specialisn and duration of the subject
    public Subject(int id, int specialism, int duration, String description) {
        this.id = id;
        this.specialism = specialism;
        this.duration = duration;
        this.description = description;
    }

    //second constructor for if the user does not supply a description
    public Subject(int id, int specialism, int duration) {
        this.id = id;
        this.specialism = specialism;
        this.duration = duration;
    }

    //accessor methods used to return various parts of the subject
    public int getID() {
        return id;
    }

    public int getSpecialism() {
        return specialism;
    }

    public int getDuration() {
        return duration;
    }

    public String getDescription() {
        return description;
    }

    //setter for the description
    public void setDescription(String description) {
        this.description = description;
    }

    //returns a pretty print string of the subject
    public String toString() {
        String string; //string holds the information about the subject
        string = "Subject description: " + getDescription(); //the description of the subject is added
        string = string + ", Subject ID: " + getID(); //the subject id is added
        string = string + ", Subject specialism: " + getSpecialism(); //the required specialism is added
        return string + ", Subject duration in days: " + getDuration() + "\n"; //the duration of the course is added
    }
}
