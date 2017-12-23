package com.bluepoint.code.freemarker;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.bluepoint.code.util.BaseConfig;

public class MainBuild {
	public static void main(String[] args) throws Exception {
		String[] configLocation = new String[] { "applicationContext.xml" };
        ApplicationContext context = new ClassPathXmlApplicationContext(configLocation);
        BaseConfig baseConfig = context.getBean(BaseConfig.class);
        FreeMarkerConfigurer freeMarkerConfigurer = context.getBean(FreeMarkerConfigurer.class);
        baseConfig.setEntityPath("F:/code-src/admin/");
        baseConfig.setMapperXmlPath("F:/code-src/admin/");
        String EntityPath = "F:/code-src/admin/";
        //文档生成
    	baseConfig.setEntityPath(EntityPath + "doc/");
        baseConfig.setSuffix(".md");
        FreemarDocMd.run(baseConfig, freeMarkerConfigurer);
        //Service
        baseConfig.setEntityPath(EntityPath + "java/");
        baseConfig.setSuffix(".java");
        FreemarkerBO.run(baseConfig, freeMarkerConfigurer);
        //Service实现
        baseConfig.setEntityPath(EntityPath+ "java/");
        baseConfig.setSuffix(".java");
        FreemarkerBOImpl.run(baseConfig, freeMarkerConfigurer);
        //dao
        baseConfig.setEntityPath(EntityPath+ "java/");
        baseConfig.setSuffix(".java");
        FreemarkerDao.run(baseConfig, freeMarkerConfigurer);
        //实体
        baseConfig.setEntityPath(EntityPath+ "java/");
        baseConfig.setSuffix(".java");
        FreemarkerEntityImpl.run(baseConfig, freeMarkerConfigurer);
        //FreeMarkerFrontAction api 接口
        baseConfig.setEntityPath(EntityPath+ "java/");
        baseConfig.setSuffix(".java");
        FreeMarkerFrontAction.run(baseConfig, freeMarkerConfigurer);
        //FreeMarkerManageAction 管理系统
        baseConfig.setEntityPath(EntityPath+ "java/");
        baseConfig.setSuffix(".java");
        FreeMarkerManageAction.run(baseConfig, freeMarkerConfigurer);
        //数据库映射文件
        baseConfig.setEntityPath(EntityPath+ "xml/");
        baseConfig.setSuffix(".xml");
        FreemarkerMapperXmlImpl.run(baseConfig, freeMarkerConfigurer);
        //jsp 增加
        baseConfig.setEntityPath(EntityPath+ "jsp/");
        baseConfig.setSuffix(".jsp");
        FreeMarkerJspAddImpl.run(baseConfig, freeMarkerConfigurer);
        //jsp 详细
        baseConfig.setEntityPath(EntityPath+ "jsp/");
        baseConfig.setSuffix(".jsp");
        FreeMarkerJspDetailImpl.run(baseConfig, freeMarkerConfigurer);
        //jsp 列表
        baseConfig.setEntityPath(EntityPath+ "jsp/");
        baseConfig.setSuffix(".jsp");
        FreeMarkerJspListImpl.run(baseConfig, freeMarkerConfigurer);
        //jsp 修改
        baseConfig.setEntityPath(EntityPath+ "jsp/");
        baseConfig.setSuffix(".jsp");
        FreeMarkerJspUpdateImpl.run(baseConfig, freeMarkerConfigurer);
        //jsp 修改
        baseConfig.setEntityPath(EntityPath+ "js/");
        baseConfig.setSuffix(".js");
        Js.run(baseConfig, freeMarkerConfigurer);
	}
}
