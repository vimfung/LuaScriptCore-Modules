require("Foundation")

-- 获取应用路径示例
function Path_Sample_appPath()

	print(Path:app());

end

-- 获取沙箱根目录示例
function Path_Sample_homePath()
	
	print(Path:home());

end

-- 获取缓存目录示例
function Path_Sample_cachesPath()
	
	print(Path:caches());

end

-- 获取文档目录示例
function Path_Sample_docsPath()
	
	print (Path:docs());

end

-- 获取临时目录示例
function Path_Sample_tmpPath()
	
	print (Path:tmp());

end

-- 判断文件是否存在示例
function Path_Sample_exists()

	print (Path:exists(Path:app() .. "/timg.jpeg"));

end
