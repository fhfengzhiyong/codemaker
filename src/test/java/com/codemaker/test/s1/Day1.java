package com.codemaker.test.s1;
import java.util.List;
import java.util.LinkedList;
import java.util.Iterator;
public class Day1 {
	//使用java.lang.Math类，生成100个0到99之间的随机整数，找出它们之中的最大者和最小者，并统计大于50的整数个数 
	public static void main(String[] args){
		int x = 999999;
		Math.random();
		int i=0;
		List<Integer> list= new LinkedList<Integer>();
		while(i<x+1){
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			i++;
			list.add((int)(Math.random()*10000));
		}
		int max=0;
		int min=x;
		int temp;
		int count= 0;
		for(Iterator<Integer> it = list.iterator();it.hasNext();){
			temp = it.next();
			System.out.println(temp);
			if(temp<min){
				min = temp;
			}
			if(temp>max){
				max = temp;
			}
			if(temp>50){
				count++;
			}
		}
		System.out.println("max="+max+" min="+min+" 大于50的有="+count);
	}
}
