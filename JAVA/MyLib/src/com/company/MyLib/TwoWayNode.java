package com.company.MyLib;

public class TwoWayNode {
    private int data;
    private TwoWayNode next;
    private TwoWayNode prev;

    public TwoWayNode(int val) {
        data = val;
        next = null;
        prev = null;
    }

    public TwoWayNode(int x, TwoWayNode next) {
        data = x;
        this.next = next;
        prev = null;
    }

    public TwoWayNode(int x, TwoWayNode next, TwoWayNode prev) {
        data = x;
        this.next = next;
        this.prev = prev;
    }

    public TwoWayNode(TwoWayNode node) {
        data = node.data;
        next = node.next;
        prev = node.prev;
    }

    public void setData(int val) {
        data = val;
    }

    public int getData() {
        return data;
    }

    public void setNext(TwoWayNode newNext) {
        next = newNext;
    }

    public TwoWayNode getNext() {
        return next;
    }

    public void setPrev(TwoWayNode newPrev) {
        prev = newPrev;
    }

    public TwoWayNode getPrev() {
        return prev;
    }
}
