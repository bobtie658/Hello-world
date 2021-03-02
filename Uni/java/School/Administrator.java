import java.util.*; //used for random number generator

public class Administrator {
    private School school; //school the adminsitrator works for

    //a school is needed to asign to the administrator
    public Administrator (School school) {
        this.school = school;
    }

    /*
    run method is used to run a simulation of a single day at the school
    in the morning, anywhere from 0-2 students can join the school
    there is a chance new instructors of each type can join
    in the afternoon, the day is run, courses run and are deleted
    in the evening, all unassigned instructors have a 20% chance of leaving the school
    any student who has completed all courses will leave, any student who is not on a course has a 5% chance of leaving
     */
    public void run() {
        Generator generator = new Generator(); //generator is a class used to create a random name and gender
        Random rand = new Random();
        for (int a = rand.nextInt(2); a>-1; a--) { //for statement adds a random number of students
            //i used my generator for the names and gender, the age of the student can be between 17 and 75
            school.addStudent(new Student(generator.generateName(), generator.generateGender(), rand.nextInt(58)+18));
        }

        //the age of instructors can be between 25 and 75
        if (rand.nextInt(20) < 4) { //checks if a teacher is added
            school.addInstructor(new Teacher(generator.generateName(),generator.generateGender(), rand.nextInt(50)+26));
        }
        if (rand.nextInt(20) < 2) { //checks if a demonstrator is added
            school.addInstructor(new Demonstrator(generator.generateName(),generator.generateGender(), rand.nextInt(50)+26));
        }
        if (rand.nextInt(20) < 1) { //checks if a GUITrainer is added
            school.addInstructor(new GUITrainer(generator.generateName(),generator.generateGender(), rand.nextInt(50)+26));
        }
        if (rand.nextInt(20) < 1) { //checks if a OOTrainer is added
            school.addInstructor(new OOTrainer(generator.generateName(),generator.generateGender(), rand.nextInt(50)+26));
        }

        school.aDayAtSchool();

        //goes through each instructor, checks if they are assigned a course
        //if they arent, there is a 20% chance they will leave
        for (Instructor instructor : school.getInstructors()) {
            if (instructor.getAssignedCourse().length == 0 && rand.nextInt(5) == 0) { //checks if they have a course assigned
                school.removeInstructor(instructor);
            }
        }

        //goes through each student, if they have every certificate for each subject they leave
        //if they are not in a course, they have a 5% chance of leaving
        for (Student student : school.getStudents()) {
            //if a student has the same number of certificates as there are subjects, they must have completed them all
            if (student.getCertificates().size() == school.getSubjects().length) {
                school.removeStudent(student);
            }
            //checks if the student isnt on a course, they then have a 5% chance of leaving
            else if (student.getCourse().length == 0 && rand.nextInt(20) == 0) {
                school.removeStudent(student);
            }
        }
    }

    //completes the run method the inputted number of times
    public void run(int days) {
        for (int x = days; x>0; x--) {
            run();
            System.out.println(school.toString()); //prints out the details of the school after each day
        }
    }

    //main method takes args, seperates them and sends it to run which actually runs the simulation
    public static void main(String[] args) {
        try {
            String fileName = args[0]; //filename takes the first argument
            int number = Integer.parseInt(args[1]); //takes the number from the second argument
            new Run(fileName, number); //starts run with a filename and number
        } catch(Exception e) {
            System.out.println("Please use arguments in the format 'java Administrator [config filename] [number of days to run simulation]'");
        }
    }
}