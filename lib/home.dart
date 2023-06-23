import 'package:flutter/material.dart';
import 'package:newuser/userdata.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Container(height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/image/Welcome (1).png"),fit: BoxFit.fill)
        ),
        child: Center(child: Column(
          children: [SizedBox(height: 400,),
            Text('Welcome !',style: TextStyle(color: Colors.pinkAccent.shade100		,fontSize: 50),),
            ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.shade100),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>userdata()));
            }, child: Text('welcome',style: TextStyle(color: Colors.black),))
          ],
        )),)
          ,
     /* ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>userdata()));
      }, child: Text('welcome'))*/

    );
  }
}
