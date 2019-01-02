
package com.os.admin.config;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 
 *
 * <p>Title: SysConfig.java</p> <p>Description: SysConfig.java</p> <p>Copyright:
 * Copyright (c) 2018</p> <p>Company: luchenxi </p>
 * @author luchenxi
 * @version 1.0
 * @creattime 2018年12月27日 上午11:07:38
 */
@ Data
@ NoArgsConstructor
@ AllArgsConstructor
public class SysConfig
{
	//後台接口地址
	String hostName;
	String appKey;
}
