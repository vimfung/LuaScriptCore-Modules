using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using cn.vimfung.luascriptcore;
using System.IO;
using System;

namespace cn.vimfung.luascriptcore.modules.foundation
{
	/// <summary>
	/// 路径工具类
	/// </summary>
	public class Path : object, LuaExportType
	{
		/// <summary>
		/// 获取应用目录
		/// </summary>
		public static string app()
		{
			return Application.streamingAssetsPath;
		}

		/// <summary>
		/// 获取沙箱根目录
		/// </summary>
		public static string home()
		{
			#if UNITY_EDITOR

			return Application.persistentDataPath;

			#elif UNITY_IOS

			string path = Application.persistentDataPath;
			return path.Substring(0, path.LastIndexOf ("/"));

			#else

			return Application.persistentDataPath;

			#endif
		}

		/// <summary>
		/// 获取文档目录
		/// </summary>
		public static string docs()
		{
			#if UNITY_EDITOR || UNITY_ANDROID

			string path = Application.persistentDataPath;
			path = string.Format("{0}/Documents", path);

			if (!Directory.Exists (path))
			{
				Directory.CreateDirectory (path);
			}

			return path;

			#else

			return Application.persistentDataPath;

			#endif
		}

		/// <summary>
		/// 获取缓存目录
		/// </summary>
		public static string caches()
		{
			#if UNITY_EDITOR

			string path = home ();
			path = string.Format ("{0}/Caches", path);

			if (!Directory.Exists (path))
			{
				Directory.CreateDirectory (path);
			}

			return path;

			#else

			return Application.temporaryCachePath;

			#endif
		}

		/// <summary>
		/// 获取临时目录
		/// </summary>
		public static string tmp()
		{
			#if UNITY_EDITOR

			return Application.temporaryCachePath;

			#else

			string path = home ();
			path = string.Format ("{0}/tmp", path);

			if (!Directory.Exists (path))
			{
				Directory.CreateDirectory (path);
			}

			return path;

			#endif
		}


		/// <summary>
		/// 判断指定路径是否存在
		/// </summary>
		/// <param name="path">路径.</param>
		public static bool exists(string path)
		{

			#if UNITY_ANDROID && !UNITY_EDITOR

			bool isAppPath = false;

			if (path.StartsWith(app()))
			{
				path = path.Substring(app().Length + 1);
				isAppPath = true;
			}
			else if (!path.StartsWith("/"))
			{
				isAppPath = true;
			}

			if (isAppPath)
			{
				try
				{
					AndroidJavaObject curActivity = UNIEnv.getCurrentActivity();
					AndroidJavaObject assetManager = curActivity.Call<AndroidJavaObject>("getAssets", new object[0]);
				 	AndroidJavaObject fd = assetManager.Call<AndroidJavaObject>("openFd", new object[1] {path});
					if (fd != null)
					{
						return true;
					}
					return false;
				}
				catch(Exception ex)
				{
					return false;
				}
			}
			else
			{
				if (File.Exists(path))
				{
					return true;
				}
				else
				{
					return Directory.Exists(path);
				}
			}

			#else

			if (File.Exists(path))
			{
				return true;
			}
			else
			{
				return Directory.Exists(path);
			}

			#endif
		}
	}
}