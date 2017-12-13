package com.codemaker.test;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class T3 {
	static List list = new ArrayList(10);
	public static void main(String[] args) {
		ThreadTest1 ts = new ThreadTest1();
		Thread tt = new Thread(ts);
		tt.start();
		T3 t = new T3();
		for(int i=0;i<1000;i++){
			try {
				Thread.sleep(2);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			t.list.add("main="+i);
		}
		Iterator it = t.list.iterator();
		while(it.hasNext()){
			try {
				Thread.sleep(1);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("目前的list=  "+it.next());
		}
		System.out.println(Thread.currentThread().getName()+"  list Hashcode is= "+t.list.hashCode());
	}
}
class ThreadTest1 implements Runnable{
	public  void run(){
		T3 t = new T3();
		for(int i=0;i<800;i++){
			try {
				Thread.sleep(1);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			t.list.add("i="+i);
		}
		System.out.println(Thread.currentThread().getName()+"  list Hashcode is= "+t.list.hashCode());
	}
}
