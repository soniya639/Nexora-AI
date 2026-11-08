import 'package:flutter/material.dart';
import '../../widgets/ai_header.dart';


class FamilyNotificationScreen extends StatefulWidget {

  const FamilyNotificationScreen({super.key});


  @override
  State<FamilyNotificationScreen> createState() =>
      _FamilyNotificationScreenState();

}



class _FamilyNotificationScreenState
    extends State<FamilyNotificationScreen> {


  final TextEditingController nameController =
      TextEditingController();


  final TextEditingController phoneController =
      TextEditingController();


  final TextEditingController messageController =
      TextEditingController();



  List<String> familyMembers = [];



  void addFamilyMember(){


    if(nameController.text.isNotEmpty){


      setState((){


        familyMembers.add(

          "${nameController.text} - ${phoneController.text}",

        );


      });


      nameController.clear();

      phoneController.clear();


    }


  }




  void sendNotification(){


    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content:Text(

          "Emergency Notification Sent Successfully",

        ),

      ),

    );


  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar:AppBar(

        title:const Text(

          "Family Notification",

        ),

      ),



      body:SingleChildScrollView(

        padding:const EdgeInsets.all(15),


        child:Column(

          children:[



            const AIHeader(

              title:"Family Health Alert",

              subtitle:
              "Notify your family during emergency situations",

              icon:Icons.family_restroom,

            ),



            const SizedBox(height:20),



            TextField(

              controller:nameController,


              decoration:InputDecoration(

                labelText:"Family Member Name",

                prefixIcon:
                const Icon(Icons.person),


                border:OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(15),

                ),

              ),

            ),



            const SizedBox(height:15),



            TextField(

              controller:phoneController,


              keyboardType:
              TextInputType.phone,


              decoration:InputDecoration(

                labelText:"Phone Number",

                prefixIcon:
                const Icon(Icons.phone),


                border:OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(15),

                ),

              ),

            ),



            const SizedBox(height:15),



            ElevatedButton.icon(

              onPressed:addFamilyMember,


              icon:const Icon(

                Icons.add,

              ),


              label:const Text(

                "Add Family Member",

              ),

            ),



            const SizedBox(height:20),



            const Align(

              alignment:Alignment.centerLeft,


              child:Text(

                "Family Members",

                style:TextStyle(

                  fontSize:22,

                  fontWeight:FontWeight.bold,

                ),

              ),

            ),



            const SizedBox(height:10),



            ListView.builder(

              shrinkWrap:true,

              physics:
              const NeverScrollableScrollPhysics(),


              itemCount:familyMembers.length,


              itemBuilder:(context,index){


                return Card(

                  child:ListTile(

                    leading:
                    const Icon(Icons.family_restroom),


                    title:
                    Text(familyMembers[index]),

                  ),

                );


              },

            ),



            const SizedBox(height:20),



            TextField(

              controller:messageController,


              maxLines:3,


              decoration:InputDecoration(

                labelText:"Emergency Message",

                hintText:
                "Example: I need medical help",

                border:OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(15),

                ),

              ),

            ),



            const SizedBox(height:25),



            SizedBox(

              width:double.infinity,


              child:ElevatedButton.icon(

                onPressed:sendNotification,


                icon:const Icon(

                  Icons.notifications_active,

                ),


                label:const Text(

                  "Send Notification",

                ),

              ),

            ),



          ],

        ),

      ),

    );

  }

}