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

public class FreeMarkerActionImpl extends FreemarkerService
{ 
    public static void run(BaseConfig baseConfig, FreeMarkerConfigurer freeMarkerConfigurer) throws Exception
    {
        FreemarkerService freemarkerService = new FreemarkerEntityImpl();
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/ec";
        Connection connection = DriverManager.getConnection(url, "root", "123456");
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
            entityBean.setPackagePath("com.lcword.aznature.action." + getPackage(entityBean.getClassName()) + ".");
            Map<String, Object> data = new HashMap<String, Object>();
            data.put("className", entityBean.getClassName());
            data.put("tableName", tb.toLowerCase());
            data.put("fixpack", getPackage(entityBean.getClassName()));
            //data.put("primaryKey", NameConverter.toJavaCase(entityBean.getPrimaryKey()));
            /*************************************************************/
            entityBean.setFileName(entityBean.getClassName() + "Action");
            /*************************************************************/
            // freemarkerService.createJavaFile(data, "action.ftl", entityBean);
            freemarkerService.createJavaFile(data, "action.ftl", entityBean, baseConfig, freeMarkerConfigurer);

        }

    }

    public static void main(String[] args) throws Exception
    {
        String[] configLocation = new String[] { "applicationContext.xml" };
        ApplicationContext context = new ClassPathXmlApplicationContext(configLocation);
        BaseConfig baseConfig = context.getBean(BaseConfig.class);
        FreeMarkerConfigurer freeMarkerConfigurer = context.getBean(FreeMarkerConfigurer.class);
        /*路径设置*********************************************************/
        // <property name="entityPath" value="F:/code-src/src/"/>
        // <property name="mapperXmlPath" value="F:/code-src/src/"/>
        baseConfig.setEntityPath("F:/code-src/src/");
        baseConfig.setMapperXmlPath("F:/code-src/src/");
        baseConfig.setEntityPath(baseConfig.getEntityPath() + "main/java/");
        baseConfig.setSuffix(".java");
        FreeMarkerActionImpl.run(baseConfig, freeMarkerConfigurer);
    }
}
