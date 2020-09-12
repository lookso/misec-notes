<?php
$contact = array(
            "ID" => 1,
            "姓名" => "高某",
            "公司" => "A公司",
            "地址" => "北京市",
            "电话" => "(010)98765432",
            "EMAIL" => "gao@brophp.com",
            ); 
//数组刚声明时，数组指针在数组中第一个元素位置
echo '第一个元素：'.key($contact).' => '.current($contact).'<br>'; //第一个元素
echo '第一个元素：'.key($contact).' => '.current($contact).'<br>'; //数组指针没动
 
next($contact);
next($contact);
echo '第三个元素：'.key($contact).' => '.current($contact).'<br>'; //第三个元素
 
end($contact);
echo '最后一个元素：'.key($contact).' => '.current($contact).'<br>';
 
prev($contact);
echo '倒数第二个元素：'.key($contact).' => '.current($contact).'<br>';
 
reset($contact);
echo '又回到了第一个元素：'.key($contact).' => '.current($contact).'<br>';
?>
