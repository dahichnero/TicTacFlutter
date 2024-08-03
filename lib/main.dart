import 'package:flutter/material.dart';
import 'package:flutter_eh/allcolors.dart';
import 'package:flutter_eh/gamingtic.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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
  const MyGamePage({super.key, required this.login, required this.count, required this.modId});

  final String login;
  final int count;
  final int modId;

  @override
  State<MyGamePage> createState()=>_MyGamePageState();
}

class Modificators extends StatefulWidget{
  const Modificators({super.key, required this.login, required this.count});
  final String login;
  final int count;
  //final int modId;
  @override
  State<Modificators> createState()=>_ModificatorsState();
}

class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  State<SignUp> createState()=>_SignUpState();
}

class AchivHunt extends StatefulWidget{
  const AchivHunt({super.key, required this.login, required this.count, required this.modId});

  final String login;
  final int count;
  final int modId;

  @override
  State<AchivHunt> createState()=>_AchivHuntState();
}




class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _ModificatorsState extends State<Modificators>{
  //int count=0;
  
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
          const Text("Модификаторы", style: TextStyle(color: Colors.white, fontSize: 20),),
          const Text("Доступно несколько модификаторов", style: TextStyle(color: Colors.white, fontSize: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(iconSize: 50, onPressed: () async{
                final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                sharedPreferences.setInt("MOD", 1);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGamePage(login: widget.login, count: widget.count, modId: 1,)));
              }, icon: const Icon(Icons.toys)),
              const Text("Режим кошки/собаки", style: TextStyle(color: Colors.white, fontSize: 15),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(iconSize: 50, onPressed: () async {
                final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                sharedPreferences.setInt("MOD", 0);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGamePage(login: widget.login, count: widget.count, modId: 0,)));
              }, icon: const Icon(Icons.ac_unit)),
              const Text("Классический режим", style: TextStyle(color: Colors.white, fontSize: 15),)
            ],
          ),
          IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back)),
          
        ],
      ),
    );
  }

  
}

class _AchivHuntState extends State<AchivHunt>{

  List<Achivment> exList=[];

  @override
  void initState(){
    for (int i=0; i<allAch.length; i++){
      if (allAch[i].countWin<=widget.count){
        exList.add(allAch[i]);
      }
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Allcolors.firstColor,
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              const Text("Достижения", style: TextStyle(color: Colors.white, fontSize: 20,)),
              SizedBox(width: 430, height: 500,
              child: ListView.builder(itemCount: exList.length, scrollDirection: Axis.vertical, itemBuilder: (BuildContext context, int index){
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
                      Image(image: AssetImage(exList[index].image),width: 50, height: 50,),
                      Text(exList[index].name,style: const TextStyle(color: Colors.black, fontSize: 18)),
                      Text("${exList[index].countWin}",style: const TextStyle(color: Colors.black, fontSize: 18),)
                    ],),
                  ),
                );
              }),),
              IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back)),
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

  @override
  void initState(){
    super.initState();
    login=PlatTicTac.getLogin();
    pass=PlatTicTac.getPass();
    count=PlatTicTac.getCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Allcolors.firstColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text("Вход", style: TextStyle(color: Colors.white, fontSize: 20),),
          TextFormField(decoration: const InputDecoration(hintText: "Логин",), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, ), initialValue: "$login", onChanged: (text){
            login=text;
          },),
          TextFormField(decoration: const InputDecoration(hintText: "Пароль",), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, ), initialValue: "$pass", onChanged: (text){
            pass=text;
          },),
          ElevatedButton(onPressed: () async {
            if (login.isNotEmpty && pass.isNotEmpty){
              final SharedPreferences shared=await SharedPreferences.getInstance();
              if (shared.getString("USERNAME")==login && shared.getString("USERPASS")==pass){
                count=shared.getInt("USERCOUNT")!;
                login=shared.getString("USERNAME")!;
                pass=shared.getString("USERPASS")!;
                shared.setInt("MOD", 0);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGamePage(login: login, count: count, modId: 0,)));
              }
              else{
                shared.setInt("USERCOUNT", count);
                shared.setString("USERNAME", login);
                shared.setString("USERPASS", pass);
                shared.setInt("MOD", 0);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGamePage(login: login, count: count, modId: 0,)));
              }
            }
            else{
              showDialog(context: context, builder: (context)=>AlertDialog(
                title: const Text("Ошибка"),
                content: const Text("Ошибка входа в систему"),
                actions: <Widget>[
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("ОК"))
                ],
              ));
            }
          }, child: const Text("Войти", style: TextStyle(fontSize: 18,),))
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

  String login="";//Shared
  int count=0;
  int modId=0;

  @override
  void initState(){
    super.initState();
    login=widget.login;
    count=widget.count;
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
          Text("Игрок: $login Количество побед: $count", style: const TextStyle(color: Colors.white, fontSize: 22),),
          Text("$lastPlay Очередь", style: const TextStyle(color: Colors.white, fontSize: 22)),
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
                      gaming.newBoard![index]=lastPlay;
                      turn++;
                      gameOver=gaming.whoWin(lastPlay, index, scoreBoard, 3);
                      if (gameOver){
                        resInEnd="$lastPlay победил!!!";
                        if (lastPlay==mods[modId][0]){
                          count=count+1;
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
          Text(resInEnd, style: const TextStyle(color: Colors.white, fontSize: 54.0),),
          ElevatedButton.icon(onPressed: (){
            setState(() {
              gaming.newBoard=Gaming.newGameBoard();
              lastPlay=mods[modId][0];
              gameOver=false;
              turn=0;
              resInEnd="";
              scoreBoard=[0, 0, 0, 0, 0, 0, 0, 0];
            });
          }, icon: const Icon(Icons.replay), label: const Text("Начать заново")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(onPressed: () async{
                final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                sharedPreferences.setInt("USERCOUNT", count);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Modificators(login: login, count: count)));
              }, icon: const Icon(Icons.restart_alt)),
              IconButton(onPressed: () async {
                final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                sharedPreferences.setInt("USERCOUNT", count);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AchivHunt(login: login, count: count, modId: modId,)));
              }, icon: const Icon(Icons.payment)),
              IconButton(onPressed: (){
                showDialog(context: context, builder: (context)=> AlertDialog(
                  title: const Text("Выход из системы"),
                  content: const Text("Вы уверены что хотите выйти?"),
                  actions: <Widget>[
                    TextButton(onPressed: () async{
                      final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                      sharedPreferences.setInt("USERCOUNT", count);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));
                    }, child: Container(color: Colors.white, padding: const EdgeInsets.all(14), child: const Text("Да"),)),
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Container(color: Colors.white, padding: const EdgeInsets.all(14), child: const Text("Нет"),)),
                  ],
                ));
              }, icon: const Icon(Icons.exit_to_app))
            ],
          ),
        ],
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Achivment{
  late String name;
  late int countWin;
  late String image;
  Achivment(this.name,this.countWin,this.image);
}

List allAch=[
  Achivment("Выйграйте 1 раз", 1, "assets/bronze.png"),
  Achivment("Выйграйте 3 раз", 3, "assets/silver.png"),
  Achivment("Выйграйте 5 раз", 5, "assets/gold.png"),
];

