package com.company;

public class Circle extends Shape {
    private Point center;
    private int radius;


    public Circle(int x, int y, int radius) {
        setCenter(new Point(x, y));
        setRadius(radius);
    }

    public Circle(Point center, int radius) {
        setCenter(center);
        setRadius(radius);
    }

    public Circle(Circle c) {
        this(c.center, c.radius);
    }

    @Override
    public void paint(boolean[][] canvas) {
        super.paint(canvas);
    }

    public int getX() {
        return center.getX();
    }

    public void setX(int x) {
        if (x < 0)
            return;
        this.center.setX(x);
    }

    public int getY() {
        return center.getY();
    }

    public void setY(int y) {
        if (y < 0)
            return;
        this.center.setY(y);
    }

    public int getRadius() {
        return radius;
    }

    public void setRadius(int radius) {
        this.radius = radius;
    }

    public Point getCenter() {
        return new Point(center);
    }

    public void setCenter(Point center) {
        if (center.getX() < 0 || center.getY() < 0)
            return;
        this.center = new Point(center);
    }

    @Override
    public String toString() {
        return center.toString() + " radius=" + radius;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null)
            return false;
        if (this == obj)
            return true;
        if (obj instanceof Circle) {
            Circle other = (Circle) obj;
            return this.center.equals(other.center) && this.radius == other.radius;
        }
        return false;
    }
}
