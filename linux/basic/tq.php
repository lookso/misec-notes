<?php
$a = array(1,2,3,6,8);
$b = array(4,5,6,7,8,9,10);
$c = array();
foreach($b as $key=>$value){
    next($a);
    echo current($a);
    if($b[$key]==current($a)){
     //   echo $b[$key];
    }
        //   $c[]=$value;
    //}else{
    //    next($a);
   // }
}
print_r($c);
?>
