package generated;
import java.util.*;
public class StateMap {
	private static HashMap<String, Integer> stateMapVar = new HashMap<String, Integer>();
	public StateMap(){
		stateMapVar.put("x", 7);
		stateMapVar.put("y", 1);
	}
	public void SetState(String strVar, Integer intVar) {
		stateMapVar.put(strVar, intVar);
	}
	public HashMap<String, Integer> GetStateMapObject(){
		return stateMapVar;
	}
}
