package com.company;

public class ArrayList {
    private ArrayNode head;

    public ArrayList() {
        this.head = null;
    }

    public ArrayList(ArrayNode head) {
        this.head = head;
    }

    public int get(int index) {
        ArrayNode pnt = head;
        for (; pnt != null && index > 0; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            return -9999999;
        return pnt.getData();
    }

    public int set(int index, int val) {
        ArrayNode pnt = head;
        for (; pnt != null && index > 0; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            return -1;
        pnt.setData(val);
        return 1;
    }

    public int add(int val) {
        ArrayNode pnt = head, a = new ArrayNode(val);
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
        ArrayNode pnt = head;
        if (index == 0) {
            head = new ArrayNode(val, head);
            return 1;
        }
        for (; pnt != null && index > 1; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            return -1;
        pnt.setNext(new ArrayNode(val, pnt.getNext()));
        return 1;
    }

    public int removeAt(int index) {
        ArrayNode pnt = head;
        for (; pnt != null && index > 1; pnt = pnt.getNext(), index--)
            ;
        if (pnt == null)
            return -1;
        pnt.setNext(pnt.getNext().getNext());
        return 1;
    }

    public int size() {
        int count = 1;
        ArrayNode pnt = head;
        if (pnt == null)
            return 0;
        for (; pnt.getNext() != null; pnt = pnt.getNext(), count++)
            ;
        return count;
    }

    public int indexOf(int val) {
        int count = 0;
        ArrayNode pnt = head;
        for (; pnt != null; pnt = pnt.getNext(), count++)
            if (pnt.getData() == val)
                return count;
        return -1;
    }

    public int[] toArray() {
        int arr[] = new int[this.size()], i = 0;
        ArrayNode pnt = head;
        for (; pnt != null; pnt = pnt.getNext())
            arr[i++] = pnt.getData();
        return arr;
    }

    public String toString() {
        ArrayNode pnt = head;
        if (pnt == null)
            return "The list is empty";
        String s = "{" + pnt.getData();
        for (pnt = pnt.getNext(); pnt != null; pnt = pnt.getNext())
            s = s.concat("," + pnt.getData());
        s = s.concat("}");
        return s;
    }
}
