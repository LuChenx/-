
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
 * <p>Title: ConfigController.java</p> <p>Description: ConfigController.java</p>
 * <p>Copyright: Copyright (c) 2019</p> <p>Company: luchenxi </p>
 * @author luchenxi
 * @version 1.0
 * @creattime 2019年1月9日 上午11:31:41
 */
@ Controller
@ RequestMapping ("/system/config")
public class ConfigController
{
	private Logger logger = LogManager.getLogger(ConfigController.class);
	@ Autowired
	SysConfig      systemConfig;

	@ RequestMapping ("/optionTypeList")
	@ ResponseBody
	public JSONObject optionTypeList(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/config/optionTypeList",
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

	@ RequestMapping ("/options")
	@ ResponseBody
	public JSONObject options(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/config/options",
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
