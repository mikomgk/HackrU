package com.company;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Main {

    public static void main(String[] args) {
        int[] coins = {1, 2, 5, 10};
        int sum = 10;
        //System.out.println(countOptions(sum, coins));
        //System.out.println(spiralDiagonal(1001));
        //System.out.println(distinctPower(2, 100));
        System.out.println(digitFifthPower(4));
    }

    static int digitFifthPower(int power) {
        int sum = 0;
        List<Integer> correctNumbers=new ArrayList<>();
        List<Integer> digits = null;
        for (int i = 10; i < 1000000; i++) {
            sum=0;
            digits = getDigits(i);
            for (int j = 0; j < digits.size(); j++) {
                sum+=Math.pow(digits.get(j),power);
            }
            if(sum==i)
                correctNumbers.add(i);
        }
        sum=0;
        for (int i = 0; i < correctNumbers.size(); i++) {
            sum+=correctNumbers.get(i);
        }
        return sum;
    }

    static List<Integer> getDigits(int n) {
        List<Integer> digits = new ArrayList<>();
        for (; n > 0; n /= 10) {
            digits.add(n % 10);
        }
        return digits;
    }

    static int distinctPower(int min, int max) {
        Set<Double> dP = new HashSet<>();
        for (int i = min; i <= max; i++) {
            for (int j = min; j <= max; j++) {
                dP.add(Math.pow(i, j));
            }
        }
        return dP.size();
    }

    static int spiralDiagonal(int n) {
        int x = 2, sum = 1, num = 1;
        while (x < n) {
            for (int j = 0; j < 4; j++) {
                sum += num += x;
            }
            x += 2;
        }
        return sum;
    }

    static int countOptions(int n, int[] coins) {
        int[][] cache = new int[n + 1][coins.length+1];
        for (int i = 0; i < n + 1; i++) {
            for (int j = 0; j < coins.length; j++) {
                if (i == 0)
                    cache[i][j] = 1;
                else if (j == 0)
                    cache[i][j] = 0;
                else
                    cache[i][j] = -1;
            }
        }
        return countOptions(n, coins, coins.length, cache);
    }

    static int countOptions(int n, int[] coins, int end, int[][] cache) {
        int result;
        if (n < 0 || end < 0 )
            result = 0;
        else if (cache[n][end] != -1)
            return cache[n][end];
        else
            result = countOptions(n - coins[end], coins, end, cache) + countOptions(n, coins, end - 1, cache);
        cache[n][end] = result;
        return cache[n][end];
    }

    static int count(int n,int[] coins){
        int[] arr=new int[coins.length];
        for (int i = 0; i < coins.length; i++) {
            for (int j = coins[i]; j < n; j++) {
                arr[i]+=coins[j-];
            }
        }
    }
}
