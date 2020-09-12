<?php
	/*
	* since 20180925 pm 10:38
	* Redis::MULTI或Redis::PIPELINE. 默认是 Redis::MULTI
	* Redis::MULTI：将多个操作当成一个事务执行
	* Redis::PIPELINE:让（多条）执行命令简单的，更加快速的发送给服务器，但是没有任何原子性的保证
	* Redis处理批量请求有两种命令，一种是multi一种是pipeline		
	* pipeline 只是把多个redis指令一起发出去，redis并没有保证这些指定的执行是原子的；multi相当于一个redis的transaction的。
	*/

	$redis = new Redis();
	$redis->connect('127.0.0.1', 6379);
	$pipe = $redis->multi(Redis::PIPELINE);
	for ($i = 0; $i < 3; $i++) {    
		$key = "key::{$i}";   
		print_r($pipe->set($key, str_pad($i, 2, '0', 0)));   
		echo PHP_EOL;    
		print_r($pipe->get($key));    
		echo PHP_EOL;
	}
	$result = $pipe->exec();
	print_r($result);
	
	/**
	  * 从结果可以看出每次执行set/get命令,并没有被redis服务器立即执行,执行结果被放在了最后的result中
	  *	1. Multi:
　　  * 1.1. 每发送一条指令，都需要单独发给服务器，服务器再单独返回“该条指令已加入队列”这个消息。这是比Pipeline慢的原因之一。
　　  *	1.2. Multi执行的时候会先暂停其他命令的执行，类似于加了个锁，直到整个Multi结束完成再继续其他客户端的请求。这是Multi能保证一致性的原因，也是比Pipeline慢的原因之二。（需要读Redis Server的代码，从TCPDump上看不出）

	  * 2. Pipeline:
　	  *	2.1. 将所有命令打包一次性发送。发送成功后，服务端不用返回类似“命令已收到”这样的消息，而是一次性批量执行所有命令，成功后再一次性返回所有处理结果。
　　  *	2.2. 服务端处理命令的时候，不需要加锁，而是与其他客户端的命令混合在一起处理，所以无法保证一致性。

	  *	适用场景：
	  *	1. 如果要顺序执行一组命令（既网上所谓的“Redis事务”），Multi很合适。
	  *	2. 如果要往Redis里批量插入Log, 或者使用Redis List做为队列并插入很多消息的话，Pipleline是挺合适的
      */
?>


