require("Foundation")

-- URL编码示例
function Encoding_Sample_urlEncode()
	
	print(Encoding:urlEncode("https://www.baidu.com/s?wd=你的名字"));

end

-- URL解码示例
function Encoding_Sample_urlDecode()
	
	print(Encoding:urlDecode("https://www.baidu.com/s?wd=%E4%B8%8A%E4%BC%A0"));

end

-- Base64编码示例
function Encoding_Sample_base64Encode()
	
	print(Encoding:base64Encode("Hello LuaScriptCore"));

end

-- Base64解码示例
function Encoding_Sample_base64Decode()

    print(Encoding:base64Decode("SGVsbG8gTHVhU2NyaXB0Q29yZQ=="));

end

-- JSON编码示例
function Encoding_Sample_jsonEndode()
	print(Encoding:jsonEncode({a=1024,b="Hello LuaScriptCore"}));
end

-- JSON解码示例
function Encoding_Sample_jsonDecode()
	local obj = Encoding:jsonDecode("{\"a\":1024,\"b\":\"Hello LuaScriptCore\"}");
	print ("a = (", obj.a, ") b = (", obj.b, ")");
end

-- 十六进制编码示例
function Encoding_Sample_hexEncode()
	print(Encoding:hexEncode("Hello LuaScriptCore"));
end

-- 十六进制解码示例
function Encoding_Sample_hexDecode()
	print(Encoding:hexDecode("48656c6c6f204c7561536372697074436f7265"));
end
