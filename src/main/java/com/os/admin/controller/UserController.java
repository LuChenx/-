
package com.os.admin.controller;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
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
 * <p>Title: UserController.java</p> <p>Description: UserController.java</p>
 * <p>Copyright: Copyright (c) 2019</p> <p>Company: luchenxi </p>
 * @author luchenxi
 * @version 1.0
 * @creattime 2019年1月2日 上午9:08:38
 */
@ Controller
@ RequestMapping ("/system/user")
public class UserController
{
	private Logger logger = LogManager.getLogger(UserController.class);
	@ Autowired
	SysConfig      systemConfig;

	@ RequestMapping ("/list")
	@ ResponseBody
	public JSONObject list(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/user/list", jsonObject);
		}
		catch (Exception e)
		{
			logger.error("请求失败", e);
			result.put("rcode", "400000");
			result.put("rmsg", "网络异常");
		}
		return result;
	}

	@ RequestMapping ("/addUser")
	@ ResponseBody
	public JSONObject addUser(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/user/addUser", jsonObject);
		}
		catch (Exception e)
		{
			logger.error("请求失败", e);
			result.put("rcode", "400000");
			result.put("rmsg", "网络异常");
		}
		return result;
	}

	@ RequestMapping ("/deleteUser")
	@ ResponseBody
	public JSONObject deleteUser(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/user/deleteUser",
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

	@ RequestMapping ("/updateUser")
	@ ResponseBody
	public JSONObject updateUser(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/user/updateUser",
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

	@ RequestMapping ("/authList")
	@ ResponseBody
	public JSONObject authList(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/user/authList",
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

	@ RequestMapping ("/baseInfo")
	@ ResponseBody
	public JSONObject baseInfo(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/user/userBaseInfo",
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

	@ RequestMapping ("/updateUserBaseInfo")
	@ ResponseBody
	public JSONObject updateUserBaseInfo(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		try
		{
			jsonObject.put("appKey", systemConfig.getAppKey());
			result = HttpClientUtils.doPost(systemConfig.getHostName() + "system/user/updateUserBaseInfo",
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

	@ RequestMapping (value = "/login")
	@ ResponseBody
	public JSONObject login(@ RequestBody JSONObject jsonObject)
	{
		JSONObject result = new JSONObject();
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(jsonObject.getString("account"),
			jsonObject.getString("password"));
		try
		{
			// 跳转入shiro进行身份验证和授权
			subject.login(token);
			// 验证通过后查查询用户信息并将用户信息放入session中
			jsonObject.put("appKey", systemConfig.getAppKey());
			JSONObject httpresp = HttpClientUtils
				.doPost(systemConfig.getHostName() + "system/user/baseinfo", jsonObject);
			result.put("rcode", "000000");
			result.put("rmsg", "验证通过");
			result.put("uid", httpresp.getString("uid"));
			result.put("userName", httpresp.getString("userName"));
			return result;
		}
		catch (UnknownAccountException e)
		{
			logger.error("用户名不存在", e);
			result.put("rcode", "299999");
			result.put("rmsg", "用户名不存在");
		}
		catch (IncorrectCredentialsException e)
		{
			logger.error("密码错误", e);
			result.put("rcode", "299998");
			result.put("rmsg", "密码错误");
		}
		catch (Exception e)
		{
			logger.error("请求失败", e);
			result.put("rcode", "400000");
			result.put("rmsg", "用户名或密码错误");
		}
		return result;
	}
}
