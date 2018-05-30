package com.company;

public class ArrayNode {
    private int data;
    private ArrayNode next;

    public ArrayNode(int val) {
        data = val;
        next = null;
    }

    public ArrayNode(int x, ArrayNode next) {
        data = x;
        this.next = next;
    }

    public void setData(int val) {
        data = val;
    }

    public int getData() {
        return data;
    }

    public void setNext(ArrayNode newNext) {
        next = newNext;
    }

    public ArrayNode getNext() {
        return next;
    }
}
