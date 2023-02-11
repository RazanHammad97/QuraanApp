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
        primarySwatch: Colors.green,
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
                                      color: Colors.green,
                                      image: AssetImage("surahnum.png"),),
                                      Center(child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text("${index+1}",style: TextStyle(color: Colors.green),)),)
                                    ]),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_left),
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
