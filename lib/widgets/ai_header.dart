import 'package:flutter/material.dart';

class AIHeader extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData icon;

  const AIHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });


  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        gradient: const LinearGradient(

          colors: [

            Color(0xff007BFF),
            Color(0xff00C6FF),

          ],

        ),

        borderRadius: BorderRadius.circular(20),

      ),


      child: Column(

        children: [

          Icon(

            icon,

            size:60,

            color:Colors.white,

          ),


          const SizedBox(height:10),


          Text(

            title,

            style:const TextStyle(

              color:Colors.white,

              fontSize:24,

              fontWeight:FontWeight.bold,

            ),

          ),


          const SizedBox(height:8),


          Text(

            subtitle,

            textAlign:TextAlign.center,

            style:const TextStyle(

              color:Colors.white70,

              fontSize:15,

            ),

          ),

        ],

      ),

    );

  }

}