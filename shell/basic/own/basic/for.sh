#!/bin/bash
for varible1 in {1..5}  
#for varible1 in 1 2 3 4 5  
do  
    echo "Hello, Welcome $varible1 times "  
done

#也可一使用for file in *，通配符*产生文件名扩展，匹配当前目录下的所有文件。
for file in $( ls )  
#for file in *  
do  
    echo "file: $file"  
done 

for(( i=1;i<=4;i++))
do
    touch $i.sh
    echo '#!/bin/bash' >$i.sh
    chmod 764 $i.sh
done

