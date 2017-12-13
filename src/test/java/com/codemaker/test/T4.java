package com.codemaker.test;

public class T4 {
	int number = 1;
	int result = 0;
	boolean ready = false;
	public synchronized void write(){
		number  = 3;
		ready = true;
	}
	public synchronized void read(){
		System.out.println(number);
		if(ready){
			result = number * 2;
		}
		System.out.println("result"+result);
	}
	public static void  main(String[] args){
		ThreadTest4 threadTest4 = new ThreadTest4();
		T4 t4 = new T4();
		Thread t = new Thread(threadTest4);
		t4.write();
		t.start();
	}
}
class ThreadTest4 implements Runnable{
	public void run(){
		T4  t = new T4();
		t.read();
	}
}
