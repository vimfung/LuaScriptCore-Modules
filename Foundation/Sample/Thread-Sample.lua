require("Foundation")

-- 启动线程
function Thread_Sample_run()

    local t = Thread(function ()

      while(1)
      do
          print ("============ thread 1 handler");
      end

    end);

    local t2 = Thread(function ()

        print ("============ thread 2 handler");

    end);

    targetThread = t;

    t:run();
    t2:run();

end

-- 结束线程
function Thread_Sample_stop()

    if targetThread ~= nil then
        targetThread:exit();
    end

end
