package com.bluepoint.code.freemarker;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.bluepoint.code.util.BaseConfig;
import com.bluepoint.code.util.EntityBean;
import com.bluepoint.code.util.EntityProperties;
import com.bluepoint.code.util.NameConverter;

public class FreemarDocMd extends FreemarkerService {

	public static void run(BaseConfig baseConfig,
			FreeMarkerConfigurer freeMarkerConfigurer) throws Exception {
		FreemarkerService freemarkerService = new FreemarDocMd();
		Class.forName(driver);
		// String url = "jdbc:mysql://localhost/taijisoft_db";
		Connection connection = DriverManager
				.getConnection(url, user, password);
		DatabaseMetaData dbmd = connection.getMetaData();
		ResultSet resultSet = dbmd.getTables(null, null, null, new String[]{"TABLE"});
		
		List<String> listTb = new ArrayList<String>();
		while (resultSet.next()) {
			String tableName = resultSet.getString(3);
		            listTb.add(tableName);
			
		}
		String sql = "select * from ";
		PreparedStatement pstemt = null;
		for (String tb : listTb) {
			pstemt = connection.prepareStatement(sql + tb);
			ResultSetMetaData rsmd = pstemt.getMetaData();
			int size = rsmd.getColumnCount();
			String[] colnames = new String[size];
			String[] colTypes = new String[size];
			String[] remarks = new String[size];
			EntityBean entityBean = new EntityBean();
			setEntityBean(dbmd, rsmd, entityBean, tb, size, colnames, colTypes,
					remarks);
			entityBean.setPackagePath("");
			String className = NameConverter.toJavaCase(tb);
			entityBean.setClassName(firsetLetterUpper(className));
			Map<String, Object> data = new HashMap<String, Object>();
			data.put("className", entityBean.getClassName());
			/*************************************************************/
			List<EntityProperties> list = new ArrayList<EntityProperties>();
			for (int i = 0; i < size; i++) {
				EntityProperties entityProperties = new EntityProperties();
				entityProperties.setColumnNameLower(NameConverter.dealLine(colnames[i]));
				entityProperties.setSimpleJavaType(sqlType2JavaType(colTypes[i]));
				entityProperties
						.setColumnName(firsetLetterUpper(entityProperties
								.getColumnNameLower()));
				entityProperties.setRemarks(remarks[i]);
				list.add(entityProperties);
			}
			data.put("columns", list);
			data.put("pk", NameConverter.dealLine(entityBean.getPrimaryKey()));
			data.put("datetime",
					DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
			data.put("date",
					DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
			/*************************************************************/
			entityBean.setFileName(entityBean.getClassName());
			freemarkerService.createJavaFile(data, "doc.ftl", entityBean,
					baseConfig, freeMarkerConfigurer);
		}

	}

	public static void main(String[] arg) throws Exception {
		String[] configLocation = new String[] { "applicationContext.xml" };
        ApplicationContext context = new ClassPathXmlApplicationContext(configLocation);
        BaseConfig baseConfig = context.getBean(BaseConfig.class);
        FreeMarkerConfigurer freeMarkerConfigurer = context.getBean(FreeMarkerConfigurer.class);
        baseConfig.setEntityPath("F:/code-src/src/");
        baseConfig.setMapperXmlPath("F:/code-src/src/"); 
    	baseConfig.setEntityPath(baseConfig.getEntityPath() + "doc/");
        baseConfig.setSuffix(".md");
        run(baseConfig, freeMarkerConfigurer);
	}
}
