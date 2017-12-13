package com.lcworld.robot.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Locale;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lcworld.robot.common.BaseAction;
import com.lcworld.robot.model.${className};
import com.lcworld.robot.service.${className}Service;
import com.lcworld.robot.utils.CommonUtils;
import com.lcworld.robot.utils.PageBean;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * ${className}  
 *  @author fengzy
*/
<#assign classname=classNameLower(className)>
<#assign getpk="get"+(labelUpper(pk))+"()">
<#assign setpk="set"+(labelUpper(pk))+"(idWorker.nextId())">
@Controller
@RequestMapping("${classname}Front")
public class ${className}FrontAction extends BaseAction<${className}FrontAction> {
	/**
	 */
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(${className}FrontAction.class);
	@Autowired
	${className}Service ${classname}Service;
	
	/**
	 * @Description:分页查询
	 * @param model
	 * @param ${classname}
	 * @return void
	 * @author fengzy ${createDate}
	 */
	//@RequestMapping("findPage")
	public void index(HttpServletRequest request, HttpServletResponse response,Model model, ${className}  ${classname},Locale locale) {
		MessageInfo messageInfo = new MessageInfo();
		Map<String,Object>  resultMap= new HashMap<String,Object>();
		if (request.getParameter("pageNum") != null) { // 判断页面是否第一次进入
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		try {
			// 使用上次保存的查询条件
			Map<String, Object> filterMap = getFilterMap(request);
			boolean useLastFilter = Boolean.parseBoolean(request.getParameter("useLastFilter"));
			if (useLastFilter) {
				if (null != filterMap) {
					pageNum = (int) filterMap.get("pageNum");
					${classname} = ((${className}) filterMap.get("entity"));
				}
			} else {
				filterMap = new HashMap<String, Object>();
				filterMap.put("pageNum", pageNum);
				filterMap.put("entity", ${classname});
			}
			Map<String, Object> map = CommonUtils.convertBean(${classname});
			PageBean<${className}> pageBean = ${classname}Service.findPageBean(pageNum, pageSize,map);
			if (!useLastFilter) {
				setFilterMap(request,filterMap);
			}
			resultMap.put("page", pageBean);
			messageInfo.setObject(resultMap);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("查询${className}失败：" + e.getMessage());
			messageInfo.setMessage("sys.message.error");
			messageInfo.setResult(false);
		}
		super.responseJson(response, messageInfo,locale);
	}
	
	/**
	 * @Description: 查询所有
	 * @param model
	 * @param ${classname}
	 * @param locale  
	 * @return void
	 * @author ${createDate}
	 */
	//@RequestMapping("findAll")
	public void findAll(HttpServletRequest request, HttpServletResponse response,Model model, ${className}  ${classname},Locale locale){
		MessageInfo messageInfo = new MessageInfo();
		try {
			Map<String, Object> map = CommonUtils.convertBean( ${classname});
			List<${className}> bean = ${classname}Service.findAll(map);
			/**if (!this.isUseLastFilter()) {
			  *this.saveFilter(filterMap);
			 }*/
			messageInfo.setObject(bean);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("查询所有${className}失败：" + e.getMessage());
			messageInfo.setMessage("sys.message.error");
			messageInfo.setResult(false);
		}
		super.responseJson(response, messageInfo,locale);
	}
	
	/**
	 * @Description: 增加
	 * @param ${classname}  
	 * @return void
	 * @author fengzy ${createDate}
	 */
	//@RequestMapping("add")
	public void add(HttpServletRequest request, HttpServletResponse response,${className} ${classname},Locale locale) {
		MessageInfo messageInfo = new MessageInfo();
		try {
			${classname}.${setpk};
			this.${classname}Service.insert(${classname});
		} catch (Exception e) {
			e.printStackTrace();
			log.error("新增${className}失败：" + e.getMessage());
			messageInfo.setMessage("sys.message.error");
			messageInfo.setResult(false);
		}
		super.responseJson(response, messageInfo,locale);
	}
	/**
	 * @Description: 修改
	 * @param   ${classname}
	 * @return void
	 * @author fengzy ${createDate}
	 */
	//@RequestMapping("update")
	public void edit(HttpServletRequest request, HttpServletResponse response,${className} ${classname},Locale locale) {
		MessageInfo messageInfo = new MessageInfo();
		try {
			${classname}Service.update(${classname});
		} catch (Exception e) {
			e.printStackTrace();
			log.error("修改${className}失败：" + e.getMessage());
			messageInfo.setMessage("sys.message.error");
			messageInfo.setResult(false);
		}
		super.responseJson(response, messageInfo,locale);
	}
	
	/**
	 * @Description: 详细
	 * @param model
	 * @param ${classname}  
	 * @return void
	 * @author fengzy ${createDate}
	 */
	//@RequestMapping("detail")
	public void detail(HttpServletRequest request, HttpServletResponse response,Model model,${className} ${classname},Locale locale) {
		MessageInfo messageInfo = new MessageInfo();
		List<Object> resultList = new ArrayList<Object>();
		try {
			${className} bean =  ${classname}Service.selectByPrimaryKey(${classname}.${getpk});
			model.addAttribute("${classname}", bean);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("查询${className}失败：" + e.getMessage());
			messageInfo.setMessage("sys.message.error");
			messageInfo.setResult(false);
		}
		super.responseJson(response, messageInfo,locale);
	}

	/**
	 * @Description: 删除
	 * @param ${classname}  
	 * @return void
	 * @author fengzy ${createDate}
	 */
	//@RequestMapping("delete")
	public void delete(HttpServletRequest request, HttpServletResponse response,${className} ${classname},Locale locale) {
		MessageInfo messageInfo = new MessageInfo();
		try {
			${classname}Service.delete(${classname}.${getpk});
		} catch (Exception e) {
			e.printStackTrace();
			log.error("删除${className}失败：" + e.getMessage());
			messageInfo.setMessage("sys.message.error");
			messageInfo.setResult(false);
		}
		super.responseJson(response, messageInfo,locale);
	}
	//@RequestMapping("business")
	public void business(HttpServletRequest request, HttpServletResponse response,${className} ${classname},Locale locale) {
		MessageInfo messageInfo = new MessageInfo();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// resultMap = ${classname}Service.business(${classname}); 
			messageInfo.setObject(resultMap.get("messageInfo_object"));
			messageInfo.setErrorCode(resultMap.get("messageInfo_errorCode")==null?messageInfo.getErrorCode():Integer.parseInt(resultMap.get("messageInfo_errorCode")+""));
			messageInfo.setMessage(resultMap.get("messageInfo_message")==null?messageInfo.getMessage():resultMap.get("messageInfo_message")+"");
			messageInfo.setResult(resultMap.get("messageInfo_result")==null?messageInfo.isResult():Boolean.parseBoolean(""+resultMap.get("messageInfo_result")));
		} catch (Exception e) {
			e.printStackTrace();
			log.error("操作About失败：" + e.getMessage());
			messageInfo.setMessage("sys.message.error");
			messageInfo.setResult(false);
		}
		super.responseJson(response, messageInfo,locale);
	}
}
