package ru.xmlex.vk;

import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.message.BasicNameValuePair;

import java.io.IOException;
import java.util.List;

/**
 * Created by xMlex on 06.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public interface IHttpExecutor {
    public String executeGet(String url, List<BasicNameValuePair> params) throws IOException;

    public String executeRequest(HttpRequestBase r) throws IOException;
}
