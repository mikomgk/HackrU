package com.company;

public class Point4D extends Point3D {
    int a;

    public Point4D(int x, int y, int z, int a) {
        super(x, y, z);
        this.a = a;
    }

    public int getA() {
        return a;
    }

    public void setA(int a) {
        this.a = a;
    }

    @Override
    protected String extendToString() {
        return super.extendToString() + "," + a;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null)
            return false;
        if (this == obj)
            return true;
        if (obj instanceof Point) {
            Point4D other=(Point4D)obj;
            return super.equals(other) && this.a == other.a;
        }
        return false;
    }
}
