using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace cn.vimfung.luascriptcore.modules.foundation
{
	/// <summary>
	/// 线程
	/// </summary>
	public class Thread : object, LuaExportType
	{
		private LuaFunction _handler;
		private LuaScriptController _scriptController;

		/// <summary>
		/// 初始化
		/// </summary>
		/// <param name="handler">线程处理器.</param>
		public Thread (LuaFunction handler)
		{
			_scriptController = new LuaScriptController ();
			_handler = handler;
		}

		/// <summary>
		/// 执行线程
		/// </summary>
		/// <param name="arguments">线程参数.</param>
		public void run(List<LuaValue> arguments)
		{
			_handler.context.runThread (_handler, arguments, _scriptController);
		}

		/// <summary>
		/// 退出线程
		/// </summary>
		public void exit()
		{
			_scriptController.forceExit ();
		}
	}
}