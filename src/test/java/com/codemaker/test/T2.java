package com.codemaker.test;

public class T2 {
	public static void main(String[] args) {
		System.out.println("main is Daemon "+Thread.currentThread().isDaemon());
		ThreadTest threadTest = new ThreadTest();
		Thread t  = new Thread(threadTest);
		t.setDaemon(true);
		System.out.println("main is Daemon "+Thread.currentThread().isDaemon());
		t.start();
		System.out.println("main is Daemon "+Thread.currentThread().isDaemon());
		for(int i=0;i<6;i++){
			System.out.println(Thread.currentThread().getName());
		}
	}
}
class ThreadTest implements Runnable{
	ThreadTest(){
		System.out.println("ThreadTest is start!");
	}
		public void run(){
			System.out.println("ThreadTest is Daemon "+Thread.currentThread().isDaemon());
			for(int i=0;i<6;i++){
				System.out.println(Thread.currentThread().getName());
			}
		}
}
