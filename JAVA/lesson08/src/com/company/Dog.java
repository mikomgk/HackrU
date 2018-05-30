package com.company;

public class Dog {
    String name;
    int age;
    String breed;

    public Dog(String name, int age, String race) {
        this.name = name;
        this.age = age;
        this.breed = race;
    }

    public void bark() {
        System.out.println(name + " WAF WAF!!!");
    }

    public boolean equals(Dog other){
        if(this.name.equals(other.name)&&this.age==other.age&&this.breed.equals(other.breed))
            return true;
        return false;
    }
}
