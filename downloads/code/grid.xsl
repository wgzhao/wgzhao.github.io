<?xml version="1.0" encoding="utf-8" ?>
<!--
/**********************************************
图书管理系统 v1.0
作者: 	赵卫国 
联系方式: mlsx@cie.xtu.edu.cn http:/www.xplore.cn
完成时间: 2004年4月
************************************************/
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="rows_page">10</xsl:param>
<xsl:param name="pageno">1</xsl:param>
<xsl:template match="all_books">
<html>
<head>
<meta http-equiv="Pragma" content="no-cache" /> <!--this will not work in IE-->
<meta http-equiv="expires" content="0" /> <!-- this will not work in Mozilla-->
<title>图书详细信息</title>
<link rel="stylesheet" type="text/css" href="../text.css" />
</head>
<body>
<p align="center">图书详细信息     
<a href="books_card.xml" target="_blank" >卡片形式   </a>
<a href="books_manage.php" target="_self" >网格形式  </a>  
<a href="add_books.php" target="_self" >添加图书    </a>     
<a href="books_manage.php?refresh=ok" target="_self">刷新</a>
</p>
<table>
<tr bgcolor="#efefef">
	  <th>分类号</th>
      <th>书名</th>
      <th>作者</th>
      <!--<th>版次</th>-->
      <th>出版社</th>
      <th>出版时间</th>
      <!--<th>资产号</th>
      <th>页数</th>
      <th>开本</th>-->
      <th>价格</th>
      <th>备注</th>
      <th>流通情况</th>
	<th colspan="2" >操作</th>
</tr>
<xsl:apply-templates select="book" />
</table>
<xsl:apply-templates select="prompt" />
</body>
</html>
</xsl:template>
<xsl:template match="book">
<!--<xsl:if test="not (position() &gt; ($pageno * $rows_page ))" >-->
<tr bgcolor='#dcdcdc' onmouseover="javascript:this.style.background='#7fffde'"
					onmouseout=" javascript:this.style.background='#dcdcdc'">
<xsl:for-each select="分类号|书名|作者|出版社|出版时间|价格|备注">
	<td><xsl:value-of select="node()" /></td>
</xsl:for-each>
<xsl:for-each select="流通情况">
	<td><xsl:if test="node()='0'">在库</xsl:if><xsl:if test="node()='1'"><font color="red">借出</font></xsl:if></td>
</xsl:for-each>
	<td><a>
	<xsl:attribute name="href">
	modify_book.php?id=<xsl:value-of select="资产号" />
	</xsl:attribute>
	修改</a></td>
	<td><a >
	<xsl:attribute name="href">
	delete_book.php?id=<xsl:value-of select="资产号" />
	</xsl:attribute>
	删除</a></td>
</tr>
<!--</xsl:if>-->
</xsl:template>
<xsl:template name="prompt">
<p align="center">
共有图书<xsl:value-of select="count(//book)" />本 显示 <xsl:value-of select=" ($pageno -1) * $rows_page +1" />--<xsl:value-of select="$pageno * $rows_page" /> 条记录
<xsl:value-of select="$rows_page" />条/页  共<xsl:value-of select="(count(//book) +5) div $rows_page " />页  
</p>
</xsl:template>

</xsl:stylesheet>
