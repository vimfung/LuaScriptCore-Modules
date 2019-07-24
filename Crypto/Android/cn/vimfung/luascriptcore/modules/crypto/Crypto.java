package cn.vimfung.luascriptcore.modules.crypto;

import android.os.Message;
import android.util.Log;

import java.io.UnsupportedEncodingException;
import java.security.DigestException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import cn.vimfung.luascriptcore.LuaExportType;
import cn.vimfung.luascriptcore.modules.foundation.Encoding;

/**
 * 加密类
 */
public class Crypto implements LuaExportType
{
    /**
     * 对数据使用MD5
     * @param data 需要MD5的数据
     * @return MD5后的数据
     */
    public static byte[] md5(Object data)
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

            try
            {
                MessageDigest md = MessageDigest.getInstance("MD5");
                md.update(rawData);
                return md.digest();
            }
            catch (NoSuchAlgorithmException e)
            {
                e.printStackTrace();
            }

        }

        return null;
    }

    /**
     * 对数据使用SHA1
     * @param data 需要SHA1的数据
     * @return SHA1后的数据
     */
    public static byte[] sha1(Object data)
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

            try
            {
                MessageDigest md = MessageDigest.getInstance("SHA");
                md.update(rawData);
                return md.digest();
            }
            catch (NoSuchAlgorithmException e)
            {
                e.printStackTrace();
            }

        }

        return null;
    }

    /**
     * 对数据使用HMAC-MD5
     *
     * @param data 需要HMAC-MD5的数据
     * @param key 密钥
     * @return HMAC-MD5后的数据
     */
    public static byte[] hmacMD5(Object data, Object key)
    {
        byte[] rawKeyData = null;
        byte[] rawData = null;

        if (key instanceof byte[] || key instanceof String)
        {
            if (key instanceof String)
            {
                rawKeyData = ((String) key).getBytes();
            }
            else
            {
                rawKeyData = (byte[]) key;
            }
        }

        if (data instanceof byte[] || data instanceof String)
        {
            if (data instanceof String)
            {
                rawData = ((String) data).getBytes();
            }
            else
            {
                rawData = (byte[]) data;
            }
        }

        if (rawKeyData != null && rawData != null)
        {
            try
            {
                Mac mac = Mac.getInstance("HmacMD5");
                SecretKeySpec secret = new SecretKeySpec(
                        rawKeyData, "HmacMD5");
                mac.init(secret);
                byte[] result = mac.doFinal(rawData);

                return result;
            }
            catch (InvalidKeyException e)
            {
                e.printStackTrace();
            }
            catch (NoSuchAlgorithmException e)
            {
                e.printStackTrace();
            }
        }

        return null;
    }

    /**
     * 对数据使用HMAC-SHA1
     * @param key 密钥
     * @param data 需要HMAC-SHA1的数据
     * @return HMAC-SHA1后的数据
     */
    public static byte[] hmacSHA1(Object data, Object key)
    {
        byte[] rawKeyData = null;
        byte[] rawData = null;

        if (key instanceof byte[] || key instanceof String)
        {
            if (key instanceof String)
            {
                rawKeyData = ((String) key).getBytes();
            }
            else
            {
                rawKeyData = (byte[]) key;
            }
        }

        if (data instanceof byte[] || data instanceof String)
        {
            if (data instanceof String)
            {
                rawData = ((String) data).getBytes();
            }
            else
            {
                rawData = (byte[]) data;
            }
        }

        if (rawKeyData != null && rawData != null)
        {
            try
            {
                Mac mac = Mac.getInstance("HmacSHA1");
                SecretKeySpec secret = new SecretKeySpec(
                        rawKeyData, "HmacSHA1");
                mac.init(secret);
                byte[] result = mac.doFinal(rawData);

                return result;
            }
            catch (InvalidKeyException e)
            {
                e.printStackTrace();
            }
            catch (NoSuchAlgorithmException e)
            {
                e.printStackTrace();
            }
        }

        return null;
    }
}
