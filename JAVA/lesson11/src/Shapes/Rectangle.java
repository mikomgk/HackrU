package Shapes;

public class Rectangle extends Shape {
    private double base;
    private double height;

    public Rectangle() {
        this.base = 0;
        this.height = 0;
    }

    public Rectangle(double base, double height) {
        this.base = base;
        this.height = height;
    }
    public Rectangle(Rectangle r) {
        this.base = r.base;
        this.height = r.height;
    }

    public double getBase() {
        return base;
    }

    public void setBase(double base) {
        this.base = base;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    @Override
    public double getArea() {
        return height * base / 2;
    }

    @Override
    public String toString() {
        return "Rectangle{" +
                "base=" + base +
                ", height=" + height +
                '}';
    }
}
