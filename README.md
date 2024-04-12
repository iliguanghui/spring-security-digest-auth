## 快速入门：演示Spring Security摘要认证

当客户端访问受保护资源时，服务器会生成一组随机数交给客户端，客户端将这些信息和密码混在一起，算出一个摘要值，还给服务器。服务器拿着同样的随机数和保存的用户密码自己算一遍，如果和客户端算的一致，说明客户端是知道密码的，认证通过。

下面是一个携带摘要认证信息的请求：

```plain
GET / HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Accept-Encoding: gzip, deflate, br, zstd
Accept-Language: en,zh-CN;q=0.9,zh;q=0.8
Authorization: Digest username="admin", realm="My App Realm", nonce="MTcxMjkzMDA2MzE5NzowYjdlYjA2MDRlOGIyMzgwYzU1YTliNjVmMmRmMWVlYQ==", uri="/", response="bc0e1617ab36457a2322f18db12f16e1", qop=auth, nc=00000009, cnonce="3654b9f9d3ba49dc"
Cache-Control: no-cache
Connection: keep-alive
DNT: 1
Host: localhost:8080
Pragma: no-cache
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: none
Sec-Fetch-User: ?1
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36
sec-ch-ua: "Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "macOS"
```

当不提供摘要或者摘要不正确的时候，会由DigestAuthenticationEntryPoint返回401，并在响应里添加WWW-Authenticate首部，tomcat会把这个请求转发到/error以请求错误页，这个转发的请求也会再被DigestAuthenticationEntryPoint处理一遍，所以会在最终的响应里看到2个WWW-Authenticate首部。解决方案就是取消第二次添加WWW-Authenticate首部的动作。