<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "htpp://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.lcworld.robot.mapper.${className}Dao">
   <resultMap id="BaseResultMap" type="com.lcworld.robot.model.${className}">
      <#list columns as column>
      <#if  column.columnName == entity.primaryKey>
      <id column="${column.columnName}" property="${column.columnNameLower}" jdbcType="${column.colType}"/>
      <#else>
      <result column="${column.columnName}" property="${column.columnNameLower}" jdbcType="${column.colType}"/>
      </#if>
      </#list>
   </resultMap>
   
   <insert id="insertBatch" parameterType="ArrayList">
	    insert into ${table}  (<#list columns as column><#if column_has_next>${column.columnName},<#else>${column.columnName}</#if></#list>)  values 
	    <foreach collection="list" item="obj" index="index" separator="," >
	    (<#list columns as column><#if column_has_next>${jh}{obj.${column.columnNameLower}},<#else>${jh}{obj.${column.columnNameLower}}</#if></#list>)
	    </foreach>
   </insert>
  
   <insert id="insert" parameterType="com.lcworld.robot.model.${className}">
	  insert into ${table}   
      <trim prefix="(" suffix=")" suffixOverrides=",">
      <#list columns as column>
         <if test="@com.lcworld.robot.common.Ognl@isNotEmpty(${column.columnNameLower})">${column.columnName},</if>
      </#list>
      </trim>
      <trim prefix=" values (" suffix=")" suffixOverrides=",">
      <#list columns as column>
          <if test="@com.lcworld.robot.common.Ognl@isNotEmpty(${column.columnNameLower})">${jh}{${column.columnNameLower},jdbcType=${column.colType}},</if>
      </#list>    
      </trim>
   </insert>
   
   <update id="update" parameterType="com.lcworld.robot.model.${className}"> 
      update ${table} 
       <set>
       <#list columns as column>
          <if test="@com.lcworld.robot.common.Ognl@isNotEmpty(${column.columnNameLower})">${column.columnName} = ${jh}{${column.columnNameLower},jdbcType=${column.colType}},</if>
       </#list>  
      </set>
      <trim prefix="where" prefixOverrides="AND |OR "> 
	   <#list columns as column>
	      <#if  column.columnName == entity.primaryKey>
          and ${column.columnName} = ${jh}{${column.columnNameLower},jdbcType=${column.colType}}
	      </#if>
       </#list>
	  </trim>
   </update>
   
   <select id="selectByPrimaryKey" resultMap="BaseResultMap" parameterType="java.lang.Long">
		select *  from ${table} where ${entity.primaryKey} = ${jh}{${fieldPrimaryKey},jdbcType=BIGINT}   limit 1
   </select>
   <select id="selectByPrimaryKeyForUpdate" resultMap="BaseResultMap" parameterType="java.lang.Long">
		select *  from ${table} where ${entity.primaryKey} = ${jh}{${fieldPrimaryKey},jdbcType=BIGINT}   for update
   </select>
   <select id="selectAllInfo" resultMap="BaseResultMap">
	select *  from ${table}
	<trim prefix="where" prefixOverrides="AND |OR "> 
	   <#list columns as column>
          <if test="@com.lcworld.robot.common.Ognl@isNotEmpty(${column.columnNameLower})">and ${column.columnName} = ${jh}{${column.columnNameLower},jdbcType=${column.colType}}</if>
       </#list>
	</trim>
	order  by  ${entity.primaryKey}  desc 
   </select>
   
   <select id="selectPageInfo" resultMap="BaseResultMap">
	select *  from ${table}
	<trim prefix="where" prefixOverrides="AND |OR "> 
	   <#list columns as column>
          <if test="@com.lcworld.robot.common.Ognl@isNotEmpty(${column.columnNameLower})">and ${column.columnName} = ${jh}{${column.columnNameLower},jdbcType=${column.colType}}</if>
       </#list>
	</trim>
	order  by ${entity.primaryKey} desc
	<trim prefix="limit" prefixOverrides=","> 
		<if test="@com.lcworld.robot.common.Ognl@isNumber(start)">${jh}{start,jdbcType=INTEGER},</if>
		<if test="@com.lcworld.robot.common.Ognl@isNotEmpty(end)">${jh}{end,jdbcType=INTEGER}</if>
	</trim> 
   </select>
   
   <select id="count"  resultType="int">
	 select count(*)  from ${table}  
	<trim prefix="where" prefixOverrides="AND |OR "> 
	   <#list columns as column>
          <if test="@com.lcworld.robot.common.Ognl@isNotEmpty(${column.columnNameLower})">and ${column.columnName} = ${jh}{${column.columnNameLower},jdbcType=${column.colType}}</if>
       </#list>
	</trim>
   </select>
   
   <delete id="delete" parameterType="java.lang.Long">
	delete  from ${table} where  ${entity.primaryKey} =  ${jh}{${fieldPrimaryKey},jdbcType=BIGINT}
   </delete>
	
   <update id="remove" parameterType="java.lang.Long">
	update  ${table} set status = 1  where  ${entity.primaryKey} = ${jh}{${fieldPrimaryKey},jdbcType=BIGINT}
   </update>
   
   <select id="findByNamedParam" resultMap="BaseResultMap">
    select *  from   ${table}
    <trim prefix="where" prefixOverrides="AND |OR "> 
	   <#list columns as column>
          <if test="@com.lcworld.robot.common.Ognl@isNotEmpty(${column.columnNameLower})">and ${column.columnName} = ${jh}{${column.columnNameLower},jdbcType=${column.colType}}</if>
       </#list>
	</trim>
	limit 1
   </select>
   
   <select id="findByNamedParamList" resultMap="BaseResultMap">
    select *  from   ${table}
    <trim prefix="where" prefixOverrides="AND |OR "> 
	   <#list columns as column>
          <if test="@com.lcworld.robot.common.Ognl@isNotEmpty(${column.columnNameLower})">and ${column.columnName} = ${jh}{${column.columnNameLower},jdbcType=${column.colType}}</if>
       </#list>
	</trim>  order  by  ${entity.primaryKey}  desc  
	<trim prefix="limit" prefixOverrides=","> 
		<if test="@com.lcworld.robot.common.Ognl@isNumber(start)">${jh}{start,jdbcType=INTEGER},</if>
		<if test="@com.lcworld.robot.common.Ognl@isNotEmpty(end)">${jh}{end,jdbcType=INTEGER}</if>
	</trim> 
   </select>
   
</mapper>
