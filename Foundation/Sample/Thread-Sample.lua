require("Foundation")

-- 启动线程
function Thread_Sample_run()

    local t = Thread(function ()

        while(1)
        do
            print (a, b);
            a = 1024;
            b = "Hahahahahahah";

--            error("--------- error");

        end

    end);

    local t2 = Thread(function ()

        -- while(1)
        -- do
--        print ("**", a, b);
        a = 512;
        b = "xxxxxx";
        -- end

    end);

    local a = 1024;
    local b = "xxxxxx";

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
