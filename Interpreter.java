package generated;
import org.antlr.v4.gui.Trees;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTree;

import generated.WHILEParser.ProgramContext;

import java.util.*;

class StateMap {																				//state ���� Ŭ����
	private static HashMap<String, Integer> stateMapVar = new HashMap<String, Integer>();		
	public StateMap(){																			//state �ʱⰪ
		stateMapVar.put("x", 7);
		stateMapVar.put("y", 1);
	}
	public void SetState(String strVar, Integer intVar) {										//state key value ����
		stateMapVar.put(strVar, intVar);
	}
	public HashMap<String, Integer> GetStateMapObject(){										//state ��ü ����
		return stateMapVar;
	}
}

public class Interpreter {	
    
	public static void main(String[] args) throws Exception {
    	StateMap vars =  new StateMap();																//state ��ü ����
    	System.out.println("���� ����");
    	while(true) {	
    		System.out.println("��ȣ ����,   1.State ���   2.State �Է�   3.���İ��   4.����");
    	
    		int num = new Scanner(System.in).nextInt();	
    		if(num == 1) {
    			System.out.println("���� States:");
    			for(String key : vars.GetStateMapObject().keySet()) {									//��� state key value ���
    				System.out.println("key=value: "+key + " = "+vars.GetStateMapObject().get(key));	
    			}
    			
    			System.out.println();
    		}else if(num == 2){																			//state ���� �� substitute
    			
    			System.out.println("State �Է�:");
    			System.out.println("State key:");
    			String key = new Scanner(System.in).nextLine();
    			System.out.println("State value:");
    			Integer value = new Scanner(System.in).nextInt();
    			vars.SetState(key, value);
    			
    		}else if(num == 3){																			//���� ���
    			System.out.println("���� �Է�:");
    			CharStream input = CharStreams.fromString(new Scanner(System.in).nextLine());			//������ ���ڿ��� ����
    			WHILELexer lexer = new WHILELexer(input);												//���ڿ��� lexer rule �������� ����
    			CommonTokenStream tokens = new CommonTokenStream(lexer);								//�ǹ��ִ� �ܾ ���� �ּҴ����� ����				
    			WHILEParser parser = new WHILEParser(tokens);											//parser rule �������� ast�� �����Ѵ�
    			parser.memory.putAll(vars.GetStateMapObject());											//parser�� �����ü�� state ��ü ����
    			
    			ProgramContext parse_program= parser.program();										//�Էµ� ���� �ؼ�
    			System.out.println(parse_program.sv);												//���� ���� �� ���
    			ParseTree tree = parse_program;														//�Էµ� ������ �ؼ� �Ǵ� Ʈ�� ����
    			Trees.inspect(tree,parser);															//�������� Ʈ�� ����
    			System.out.println();
    			
    		}else if(num == 4) {
    			System.out.println("The End of Calc.");
    			break;
    		}else{
    			System.out.println("Incorrect number.");
    		}
    	
    	}
    	
    
    }
}