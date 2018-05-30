package com.company;

public class Main {

    public static void main(String[] args) {
//        Dog donald=new Dog("Donald",3,"Boxer");
//        Dog rexy=new Dog("Rexy",5,"Lavrador");
//        Dog ralf=new Dog("Ralph",13,"Pug");
//        donald.bark();
//        Dog micky=rexy;
//        micky.bark();
//        System.out.println(donald.equals(rexy));
//        System.out.println(micky.equals(rexy));

        ArrayList a = new ArrayList();
        System.out.println(a.get(1));
        System.out.println(a.size());
        System.out.println(a.indexOf(2));
        System.out.println(a.toString());
        a.add(5);
        a.add(2);
        a.addAt(0, 8);
        a.set(1,354);
        System.out.println(a.toString());
        System.out.println(a.size());
        a.removeAt(1);
        System.out.println(a.toString());
        System.out.println(a.size());
        System.out.println(a.get(2));
    }
}
