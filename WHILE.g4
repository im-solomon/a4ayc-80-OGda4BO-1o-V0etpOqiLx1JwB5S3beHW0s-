/**
 * Define a grammar called Hello
 */
grammar WHILE;

@header {											//�ڵ� �����Ǵ� �м��� ���� ����
package generated;
}

@parser::members{									//antlr�ȿ��� ���� �ڹ� ��ü
	public java.util.HashMap<String, Integer> memory = new java.util.HashMap<String, Integer>();
	
}
program: aexpr;										//��Ī
																				//parser rule ����, lexer rule�� ������ ��ū���� �ǹ� �ľ�
aexpr returns [int sv]															//aexpr�� ���� Ÿ�� ����
	: 	N = additionExp {$sv = $N.sv;}											//��� ������ ��� �� ���� �� �ޱ�
	;
additionExp returns [int sv]													//+ - ���ڿ��� �ǹ� ����, ���� Ÿ�� ����
	: 	a1 = multiplyExp		{$sv = $a1.sv;}									//multiplyExp ��Ģ ���� ���� �� ���� ���� ���� + - ����
		(	'+' a2=multiplyExp 	{$sv += $a2.sv;} 
        | 	'-' a2=multiplyExp 	{$sv -= $a2.sv;}	
		)*																		//zero or more
	;
	
multiplyExp returns [int sv]													// * / ���ڿ��� �ǹ� ����, ���� Ÿ�� ����
	:   m1 = atomExp       {$sv =  $m1.sv;}										// ��Ģ���� ���� ���ڿ� ���� �ؼ��� ����Ǿ�� ��
        ( '*' m2=atomExp {$sv *= $m2.sv;} 
        | '/' m2=atomExp {$sv /= $m2.sv;}
        )*  																	//zero or more
	;
atomExp returns [int sv]														//��Ģ���� ���� ���ڿ� ���� ���� �ؼ�
	: 	n=Number				{$sv = Integer.parseInt($n.text);}				//��ū�� Number��� ������ ��ȯ
	|	i=Identifier			{$sv = memory.get($i.text);}					//��ū�� Identifier��� State���� ������
	|	'(' exp=additionExp ')'	{$sv = $exp.sv;}								//��ȣ �߰ߵǸ� additionExp ��Ģ���� �ٽ� ����(��Ŀ��)
	;

																				//lexer rule ����, �ǹ��ִ� ������ ������ ��Ģ
Identifier
	:	('a'..'z' | 'A'..'Z' | '_') ('a'..'z' | 'A'..'Z' | '_' | '0'..'9')* 	//���ڸ� �̻��� ����, ���ڸ� ��ҹ���/����ٸ� ���, ���ڸ����ʹ� ���ڱ��� ���(zero or more)
	;
Number
	:	('0'..'9')+ 															//���ڸ� �̻��� ������ ��� (one or more)
	;

WS : [ \t\r\n]+ -> skip ; 														//����,��,���� �� ������

