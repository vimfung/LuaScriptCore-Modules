package cn.vimfung.luascriptcore.modules.foundation;

import cn.vimfung.luascriptcore.LuaExportType;
import cn.vimfung.luascriptcore.LuaFunction;
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

    public Thread(LuaFunction handler)
    {
        _handler = handler;
    }

    public void run(LuaValue[] arguments)
    {
        if (_handler != null)
        {
            _handler.getContext().runThread(_handler, arguments);
        }
    }
}
