
package com.os.admin.controller;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.os.admin.config.SysConfig;
import com.os.admin.utils.ExcelUtils;
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

	@ RequestMapping ("/updateSupplier")
	@ ResponseBody
	public JSONObject updateSupplier(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/manager/updateSupplier",
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

	@ RequestMapping ("/supplierUserList")
	@ ResponseBody
	public JSONObject supplierUserList(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/manager/supplierUserList",
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

	@ RequestMapping ("/addSupplierUser")
	@ ResponseBody
	public JSONObject addSupplierUser(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/manager/addSupplierUser",
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

	@ RequestMapping ("/deleteSupplierUser")
	@ ResponseBody
	public JSONObject deleteSupplierUser(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils
				.doPost(systemConfig.getHostName() + "system/manager/deleteSupplierUser", jsonObject);
		}
		catch (Exception e)
		{
			logger.error("请求失败", e);
			result.put("rcode", "400000");
			result.put("rmsg", "网络异常");
		}
		return result;
	}

	@ RequestMapping ("/deleteSupplier")
	@ ResponseBody
	public JSONObject deleteSupplier(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/manager/deleteSupplier",
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

	@ RequestMapping ("/updateSupplierUser")
	@ ResponseBody
	public JSONObject updateSupplierUser(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils
				.doPost(systemConfig.getHostName() + "system/manager/updateSupplierUser", jsonObject);
		}
		catch (Exception e)
		{
			logger.error("请求失败", e);
			result.put("rcode", "400000");
			result.put("rmsg", "网络异常");
		}
		return result;
	}

	@ RequestMapping ("/uploadSupplier")
	@ ResponseBody
	public JSONObject uploadSupplier(MultipartFile file)
	{
		JSONObject result = new JSONObject();
		try
		{
			JSONObject request = new JSONObject();
			//读取Excel中的数据
			List<List<String>> datas = ExcelUtils.readExcel(file);
			request.put("rows", JSONObject.toJSONString(datas));
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/manager/uploadSupplier",
				request);
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
