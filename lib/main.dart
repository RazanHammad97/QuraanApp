import 'package:flutter/material.dart';
import 'package:quraan_task_razan/QuraanBrain.dart';
import 'package:quraan_task_razan/splashscreen.dart';

import 'loadayahs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'القران الكريم',
      theme: ThemeData(
        primarySwatch: buildMaterialColor(Color(0xE2195E59)),
      ),

      home: const SplashScreen(title: "القران الكريم",)
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  QuraanBrain qb = QuraanBrain();

  // late int numberOfPages =  qb.getQuraanPages() as int;
  PageController _controller = PageController();

  Future<List<String>> getQuraanTextsBrain(String page) async {
    final int ayahs = await qb.getAyahsNumberperPage(page);
    List<String> texts = [];
    for (int i = 0; i < ayahs - 1; i++) {
      texts.add(await qb.getAyahsTextsPerPage(i + 1, page));
      setState(() {});
    }
    //print(texts);
    return (texts);
  }

  @override
  Widget build(BuildContext context) {
    //qb.loadNeededData(surahNum: 1);
    //qb.getSurahAyahs(surahNum: 1);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: SafeArea(
            child: Container(
              child: FutureBuilder(
                  future: qb.getSurahsNameOfQuraan(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List items = snapshot.data as List;
                      //print(items);
                      //print(items[0]['name']);
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: SizedBox(
                                width: 27,
                                height: 35,
                                child: Stack(
                                    children: [Image(
                                      color: Color(0xE2195E59),
                                      image: AssetImage("surahnum.png"),),
                                      Center(child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text("${index+1}",style: TextStyle(color: Color(0xE2195E59)),)),)
                                    ]),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_left,color: Color(0xE2195E59),),
                              onTap: () {
                                // print(qb.getSurahAyahs(surahNum: index + 1));
                                print('tapp');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoadAyahs(title: widget.title,surahNum: index+1,surahName: '${items[index]['name']}')));
                                /**  PageView(
                                    controller: _controller,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                    Text('${qb.getSurahAyahs(surahNum: index + 1)}'),
                                    ],
                                    );**/

                                //print(qb.getSurahAyahs(surahNum: 1));
                                // print(index+1);
                                //print(items[index]['numberOfAyahs']);
                              },
                              title: Text('${items[index]['name']}'),
                            );
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          )),
    );
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}