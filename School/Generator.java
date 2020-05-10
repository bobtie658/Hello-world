import java.util.Random;

//name generator class is ued to generate random names and genders
//originally it generated a random first name and surname, however it became difficult to read in toString()
//so it now only generates a first name
public class Generator {

    public String generateName() {
        Random rand = new Random();
        //24 possible options for a gender neutral first name
        String[] fName = {"Sam","Alex","Jordan","Quinn","Charlie","Elliot","Morgan","Ali","Billy","Cameron","Cody","Drew","Eden","Erin","Frankie","Glen","Harley","Hunter","Jamie","Lee","Nico","Robin","Corrin","Riley"};

        //generates a random first name
        return (fName[rand.nextInt(24)]);
    }

    //used to generate a random generator
    public char generateGender() {
        Random rand = new Random();
        if (rand.nextBoolean()) { //50 50 chances of being a male or female
            return 'M';
        } else {
            return 'F';
        }
    }
}
