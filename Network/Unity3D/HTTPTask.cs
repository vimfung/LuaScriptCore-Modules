using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;
using System;
using System.IO;

namespace cn.vimfung.luascriptcore.modules.network
{
	/// <summary>
	/// HTTP请求任务
	/// </summary>
	public class HTTPTask : object, LuaExportType
	{
		/// <summary>
		/// Http回复对象
		/// </summary>
		public class HttpResponse : object
		{
			internal HttpResponse(UnityWebRequest req)
			{
				_req = req;
			}

			private UnityWebRequest _req;

			/// <summary>
			/// 获取状态码
			/// </summary>
			/// <value>状态码.</value>
			public long statusCode
			{
				get
				{
					return _req.responseCode;
				}
			}

			/// <summary>
			/// 获取回复头
			/// </summary>
			/// <returns>回复头信息.</returns>
			/// <param name="name">名称.</param>
			public string getResponseHead(string name)
			{
				return _req.GetResponseHeader (name);
			}

			/// <summary>
			/// 获取请求头
			/// </summary>
			/// <returns>请求头信息.</returns>
			/// <param name="name">名称.</param>
			public string getRequestHead(string name)
			{
				return _req.GetRequestHeader (name);
			}
		}

		/// <summary>
		/// HTTP会话类
		/// </summary>
		class HttpSession : MonoBehaviour
		{
			public Action<HttpSession, HttpResponse, byte[]> resultHandler;
			public Action<HttpSession, Exception> faultHandler;
			public Action<HttpSession, ulong, ulong> uploadProgressHandler;
			public Action<HttpSession, ulong, ulong> downloadProgressHandler;

			public IEnumerator send(UnityWebRequest request, float timeout)
			{
				AsyncOperation asyncOp = request.SendWebRequest ();

				ulong curUploadedBytes = 0;
				ulong curDownloadedBytes = 0;
				float elapsedTime = 0.0f;
				while (!asyncOp.isDone)
				{
					elapsedTime += Time.deltaTime;
					if (elapsedTime >= timeout) //Low timing for test
					{
						request.Abort ();
						break;
					}

					if (uploadProgressHandler != null && request.uploadedBytes > 0 && request.uploadedBytes != curUploadedBytes)
					{
						curUploadedBytes = request.uploadedBytes;
						uploadProgressHandler (this, (ulong)(curUploadedBytes / request.uploadProgress), curUploadedBytes);
					}

					if (request.uploadProgress == 1)
					{
						//只有上传完成后才会接受回复
						if (downloadProgressHandler != null && request.downloadedBytes > 0 && request.downloadedBytes != curDownloadedBytes)
						{
							curDownloadedBytes = request.downloadedBytes;
							downloadProgressHandler (this, (ulong)(curDownloadedBytes / request.downloadProgress), curDownloadedBytes);
						}
					}

					yield return null;
				}

				//最后回调一次下载进度
				if (downloadProgressHandler != null)
				{
					downloadProgressHandler (this, (ulong)(request.downloadedBytes / request.downloadProgress), request.downloadedBytes);
				}

				if (request.isNetworkError)
				{
					if (faultHandler != null)
					{
						faultHandler (this, new Exception (request.error));
					}
				}
				else
				{
					HttpResponse response = new HttpResponse (request);
					if (resultHandler != null)
					{
						resultHandler (this, response, request.downloadHandler.data);
					}
				}
			}

			void OnDestroy ()
			{
				resultHandler = null;
				faultHandler = null;
			}
		}

		/// <summary>
		/// 请求地址
		/// </summary>
		public string url {get;set;}

		/// <summary>
		/// 请求头
		/// </summary>
		public Dictionary<string, string> headers {get;set;}

		/// <summary>
		/// 超时时间
		/// </summary>
		public float timeout {get;set;}

		/// <summary>
		/// 网络请求对象
		/// </summary>
		private UnityWebRequest _request;

		/// <summary>
		/// 下载文件保存路径
		/// </summary>
		private string _filePath;

		/// <summary>
		/// 返回回调
		/// </summary>
		private LuaFunction _resultHandler;

		/// <summary>
		/// 失败回调
		/// </summary>
		private LuaFunction _faultHandler;

		/// <summary>
		/// 上传进度回调
		/// </summary>
		private LuaFunction _uploadProgressHandler;

		/// <summary>
		/// 下载进度回调
		/// </summary>
		private LuaFunction _downloadProgressHandler;

		/// <summary>
		/// 填充HTTP请求头
		/// </summary>
		private void fillHeaders()
		{
			if (headers != null)
			{
				foreach (KeyValuePair<string, string> kv in headers)
				{
					_request.SetRequestHeader (kv.Key, kv.Value);
				}
			}
		}

		/// <summary>
		/// 发送请求
		/// </summary>
		private void sendRequest()
		{
			GameObject go = new GameObject ();
			go.name = "HTTPRequest";
			HttpSession session = go.AddComponent<HttpSession> ();
			GameObject.DontDestroyOnLoad (go);

			session.resultHandler = resultCallback;
			session.faultHandler = faultCallback;
			session.uploadProgressHandler = uploadProgressCallback;
			session.downloadProgressHandler = downloadProgressCallback;

			session.StartCoroutine (session.send (_request, timeout));
		}

		/// <summary>
		/// 返回回调处理器
		/// </summary>
		/// <param name="session">会话对象.</param>
		/// <param name="response">回复对象.</param>
		/// <param name="responseData">回复数据.</param>
		private void resultCallback (HttpSession session, HttpResponse response, byte[] responseData)
		{
			if (_filePath != null)
			{
				//写入文件
				FileStream fs = new FileStream(_filePath, FileMode.Create);
				try
				{
					fs.Write (responseData, 0, responseData.Length);
					fs.Flush();
				}
				finally
				{
					fs.Close ();
				}
			}

			if (_resultHandler != null)
			{
				_resultHandler.invoke (new List<LuaValue> () { new LuaValue(response.statusCode), new LuaValue(responseData) });
			}

			GameObject.Destroy (session.gameObject);
		}

		/// <summary>
		/// 失败回调处理器
		/// </summary>
		/// <param name="session">会话对象.</param>
		/// <param name="ex">异常信息.</param>
		private void faultCallback (HttpSession session, Exception ex)
		{
			if (_faultHandler != null)
			{
				_faultHandler.invoke (new List<LuaValue> () { new LuaValue(ex.Message) });
			}

			GameObject.Destroy (session.gameObject);
		}

		/// <summary>
		/// 上传进度回调处理器
		/// </summary>
		/// <param name="session">会话对象.</param>
		/// <param name="totalBytes">总字节数.</param>
		/// <param name="uploadedBytes">已上传字节数.</param>
		private void uploadProgressCallback(HttpSession session, ulong totalBytes, ulong uploadedBytes)
		{
			if (_uploadProgressHandler != null)
			{
				_uploadProgressHandler.invoke (new List<LuaValue> () { new LuaValue(totalBytes), new LuaValue(uploadedBytes) });
			}
		}

		/// <summary>
		/// 下载进度回调处理器
		/// </summary>
		/// <param name="session">会话对象.</param>
		/// <param name="totalBytes">总字节数.</param>
		/// <param name="downloadedBytes">已下载字节数.</param>
		private void downloadProgressCallback(HttpSession session, ulong totalBytes, ulong downloadedBytes)
		{
			if (_downloadProgressHandler != null)
			{
				_downloadProgressHandler.invoke (new List<LuaValue> () { new LuaValue(totalBytes), new LuaValue(downloadedBytes) });
			}
		}

		public HTTPTask()
		{
			timeout = 60;
		}

		/// <summary>
		/// 发起GET请求
		/// </summary>
		/// <param name="resultHandler">返回回调.</param>
		/// <param name="faultHandler">失败回调.</param>
		public void get(LuaFunction resultHandler, LuaFunction faultHandler)
		{
			_resultHandler = resultHandler;
			_faultHandler = faultHandler;
			_request = UnityWebRequest.Get (url);

			if (_request != null)
			{
				fillHeaders ();
				sendRequest ();
			}
		}

		/// <summary>
		/// 发起POST请求
		/// </summary>
		/// <param name="parameters">请求参数.</param>
		/// <param name="resultHandler">返回回调.</param>
		/// <param name="faultHandler">失败回调.</param>
		public void post(
			Dictionary<string, string> parameters, 
			LuaFunction resultHandler, 
			LuaFunction faultHandler)
		{

			_resultHandler = resultHandler;
			_faultHandler = faultHandler;

			WWWForm form = new WWWForm ();
			if (parameters != null)
			{
				foreach (KeyValuePair<string, string> kv in parameters)
				{
					form.AddField (kv.Key, kv.Value);
				}
			}

			_request = UnityWebRequest.Post (url, form);

			if (_request != null)
			{
				fillHeaders ();
				sendRequest ();
			}
		}

		/// <summary>
		/// 上传文件
		/// </summary>
		/// <param name="fileParams">文件参数.</param>
		/// <param name="parameters">请求参数.</param>
		/// <param name="resultHandler">返回回调.</param>
		/// <param name="faultHandler">失败回调.</param>
		/// <param name="progressHandler">进度回调</param>
		public void upload(
			Dictionary<string, HTTPFile> fileParams, 
			Dictionary<string, string> parameters, 
			LuaFunction resultHandler, 
			LuaFunction faultHandler,
			LuaFunction progressHandler)
		{
			_resultHandler = resultHandler;
			_faultHandler = faultHandler;
			_uploadProgressHandler = progressHandler;

			#if UNITY_ANDROID && !UNITY_EDITOR

			string appPath = luascriptcore.modules.foundation.Path.app ();
			AndroidJavaObject currentActivity = UNIEnv.getCurrentActivity ();
			AndroidJavaObject assetManager = currentActivity.Call<AndroidJavaObject> ("getAssets", new object[0]);

			#endif

			WWWForm form = new WWWForm ();
			if (fileParams != null)
			{
				foreach (KeyValuePair<string, HTTPFile> kv in fileParams)
				{
					HTTPFile file = kv.Value;
					string path = file.path;
					byte[] fileData = null;


					#if UNITY_ANDROID && !UNITY_EDITOR

					if (path.StartsWith (appPath)
					    || !path.StartsWith ("/"))
					{
						//应用包内文件
						if (path.StartsWith (appPath))
						{
							path = path.Substring (appPath.Length + 1);
						}

						AndroidJavaObject inputStream = assetManager.Call<AndroidJavaObject> ("open", path);
						using (MemoryStream ms = new MemoryStream ())
						{
							try
							{
								IntPtr buffer = AndroidJNI.NewByteArray (1024);
								jvalue[] args = new jvalue[1];
								args [0].l = buffer;

								IntPtr readMethodId = AndroidJNIHelper.GetMethodID (inputStream.GetRawClass (), "read", "([B)I");
								int hasRead = 0;
								while ((hasRead = AndroidJNI.CallIntMethod (inputStream.GetRawObject (), readMethodId, args)) != -1)
								{
									byte[] byteArray = AndroidJNIHelper.ConvertFromJNIArray<byte[]> (buffer);
									ms.Write (byteArray, 0, hasRead);
								}

								fileData = new byte[ms.Length];
								ms.Read (fileData, 0, (int)ms.Length);

							}
							finally
							{
								ms.Close ();
							}
						}
					}
					else
					{

					#endif

						FileStream fs = new FileStream (path, FileMode.Open);
						try
						{
							fileData = new byte[fs.Length];
							fs.Read (fileData, 0, (int)fs.Length);
						}
						finally
						{
							fs.Close ();
						}

					#if UNITY_ANDROID && !UNITY_EDITOR

					}

					#endif
						
					if (fileData != null)
					{
						form.AddBinaryData (kv.Key, fileData, System.IO.Path.GetFileName (file.path), file.mimeType);
					}

				}
			}

			if (parameters != null)
			{
				foreach (KeyValuePair<string, string> kv in parameters)
				{
					form.AddField (kv.Key, kv.Value);
				}
			}

			_request = UnityWebRequest.Post (url, form);

			if (_request != null)
			{
				fillHeaders ();
				sendRequest ();
			}

		}

		/// <summary>
		/// 下载文件
		/// </summary>
		/// <param name="filePath">下载文件的保存路径.</param>
		/// <param name="resultHandler">返回回调.</param>
		/// <param name="faultHandler">失败回调</param>
		/// <param name="progressHandler">进度回调.</param>
		public void download(
			string filePath,
			LuaFunction resultHandler, 
			LuaFunction faultHandler,
			LuaFunction progressHandler)
		{
			_filePath = filePath;
			_resultHandler = resultHandler;
			_faultHandler = faultHandler;
			_downloadProgressHandler = progressHandler;

			_request = UnityWebRequest.Get (url);

			if (_request != null)
			{
				fillHeaders ();
				sendRequest ();
			}
		}
	}

}