

import 'package:flutter/material.dart';
import 'package:quraan_task_razan/QuraanBrain.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key,required this.searchKey}) : super(key: key);
  final String searchKey;
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  QuraanBrain qb = QuraanBrain();
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold (
        appBar: AppBar(),
        body: FutureBuilder(
          future: qb.searchQuraan(widget.searchKey),
          builder: (context,snapshot){
            if(snapshot.hasData){
              List results = snapshot.data as List;
              return ListView.builder(itemBuilder: (context,index){
                return SingleChildScrollView(
                  child: Container(
                    child:
                      ListTile(title: Text('${results[index]['text']}'),),

                  ),
                );
              });
            }
            else{
              return CircularProgressIndicator();
            }
          },),
      ),
    );
  }
}
