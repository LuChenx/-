
package com.os.admin.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

/**
 * 
 *
 * <p>Title: HttpClientUtils.java</p> <p>Description: HttpClientUtils.java</p>
 * <p>Copyright: Copyright (c) 2019</p> <p>Company: luchenxi </p>
 * @author luchenxi
 * @version 1.0
 * @creattime 2019��1��2�� ����8:27:55
 */
public class HttpClientUtils
{
	private final static Logger logger = LogManager.getLogger(HttpClientUtils.class);

	public static JSONObject doPost(String url , JSONObject jsonObject)
	{
		HttpClient httpClient = null;
		HttpPost httpPost = null;
		String result = null;
		JSONObject resultJson = new JSONObject();
		try
		{
			httpClient = new SSLClient();
			httpPost = new HttpPost(url);
			List<NameValuePair> list = new ArrayList<NameValuePair>();
			StringEntity entity = new StringEntity(jsonObject.toString(), "UTF-8");
			entity.setContentEncoding("UTF-8");
			entity.setContentType("application/json");
			httpPost.setEntity(entity);
			HttpResponse response = httpClient.execute(httpPost);
			if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK)
			{
				HttpEntity resEntity = response.getEntity();
				if(resEntity != null)
				{
					result = EntityUtils.toString(resEntity, "UTF-8");
				}
			}
		}
		catch (Exception ex)
		{
			logger.error("HTTP请求失败", ex);
		}
		if(StringUtils.isNotEmpty(result))
		{
			resultJson = JSON.parseObject(result);
		}
		return resultJson;
	}
}
