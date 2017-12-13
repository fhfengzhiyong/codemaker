package com.codemaker.test.s1;

import java.math.BigDecimal;
import java.text.DecimalFormat;

public class Day3 {
	public static void main(String[] args) {
//		String attribution = "招商银行太原分行小店支行";
//		String str =  attribution.substring(0, attribution.indexOf("银行"));
//		String str = "3";
//		boolean isNum = str.matches("[0-9]+"); 
//		System.out.println(isNum);
//		System.out.println(Double.parseDouble("5")+1);
//		DecimalFormat dateFormat = new DecimalFormat("0.00");
//		System.out.println(dateFormat.format(Double.parseDouble("6.999999999999999")));
		BigDecimal b = new BigDecimal("62.19999").setScale(0, BigDecimal.ROUND_HALF_UP);
		System.out.println(b.intValue());
	}

}
