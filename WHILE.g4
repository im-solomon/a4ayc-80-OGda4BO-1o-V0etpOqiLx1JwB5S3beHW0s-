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

	
//���� ��, syntax ��
Identifier
	:	('a'..'z' | 'A'..'Z' | '_') ('a'..'z' | 'A'..'Z' | '_' | '0'..'9')* //���ڸ� ��ҹ���,����ٸ� ��� ���ڸ����ʹ� ���ڱ��� ���
	;
Number
	:	('0'..'9')+ //���ڸ� �̻��� ������ ���
	;

WS : [ \t\r\n]+ -> skip ; 

