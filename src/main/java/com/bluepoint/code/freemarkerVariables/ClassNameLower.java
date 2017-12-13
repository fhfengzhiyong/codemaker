package com.bluepoint.code.freemarkerVariables;

import java.util.List;

import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

public class ClassNameLower  implements TemplateMethodModel{
	@Override
	
	public Object exec(List arguments) throws TemplateModelException {
		if(arguments != null && arguments.size()>0){
			String argument = (String) arguments.get(0);
			return argument.toLowerCase().substring(0, 1)+argument.substring(1, argument.length());
		}
		return null;
	}

}
