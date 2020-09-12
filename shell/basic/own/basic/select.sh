#!/bin/bash
# Select擅长于交互式场合。用户可以从一组不同的值中进行选择
echo "What is your favourite OS?"
select var in "Linux" "Gnu Hurd" "Free BSD" "Other";do
  break;
done
echo "You have selected $var"
