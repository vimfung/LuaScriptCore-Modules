package cn.vimfung.luascriptcore.modules.foundation;

import android.util.Base64;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import cn.vimfung.luascriptcore.LuaExportType;

/**
 * 编码工具类
 */
public final class Encoding implements LuaExportType
{
    /**
     * 对文本进行URL编码
     * @param text  文本内容
     * @return  编码后的文本内容
     */
    public static String urlEncode(String text)
    {
        try
        {
            return URLEncoder.encode(text, "utf-8");
        }
        catch (UnsupportedEncodingException e)
        {
            return "";
        }
    }

    /**
     * 对文本进行URL解码
     * @param text  文本内容
     * @return  解码后文本内容
     */
    public static String urlDecode(String text)
    {
        try
        {
            return URLDecoder.decode(text, "utf-8");
        }
        catch (UnsupportedEncodingException e)
        {
            return "";
        }
    }

    /**
     * 对数据进行Base64编码
     * @param data 需要编码数据
     * @return 编码后文本
     */
    public static String base64Encode(Object data)
    {
        if (data instanceof byte[] || data instanceof String)
        {
            byte[] rawData = null;
            if (data instanceof String)
            {
                rawData = ((String) data).getBytes();
            }
            else
            {
                rawData = (byte[]) data;
            }

            return Base64.encodeToString(rawData, Base64.DEFAULT);
        }

        return null;
    }

    /**
     * 对文本进行Base64解码
     * @param text 需要解码文本
     * @return 解码后数据
     */
    public static byte[] base64Decode(String text)
    {
        return Base64.decode(text, Base64.DEFAULT);
    }

    /**
     * 将对象进行JSON编码
     * @param data 需要编码对象
     * @return 编码后的JSON字符串
     */
    public static String jsonEncode(Object data)
    {
        if (data instanceof Map)
        {
            JSONObject object = new JSONObject((Map) data);
            return object.toString();
        }
        else if (data instanceof List)
        {
            JSONArray array = new JSONArray((List) data);
            return array.toString();
        }

        return null;
    }

    /**
     * 将JSON字符串进行解码
     * @param text 需要解码的JSON字符串
     * @return 解码后的对象
     */
    public static Object jsonDecode(String text)
    {

        try
        {

            if (text.matches("^\\s*[\\{].*[\\}]\\s*$"))
            {
                JSONObject object = new JSONObject(text);
                return toMap(object);
            }
            else if (text.matches("^\\s*[\\[].*[\\]]\\s*$"))
            {
                JSONArray array = new JSONArray(text);
                return toList(array);
            }
        }
        catch (JSONException e)
        {

        }

        return null;
    }

    private static Map<String, Object> toMap(JSONObject jsonobj)  throws JSONException
    {
        Map<String, Object> map = new HashMap<String, Object>();
        Iterator<String> keys = jsonobj.keys();
        while(keys.hasNext())
        {
            String key = keys.next();
            Object value = jsonobj.get(key);
            if (value instanceof JSONArray)
            {
                value = toList((JSONArray) value);
            }
            else if (value instanceof JSONObject)
            {
                value = toMap((JSONObject) value);
            }
            map.put(key, value);
        }   return map;
    }

    private static List<Object> toList(JSONArray array) throws JSONException
    {
        List<Object> list = new ArrayList<Object>();
        for(int i = 0; i < array.length(); i++)
        {
            Object value = array.get(i);
            if (value instanceof JSONArray)
            {
                value = toList((JSONArray) value);
            }
            else if (value instanceof JSONObject)
            {
                value = toMap((JSONObject) value);
            }
            list.add(value);
        }   return list;
    }
}
