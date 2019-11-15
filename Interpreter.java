package generated;
import org.antlr.v4.runtime.*;
import java.util.*;

class StateMap {															//state 저장 클래스
	private static HashMap<String, Integer> stateMapVar = new HashMap<String, Integer>();		
	public StateMap(){														//state 초기값
		stateMapVar.put("x", 7);
		stateMapVar.put("y", 1);
	}
	public void SetState(String strVar, Integer intVar) {										//state key value 세팅
		stateMapVar.put(strVar, intVar);
	}
	public HashMap<String, Integer> GetStateMapObject(){										//state 객체 리턴
		return stateMapVar;
	}
}

public class Interpreter {	
    
	public static void main(String[] args) throws Exception {
    	StateMap vars =  new StateMap();												//state 객체 생성
    	System.out.println("계산기 시작");
    	while(true) {	
    		System.out.println("번호 선택,   1.State 출력   2.State 입력   3.수식계산   4.종료");
    	
    		int num = new Scanner(System.in).nextInt();	
    		if(num == 1) {
    			System.out.println("현재 States:");
    			for(String key : vars.GetStateMapObject().keySet()) {								//모든 state key value 출력
    				System.out.println("key=value: "+key + " = "+vars.GetStateMapObject().get(key));	
    			}
    			
    			System.out.println();
    		}else if(num == 2){													//state 생성 및 substitute
    			
    			System.out.println("State 입력:");
    			System.out.println("State key:");
    			String key = new Scanner(System.in).nextLine();
    			System.out.println("State value:");
    			Integer value = new Scanner(System.in).nextInt();
    			vars.SetState(key, value);
    			
    		}else if(num == 3){													//수식 계산
    			System.out.println("수식 입력:");
    			CharStream input = CharStreams.fromString(new Scanner(System.in).nextLine());					//수식을 문자열로 받음
    			WHILELexer lexer = new WHILELexer(input);									//문자열을 lexer rule 기준으로 나눔
    			CommonTokenStream tokens = new CommonTokenStream(lexer);							//의미있는 단어를 기준 최소단위로 나눔				
    			WHILEParser parser = new WHILEParser(tokens);									//parser rule 기준으로 ast를 생성한다
            
    			parser.memory.putAll(vars.GetStateMapObject());									//parser의 멤버객체에 state 객체 전달
    			
    			System.out.println(parser.program().aexpr().sv);								//최종 결과인 리턴 값 출력
    			System.out.println();
    			
    		}else {
    			break;
    		}  	
    	
    	}
    	
    
    }
}
