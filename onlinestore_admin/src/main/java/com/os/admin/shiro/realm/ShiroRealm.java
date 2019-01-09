
package com.os.admin.shiro.realm;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.os.admin.config.SysConfig;
import com.os.admin.utils.HttpClientUtils;

/**
 * 验证授权
 * 
 * @author luchenxi
 *
 */
public class ShiroRealm extends AuthorizingRealm
{
	private Logger	  logger = LogManager.getLogger(ShiroRealm.class);
	@ Resource
	private SysConfig systemConfig;

	/**
	 * 为当前登陆成功的用户授予权限和角色
	 */
	@ Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals)
	{
		String account = (String) principals.getPrimaryPrincipal(); // 获取用户名
		SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
		//查询用户角色
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("appId", "1");
		jsonObject.put("account", account);
		jsonObject.put("appKey", systemConfig.getAppKey());
		JSONObject httpresp = HttpClientUtils.doPost(systemConfig.getHostName() + "system/user/baseinfo",
			jsonObject);
		JSONArray roleArr = httpresp.getJSONArray("roles");
		JSONArray authArr = httpresp.getJSONArray("auths");
		Set<String> roles = new HashSet<>();
		for(int i = 0 ; i < roleArr.size() ; i++)
		{
			roles.add(roleArr.getJSONObject(i).getString("roleId"));
		}
		authorizationInfo.setRoles(roles);
		//查询用户拥有的权限
		Set<String> auths = new HashSet<>();
		for(int i = 0 ; i < authArr.size() ; i++)
		{
			auths.add(authArr.getJSONObject(i).getString("authId"));
		}
		authorizationInfo.setStringPermissions(auths);
		return authorizationInfo;
	}

	/**
	 * 验证登录信息
	 */
	@ Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException
	{
		String account = (String) token.getPrincipal(); // 获取用户名(工号)
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("appId", "1");
		jsonObject.put("account", account);
		jsonObject.put("valid", "1");
		jsonObject.put("appKey", systemConfig.getAppKey());
		JSONObject httpresp = HttpClientUtils.doPost(systemConfig.getHostName() + "system/user/baseinfo",
			jsonObject);
		if(httpresp.getString("rcode").equals("000000"))
		{
			AuthenticationInfo authcInfo = new SimpleAuthenticationInfo(account,
				httpresp.getString("password"), "shiroRealm");
			return authcInfo;
		}
		else
		{
			logger.info(httpresp.getString("rprompt"));
			return null;
		}
	}
}
