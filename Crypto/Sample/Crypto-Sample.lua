require("Foundation")
require("Crypto")

-- MD5
function Crypto_Sample_md5()

    local result = Encoding:hexEncode(Crypto:md5("Hello LuaScriptCore!"));
    print(result);

end

-- SHA1
function Crypto_Sample_sha1()

    local result = Encoding:hexEncode(Crypto:sha1("Hello LuaScriptCore!"));
    print(result);

end

-- HMAc-MD5
function Crypto_Sample_hmacMD5()

    local result = Encoding:hexEncode(Crypto:hmacMD5("Hello LuaScriptCore!", "vim"));
    print(result);

end

-- HMAc-SHA1
function Crypto_Sample_hmacSHA1()

    local result = Encoding:hexEncode(Crypto:hmacSHA1("Hello LuaScriptCore!", "vim"));
    print(result);

end