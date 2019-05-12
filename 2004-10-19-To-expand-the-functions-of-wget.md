---
layout: post
title: 扩展wget的功能
date: "2004-10-19"
tags: [wget, curl]
---
## 问题
wget和curl是我非常喜爱的下载程序，可是却有这样的问题，比如当我要下载20个文件，这些文件至少名字不同，但是非常有规律，比如

	http://www.example.com/01.html
	http://www.example.com/02.html
	..............
	http://www.example.com/99.html

如果http://www.example.com/目录下支持robots的话，那么可以使用
`wget -r http://www.example.com/`
来批量下载，但是这种情况很少，特别是http协议的(ftp的话都可以)
于是我就想扩展这个功能。

## 解决

代码如下，取名为`download.pl`，是用perl实现的，大家可以根据这个方法来改写成很多种语言。

使用方法：  
该程序带两个参数，第一个是下载的url，第二个是要替换的值的宽度。  
比如，对于上面那些页面要下载的话，可以这样使用：
`./download.pl http://www.example.com/[01-99].html 2`
这样就可以下载了。
如果文件明不是纯数字的话，那么就可以这样
`./download.pl http://www.example.com/a[1-99].html 2`
这样就可以下载a01.html,a02.html......a99.html的页面了。

如果要使用curl的话，将wget换成curl，同时使用重定向来输出到文件。

bugs：

1. 目前不支持类似 `[a-z]` 的情况。  
2. 不支持类似 `[01,03,22]` 这种离散的情况。

准备下次修改程序来完善。

ps：perl我不会，这个程序是我一边查perl的指南一边写的，30多行的程序我写了2个小时，惭愧！ :(
