import 'package:flutter/material.dart';
import '../../widgets/ai_header.dart';


class EmergencyScreen extends StatefulWidget {

  const EmergencyScreen({super.key});


  @override
  State<EmergencyScreen> createState() =>
      _EmergencyScreenState();

}



class _EmergencyScreenState
    extends State<EmergencyScreen> {


  bool emergencyActivated = false;



  void activateSOS(){


    setState((){

      emergencyActivated = true;

    });


    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content:Text(

          "Emergency Alert Sent Successfully",

        ),

      ),

    );


  }



  void callEmergency(){


    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content:Text(

          "Calling 108 Emergency Service",

        ),

      ),

    );


  }




  void sendFamilyAlert(){


    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content:Text(

          "Family Members Notified",

        ),

      ),

    );


  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar:AppBar(

        title:const Text(

          "Emergency SOS",

        ),

      ),



      body:SingleChildScrollView(

        padding:const EdgeInsets.all(15),


        child:Column(

          children:[



            const AIHeader(

              title:"Emergency SOS",

              subtitle:
              "Quick medical help during critical situations",

              icon:Icons.warning,

            ),



            const SizedBox(height:40),



            GestureDetector(

              onTap:activateSOS,


              child:Container(

                height:170,

                width:170,


                decoration:BoxDecoration(

                  color:Colors.red,

                  shape:BoxShape.circle,


                  boxShadow:[

                    BoxShadow(

                      color:Colors.red.withOpacity(0.4),

                      blurRadius:20,

                      spreadRadius:5,

                    )

                  ],

                ),



                child:const Center(

                  child:Text(

                    "SOS",

                    style:TextStyle(

                      color:Colors.white,

                      fontSize:45,

                      fontWeight:
                      FontWeight.bold,

                    ),

                  ),

                ),

              ),

            ),



            const SizedBox(height:30),



            if(emergencyActivated)

              Card(

                color:Colors.red.shade50,


                child:const Padding(

                  padding:EdgeInsets.all(15),


                  child:Text(

                    "🚨 Emergency Activated\n"
                    "Location shared\n"
                    "Family notification sent",

                    style:TextStyle(

                      fontSize:18,

                      fontWeight:
                      FontWeight.bold,

                    ),

                  ),

                ),

              ),



            const SizedBox(height:25),



            SizedBox(

              width:double.infinity,


              child:ElevatedButton.icon(

                onPressed:callEmergency,


                icon:const Icon(

                  Icons.call,

                ),


                label:const Text(

                  "Call 108",

                ),

              ),

            ),



            const SizedBox(height:15),



            SizedBox(

              width:double.infinity,


              child:ElevatedButton.icon(

                onPressed:sendFamilyAlert,


                icon:const Icon(

                  Icons.family_restroom,

                ),


                label:const Text(

                  "Notify Family",

                ),

              ),

            ),



            const SizedBox(height:15),



            Card(

              elevation:5,


              child:ListTile(

                leading:const Icon(

                  Icons.location_on,

                  color:Colors.red,

                ),


                title:const Text(

                  "Live Location",

                ),


                subtitle:const Text(

                  "Current location shared with emergency contacts",

                ),

              ),

            ),



            const SizedBox(height:15),



            Container(

              height:200,

              width:double.infinity,


              decoration:BoxDecoration(

                color:Colors.grey.shade300,

                borderRadius:
                BorderRadius.circular(20),

              ),



              child:const Center(

                child:Text(

                  "Live Map Placeholder",

                  style:TextStyle(

                    fontSize:20,

                  ),

                ),

              ),

            ),


          ],

        ),

      ),

    );

  }

}