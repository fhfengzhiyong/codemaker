package com.bluepoint.code.freemarker;

import java.io.File;
import java.nio.charset.Charset;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.bluepoint.code.util.BaseConfig;
import com.bluepoint.code.util.EntityBean;

import freemarker.template.Template;

public abstract class FreemarkerService
{ 
	public static String url = "jdbc:mysql://123.57.80.58:3306/robot";
    public static String user = "robot";
    public static String password = "robot";
    

  /*  public static String url = "jdbc:mysql://115.28.2.193:3306/choir";
    public static String user = "root";
    public static String password = "lcworld2211";*/
/*  public static String url = "jdbc:mysql://123.206.82.243:3306/jsxx";
    public static String user = "root";
    public static String password = "mypasswd"; */
    public static String driver = "com.mysql.jdbc.Driver";
//	 public static String url = "jdbc:oracle:thin:@localhost:1521:ORCL";
//	    public static String user = "scwc";
//	    public static String password = "1234"; 
//	    public static String driver = "oracle.jdbc.driver.OracleDriver";

    public static void setEntityBean(DatabaseMetaData dbmd, ResultSetMetaData rsmd, EntityBean entityBean, String tb, int size, String[] colnames, String[] colTypes, String[] remarks)
    {
        try
        {
            ResultSet columnSet = dbmd.getColumns(null, "%", tb, "%");
            int k = 0;
            while (columnSet.next())
            {

                String columnComment = columnSet.getString("REMARKS");
                remarks[k] = columnComment;
                k++;
            }
            ResultSet _ResultSet = dbmd.getPrimaryKeys(null, null, tb);
            if (_ResultSet.next())
            {
                entityBean.setPrimaryKey(_ResultSet.getObject(4) + "");
            }
            for (int i = 0; i < size; i++)
            {

                colnames[i] = rsmd.getColumnName(i + 1);
                String jdbcType = rsmd.getColumnTypeName(i + 1);
                if (jdbcType.equalsIgnoreCase("int"))
                    jdbcType = "INTEGER";
                if (jdbcType.equalsIgnoreCase("DATETIME"))
                    jdbcType = "TIMESTAMP";
                colTypes[i] = jdbcType;
                if (colnames[i].equalsIgnoreCase(entityBean.getPrimaryKey()))
                {
                    entityBean.setPrimaryKeyType(colTypes[i]);
                }
            }

        }
        catch (Exception e)
        {
            // TODO: handle exception
        }

    }

    /**
     * 
     * @param str
     * @return
     */
    public static String firsetLetterUpper(String str)
    {

        char[] ch = str.toCharArray();
        if (ch[0] >= 'a' && ch[0] <= 'z')
        {
            ch[0] = (char) (ch[0] - 32);
        }
        return new String(ch);
    }

    public void createJavaFile(Map<String, Object> data, String ftl, EntityBean entityBean, BaseConfig baseConfig, FreeMarkerConfigurer freeMarkerConfigurer)
    {

        try
        {

            Template template = freeMarkerConfigurer.getConfiguration().getTemplate(ftl);
            template.setEncoding("utf-8");
            String htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(template, data);
            String tmpDir = null;
            if (StringUtils.isNotBlank(baseConfig.getEntityPath()))
            {
                // tmpDir = baseConfig.getEntityPath() + "/src/main/java/" + entityBean.getPackagePath().replace(".", "/");
                tmpDir = baseConfig.getEntityPath() + entityBean.getPackagePath().replace(".", "/");

                //baseConfig.setSuffix(".java");
                File htmlFile = new File(tmpDir);
                if (!htmlFile.exists())
                    htmlFile.mkdirs();

                htmlFile = new File(tmpDir + entityBean.getFileName() + baseConfig.getSuffix());
                FileUtils.write(htmlFile, htmlText, Charset.forName("utf-8"));
            }
            /*if (StringUtils.isNotBlank(baseConfig.getMapperXmlPath()))
            {
                tmpDir = baseConfig.getMapperXmlPath() + "/src/main/resources/" + entityBean.getPackagePath().replace(".", "/");
                baseConfig.setSuffix(".xml");
                File htmlFile = new File(tmpDir);
                if (!htmlFile.exists())
                    htmlFile.mkdirs();

                htmlFile = new File(tmpDir + entityBean.getFileName() + baseConfig.getSuffix());
                FileUtils.write(htmlFile, htmlText);
            }*/

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    public static String sqlType2JavaType(String sqlType)
    {
        System.out.println("sqlType  = " + sqlType);
        if (sqlType.equalsIgnoreCase("bit"))
        {
            return "boolean";
        }
        else if (sqlType.equalsIgnoreCase("tinyint"))
        {
            return "byte";
        }
        else if (sqlType.equalsIgnoreCase("smallint"))
        {
            return "short";
        }
        else if (sqlType.equalsIgnoreCase("integer"))//宸茬粡鍙樻崲mybatis绫诲瀷
        {
            return "Integer";
        }
        else if (sqlType.equalsIgnoreCase("bigint"))
        {
            return "Long";
        }
        else if (sqlType.equalsIgnoreCase("float"))
        {
            return "float";
        }
        else if (sqlType.equalsIgnoreCase("double") || sqlType.equalsIgnoreCase("decimal") || sqlType.equalsIgnoreCase("numeric") || sqlType.equalsIgnoreCase("real") || sqlType.equalsIgnoreCase("money") || sqlType.equalsIgnoreCase("smallmoney"))
        {
            return "Double";
        }
        else if (sqlType.equalsIgnoreCase("varchar") || sqlType.equalsIgnoreCase("char") || sqlType.equalsIgnoreCase("nvarchar") || sqlType.equalsIgnoreCase("nchar") || sqlType.equalsIgnoreCase("text"))
        {
            return "String";
        }
        else if (sqlType.equalsIgnoreCase("datetime"))
        {
            return "Date";
        }
        else if (sqlType.equalsIgnoreCase("timestamp"))
        {
            return "Date";
        }
        else if (sqlType.equalsIgnoreCase("image"))
        {
            return "Blod";
        }

        return null;
    }

    public static String getPackage(String fixpackage)
    {
        fixpackage = fixpackage.toLowerCase();
        //category
        if (fixpackage.startsWith("category"))
        {
            fixpackage = "category";
        }
        if (fixpackage.startsWith("msg"))
        {
            fixpackage = "msg";
        }
        if (fixpackage.startsWith("org"))
        {
            fixpackage = "org";
        }

        if (fixpackage.startsWith("img"))
        {
            fixpackage = "img";
        }
        if (fixpackage.startsWith("img"))
        {
            fixpackage = "img";
        }
        if (fixpackage.startsWith("dict"))
        {
            fixpackage = "dict";
        }
        if (fixpackage.startsWith("system"))
        {
            fixpackage = "system";
        }
        if (fixpackage.startsWith("apply"))
        {
            fixpackage = "apply";
        }
        if (fixpackage.startsWith("authority"))
        {
            fixpackage = "authority";
        }
        if (fixpackage.startsWith("match"))
        {
            fixpackage = "match";
        }
        if (fixpackage.startsWith("school"))
        {
            fixpackage = "school";
        }
        if (fixpackage.startsWith("user"))
        {
            fixpackage = "user";
        }
        if (fixpackage.startsWith("tuan"))
        {
            fixpackage = "tuan";
        }
        if (fixpackage.startsWith("cms"))
        {
            fixpackage = "cms";
        }
        if (fixpackage.startsWith("feedback"))
        {
            fixpackage = "feedback";
        }
        if (fixpackage.startsWith("order"))
        {
            fixpackage = "order";
        }
        return fixpackage;
    }

}
