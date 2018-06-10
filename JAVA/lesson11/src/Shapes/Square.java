package Shapes;

public class Square extends Shape {
    private double width;
    private double height;

    public Square() {
        this.width = 0;
        this.height = 0;
    }

    public Square(double width, double height) {
        this.width = width;
        this.height = height;
    }

    public Square(Square s) {
        this.width = s.width;
        this.height = s.height;
    }

    public double getWidth() {
        return width;
    }

    public void setWidth(double width) {
        this.width = width;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    @Override
    public double getArea() {
        return width * height;
    }

    @Override
    public String toString() {
        return "Square{" +
                "width=" + width +
                ", height=" + height +
                '}';
    }
}
