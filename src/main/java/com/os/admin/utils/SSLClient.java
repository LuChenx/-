
package com.os.admin.utils;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.DefaultHttpClient;

/**
 * 
 *
 * <p>Title: SSLClient.java</p> <p>Description: SSLClient.java</p> <p>Copyright:
 * Copyright (c) 2019</p> <p>Company: luchenxi </p>
 * @author luchenxi
 * @version 1.0
 * @creattime 2019年1月2日 上午8:55:43
 */
public class SSLClient extends DefaultHttpClient
{
	public SSLClient() throws Exception
	{
		super();
		SSLContext ctx = SSLContext.getInstance("TLS");
		X509TrustManager tm = new X509TrustManager(){
			@ Override
			public void checkClientTrusted(X509Certificate[] chain , String authType)
				throws CertificateException
			{}

			@ Override
			public void checkServerTrusted(X509Certificate[] chain , String authType)
				throws CertificateException
			{}

			@ Override
			public X509Certificate[] getAcceptedIssuers()
			{
				return null;
			}
		};
		ctx.init(null, new TrustManager[]{tm}, null);
		SSLSocketFactory ssf = new SSLSocketFactory(ctx, SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
		ClientConnectionManager ccm = this.getConnectionManager();
		SchemeRegistry sr = ccm.getSchemeRegistry();
		sr.register(new Scheme("https", 443, ssf));
	}
}
