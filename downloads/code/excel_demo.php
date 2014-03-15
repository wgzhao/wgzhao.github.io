<?php
include("excelwriter.inc.php");

$excel=new ExcelWriter("myXls.xls");

if($excel==false) 
 echo $excel->error;
 
$myArr=array("Name","Last Name","Address","Age");
$excel->writeLine($myArr);

$myArr=array("你好","Pandit","23 mayur vihar",24);
$excel->writeLine($myArr);

$excel->writeRow();
$excel->writeCol("Manoj");
$excel->writeCol("Tiwari");
$excel->writeCol("80 Preet Vihar");
$excel->writeCol(24);

$excel->writeRow();
$excel->writeCol("Harish");
$excel->writeCol("Chauhan");
$excel->writeCol("115 Shyam Park Main");
$excel->writeCol(22);

$myArr=array("Tapan","Chauhan","1st Floor Vasundhra",25);
$excel->writeLine($myArr);
/* 
uncomment the follow code if you wanna write a hole table 
*/
/*
$excel->writetable('<table x:str border=0 cellpadding=0 cellspacing=0
style="border-collapse: collapse;table-layout:fixed;"><tr><td
class=xl24 width=64 >Name</td>
<td class=xl24 width=64 >Last Name</td>
<td class=xl24 width=64 >Address</td>
<td class=xl24 width=64 >Age</td>
</tr>
<tr><td class=xl24 width=64 >你好</td>
<td class=xl24 width=64 >Pandit</td>
<td class=xl24 width=64 colspan="2" >23 mayur vihar</td>
</tr>
</tr></table>');*/

$excel->close();
echo "data is write into myXls.xls Successfully.";

?>
