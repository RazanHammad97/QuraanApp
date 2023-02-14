import 'dart:convert';

import 'package:http/http.dart' as http;


class QuraanBrain {
  List<dynamic> data=[];
  Future<int> getQuraanPages() async {
    String url = "http://api.alquran.cloud/v1/meta";
    Uri apiUrl = Uri.parse(url);
    var response = await http.get(apiUrl, headers: {});
    //print(response.body);

    var decodedResponse = jsonDecode(response.body);

   // print(decodedResponse['data']['pages']['count']);
    return decodedResponse['data']['pages']['count'];
  }

  Future<int> getAyahsNumberperPage(String pageNum) async {
    String url = "http://api.alquran.cloud/v1/page/$pageNum";
    Uri apiUrl = Uri.parse(url);
    var response = await http.get(apiUrl, headers: {});
    var decodedResponse = jsonDecode(response.body);
   // print(decodedResponse['data']['ayahs'].length);
    return decodedResponse['data']['ayahs'].length;
  }

  Future<String> getAyahsTextsPerPage(int numOfAyah,String pageNum) async{
   // late final int numOfAyahs =QuraanBrain().getAyahsNumberperPage(pageNum) as int;
    String url = "http://api.alquran.cloud/v1/page/$pageNum";
    Uri apiUrl = Uri.parse(url);
    var response = await http.get(apiUrl, headers: {});
    var decodedResponse = jsonDecode(response.body);
    print(decodedResponse['data']['ayahs'][numOfAyah]['text']);

   return decodedResponse['data']['ayahs'][numOfAyah]['text'];



  }

  Future<List<String>> getQuraanTextsBrain(String page) async {
    final int ayahs = await getAyahsNumberperPage(page);
    List<String> texts=[];
    for (int i = 0; i < ayahs - 1; i++)
       {texts.add( await getAyahsTextsPerPage(i + 1, page));

      }
    print(texts);
    return (texts);


  }

  // from the below function , can get the name of quraan surahs and it's numbers
   Future<List> getSurahAyahs({int? surahNum}) async{
    String url = "http://api.alquran.cloud/v1/surah/$surahNum";
    Uri api_url = Uri.parse(url);
    var response = await http.get(api_url, headers: {});
    var decodedResponse = jsonDecode(response.body);


    //print(decodedResponse['data'][index]['name']);
    //print(decodedResponse['data']['ayahs']);
    return decodedResponse['data']['ayahs'];
  }


  getSurahsNameOfQuraan() async{
    String url = "http://api.alquran.cloud/v1/surah";
    Uri api_url = Uri.parse(url);
    var response = await http.get(api_url, headers: {});
    var decodedResponse = jsonDecode(response.body);


    //print(decodedResponse['data'][index]['name']);
    return decodedResponse['data'];
  }

    // no need for this function
  // this function returns the number of quraan surahs
  Future<int> getNumberOfQuraanSurahs() async{
    String url = "http://api.alquran.cloud/v1/surah";
    Uri api_url = Uri.parse(url);
    var response = await http.get(api_url,headers: {});
    var decodedResponse = jsonDecode(response.body);
    //print(decodedResponse['data']);
    data.add(decodedResponse['data'].length);
   // print(data[0]);
    return (data[0]);
  }

  Future<List<dynamic>> loadNeededData({int? surahNum}) async{
    List<dynamic> neededData=[];
    var surahName = await getSurahsNameOfQuraan();
    neededData.add(surahName);
    var surahAyahs = await getSurahAyahs(surahNum: surahNum);
    neededData.add(surahAyahs);
    //print(neededData[1]);
    return neededData;
  }

   getTheHolyQuraan(String keyword) async{
    String url = "http://api.alquran.cloud/v1/search/$keyword";
    Uri api_url = Uri.parse(url);
    var response = await http.get(api_url);
    var decodedResponse = jsonDecode(response.body);
    print(decodedResponse['data']['matches']);
   // print(decodedResponse['data']['count']);
    return decodedResponse['data']['matches'];
  }

  searchQuraan(String query) async{
    String url = "http://api.alquran.cloud/v1/search/$query";
    Uri api_url = Uri.parse(url);
    var response = await http.get(api_url);
    var decoded_response = jsonDecode(response.body);
   // print (decoded_response['data']['matches']);
    return decoded_response['data']['matches'];
  }
}
