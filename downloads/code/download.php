#!/usr/bin/php -qC
/*
Author:赵卫国
create：Wed Dec 22 14:27:45 2004
version:0.01
function: 批量下载,使用了prozilla程序,如果你没有安装prozilla,你可以”proz -k=10″替换成”wget ”
使用方法:
download.php <'url'> [width] [ -f ]
url:要下载的网址,含有通配符号的网址.
width:通配符的宽度.
通配符:这里采用两种方式,如果是连续的文件,比如要下载http://www.foobar.com/001…. 到http://www.foobar.com/100….
那么你可以写成http://www.foobar.com/[001-100].html 3
后面的3表示通配符号是3位.
如果你下载的非连续的文件,那么可以使用列表的方式,比如你要下载文件名分别是11.html,23.html,aa.html.
那么你可以这样写:http://www.foobar.com/{11,23,aa}.html
如果你只下载一个文件,你可以直接给定确定的url就可以了.
对于字母的方式,通用也支持,这里给定的字母序列是安装ASCII码排列,也就是说大写字母排在小写字母前面.
比如 http://www.foobar.com/23[A-b].html 1
那么表示下载从A.html,B.html….Z.html,a.html,b.html
注意:请把URL用单引号(')包含起来,以阻止shell对特殊字符的解析.
todo:
1.实现文件读取
2.实现同时含有两个以上[符号后者含有{符号
3.实现含有{,[混和符号
4.实现aa-bb的连续下载方式

*/
if (!isset($_SERVER["argv"][1]) )
{
	usage();
	exit(1);

}
//解析参数，第一个参数是连接的url，第二个可选的参数是匹配字符的宽度。
$url=$_SERVER["argv"][1];
if (isset($_SERVER["argv"][2]))
	$width=$_SERVER["argv"][2];
	//echo $url.”t”.$width;
	//找到要匹配的地方,进行替换,这里需要考虑两种情况
	//一种是采用下载连续文件的方式,比如[1-12].html,我们使用中括号的方式表示
	//另外一种是采用文件列表的方式,比如{1,2}.rpm,我们使用大括号的方式表示
	//要注意的是,这里我们只考虑匹配一个通用符的方式.也就是一个url上只能出现一次
	//中括号或大括号
if (strpos($url,”[")> 0 ) //找到了大括号
	download_continue_files($url,$width);
else if (strpos($url,"{") > 0 ) //找到了{,采用文件列表的方式下载
	download_list_files($url);
else
	download_single_file($url); //下载单个文件
?>
function download_continue_files($url,$width)
{
	$begin=strpos($url,"[");
	$middle=strpos($url,"-",$begin);
	$end=strpos($url,"]“,$middle);
	// echo “beign: $begint middle: $middle t end $endn”;
	$first=substr($url,$begin + 1,$middle – $begin -1);
	$last=substr($url,$middle + 1,$end – $middle – 1);
	$url_prefix=substr($url,0,$begin );
	$url_suffix=substr($url,$end+1);
	//echo “url_prefix :$url_prefix t url_suffix: $url_suffix n”;
	$continue_array=create_fill($first,$last,$width);
	foreach($continue_array as $value)
	{
		$real_url=$url_prefix.$value.$url_suffix.”n”;
		echo $real_url;
		//system(“proz -k=10 $real_url”);
	}
}
function create_fill($first,$last,$width)
{

if (is_numeric($first))
{

	for($i=$first;$i<=$last;$i++)
	{
		//echo "i is $it";
		$format="%0".$width."d";
		$tt=sprintf($format,$i);
		//echo "$tt t";
		$tmp_array[]=$tt;
	}
}
else //letter
{
	$letter="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

if ($width==1) //这是一个字母的问题,如果有两个字母或者以上的,目前不考虑
{
	$begin=strpos($letter,$first);
	$end=strpos($letter,$last,$begin);
	for($i=$begin;$i<= $end;$i++)
	$tmp_array[]=$letter{$i};

}

}
if (!is_array($tmp_array))
	$tmp_array=array();
return $tmp_array;
}
function download_list_files($url)
{
	$begin=strpos($url,"{");
	$end=strpos($url,"}",$begin);
	$url_prefix=substr($url,0,$begin );
	$url_suffix=substr($url,$end+1);
	$tmp_str=substr($url,$begin + 1,$end -$begin -1);
	$file_array=explode(",",$tmp_str);
	foreach($file_array as $value)
	$real_urlurl_prefix.$value.$url_suffix;
	system("proz -k=10 $real_url");

}
function download_single_file($url)
{
	echo $url;
	//system("proz -k=10 $url");
}
function usage()
{
	print "Usage: ".$_SERVER["argv"][0]." <'url'> [width]n”;

	exit;
}
?>