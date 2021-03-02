public class Person {
    protected String name; //name of the person
    protected char gender; //the person's gender in a single character
    protected int age; //the age of the person in years

    //constructor for the name, gender and age of the person
    public Person(String name, char gender, int age) {
        this.name = name;
        this.gender = gender;
        this.age = age;
    }

    //accessors used to return parts of the person's information
    public String getName() {
        return name;
    }

    public char getGender() {
        return gender;
    }

    public int getAge() {
        return age;
    }

    //another setter for the age, incase the person becomes older
    public void setAge(int age) {
        this.age = age;
    }
}