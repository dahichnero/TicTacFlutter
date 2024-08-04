
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eh/allcolors.dart';
import 'package:flutter_eh/firebase_options.dart';
import 'package:flutter_eh/gamingtic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Allcolors.thirdColor),
        useMaterial3: true,
      ),
      home: const SignUp(),
    );
  }
}

class MyGamePage extends StatefulWidget{
  const MyGamePage({super.key, required this.playId, required this.modId});

  final int modId;
  final int playId;

  @override
  State<MyGamePage> createState()=>_MyGamePageState();
}

class Modificators extends StatefulWidget{
  const Modificators({super.key, required this.playId});
  final int playId;
  @override
  State<Modificators> createState()=>_ModificatorsState();
}

class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  State<SignUp> createState()=>_SignUpState();
}

class AchivHunt extends StatefulWidget{
  const AchivHunt({super.key, required this.playId, required this.modId, required this.real});
  final int modId;
  final int playId;
  final List<Map<String,dynamic>> real;

  @override
  State<AchivHunt> createState()=>_AchivHuntState();
}



class _ModificatorsState extends State<Modificators>{
  


  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Allcolors.firstColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Модификаторы", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'RubikBubbles'),),
          const Text("Доступно несколько модификаторов", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'RubikBubbles')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(iconSize: 50, onPressed: () async{
                final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                sharedPreferences.setInt("MOD", 1);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGamePage(playId: widget.playId, modId: 1,)));
              }, icon: const Icon(Icons.catching_pokemon, color: Colors.white,)),
              const Text("Режим кошки/собаки", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'RubikBubbles'),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(iconSize: 50, onPressed: () async {
                final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                sharedPreferences.setInt("MOD", 0);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGamePage(playId: widget.playId, modId: 0,)));
              }, icon: const Icon(Icons.ac_unit, color: Colors.white,)),
              const Text("Классический режим", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'RubikBubbles'),)
            ],
          ),
          IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back, color: Colors.white,)),
          
        ],
      ),
    );
  }

  
}

class _AchivHuntState extends State<AchivHunt>{

  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Allcolors.firstColor,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Достижения", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'RubikBubbles')),
              SizedBox(width: 430, height: 500,
              child: ListView.builder(itemCount: widget.real.length, scrollDirection: Axis.vertical, itemBuilder: (BuildContext context, int index){
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: 308,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xfff5f5dc),
                    border: Border.all(color: const Color(0xfff5f5dc))
                  ),
                  child: Center(
                    child: Column(children: [
                      Image(image: AssetImage(widget.real[index]['photo']),width: 50, height: 50,),
                      Text(widget.real[index]['name'],style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'RubikBubbles')),
                    ],),
                  ),
                );
              }),),
              IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back, color: Colors.white,)),
            ],
          ),
        ),
      ),
    );
  }

  
}

class PlatTicTac{
  static String login="";
  static String pass="";
  static int count=0;
  static List<String> ach=[];
  static List<int> achi=[];

  static getDataLogin() async{
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("USERNAME")){
      login=prefs.getString("USERNAME")!;
    }
  }

  static getDataPass() async{
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("USERPASS")){
      pass=prefs.getString("USERPASS")!;
    }
  }

  static getDataCount() async{
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("USERCOUNT")){
      count=prefs.getInt("USERCOUNT")!;
    }
  }

  static getDataAch() async{
    final prefs=await SharedPreferences.getInstance();
    if (prefs.containsKey("USERACH")){
      ach=prefs.getStringList("USERACH")!;
    }
  }

  static String getLogin(){
    getDataLogin();
    return login;
  }

  static String getPass(){
    getDataPass();
    return pass;
  }

  static int getCount(){
    getDataCount();
    return count;
  }

  static List<int> getAch(){
    getDataAch();
    for (int i=0; i<ach.length; i++){
      achi.add(int.parse(ach[i]));
    }
    return achi;
  }
}

class _SignUpState extends State<SignUp>{

  String login="";
  String pass="";
  int count=0;
  int playerId=0;

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState(){
    super.initState();
    initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Allcolors.firstColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text("Вход", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'RubikBubbles'),),
          TextFormField(decoration: const InputDecoration(hintText: "Логин",), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'RubikBubbles'), initialValue: "$login", onChanged: (text){
            login=text;
          },),
          TextFormField(decoration: const InputDecoration(hintText: "Пароль",), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'RubikBubbles'), initialValue: "$pass", onChanged: (text){
            pass=text;
          },),
          ElevatedButton(onPressed: () async {

            FirebaseFirestore.instance.collection('PlayerTicTac').where('login', isEqualTo: login).where('password', isEqualTo: pass).get().then((QuerySnapshot que){
              que.docs.forEach((doc){
                playerId=doc['id'];
              });
            });

            if (playerId!=0){
              final SharedPreferences shared=await SharedPreferences.getInstance();
              shared.setInt("MOD", 0);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGamePage(playId: playerId, modId: 0,)));
            }

            else{
              showDialog(context: context, builder: (context)=>AlertDialog(
                title: const Text("Ошибка", style: TextStyle(fontFamily: 'RubikBubbles'),),
                content: const Text("Ошибка входа в систему", style: TextStyle(fontFamily: 'RubikBubbles'),),
                actions: <Widget>[
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("ОК", style: TextStyle(fontFamily: 'RubikBubbles'),))
                ],
              ));
            }
          }, child: const Text("Войти", style: TextStyle(fontSize: 18, fontFamily: 'RubikBubbles'),))
        ],
      ),
    );
  }
}


class _MyGamePageState extends State<MyGamePage>{
  String lastPlay=mods[Mods.getMods()][0];
  bool gameOver=false;
  int turn=0;
  String resInEnd="";
  List<int> scoreBoard=[0,0,0,0,0,0,0,0,];
  Gaming gaming=Gaming();

  List<Map<String,dynamic>> items=[];
  List<dynamic> itemsPlayer=[];
  List<Map<String, dynamic>> real=[];

  String login="";//Shared
  int count=0;
  int modId=0;
  int playerId=0;

  @override
  void initState(){
    super.initState();
    playerId=widget.playId;
    FirebaseFirestore.instance.collection('PlayerTicTac').where('id', isEqualTo: playerId).get().then((QuerySnapshot que){
              que.docs.forEach((doc){
                login=doc['login'];
                count=doc['countWin'];
              });
            });
    modId=widget.modId;
    //
    gaming.newBoard=Gaming.newGameBoard();
    lastPlay=mods[modId][0];
    gameOver=false;
    turn=0;
    resInEnd="";
    scoreBoard=[0, 0, 0, 0, 0, 0, 0, 0];
    //
    gaming.newBoard=Gaming.newGameBoard();
    print(gaming.newBoard);
  }

  @override
  Widget build(BuildContext context){
    double boardWigth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Allcolors.firstColor,
      body: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Игрок: $login Количество побед: $count", style: const TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'RubikBubbles'),),
          Text("$lastPlay Очередь", style: const TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'RubikBubbles')),
          SizedBox(height: 20.0,),
          Container(
            width: boardWigth,
            height: boardWigth,
            child: GridView.count(crossAxisCount: Gaming.gamelength ~/ 3,
            padding: const EdgeInsets.all(16.0), mainAxisSpacing: 8.0, crossAxisSpacing: 8.0,
            children: List.generate(Gaming.gamelength, (index) {
              return InkWell(
                onTap: gameOver ? null : () {
                  if (gaming.newBoard![index]==""){
                    setState(() {
                      items.clear();
                      real.clear();
                      gaming.newBoard![index]=lastPlay;
                      turn++;
                      gameOver=gaming.whoWin(lastPlay, index, scoreBoard, 3);
                      if (gameOver){
                        resInEnd="$lastPlay победил!!!";
                        if (lastPlay==mods[modId][0]){
                          count=count+1;
                          //update
                          FirebaseFirestore.instance.collection('PlayerTicTac').where('id', isEqualTo: playerId).get().then((QuerySnapshot que){
                          que.docs.forEach((doc){
                            doc.reference.update({'countWin': count});
                            });
                          });

                          switch (count){
                            case 1: FirebaseFirestore.instance.collection('PlayerTicTac').where('id', isEqualTo: playerId).get().then((QuerySnapshot que){
                            que.docs.forEach((doc){
                            doc.reference.update({'achivments': FieldValue.arrayUnion([1])});
                            });
                          });
                            case 3: FirebaseFirestore.instance.collection('PlayerTicTac').where('id', isEqualTo: playerId).get().then((QuerySnapshot que){
                            que.docs.forEach((doc){
                            doc.reference.update({'achivments': FieldValue.arrayUnion([2])});
                            });
                          });
                            case 5:
                            FirebaseFirestore.instance.collection('PlayerTicTac').where('id', isEqualTo: playerId).get().then((QuerySnapshot que){
                            que.docs.forEach((doc){
                            doc.reference.update({'achivments': FieldValue.arrayUnion([3])});
                            });
                          });
                          }
                        }
                                              }
                      else if (!gameOver && turn==9){
                        resInEnd="Ух ты! Ничья!";
                      }
                      if (lastPlay==mods[modId][0]){
                        lastPlay=mods[modId][1];
                      }
                      else{
                        lastPlay=mods[modId][0];
                      }
                    });
                  }
                },
                child: Container( width: Gaming.gameSize, height: Gaming.gameSize,
                decoration: BoxDecoration(color: Allcolors.secondColor, borderRadius: BorderRadius.circular(25.0)),
                child: Center(child: Text(gaming.newBoard![index], style: TextStyle(
                  color: gaming.newBoard![index]==mods[modId][0] ? Colors.redAccent : Colors.yellowAccent, fontSize: 64.0
                ),),),),
              );
            }),),
          ),
          const SizedBox(height: 10.0,),
          Text(resInEnd, style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'RubikBubbles'),),
          ElevatedButton.icon(onPressed: (){
            setState(() {
              gaming.newBoard=Gaming.newGameBoard();
              lastPlay=mods[modId][0];
              gameOver=false;
              turn=0;
              resInEnd="";
              scoreBoard=[0, 0, 0, 0, 0, 0, 0, 0];
            });
          }, icon: const Icon(Icons.replay), label: const Text("Начать заново", style: TextStyle(fontFamily: 'RubikBubbles'),)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(onPressed: () async{
                final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                sharedPreferences.setInt("USERCOUNT", count);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Modificators(playId: playerId,)));
              }, icon: const Icon(Icons.restart_alt, color: Colors.white,)),
              IconButton(onPressed: () async {
                final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                sharedPreferences.setInt("USERCOUNT", count);
                FirebaseFirestore.instance.collection('Achivment').get().then((QuerySnapshot que){
                  que.docs.forEach((doc){
                    items.add(doc.data() as Map<String, dynamic>);
                  });
                });

                FirebaseFirestore.instance.collection('PlayerTicTac').where('id', isEqualTo: playerId).get().then((QuerySnapshot que){
                          que.docs.forEach((doc){
                            itemsPlayer=doc.get('achivments');
                          });
                });

                for (int i=0; i<items.length; i++){
                  if (itemsPlayer.contains(items[i]['id'])){
                    real.add(items[i]);
                  }
                }
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AchivHunt(playId: playerId, modId: modId, real: real,)));
              }, icon: const Icon(Icons.payment, color: Colors.white,)),
              IconButton(onPressed: (){
                showDialog(context: context, builder: (context)=> AlertDialog(
                  title: const Text("Выход из системы", style: TextStyle(fontFamily: 'RubikBubbles'),),
                  content: const Text("Вы уверены что хотите выйти?", style: TextStyle(fontFamily: 'RubikBubbles'),),
                  actions: <Widget>[
                    TextButton(onPressed: () async{
                      final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                      sharedPreferences.setInt("USERCOUNT", count);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));
                    }, child: Container(color: Colors.white, padding: const EdgeInsets.all(14), child: const Text("Да", style: TextStyle(fontFamily: 'RubikBubbles'),),)),
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Container(color: Colors.white, padding: const EdgeInsets.all(14), child: const Text("Нет", style: TextStyle(fontFamily: 'RubikBubbles'),),)),
                  ],
                ));
              }, icon: const Icon(Icons.exit_to_app, color: Colors.white,))
            ],
          ),
        ],
      ),
    );
  }
}

