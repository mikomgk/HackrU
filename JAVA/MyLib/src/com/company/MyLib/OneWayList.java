package com.company.MyLib;

public class OneWayList {
    private OneWayNode head;

    public OneWayList() {
        head = null;
    }

    public OneWayList(OneWayNode head) {
        this.head = head;
    }

    public OneWayList(OneWayList list) {
        head = list.head;
    }

    public int get(int index) {
        OneWayNode pnt = head;
        for (; pnt != null && index > 0; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            return -9999999;
        return pnt.getData();
    }

    public int set(int index, int val) {
        OneWayNode pnt = head;
        for (; pnt != null && index > 0; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            return -1;
        pnt.setData(val);
        return 1;
    }

    public int add(int val) {
        OneWayNode pnt = head, a = new OneWayNode(val);
        if (pnt == null) {
            head = a;
            return 1;
        }
        for (; pnt.getNext() != null; pnt = pnt.getNext())
            ;
        pnt.setNext(a);
        return 1;
    }

    public int addAt(int index, int val) {
        OneWayNode pnt = head;
        if (index == 0) {
            head = new OneWayNode(val, head);
            return 1;
        }
        for (; pnt != null && index > 1; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            return -1;
        pnt.setNext(new OneWayNode(val, pnt.getNext()));
        return 1;
    }

    public int removeAt(int index) {
        OneWayNode pnt = head;
        for (; pnt != null && index > 1; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            return -1;
        pnt.setNext(pnt.getNext().getNext());
        return 1;
    }

    public int size() {
        int count = 1;
        OneWayNode pnt = head;
        if (pnt == null)
            return 0;
        for (; pnt.getNext() != null; pnt = pnt.getNext(), count++)
            ;
        return count;
    }

    public int indexOf(int val) {
        int count = 0;
        OneWayNode pnt = head;
        for (; pnt != null; pnt = pnt.getNext(), count++)
            if (pnt.getData() == val)
                return count;
        return -1;
    }

    public int[] toArray() {
        int arr[] = new int[this.size()], i = 0;
        OneWayNode pnt = head;
        for (; pnt != null; pnt = pnt.getNext())
            arr[i++] = pnt.getData();
        return arr;
    }

    public String toString() {
        OneWayNode pnt = head;
        if (pnt == null)
            return "The list is empty";
        String s = "{" + pnt.getData();
        for (pnt = pnt.getNext(); pnt != null; pnt = pnt.getNext())
            s = s.concat("," + pnt.getData());
        s = s.concat("}");
        return s;
    }
}
