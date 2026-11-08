import 'package:flutter/material.dart';
import '../../widgets/ai_header.dart';


class VoiceAssistantScreen extends StatefulWidget {

  const VoiceAssistantScreen({super.key});


  @override
  State<VoiceAssistantScreen> createState() =>
      _VoiceAssistantScreenState();

}



class _VoiceAssistantScreenState
    extends State<VoiceAssistantScreen> {


  bool listening = false;


  String userMessage = "";

  String aiResponse = "";



  void startListening(){


    setState((){


      listening = true;


      userMessage =
      "What are my symptoms?";


      aiResponse =
      "Based on your symptoms, please consult a doctor for accurate diagnosis.";


    });


  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar:AppBar(

        title:const Text(

          "Voice Assistant",

        ),

      ),



      body:SingleChildScrollView(

        padding:const EdgeInsets.all(15),


        child:Column(

          children:[



            const AIHeader(

              title:"AI Voice Assistant",

              subtitle:
              "Ask your healthcare questions using voice",

              icon:Icons.mic,

            ),



            const SizedBox(height:30),



            AnimatedContainer(

              duration:
              const Duration(seconds:1),


              height:150,


              width:150,


              decoration:BoxDecoration(

                shape:BoxShape.circle,


                color:listening

                    ? Colors.blue

                    : Colors.blue.shade100,

              ),



              child:Icon(

                Icons.mic,

                size:80,


                color:listening

                    ? Colors.white

                    : Colors.blue,

              ),


            ),



            const SizedBox(height:30),



            ElevatedButton.icon(

              onPressed:startListening,


              icon:const Icon(

                Icons.mic,

              ),


              label:const Text(

                "Start Listening",

              ),

            ),



            const SizedBox(height:30),



            if(userMessage.isNotEmpty)

              Card(

                elevation:5,


                child:Padding(

                  padding:
                  const EdgeInsets.all(15),


                  child:Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,


                    children:[



                      const Text(

                        "You asked:",

                        style:TextStyle(

                          fontWeight:
                          FontWeight.bold,

                        ),

                      ),



                      Text(

                        userMessage,

                      ),



                    ],

                  ),

                ),

              ),



            const SizedBox(height:15),



            if(aiResponse.isNotEmpty)

              Card(

                elevation:5,


                child:Padding(

                  padding:
                  const EdgeInsets.all(15),


                  child:Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,


                    children:[



                      const Text(

                        "Nexora AI Response:",

                        style:TextStyle(

                          fontWeight:
                          FontWeight.bold,

                        ),

                      ),



                      Text(

                        aiResponse,

                      ),



                    ],

                  ),

                ),

              ),



            const SizedBox(height:20),



            Container(

              height:80,

              width:double.infinity,


              decoration:BoxDecoration(

                color:Colors.blue.shade50,

                borderRadius:
                BorderRadius.circular(20),

              ),



              child:const Center(

                child:Text(

                  "〰️ 〰️ 〰️\nVoice Wave Animation",

                  textAlign:TextAlign.center,

                  style:TextStyle(

                    fontSize:18,

                  ),

                ),

              ),

            )


          ],

        ),

      ),

    );

  }

}