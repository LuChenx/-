
package com.os.admin.request.base;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 
 * @ClassName: BaseResq
 * @Description:TODO(请求通用参数)
 * @author: 陆晨�?
 * @date: 2018�?12�?26�? 下午11:42:42
 * 
 * @Copyright: 2018 luchenxi. All rights reserved.
 *             注意：本内容仅限于陆晨曦以及授权组织使用，禁止外泄以及用于其他的商业�?
 */
@ Data
@ AllArgsConstructor
@ NoArgsConstructor
public class BaseResq
{
	//请求发起用户
	String uid;
	//请求客户端
	String appId;
}
