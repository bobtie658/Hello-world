import java.util.*; //importing arrays
import java.io.*; //importing file reader and buffered reader

//run is used by administrator to extract infomation from config files and add it to a school
public class Run {
    Administrator admin;
    School school;
    BufferedReader reader; //bufferedreader object used to read config file

    //constructor is used by the main method in order to start reading from the config file
    public Run(String fileName, int repeats) {
        try{
            //attempts to create buffered reader using filename from command line
            reader = new BufferedReader(new FileReader(fileName));
        } catch (Exception IOExeption) {
            System.out.println("config file not found");
            System.exit(0); //if the file name was invalid, the program shuts down
        }
        simulation(repeats); //starts the simulation method which reads the config file
    }

    //isready is used to check if the next line of the file can be read
    private boolean isReady() {
        try{
            return reader.ready(); //uses the ready method to check if the file can continue to be read
        } catch(Exception IOException) {
            System.out.println("IOExeption in isReady()");
            return false;
        }
    }

    //getline is ued to retrieve the next line from the config file
    private String getLine() {
        try {
            return reader.readLine();
        } catch(Exception IOException) {
            System.out.println("failure reading config file");
            System.exit(0);
            return "";
        }
    }

    //searchschool is used in order to search the config file to find the school name
    private String searchSchool() {
        String schoolName;
        try {
            reader.mark(10000); //marks the current position in the config file to return to later
        } catch(Exception IOException) {
            System.out.println("IOExeption when searching");
        }
        while (isReady()) { //repeats for every line in the config file
            String nextLine = getLine(); //sets current line to nextline
            if (nextLine.split(":",2)[0].equals("school")) { //checks if the current line contains the school name
                schoolName = nextLine.split(":",2)[1]; //school name is saved
                try {
                    reader.reset(); //resets the current line to the one designated by mark
                } catch(Exception IOException) {
                    System.out.println("IOException when searching");
                }
                return schoolName; //returns the name of the school
            }
        }
        System.out.println("search unsuccessful"); //returns if the school name was not found in the config files
        System.exit(0); //exits the program as it cannot continue without the school
        return schoolName = "";
    }

    /*
    these newObject methods are all very similar, each creating a new object and addint them to the school
    firstly they take the string input, which should be in the form "name,gender,age" for students and instructors
    or "description,subjectID,specialisationID,duration" for subjects, and the splits it at every "," to create an array
    element of each array are then added to a constructor adding a new object to the school
     */
    private void newStudent(String string) {
        String[] stringArray = string.split(",",3);
        school.addStudent(new Student(stringArray[0],stringArray[1].charAt(0),Integer.parseInt(stringArray[2])));
    }

    private void newTeacher(String string) {
        String[] stringArray = string.split(",",3);
        school.addInstructor(new Teacher(stringArray[0],stringArray[1].charAt(0),Integer.parseInt(stringArray[2])));
    }

    private void newDemonstrator(String string) {
        String[] stringArray = string.split(",",3);
        school.addInstructor(new Demonstrator(stringArray[0],stringArray[1].charAt(0),Integer.parseInt(stringArray[2])));
    }

    private void newOOTrainer(String string) {
        String[] stringArray = string.split(",",3);
        school.addInstructor(new OOTrainer(stringArray[0],stringArray[1].charAt(0),Integer.parseInt(stringArray[2])));
    }

    private void newGUITrainer(String string) {
        String[] stringArray = string.split(",",3);
        school.addInstructor(new GUITrainer(stringArray[0],stringArray[1].charAt(0),Integer.parseInt(stringArray[2])));
    }

    private void newSubject(String string) {
        String[] stringArray = string.split(",",4);
        school.addSubject(new Subject(Integer.parseInt(stringArray[1]),Integer.parseInt(stringArray[2]),Integer.parseInt(stringArray[3]),stringArray[0]));
    }


    private void simulation(int repeats) {
        //the name of the school is searched for in the config file, it is then used to create a new school
        String schoolName = searchSchool();
        school = new School(schoolName);

        while(isReady()) { //repeats the while statment while there is a next line in the config file
            String a = getLine(); //gets the next line of the config file

            //takes the portion to the left of the : which is expected to be what is added to the school
            String b = (a.split(":",2))[0];

            //takes the portion to the right of the : which is expected to be details about the object added
            String c = (a.split(":",2))[1];

            //checks for each object type using b and adds the object using c
            //if the line does not contain any objects to add, it will skip the line
            if(b.equals("subject")) {
                newSubject(c);
            } else if(b.equals("student")) {
                newStudent(c);
            } else if(b.equals("Teacher")) {
                newTeacher(c);
            } else if(b.equals("Demonstrator")) {
                newDemonstrator(c);
            } else if(b.equals("OOTrainer")) {
                newOOTrainer(c);
            } else if(b.equals("GUITrainer")) {
                newGUITrainer(c);
            }
        }
        //updates the admin so that it runs on this school
        admin = new Administrator(school);

        //repeats the run(int) method with the admin
        admin.run(repeats);
    }
}