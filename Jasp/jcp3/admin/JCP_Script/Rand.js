// The Central Randomizer 1.3 (C) 1997 by Paul Houle (houle@msc.cornell.edu) 

rnd.today=new Date(); 

rnd.seed=rnd.today.getTime();

function rnd() {					//����һ�����������

��������rnd.seed = (rnd.seed*9301+49297) % 233280;

��������return rnd.seed/(233280.0);

}

function Rand(number) { 			//����һ���������ʱ�����磬1��10ʱ��ʹ��rand(10)

��������return Math.ceil(rnd()*number);

}

// end central randomizer

