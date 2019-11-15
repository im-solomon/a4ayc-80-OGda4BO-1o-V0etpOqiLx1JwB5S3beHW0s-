# 프로그래밍 언어론 과제 1
### ANTLR를 이용하여 아래 문법을 받아 수행하는 계산기를 작성하시오.  
![문법](/img/image01.png)
* State를 위한 전역적인 Map이 있다고 가정한다.
* Map은 별도의 클래스에서 Static 인자로 보유하며, 이미 변숫값이 다 저장되어 있다고 가정한다.
* 상수 n은 교재와 달리 값을 준다고 생각한다. 예) Integer.parseInt(get.text());
* 아래 코드는 aexpr의 타입이 State->Int로 가는 함수라고 가정한 수도코드다. 이를 참고해서 aexpr이 int라고 가정하고 코드를 작성하시오.

### 프로그램 설명

* x,y와 같은 변수, 상수, 괄호, 연산자 우선순위가 고려된 수식 문장 분석기

### 소스코드
* WHILE.g4: 계산식을 해석하는 구문분석기
* Interpreger.java : 계산식을 입력받아 결과를 내는 계산기(메인 클래스)

### 결과
*계산결과  
![result](/img/antlr4_calc_result.PNG)

*AST  
![AST](/img/antlr4_parse_tree.png)
