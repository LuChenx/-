
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
 * <p>Title: BaseController.java</p> <p>Description: BaseController.java</p>
 * <p>Copyright: Copyright (c) 2019</p> <p>Company: luchenxi </p>
 * @author luchenxi
 * @version 1.0
 * @creattime 2019年1月3日 上午9:31:41
 */
@ Controller
@ RequestMapping ("/system/role")
public class BaseController
{
	private Logger logger = LogManager.getLogger(BaseController.class);
	@ Autowired
	SysConfig      systemConfig;

	@ RequestMapping ("/authConfig")
	@ ResponseBody
	public JSONObject authConfig(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/role/authConfig",
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

	@ RequestMapping ("/priceAuthConfig")
	@ ResponseBody
	public JSONObject priceAuthConfig(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/role/priceAuthConfig",
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

	@ RequestMapping ("/config")
	@ ResponseBody
	public JSONObject queryRoleConfig(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/role/conifg", jsonObject);
		}
		catch (Exception e)
		{
			logger.error("请求失败", e);
			result.put("rcode", "400000");
			result.put("rmsg", "网络异常");
		}
		return result;
	}

	@ RequestMapping ("/addconfig")
	@ ResponseBody
	public JSONObject addconfig(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/role/addconfig",
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

	@ RequestMapping ("/updateConfig")
	@ ResponseBody
	public JSONObject updateConfig(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/role/updateConfig",
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

	@ RequestMapping ("/deleteConfig")
	@ ResponseBody
	public JSONObject deleteConfig(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/role/deleteConfig",
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

	@ RequestMapping ("/configDetail")
	@ ResponseBody
	public JSONObject configDetail(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/role/configDetail",
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

	@ RequestMapping ("/roleAuthConfig")
	@ ResponseBody
	public JSONObject roleAuthConfig(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/role/roleAuthConfig",
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
