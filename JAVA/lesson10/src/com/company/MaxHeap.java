package com.company;

public class MaxHeap {
    int[] arr;
    int size;

    public MaxHeap(){
        arr = new int[100];
    }

    //O(n)
    public MaxHeap(int[] keys){
        arr = keys;
        size = arr.length;
        for (int i = arr.length / 2 - 1; i >= 0; i--) {
            heapify(i);
        }
    }

    private int left(int i){
        return 2*i+1;
    }

    private int right(int i){
        return 2*i+2;
    }

    private int parent(int i){
        return (i-1)/2;
    }

    private void heapify(int i){
        int l = left(i);
        int r = right(i);
        int largest = i;
        if(l < size  && arr[l] > arr[largest])
            largest = l;
        if(r < size && arr[r] > arr[largest])
            largest = r;
        if(largest != i){
            int temp = arr[i];
            arr[i] = arr[largest];
            arr[largest] = temp;
            heapify(largest);
        }
    }

    public int getMax(){
        if(size == 0)
            throw new RuntimeException();
        return arr[0];
    }

    public void add(int key){
        //TODO: make room if no room
        arr[size] = key;
        int i = size;
        size++;
        int p;
        //assignment within a boolean expression
        while (i != 0 && arr[p=parent(i)] < arr[i]){
            int temp = arr[p];
            arr[p] = arr[i];
            arr[i] = temp;
            i = p;
        }
    }

    private void increasePriority(int i, int increasedPriority){
        arr[i] = increasedPriority;
        int p;
        while (i != 0 && arr[p=parent(i)] < arr[i]){
            int temp = arr[p];
            arr[p] = arr[i];
            arr[i] = temp;
            i = p;
        }

    }

    private void removeIndex(int index){
        increasePriority(index,Integer.MAX_VALUE);
        extractMax();
    }

    public int extractMax(){
        if(size == 0)
            throw new RuntimeException();
        if(size == 1){
            size--;
            return arr[0];
        }
        int result = arr[0];
        arr[0] = arr[size-1];
        size--;
        heapify(0);
        return result;

    }

    public boolean isEmpty(){
        return size == 0;
    }
}
