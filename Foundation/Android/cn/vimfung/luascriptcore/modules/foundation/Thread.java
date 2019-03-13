package cn.vimfung.luascriptcore.modules.foundation;

import cn.vimfung.luascriptcore.LuaExportType;
import cn.vimfung.luascriptcore.LuaFunction;
import cn.vimfung.luascriptcore.LuaScriptController;
import cn.vimfung.luascriptcore.LuaValue;

/**
 * 线程
 */
public final class Thread implements LuaExportType
{
    /**
     * 线程处理器
     */
    private LuaFunction _handler;

    /**
     * 脚本控制器
     */
    private LuaScriptController _scriptController;

    /**
     * 初始化线程
     * @param handler 线程处理器
     */
    public Thread(LuaFunction handler)
    {
        _scriptController = LuaScriptController.create();
        _handler = handler;
    }

    /**
     * 执行线程
     * @param arguments 参数列表
     */
    public void run(LuaValue[] arguments)
    {
        if (_handler != null)
        {
            _handler.getContext().runThread(_handler, arguments, _scriptController);
        }
    }

    /**
     * 退出线程
     */
    public void exit()
    {
        _scriptController.forceExit();
    }
}
