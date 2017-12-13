package com.lcworld.robot.service.impl;

import java.util.HashMap;
import java.util.Map;
import com.lcworld.robot.service.${className}Service;
import com.lcworld.robot.model.${className};
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.lcworld.robot.dao.${className}Dao;

import com.lcworld.robot.cache.RedisCacheKey;
import com.lcworld.robot.cache.RedisCacheable;
import com.lcworld.robot.cache.annotation.RedisCacheEvict;
import com.lcworld.robot.utils.PageBean;
import javax.annotation.Resource;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ${className}  
 *  @author fengzy
*/
@Service(value="${className}Service")
public class ${className}ServiceImpl extends BaseMyBatisServiceImpl<${className}> implements ${className}Service 
{
      <#assign classNameLowerDao=classNameLower(className+"Dao")>
      <#assign classNameLower=classNameLower(className)>
      @Resource
      ${className}Dao ${classNameLowerDao};
	  
	public Map<String, Object> business() {
	  		Map<String, Object> paramsMap = new HashMap<String,Object>();
			Map<String, Object> resultMap = new HashMap<String, Object>();
	  		resultMap.put("messageInfo_object",null);
			resultMap.put("messageInfo_errorCode", 0);
			resultMap.put("messageInfo_message", "sys.message.error");
			resultMap.put("messageInfo_result", false);
			return resultMap;
		}
	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public PageBean<${className}> findPageBean(int pageNum, int pageSize, Map<String, Object> map) {
		PageBean<${className}> pageBean = super.findPageBean(pageNum, pageSize, map);
		return pageBean;
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public List<${className}> findAll(Map<String, Object> hashMap) {
		List<${className}> bean = super.findAll(hashMap);
		return bean;
	}

	@Override
	//@RedisCacheEvict()
	public int insert(${className} ${classNameLower}) {
		int i = super.insert(${classNameLower});
		return i;
	}

	@Override
	//@RedisCacheEvict()
	public int delete(Serializable id) {
		return super.delete(id);
	}

	@Override
	//@RedisCacheEvict( )
	public int update(${className} ${classNameLower}) {
		return super.update(${classNameLower});
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME)
	public ${className} selectByPrimaryKey(/**@RedisCacheKey*/ Serializable id) {
		${className} ${classNameLower} = super.selectByPrimaryKey(id);
		return ${classNameLower};
	}
	@Override
	//@RedisCacheEvict()
	public int remove(Serializable id) {
		return super.remove(id);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME)
	public List<${className}> findAll() {
		return super.findAll();
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public List<${className}> findPageInfo(int[] page, Map<String, Object> hashMap) {
		return super.findPageInfo(page, hashMap);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public List<${className}> findPageInfo(int[] page, Serializable serializable) {
		return super.findPageInfo(page, serializable);
	}


	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public RemoteObject<${className}> selectPageInfo(int[] page, Map<String, Object> hashMap) {
		return super.selectPageInfo(page, hashMap);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public RemoteObject<${className}> selectPageInfo(int[] page, Map<String, Object> hashMap, Object[] obj) {
		return super.selectPageInfo(page, hashMap, obj);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public List<Serializable> getIds(List<?> tmplist, String propertyName) {
		return super.getIds(tmplist, propertyName);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public List<${className}> findByNamedParamList(Map<String, Object> hashMap) {
		return super.findByNamedParamList(hashMap);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public List<${className}> findByNamedParamList(Serializable serializable) {
		return super.findByNamedParamList(serializable);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public ${className} findByNamedParam(Serializable serializable) {
		return super.findByNamedParam(serializable);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public ${className} findByNamedParam(Map<String, Object> hashMap) {
		return super.findByNamedParam(hashMap);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public List<${className}> findAll(Object serializable) {
		return super.findAll(serializable);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public List<${className}> findPageInfo(int[] page, Map<String, Object> hashMap, Object[] obj) {
		return super.findPageInfo(page, hashMap, obj);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public <E> RemoteObject<E> selectPageInfoSpecial(int[] page, Map<String, Object> hashMap, Object[] obj) {
		return super.selectPageInfoSpecial(page, hashMap, obj);
	}
	@Override
	//@RedisCacheEvict()
	public void insertBatch(List<${className}> list) {
		super.insertBatch(list);
	}

	@Override
	//@RedisCacheable(expire=Constants.CACHETIME,keyMode=RedisCacheable.KeyMode.ALL)
	public PageBean<${className}> findPageBean(int pageNum, int pageSize, Map<String, Object> map, String mapperNsId, String countId) {
		return super.findPageBean(pageNum, pageSize, map, mapperNsId, countId);
	}
}
