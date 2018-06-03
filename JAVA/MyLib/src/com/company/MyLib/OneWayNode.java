package com.company.MyLib;

public class OneWayNode {
    private int data;
    private OneWayNode next;

    public OneWayNode(int val) {
        data = val;
        next = null;
    }

    public OneWayNode(int x, OneWayNode next) {
        data = x;
        this.next = next;
    }

    public void setData(int val) {
        data = val;
    }

    public int getData() {
        return data;
    }

    public void setNext(OneWayNode newNext) {
        next = newNext;
    }

    public OneWayNode getNext() {
        return next;
    }
}
