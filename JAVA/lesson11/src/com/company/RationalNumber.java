package com.company;

public class RationalNumber extends Number {

    private int numerator;//mone
    private int denominator;//mehane


    public RationalNumber(int numerator, int denominator) {
        setNumerator(numerator);
        setDenominator(denominator);
    }

    public int getNumerator() {
        return numerator;
    }

    public void setNumerator(int numerator) {
        this.numerator = numerator;
    }

    public int getDenominator() {
        return denominator;
    }

    public void setDenominator(int denominator) {
        if (denominator == 0)
            return;
        this.denominator = denominator;
    }

    @Override
    public int intValue() {
        return numerator / denominator;
    }

    @Override
    public long longValue() {
        return intValue();
    }

    @Override
    public float floatValue() {
        return numerator / (float) denominator;
    }

    @Override
    public double doubleValue() {
        return numerator / (double) denominator;
    }

    @Override
    public String toString() {
        return numerator + "/" + denominator;
    }

    public void add(RationalNumber num) {
        setNumerator(this.numerator * num.denominator + this.denominator * num.numerator);
        setDenominator(this.denominator * num.denominator);
        reduce();
    }

    public void minus(RationalNumber num) {
        setNumerator(this.numerator * num.denominator - this.denominator * num.numerator);
        setDenominator(this.denominator * num.denominator);
        reduce();
    }

    public void reduce() {
        int gcd= gcd(numerator,denominator);
        setNumerator(numerator/gcd);
        setDenominator(denominator/gcd);
    }

    public static int gcd(int a, int b){
        if(b==0)
            return a;
        return gcd(b,a%b);
    }
}