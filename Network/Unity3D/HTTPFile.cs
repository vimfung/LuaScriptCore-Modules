using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace cn.vimfung.luascriptcore.modules.network
{
	/// <summary>
	/// HTTP上传文件
	/// </summary>
	public class HTTPFile : object, LuaExportType
	{
		/// <summary>
		/// 上传文件路径
		/// </summary>
		public string path {get; set;}

		private string _mimeType;

		/// <summary>
		/// 内容类型
		/// </summary>
		public string mimeType
		{
			get
			{
				if (_mimeType == null)
				{
					_mimeType = "application/octet-stream";
				}
				return _mimeType;
			}
			set
			{
				_mimeType = value;
			}
		}

		/// <summary>
		/// 传输编码
		/// </summary>
		public string transferEncoding {get; set;}
	}
}