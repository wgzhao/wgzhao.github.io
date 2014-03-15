#!/usr/bin/perl
#this perl script extend wget function.It can get continuely files at a time
#It accept two arguments.the first is the url,and the later is the width of
#coutup,eg. ./download.pl http://www.example.com/pp[1-10].html 2
#then it will download http://www.example.com/pp01.html
#http://www.example.com/pp02.html etc
#the last file is http://www.example.com/pp10.html
$num= @ARGV;
if ($num <2 )
{
	print "Usage:./download.pl n";
	print "eg. ./download.pl http://www.example.com/foo[01-12].html 2n;
	exit;
}

$prefix=@ARGV[0];
$len=@ARGV[1];
$begin=index($prefix,'['); #begin offset
$end=index($prefix,']'); #end offset
$forward=substr($prefix,0,$begin);
$backward=substr($prefix,$end + 1);
$var=substr($prefix,$begin + 1,$end – $begin – 1); #remove the '[' and ']'
$dash=index($var,'-');
$first=substr($var,0,$dash); #the begin offset
$last=substr($var,$dash+1); #the last offset
$index=$first;
while($index <=$last)
{
	$url=sprintf("%s%0${len}d%s",$forward,$index,$backward);
	$index=$index + 1;
	exec("wget $url");
}