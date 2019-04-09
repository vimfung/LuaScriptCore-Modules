require("Foundation")

-- 启动线程
function Thread_Sample_run()

    local t = Thread(function ()

       while(1)
       do
           print ("trhead1", a, b);
           a = 1024;
           b = "Hahahahahahah";

       end

        -- for i=1,10 do
        --     print('thread =============', i);
        -- end

    end);

    local t2 = Thread(function ()

--        while(1)
--        do
            print ("thread2", a, b);
            a = 512;
            b = "xxxxxx";
--        end

    end);

    local a = 1024;
    local b = "xxxxxx";

    targetThread = t;

    t:run();
    t2:run();

    for i=1,10 do
        print('main =============', i);
    end

end

-- 结束线程
function Thread_Sample_stop()

    if targetThread ~= nil then
        targetThread:exit();
    end

end
