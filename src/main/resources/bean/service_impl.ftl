package com.lcworld.robot.service.impl;


import com.lcworld.robot.service.${className}Service;
import com.lcworld.robot.model.${className};
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.lcworld.robot.dao.${className}Dao;
/**
 * ${className}  
 *  @author fengzy
*/
@Service(value="${className}Service")
public class ${className}ServiceImpl extends BaseMyBatisServiceImpl<${className}> implements ${className}Service 
{
      <#assign classNameLower=classNameLower(className+"Dao")>
      @Resource
      ${className}Dao ${classNameLower};
	  
}
