IK Analysis for Elasticsearch
=============================

The IK Analysis plugin integrates Lucene IK analyzer (http://code.google.com/p/ik-analyzer/) into elasticsearch, support customized dictionary.

Analyzer: `ik_smart` , `ik_max_word` , Tokenizer: `ik_smart` , `ik_max_word`

Versions
--------

IK version | ES version
-----------|-----------
master | 7.x -> master
6.x| 6.x
5.x| 5.x



### Dictionary Configuration

`IKAnalyzer.cfg.xml` can be located at `{conf}/analysis-ik/config/IKAnalyzer.cfg.xml`
or `{plugins}/elasticsearch-analysis-ik-*/config/IKAnalyzer.cfg.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE properties SYSTEM "http://java.sun.com/dtd/properties.dtd">
<properties>
	<comment>IK Analyzer 扩展配置</comment>
	<!--用户可以在这里配置自己的扩展字典 -->
	<entry key="ext_dict">custom/mydict.dic;custom/single_word_low_freq.dic</entry>
	 <!--用户可以在这里配置自己的扩展停止词字典-->
	<entry key="ext_stopwords">custom/ext_stopword.dic</entry>
 	<!--用户可以在这里配置远程扩展字典 -->
	<entry key="remote_ext_dict">location</entry>
 	<!--用户可以在这里配置远程扩展停止词字典-->
	<entry key="remote_ext_stopwords">http://xxx.com/xxx.dic</entry>
</properties>
```

### 热更新 IK 分词使用方法

目前该插件支持热更新 IK 分词，通过上文在 IK 配置文件中提到的如下配置

```xml
 	<!--用户可以在这里配置远程扩展字典 -->
	<entry key="remote_ext_dict">location</entry>
 	<!--用户可以在这里配置远程扩展停止词字典-->
	<entry key="remote_ext_stopwords">location</entry>
```

其中 `location` 是指一个 url，比如 `http://yoursite.com/getCustomDict`，该请求只需满足以下两点即可完成分词热更新。

1. 该 http 请求需要返回两个头部(header)，一个是 `Last-Modified`，一个是 `ETag`，这两者都是字符串类型，只要有一个发生变化，该插件就会去抓取新的分词进而更新词库。

2. 该 http 请求返回的内容格式是一行一个分词，换行符用 `\n` 即可。

满足上面两点要求就可以实现热更新分词了，不需要重启 ES 实例。

可以将需自动更新的热词放在一个 UTF-8 编码的 .txt 文件里，放在 nginx 或其他简易 http server 下，当 .txt 文件修改时，http server 会在客户端请求该文件时自动返回相应的 Last-Modified 和 ETag。可以另外做一个工具来从业务系统提取相关词汇，并更新这个 .txt 文件。

但是这种方式不是很推荐使用，因为会出现不稳定的情况，可能导致热词并不会即使生效，所以这里采用推荐修改IK分词器源码轮询来查询MySQL实现词库的热更新

have fun.

常见问题
-------
1.异常1：Could not create connection to database server
此异常通常是因为引用的mysql驱动和mysql版本号不一致导致的，只需要替换成对应的版本号即可解决，另外，数据库连接我们不需要再额外的去配置显示加载，即不需要写 Class.forName(props.getProperty("jdbc.className"));


2.异常2：no suitable driver found for jdbc:mysql://...
此异常我们需要在环境的JDK安装目录的jre\lib\ext目录下添加对应版本的mysql驱动mysql-connector-java.jar；比如我本地的是C:\Program Files\Java\jdk1.8.0_231\jre\lib\ext 目录

3.异常3：AccessControlException: access denied（"java.net.SocketPermission" "127.0.0.1:3306" "connect,resolve"）等情况
这个异常在plugin-security.policy下新增  permission java.net.SocketPermission "*", "connect,resolve";来解决

4.电脑安装了MySQL5.7的版本，但是在尝试使用com.mysql.cj.jdbc.Driver的驱动器连接时一直会失败，所以驱动器还是得选择相互匹配兼容的driver

5.ik_max_word 和 ik_smart 什么区别?

ik_max_word: 会将文本做最细粒度的拆分，比如会将“中华人民共和国国歌”拆分为“中华人民共和国,中华人民,中华,华人,人民共和国,人民,人,民,共和国,共和,和,国国,国歌”，会穷尽各种可能的组合，适合 Term Query；

ik_smart: 会做最粗粒度的拆分，比如会将“中华人民共和国国歌”拆分为“中华人民共和国,国歌”，适合 Phrase 查询。

Changes
------
*自 v5.0.0 起*

- 移除名为 `ik` 的analyzer和tokenizer,请分别使用 `ik_smart` 和 `ik_max_word`

- 参考来源：https://github.com/yangyu9507/elasticsearch-analysis-ik-7.3.2，非常感谢原作者的开源

***修改源码过程及配置步骤看docx文档***

Thanks
------
YourKit supports IK Analysis for ElasticSearch project with its full-featured Java Profiler.
YourKit, LLC is the creator of innovative and intelligent tools for profiling
Java and .NET applications. Take a look at YourKit's leading software products:
<a href="http://www.yourkit.com/java/profiler/index.jsp">YourKit Java Profiler</a> and
<a href="http://www.yourkit.com/.net/profiler/index.jsp">YourKit .NET Profiler</a>.
