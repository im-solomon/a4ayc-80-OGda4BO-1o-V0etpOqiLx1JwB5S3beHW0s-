package generated;
import org.antlr.v4.runtime.*;
import java.util.*;


public class Interpreter {	
    public static void main(String[] args) throws Exception {
    	StateMap vars =  new StateMap();
    	
    	vars.SetState("z", 1);
    	vars.SetState("x", 2);
    	
    	System.out.println(vars.GetStateMapObject().get("x"));
    	System.out.println(vars.GetStateMapObject().get("y"));
    	System.out.println(vars.GetStateMapObject().get("z"));
    	
    	
    	System.out.println("계산 형식 입력 ex)x+(x+z):");
    	@SuppressWarnings("resource")
		CharStream input = CharStreams.fromString(new Scanner(System.in).nextLine());
        WHILELexer lexer = new WHILELexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        WHILEParser parser = new WHILEParser(tokens);
        parser.memory.putAll(vars.GetStateMapObject());
    	System.out.println(parser.program().aexpr().sv);
    
    }
}