using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using cn.vimfung.luascriptcore;
using System;
using MiniJSON;


namespace cn.vimfung.luascriptcore.modules.foundation
{
	/// <summary>
	/// 编码类
	/// </summary>
	public class Encoding : object, LuaExportType 
	{
		/// <summary>
		/// URL编码
		/// </summary>
		/// <returns>编码后内容.</returns>
		/// <param name="text">需要编码文本内容.</param>
		public static string urlEncode(string text)
		{
			return WWW.EscapeURL (text, System.Text.Encoding.UTF8);
		}

		/// <summary>
		/// URL解码
		/// </summary>
		/// <returns>解码后内容.</returns>
		/// <param name="text">需要解码文本内容.</param>
		public static string urlDecode(string text)
		{
			return WWW.UnEscapeURL (text, System.Text.Encoding.UTF8);
		}

		/// <summary>
		/// Base64编码
		/// </summary>
		/// <returns>编码后字符串</returns>
		/// <param name="data">需要编码数据</param>
		public static string base64Encode(object data)
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

				return Convert.ToBase64String (rawData);
			}

			return null;
		}

		/// <summary>
		/// Base64解码
		/// </summary>
		/// <returns>解码后数据.</returns>
		/// <param name="text">需要解码文本.</param>
		public static byte[] base64Decode(string text)
		{
			return Convert.FromBase64String (text);
		}

		/// <summary>
		/// JSON编码
		/// </summary>
		/// <returns>编码后JSON字符串.</returns>
		/// <param name="obj">需要编码的对象.</param>
		public static string jsonEncode(object obj)
		{
			return Json.Serialize (obj);
		}

		/// <summary>
		/// JSON解码
		/// </summary>
		/// <returns>解码后对象.</returns>
		/// <param name="text">需要解码的JSON字符串.</param>
		public static object jsonDecode(string text)
		{
			return Json.Deserialize (text);
		}

		/// <summary>
		/// 十六进制编码
		/// </summary>
		/// <returns>编码后字符串.</returns>
		/// <param name="data">需要编码的数据.</param>
		public static string hexEncode(object data)
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

				return BitConverter.ToString (rawData).Replace("-", string.Empty).ToLower();
			}


			return null;
		}

		/// <summary>
		/// 十六进制解码
		/// </summary>
		/// <returns>解码后的数据.</returns>
		/// <param name="text">十六进制编码字符串.</param>
		public static byte[] hexDecode(string text)
		{
			byte[] result = new byte[text.Length / 2];
			for (int x = 0; x < result.Length; x++)
			{
				byte i = Convert.ToByte(text.Substring(x * 2, 2), 16);
				result[x] = (byte)i;
			}
			return result;
		}
	}
}