import 'package:flutter/material.dart';
import 'package:quraan_task_razan/QuraanBrain.dart';

class LoadAyahs extends StatefulWidget {
  const LoadAyahs({Key? key, required String title, required this.surahNum,required this.surahName}) : super(key: key);
final int surahNum;
final String surahName;
  @override
  State<LoadAyahs> createState() => _LoadAyahsState();
}

class _LoadAyahsState extends State<LoadAyahs> {
  PageController _controller = PageController();
  QuraanBrain qb = QuraanBrain();

  @override
  void dispose() {
    _controller;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: qb.getSurahAyahs(surahNum: widget.surahNum),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List items = snapshot!.data as List;
            //print(items.length);
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  textDirection: TextDirection.rtl,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: AppBar(

                        title: Text("القران الكريم"),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    for (var item in items) ...[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Container(
                              width: double.infinity,

                            
                              child:
                                  RichText(text: TextSpan(text: '${item['text']}'))),
                        ),
                      )
                    ]
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
