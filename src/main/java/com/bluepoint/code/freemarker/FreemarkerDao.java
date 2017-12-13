package com.bluepoint.code.freemarker;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.bluepoint.code.util.BaseConfig;
import com.bluepoint.code.util.EntityBean;
import com.bluepoint.code.util.NameConverter;

public class FreemarkerDao extends FreemarkerService
{
    public static void run(BaseConfig baseConfig, FreeMarkerConfigurer freeMarkerConfigurer) throws Exception
    {
        FreemarkerService freemarkerService = new FreemarkerEntityImpl();
        Class.forName(driver);
        Connection connection = DriverManager.getConnection(url, user, password);
        DatabaseMetaData dbmd = connection.getMetaData();
        ResultSet resultSet = dbmd.getTables(null, null, null, null);
        List<String> listTb = new ArrayList<String>();
        while (resultSet.next())
        {
            String tableName = resultSet.getString(3);
            listTb.add(tableName);
        }
        String sql = "select * from ";
        PreparedStatement pstemt = null;
        for (String tb : listTb)
        {
            pstemt = connection.prepareStatement(sql + tb);
            ResultSetMetaData rsmd = pstemt.getMetaData();
            int size = rsmd.getColumnCount();
            String[] colnames = new String[size];
            String[] colTypes = new String[size];
            String[] remarks = new String[size];
            EntityBean entityBean = new EntityBean();
            String className = NameConverter.toJavaCase(tb);
            entityBean.setClassName(firsetLetterUpper(className));
            setEntityBean(dbmd, rsmd, entityBean, tb, size, colnames, colTypes, remarks);
            entityBean.setPackagePath("dao.");// + getPackage(entityBean.getClassName()) + ".");
            Map<String, Object> data = new HashMap<String, Object>();
            data.put("className", entityBean.getClassName());
            data.put("fixpack", getPackage(entityBean.getClassName()));
            //data.put("primaryKey", NameConverter.toJavaCase(entityBean.getPrimaryKey()));
            /*************************************************************/
            entityBean.setFileName(entityBean.getClassName() + "Dao");
            /*************************************************************/
            //freemarkerService.createJavaFile(data, "service.ftl", entityBean);
            freemarkerService.createJavaFile(data, "dao.ftl", entityBean, baseConfig, freeMarkerConfigurer);

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
