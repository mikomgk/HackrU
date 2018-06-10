package com.company;

import Shapes.*;

public class Main {

    public static void main(String[] args) {
        Shape[] shapes = {new Rectangle(2, 5), new Square(5, 5), new Circle(5, 2, 10), new Circle(10, 10, 50), new Square
                (50, 10),new Rectangle(50,20)};
        System.out.println(maxAreaShape(shapes));
    }

    public static Shape maxAreaShape(Shape[] shapes){
        Shape maxAreaShape=shapes[0];
        for(Shape shape:shapes){
            if(shape.getArea()>maxAreaShape.getArea())
                maxAreaShape=shape;
        }
        if(maxAreaShape instanceof Circle)
            return new Circle((Circle)maxAreaShape);
        if(maxAreaShape instanceof Rectangle)
            return new Rectangle((Rectangle)maxAreaShape);
        if(maxAreaShape instanceof Square)
            return new Square((Square)maxAreaShape);
        return new Shape();
    }
}
