
package com.os.admin.controller;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.os.admin.config.SysConfig;
import com.os.admin.utils.HttpClientUtils;

/**
 * 
 *
 * <p>Title: ManagerController.java</p> <p>Description:
 * ManagerController.java</p> <p>Copyright: Copyright (c) 2019</p> <p>Company:
 * luchenxi </p>
 * @author luchenxi
 * @version 1.0
 * @creattime 2019年1月9日 上午11:31:41
 */
@ Controller
@ RequestMapping ("/system/manager")
public class ManagerController
{
	private Logger logger = LogManager.getLogger(ManagerController.class);
	@ Autowired
	SysConfig      systemConfig;

	@ RequestMapping ("/addSupplier")
	@ ResponseBody
	public JSONObject addSupplier(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/manager/addSupplier",
				jsonObject);
		}
		catch (Exception e)
		{
			logger.error("请求失败", e);
			result.put("rcode", "400000");
			result.put("rmsg", "网络异常");
		}
		return result;
	}

	@ RequestMapping ("/supplierList")
	@ ResponseBody
	public JSONObject supplierList(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/manager/supplierList",
				jsonObject);
		}
		catch (Exception e)
		{
			logger.error("请求失败", e);
			result.put("rcode", "400000");
			result.put("rmsg", "网络异常");
		}
		return result;
	}
}
