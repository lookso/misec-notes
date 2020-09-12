#!/bin/bash  
# until命令和while命令类似，while能实现的脚本until同样也可以实现，但区别是until循环的退出状态是不为0，退出状态是为0（与while刚好相反），即whie循环在条件为真时继续执行循环而until则在条件为假时执行循环
i=0  
until [[ "$i" -gt 5 ]]    #大于5  
do  
    let "square=i*i"  
    echo "$i * $i = $square"  
    let "i++"  
done  
