package com.bluepoint.weiqi.mapper;

import java.util.HashMap;
import java.util.List;

import com.bluepoint.weiqi.entity.${className};

/**
 * match_info mapper类
 * Tue Jul 02 08:46:20 CST 2013 create by  wangchao 
*/ 

public interface ${className}Mapper 
{

	int insert(${className} ${classNameParam}); 

	${className} selectByPrimaryKey(long ${primaryKey}); 

	List<${className}> selectAllInfo(); 

	List<${className}> selectPageInfo(HashMap<String,Object> hashMap); 

	int update(${className} ${classNameParam}); 

	int delete(long ${primaryKey}); 

	int remove(long ${primaryKey}); 
	
	int count(HashMap<String, Object> hashMap);

}
