package com.straw.springTest.test;

import org.junit.Test;
import org.springframework.beans.factory.support.DefaultListableBeanFactory;
import org.springframework.beans.factory.xml.XmlBeanDefinitionReader;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import com.straw.springTest.bean.Person;

public class T1 {
//	<T>T getT(T t){
//		return t;
//	}
	@Test
	public void test1(){
		Resource resource = new ClassPathResource("bean/bean.xml");
		DefaultListableBeanFactory factory = new DefaultListableBeanFactory();
		XmlBeanDefinitionReader reader = new XmlBeanDefinitionReader(factory);
		reader.loadBeanDefinitions(resource);
		Person person = (Person) factory.getBean("person");
		System.out.println(person.getAge());
	}
}
