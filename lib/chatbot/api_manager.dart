import 'dart:convert';
import 'package:graduation_project/chatbot/ChatBot.dart';
import 'package:http/http.dart' as http;
import '../student/tabs/homeDetails/Announcments.dart';

class ApiManager{
  static const String BaseUrl='127.0.0.1';
  static Future<ChatBot> getChatMessage(String message)async{

    var uri =Uri.parse("http://10.0.2.2:8000/home/chat?message=${message}");
    var response = await http.get(uri);
    print(response);
    try{
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var sourcesResponse=ChatBot.fromJson(json);
      return sourcesResponse;
    }catch(e){
      throw e;
    }
  }
}


class AnounceManager{
  static Future<List<Announcments>> getAnnouncments()async{

    var uri =Uri.parse("http://10.0.2.2:8000/home/");
    var response = await http.get(uri);
    print(response.body);
    try{
      var bodyString = response.body;
      var json = jsonDecode(bodyString) as List;
      List<Announcments> sourcesResponse=[];
      for(int i=0;i< json.length;i++){
        sourcesResponse.add(Announcments.fromJson(json[i]));
      }
      print('source ========== ${sourcesResponse}' );
      return sourcesResponse;
    }catch(e){
      throw e;
    }
  }
}