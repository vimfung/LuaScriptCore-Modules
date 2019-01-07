require("Foundation")

-- 启动线程
function Thread_Sample_run()

    local a = 1024;
    local b = "xxxxxx";

	local t = Thread(function ()

--         while(1)
--         do
            print (a, b);
            a = 1024;
            b = "Hahahahahahah";
            
--         end

	end);

    local t2 = Thread(function ()

--         while(1)
--         do
        	print ("**", a, b);
        	a = 512;
            b = "xxxxxx";
--         end

    end);

    t:run();
    t2:run();

end
