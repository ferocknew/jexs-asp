// The Central Randomizer 1.3 (C) 1997 by Paul Houle (houle@msc.cornell.edu) 

rnd.today=new Date(); 

rnd.seed=rnd.today.getTime();

function rnd() {					//创建一个随机浮点数

　　　　rnd.seed = (rnd.seed*9301+49297) % 233280;

　　　　return rnd.seed/(233280.0);

}

function Rand(number) { 			//创建一个随机整数时，例如，1到10时，使用rand(10)

　　　　return Math.ceil(rnd()*number);

}

// end central randomizer

