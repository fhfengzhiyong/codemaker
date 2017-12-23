package com.bluepoint.code.freemarker;

import com.bluepoint.code.util.BaseConfig;
import com.bluepoint.code.util.EntityBean;
import com.bluepoint.code.util.EntityProperties;
import com.bluepoint.code.util.NameConverter;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import java.sql.*;
import java.util.*;
import java.util.Date;

public class FreeMarkerManageAction extends FreemarkerService {

	public static void run(BaseConfig baseConfig,
			FreeMarkerConfigurer freeMarkerConfigurer) throws Exception {
		FreemarkerService freemarkerService = new FreemarkerEntityImpl();
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
			entityBean.setPackagePath("action.");
			String className = NameConverter.toJavaCase(tb);
			entityBean.setClassName(firsetLetterUpper(className));
			Map<String, Object> data = new HashMap<String, Object>();
			data.put("className", entityBean.getClassName());
			/*************************************************************/
			List<EntityProperties> list = new ArrayList<EntityProperties>();
			for (int i = 0; i < size; i++) {
				EntityProperties entityProperties = new EntityProperties();
				entityProperties.setColumnNameLower(NameConverter.dealLine(colnames[i]));
				entityProperties
						.setSimpleJavaType(sqlType2JavaType(colTypes[i]));
				entityProperties
						.setColumnName(firsetLetterUpper(entityProperties
								.getColumnNameLower()));
				entityProperties.setRemarks(remarks[i]);
				list.add(entityProperties);
			}
			data.put("columns", list);
			data.put("entityBean", entityBean);
			data.put("pk", NameConverter.dealLine(entityBean.getPrimaryKey()));
		    data.put("usd", "$");
			data.put("datetime",
					DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
			/*************************************************************/
			entityBean.setFileName(entityBean.getClassName()+"ManageAction");
			freemarkerService.createJavaFile(data, "manage_action.ftl", entityBean,
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
        baseConfig.setEntityPath(baseConfig.getEntityPath() + "java/");
        baseConfig.setSuffix(".java");
        run(baseConfig, freeMarkerConfigurer);
	}
}
