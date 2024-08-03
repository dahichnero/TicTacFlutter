import 'package:shared_preferences/shared_preferences.dart';

class Mods{
  static int index=0;
  static void getMod() async{
    final prefs = await SharedPreferences.getInstance();
    index=prefs.getInt("MOD")!;
  }
  static int getMods(){
    getMod();
    return index;
  }
}

List<List<String>> mods=[["X","O"],["😽","🐶"]];

class Play{
  static String x=mods[Mods.getMods()][0];
  static String o=mods[Mods.getMods()][1];
  static const nothing="";

}


class Gaming{
  static const gamelength=9;
  static const gameSize=100.0;

  List<String>? newBoard;

  static List<String>? newGameBoard()=>List.generate(gamelength, (index)=>Play.nothing);

  bool whoWin(String player, int index, List<int> scores, int size){
    int row=index~/3;
    int column=index%3;
    int res=player==mods[Mods.getMods()][0] ? 1: -1;

    scores[row]+=res;
    scores[size+column]+=res;
    if (row==column){
      scores[2*size]+=res;
    }
    if (size-1-column==row){
      scores[2*size+1]+=res;
    }
    if (scores.contains(3) || scores.contains(-3)){
      return true;
    }
    return false;
  }
}