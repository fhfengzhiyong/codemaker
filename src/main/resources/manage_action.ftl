package com.lcworld.robot.action;

import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.lcworld.robot.model.${className};
import com.lcworld.robot.service.${className}Service;
import com.lcworld.robot.utils.CommonUtils;
import com.lcworld.robot.utils.PageBean;
import com.lcworld.robot.utils.Template;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
/**
 * ${className}  
 *  @author fengzy
*/
<#assign classname=classNameLower(className)>
<#assign getpk="get"+(labelUpper(pk))+"()">
<#assign setpk="set"+(labelUpper(pk))+"(idWorker.nextId())">
@Controller
@RequestMapping("${classname}Manage")
public class ${className}ManageAction extends BaseAction<${className}ManageAction> {
	/**
	 */
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(${className}ManageAction.class);
	@Autowired
	${className}Service ${classname}Service;

	@RequestMapping("index")
	public String index(HttpServletRequest request, HttpServletResponse response,Model model, ${className}  ${classname}) {
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
			model.addAttribute("${classname}",${classname});
			model.addAttribute("pageBean", pageBean);
		} catch (Exception e) {
			log.error("查询${className}失败：" + e.getMessage());
			return Template.common("500");
		}
		return Template.view("${classname}/${classname}_list");
	}

	@RequestMapping("toAdd")
	public String toAdd(HttpServletRequest request, HttpServletResponse response,Model model) {
		return Template.view("${classname}/${classname}_add");
	}

	@RequestMapping("add")
	public void add(HttpServletRequest request, HttpServletResponse response,${className} ${classname}) {
		MessageInfo messageInfo = new MessageInfo();
		try {
			${classname}.${setpk};
			this.${classname}Service.insert(${classname});
		} catch (Exception e) {
			log.error("新增${className}失败：" + e.getMessage());
			messageInfo.setMessage("操作失败！");
			messageInfo.setResult(false);
		}
		super.responseJson(response, messageInfo);
	}

	@RequestMapping("toUpdate")
	public String toEdit(HttpServletRequest request, HttpServletResponse response,Model model, ${className} ${classname}) {
		${className} bean =  ${classname}Service.selectByPrimaryKey(${classname}.${getpk});
		model.addAttribute("${classname}", bean);
		return Template.view("${classname}/${classname}_update");
	}

	@RequestMapping("update")
	public void edit(HttpServletRequest request, HttpServletResponse response,${className} ${classname}) {
		MessageInfo messageInfo = new MessageInfo();
		try {
			${classname}Service.update(${classname});
		} catch (Exception e) {
			log.error("修改${className}失败：" + e.getMessage());
			messageInfo.setMessage("操作失败！");
			messageInfo.setResult(false);
		}
		super.responseJson(response, messageInfo);
	}

	@RequestMapping("detail")
	public String detail(HttpServletRequest request, HttpServletResponse response,Model model,${className} ${classname}) {
		${className} bean =  ${classname}Service.selectByPrimaryKey(${classname}.${getpk});
		model.addAttribute("${classname}", bean);
		return Template.view("${classname}/${classname}_detail");
	}

	@RequestMapping("delete")
	public void delete(HttpServletRequest request, HttpServletResponse response,${className} ${classname}) {
		MessageInfo messageInfo = new MessageInfo();
		try {
			${classname}Service.delete(${classname}.${getpk});
		} catch (Exception e) {
			log.error("删除${className}失败：" + e.getMessage());
			messageInfo.setMessage("操作失败！");
			messageInfo.setResult(false);
		}
		super.responseJson(response, messageInfo);
	}
	/**
	 * 批量删除
	 * @param request
	 * @param response
	 * @param ids
	 */
	@RequestMapping("batchDelete")
	public void batchDelete(HttpServletRequest request, HttpServletResponse response,String ids){
		MessageInfo messageInfo = new MessageInfo();
		int count = 0;
		try {
			if(StringUtils.isNoneBlank(ids)){
				String [] arrIds = ids.split(",");
				if(arrIds != null && arrIds.length>0 ){
					for(int i=0;i<arrIds.length;i++){
						if(StringUtils.isNotBlank(arrIds[i])){
							try {
								${classname}Service.delete(Long.parseLong(arrIds[i]));
								count ++;
							} catch (Exception e) {
								log.error("删除Message失败：" + e.getMessage());
								messageInfo.setMessage("操作失败！");
								messageInfo.setResult(false);
							}
						}
					}
				}
			}
		} catch (Exception e) {
			log.error("删除Message失败：" + e.getMessage());
			messageInfo.setMessage("操作失败！");
			messageInfo.setResult(false);
		}
		messageInfo.setMessage("成功删除"+count+"条!");
		super.responseJson(response, messageInfo);
	}
}
