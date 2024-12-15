package helpers;

import com.github.javafaker.Faker;

public class dataGenerator {
    public static String getRandomEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0,10) + "@te.com";
        return email;
    }

    public static String getRandomUsername(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    public String getRandomUsername2(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }
}
