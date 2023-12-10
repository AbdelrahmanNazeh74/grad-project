import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/chatbot/api_manager.dart';
import 'package:graduation_project/chatbot/components/text_message.dart';
import '../my_theme.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName='chat-screen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final firestore =FirebaseFirestore.instance;
  final auth =FirebaseAuth.instance;
  late User? signedInUser;
  String? textMessage='';
  bool? isSender=false;
  List<TextMessage?> messages=[];
  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: const [
            BackButton(
              color: Colors.black,
            ),
            CircleAvatar(
            backgroundImage: AssetImage('assets/images/robot_icon.png'),
              backgroundColor: Colors.white,
          ),
            SizedBox(width: 8,),
            Text('Issac',style: TextStyle(fontSize: 16,color: Colors.black),),
          ],
        ),
      ),
        body: Column(
          children: [

            Expanded(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  itemBuilder: (buildContext, index) {
                  Widget widget=messages[index] as Widget;
                    return widget;
                  },
                itemCount: messages.length,
              ),
            ),
            ),
            Container(
              color: MyTheme.greyColor,
              padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(child: Container(
                      decoration: BoxDecoration(
                        color: MyTheme.greyColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: messageTextController,
                            onChanged: (value){
                              textMessage = value;
                              isSender = true;
                            },
                            style: const TextStyle(
                                color: Colors.black
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Type Message',
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ),
                    const SizedBox(width: 8,),
                    InkWell(
                      onTap: ()async{
                        messageTextController.clear();
                        if(isSender == true){
                          messages.add(TextMessage(isSender: true, text: textMessage));
                          await ApiManager.getChatMessage(textMessage.toString()).then((value) => messages.add(TextMessage(isSender: false, text: value.message)));
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color:MyTheme.greyColor,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.send,color: MyTheme.secondColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
  
}