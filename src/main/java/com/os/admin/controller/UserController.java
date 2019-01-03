
package com.os.admin.controller;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.os.admin.config.SysConfig;

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
}
