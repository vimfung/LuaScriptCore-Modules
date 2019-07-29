using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Security.Cryptography;

namespace cn.vimfung.luascriptcore.modules.crypto
{

	/// <summary>
	/// 加密模块
	/// </summary>
	public class Crypto : object, LuaExportType 
	{
		public static byte[] md5(object data)
		{
			if (data is byte[] || data is string)
			{
				byte[] rawData = null;
				if (data is string)
				{
					rawData = System.Text.Encoding.UTF8.GetBytes (data as string);
				}
				else
				{
					rawData = data as byte[];
				}

				MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();
				return md5Hasher.ComputeHash(rawData);

			}

			return null;
		}

		public static byte[] sha1(object data)
		{
			if (data is byte[] || data is string)
			{
				byte[] rawData = null;
				if (data is string)
				{
					rawData = System.Text.Encoding.UTF8.GetBytes (data as string);
				}
				else
				{
					rawData = data as byte[];
				}
					
				SHA1CryptoServiceProvider shaHasher = new SHA1CryptoServiceProvider();
				return shaHasher.ComputeHash(rawData);

			}

			return null;
		}

		public static byte[] hmacMD5(object data, object key)
		{
			byte[] rawKey = null;
			byte[] rawData = null;

			if (data is byte[] || data is string)
			{
				if (data is string)
				{
					rawData = System.Text.Encoding.UTF8.GetBytes (data as string);
				}
				else
				{
					rawData = data as byte[];
				}
			}

			if (key is byte[] || key is string)
			{
				if (key is string)
				{
					rawKey = System.Text.Encoding.UTF8.GetBytes (key as string);
				}
				else
				{
					rawKey = key as byte[];
				}
			}

			if (data != null && key != null)
			{
				HMACMD5 hmac = new HMACMD5 (rawKey);
				return hmac.ComputeHash (rawData);
			}

			return null;
		}

		public static byte[] hmacSHA1(object data, object key)
		{
			byte[] rawKey = null;
			byte[] rawData = null;

			if (data is byte[] || data is string)
			{
				if (data is string)
				{
					rawData = System.Text.Encoding.UTF8.GetBytes (data as string);
				}
				else
				{
					rawData = data as byte[];
				}
			}

			if (key is byte[] || key is string)
			{
				if (key is string)
				{
					rawKey = System.Text.Encoding.UTF8.GetBytes (key as string);
				}
				else
				{
					rawKey = key as byte[];
				}
			}

			if (data != null && key != null)
			{
				HMACSHA1 hmac = new HMACSHA1 (rawKey);
				return hmac.ComputeHash (rawData);
			}

			return null;
		}
	}
}