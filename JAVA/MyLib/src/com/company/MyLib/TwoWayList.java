package com.company.MyLib;

public class TwoWayList {
    private TwoWayNode head;
    private TwoWayNode tail;

    public TwoWayList() {
        head = null;
        tail = null;
    }

    public TwoWayList(TwoWayList list) {
        head = list.head;
        tail = list.tail;
    }

    public int get(int index) {
        TwoWayNode pnt = head;
        for (; pnt != null && index > 0; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            throw new IndexOutOfBoundsException("no such index");
        return pnt.getData();
    }

    public int set(int index, int val) {
        TwoWayNode pnt = head;
        for (; pnt != null && index > 0; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            return -1;
        pnt.setData(val);
        return 1;
    }

    public int add(int val) {
        TwoWayNode a = new TwoWayNode(val);
        if (tail == null) {
            head = a;
            tail = a;
        } else {
            tail.setNext(a);
            a.setPrev(tail);
            tail = a;
        }
        return 1;
    }

    public int addAt(int index, int val) {
        TwoWayNode pnt = head;
        if (head == null) {
            head = tail = new TwoWayNode(val);
            return 1;
        }
        if (index == 0) {
            head.setPrev(new TwoWayNode(val, head,null));
            head = head.getPrev();
            return 1;
        }
        if (index == this.size()) {
            tail.setNext(new TwoWayNode(val, null,tail));
            tail=tail.getNext();
            return 1;
        }
        for (; pnt != null && index > 1; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            return -1;
        pnt.setNext(new TwoWayNode(val, pnt.getNext(),pnt));
        pnt.getNext().getNext().setNext(pnt.getNext());
        return 1;
    }

    public int removeAt(int index) {
        TwoWayNode pnt = head;
        for (; pnt != null && index > 1; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            return -1;
        pnt.setNext(pnt.getNext().getNext());
        pnt.getNext().setPrev(pnt);
        return 1;
    }

    public int size() {
        if(head==null)
            return 0;
        int count = 1;
        TwoWayNode pnt = head;
        for (; pnt != null; pnt = pnt.getNext(), count++)
            ;
        return count;
    }

    public int indexOf(int val) {
        int index = 0;
        TwoWayNode pnt = head;
        for (; pnt != null; pnt = pnt.getNext(), index++)
            if (pnt.getData() == val)
                return index;
        return -1;
    }

    public int[] toArray() {
        int arr[] = new int[this.size()], i = 0;
        TwoWayNode pnt = head;
        for (; pnt != null; pnt = pnt.getNext())
            arr[i++] = pnt.getData();
        return arr;
    }

    public String toString() {
        TwoWayNode pnt = head;
        if (pnt == null)
            return "The list is empty";
        String s = "{" + pnt.getData();
        for (pnt = pnt.getNext(); pnt != null; pnt = pnt.getNext())
            s = s.concat("," + pnt.getData());
        s = s.concat("}");
        return s;
    }
}
