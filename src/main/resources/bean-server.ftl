    <#list columns as column>
    <bean name="/com.bluepoint.taijisoft.service.${column.fixPackage}.${column.className}Service" class="com.bluepoint.weiqi.common.hessian.BluepointHessianServiceExporter">
         <property name="service" ref="${column.classNameLower}ServiceImpl"/>
         <property name="serviceInterface" value="com.bluepoint.taijisoft.service.${column.fixPackage}.${column.className}Service"/>
    </bean>
    </#list>
    <#list columns as column>
      <mapper resource="dao/sqlmap/${column.className}Mapper.xml" />
    </#list>
    <#list columns as column>
    public ${column.className}Service get${column.className}Service()
    {
        try
        {
            Object object = factory.create(${column.className}Service.class, getServiceURL() + ${column.className}Service.class.getName());
            return ${column.className}Service.class.cast(object);
        }
        catch (MalformedURLException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }
    </#list>