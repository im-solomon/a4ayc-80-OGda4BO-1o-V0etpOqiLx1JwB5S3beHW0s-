/**
 * Define a grammar called Hello
 */
grammar WHILE;

@header {
package generated;
}
@parser::members{
	public java.util.HashMap<String, Integer> memory = new java.util.HashMap<String, Integer>();
	
}
program: aexpr;

aexpr returns [int sv]
	: 	N = additionExp {$sv = $N.sv;}
	;
additionExp returns [int sv]
	: 	a1 = multiplyExp		{$sv = $a1.sv;}
		(	'+' a2=multiplyExp 	{$sv += $a2.sv;} 
        | 	'-' a2=multiplyExp 	{$sv -= $a2.sv;}	
		)*
	;
	
multiplyExp returns [int sv]
	:   m1 = atomExp       {$sv =  $m1.sv;}
        ( '*' m2=atomExp {$sv *= $m2.sv;} 
        | '/' m2=atomExp {$sv /= $m2.sv;}
        )*  
	;
atomExp returns [int sv]
	: 	n=Number				{$sv = Integer.parseInt($n.text);}
	|	i=Identifier			{$sv = memory.get($i.text);}
	|	'(' exp=additionExp ')'	{$sv = $exp.sv;}
	;

	
//렉서 룰, syntax 룰
Identifier
	:	('a'..'z' | 'A'..'Z' | '_') ('a'..'z' | 'A'..'Z' | '_' | '0'..'9')* //앞자리 대소문자,언더바만 허용 뒷자리부터는 숫자까지 허용
	;
Number
	:	('0'..'9')+ //한자리 이상의 정수만 허용
	;

WS : [ \t\r\n]+ -> skip ; 

