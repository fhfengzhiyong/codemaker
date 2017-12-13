package com.bluepoint.code.freemarkerVariables;

import java.util.List;

import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

public class LabelUpper implements TemplateMethodModel{

	@Override
	public Object exec(List arguments) throws TemplateModelException {
		// TODO Auto-generated method stub
		if(arguments != null && arguments.size()>0){
			String argument = (String) arguments.get(0);
			return argument.toUpperCase().substring(0, 1)+argument.substring(1, argument.length());
		}
		return null;
	}
	
}
