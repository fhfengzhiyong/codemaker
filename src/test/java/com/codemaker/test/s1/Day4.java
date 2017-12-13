package com.codemaker.test.s1;

import java.net.InetAddress;

public class Day4 {

		public static void main(String[] args) {
			// TODO Auto-generated method stub
			InetAddress ia=null;
			try {
				ia=ia.getLocalHost();
				
				String localname=ia.getHostName();
				String localip=ia.getHostAddress();
				System.out.println("本机名称是："+ localname);
				System.out.println("本机的ip是 ："+localip);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

}
