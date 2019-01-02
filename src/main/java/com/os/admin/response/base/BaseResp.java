
package com.os.admin.response.base;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 
 * @ClassName: BaseResp
 * @Description:TODO(请求返回通用)
 * @author: 陆晨曦
 * @date: 2018年12月26日 下午11:44:46
 * 
 * @Copyright: 2018 luchenxi. All rights reserved.
 *             注意：本内容仅限于陆晨曦以及授权组织使用，禁止外泄以及用于其他的商业目
 */
@ Data
@ NoArgsConstructor
@ AllArgsConstructor
public class BaseResp
{
	//返回码
	String rcode;
	//返回说明
	String rmsg;
}
