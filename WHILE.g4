/**
 * Define a grammar called WHILE
 */
grammar WHILE;

@header {										//자동 생성되는 분석기 생성 폴더
package generated;
}

@parser::members{									//antlr안에서 사용될 자바 객체
	public java.util.HashMap<String, Integer> memory = new java.util.HashMap<String, Integer>();
	
}

											//parser rule 시작, lexer rule로 나눠진 토큰들의 의미 파악
program returns [int sv]								//program의 리턴 타입 정의
	: 	result = additionExp {$sv = $result.sv;}				//구문 분석 시작 및 모든 계산이 끝나고 리턴 값 받기
	;
additionExp returns [int sv]								//+ - 문자열의 의미 정의, 리턴 타입 정의
	: 	a1 = multiplyExp	{$sv = $a1.sv;}					//현재 토큰이 * / 기호가 있는지 분석 후 연산자에 맞게 할당함
		('+' a2=multiplyExp 	{$sv += $a2.sv;} 				
        	| '-' a2=multiplyExp 	{$sv -= $a2.sv;}				
		)*									//zero or more
	;
	
multiplyExp returns [int sv]								// * / 문자열의 의미 정의, 리턴 타입 정의
	:   m1 = atomExp       	{$sv =  $m1.sv;}					// 토큰에 사칙연산외 원자단위 값이 있는지 분석 후 연산자에 맞게 할당함 
        ( '*' m2=atomExp 	{$sv *= $m2.sv;} 
        | '/' m2=atomExp 	{$sv /= $m2.sv;}
        )*  										//zero or more
	;
atomExp returns [int sv]								//사칙연산 외의 문자에 대한 구문 해석
	: 	n=Number		{$sv = Integer.parseInt($n.text);}		//토큰이 Number라면 정수로 변환
	|	i=Identifier		{$sv = memory.get($i.text);}			//토큰이 Identifier라면 State에서 참조함
	|	'(' exp=additionExp ')'	{$sv = $exp.sv;}				//괄호 발견되면 additionExp 규칙에서 다시 시작(recursion)
	;

											//lexer rule 시작, 의미있는 단위로 나누는 규칙
Identifier
	:	('a'..'z' | 'A'..'Z' | '_') ('a'..'z' | 'A'..'Z' | '_' | '0'..'9')* 	//한자리 이상의 변수, 앞자리 대소문자/언더바만 허용, 뒷자리부터는 숫자까지 허용(zero or more)
	;
Number
	:	('0'..'9')+ 								//한자리 이상의 정수만 허용 (one or more)
	;

WS : [ \t\r\n]+ -> skip ; 								//공백,탭,엔터 값 toss

