package com.bluepoint.code.freemarker;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSetMetaData;

import com.bluepoint.code.util.NameConverter;

public class FreemarkerCo
{

    /**
     * // System.out.println("c." + rsmd.getColumnName(i + 1) + " as co_" + rsmd.getColumnName(i + 1) + ",");
    
     * @param args
     */
    public static void main(String[] args) throws Exception
    {

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/ec";
        Connection connection = DriverManager.getConnection(url, "root", "system");
        //DatabaseMetaData dbmd = connection.getMetaData();

        String sql = "select * from  bd_balance_appraise ";
        PreparedStatement pstemt = null;

        pstemt = connection.prepareStatement(sql);
        ResultSetMetaData rsmd = pstemt.getMetaData();
        int size = rsmd.getColumnCount();
        String[] colnames = new String[size];
        String[] colTypes = new String[size];
        String[] remarks = new String[size];
        //System.out.println(size);
        //c.grade as  co_grade
        for (int i = 0; i < size; i++)
        {
            String col = NameConverter.toJavaCase(rsmd.getColumnName(i + 1));
            //$("input[name='goodsName']").val('${tuanGoodsInfoVO.goodsName}');
            StringBuffer buffer = new StringBuffer();
            buffer.append("$(\"input[name='" + col + "']\")");
            buffer.append(".val");
            buffer.append("('${tuanGoodsInfoVO.tuanGoodsInfoExt." + col + "}')");
            buffer.append(";");
            // System.out.println(buffer.toString());
            System.out.println("a." + rsmd.getColumnName(i + 1) + " as  co_" + rsmd.getColumnName(i + 1) + ",");
        }

    }

}
