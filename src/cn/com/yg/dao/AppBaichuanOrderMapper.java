package cn.com.yg.dao;

import cn.com.yg.model.AppBaichuanOrder;

public interface AppBaichuanOrderMapper {
    int deleteByPrimaryKey(String id);

    int insert(AppBaichuanOrder record);

    int insertSelective(AppBaichuanOrder record);

    AppBaichuanOrder selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(AppBaichuanOrder record);

    int updateByPrimaryKey(AppBaichuanOrder record);
}