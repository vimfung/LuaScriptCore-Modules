using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using cn.vimfung.luascriptcore;


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
	}
}