*University coursework*
creating a simulation of a school


In order to run using a configuration file, place it within the same directory as the rest of the files
To use program, run administrator followed by the filename of the config file and then number of days to simulate
eg. java Administrator config.txt 20

When constructing a config file, make sure that there is a school name somewhere in the file
you can place the subject, students and instructors in any order at any point in the file
Do not use any spaces, except in names and descriptions

I made the generator class with the express purpose of generating new names and genders for students and instructors who join during the simulation
The run class was created in order to allow the user to execute the simulation from command console, however I changed it so administrator now runs it

In part 6, i didnt read the whole part before continuing, therefore I did all of the reading from files inside of the run class
I solved this problem by having the main method of administrator to just call on run

For the extension I made it so that the students can be enrolled up to on 3 different courses at the same time and instructors can teach up to 2 courses
I also made it so that the student will not join two courses which are teaching the same subject
I did this by changing the way the student and instructor store courses, they are now stored in an arraylist
This means that the instructor unassignCourse method now requires a course input instead of nothing

ALL OF MY READING FROM CONFIGURATION CODE IS IN RUN.JAVA
