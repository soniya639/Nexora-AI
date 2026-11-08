import 'package:flutter/material.dart';

import '../disease_prediction/disease_prediction_screen.dart';
import '../telemedicine/telemedicine_screen.dart';
import '../ambulance/ambulance_tracking_screen.dart';
import '../medical_records/medical_records_screen.dart';
import '../family_notification/family_notification_screen.dart';
import '../emergency/emergency_screen.dart';
import '../offline_ai/offline_ai_screen.dart';

class HomeScreen extends StatelessWidget {
  final String? name;
  final String? age;
  final String? email;

  const HomeScreen({super.key, this.name, this.age, this.email});


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: const Color(0xffF4F8FF),


      appBar: AppBar(

        title: const Text(

          "Nexora AI Healthcare",

          style: TextStyle(

            fontWeight: FontWeight.bold,

          ),

        ),

        centerTitle: true,

      ),



      body: Padding(

        padding: const EdgeInsets.all(16),


        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,


          children: [


            const Text(

              "Welcome to Nexora AI",

              style: TextStyle(

                fontSize:28,

                fontWeight:FontWeight.bold,

                color:Colors.blue,

              ),

            ),



            const SizedBox(height:8),



            const Text(

              "Smart healthcare powered by AI",

              style:TextStyle(

                fontSize:16,

                color:Colors.grey,

              ),

            ),



            const SizedBox(height:25),




            Expanded(

              child: GridView.count(


                crossAxisCount:2,

                crossAxisSpacing:15,

                mainAxisSpacing:15,



                children:[



                  card(

                    context,

                    "Disease\nPrediction",

                    Icons.health_and_safety,

                    Colors.green,

                    const DiseasePredictionScreen(),

                  ),




                  card(

                    context,

                    "Telemedicine",

                    Icons.video_call,

                    Colors.blue,

                    const TelemedicineScreen(),

                  ),




                  card(

                    context,

                    "Ambulance\nTracking",

                    Icons.local_hospital,

                    Colors.red,

                    const AmbulanceTrackingScreen(),

                  ),




                  card(

                    context,

                    "Medical\nRecords",

                    Icons.folder_shared,

                    Colors.orange,

                    const MedicalRecordsScreen(),

                  ),




                  card(

                    context,

                    "Family\nNotification",

                    Icons.family_restroom,

                    Colors.purple,

                    const FamilyNotificationScreen(),

                  ),




                  card(

                    context,

                    "Emergency\nSOS",

                    Icons.emergency,

                    Colors.redAccent,

                    const EmergencyScreen(),

                  ),




                  card(

                    context,

                    "Offline AI",

                    Icons.smart_toy,

                    Colors.teal,

                    const OfflineAIScreen(),

                  ),



                ],

              ),

            )



          ],


        ),


      ),


    );


  }







  Widget card(

      BuildContext context,

      String title,

      IconData icon,

      Color color,

      Widget page,

      ){



    return InkWell(


      onTap:(){


        Navigator.push(

          context,

          MaterialPageRoute(

            builder:(context)=>page,

          ),

        );


      },



      child:Container(


        decoration:BoxDecoration(

          color:Colors.white,

          borderRadius:
          BorderRadius.circular(20),


          boxShadow:[


            const BoxShadow(

              color:Colors.black12,

              blurRadius:8,

              offset:Offset(0,4),

            )

          ],

        ),



        child:Column(

          mainAxisAlignment:
          MainAxisAlignment.center,


          children:[



            CircleAvatar(

              radius:35,


              backgroundColor:
              color.withOpacity(0.15),



              child:Icon(

                icon,

                size:40,

                color:color,

              ),

            ),




            const SizedBox(height:15),




            Text(

              title,

              textAlign:
              TextAlign.center,


              style:const TextStyle(

                fontSize:16,

                fontWeight:
                FontWeight.bold,

              ),

            )



          ],

        ),


      ),


    );


  }


}