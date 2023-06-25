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

        Column(
          children: [SizedBox(height: 100,),
            Container(height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/image/w.jpg"),fit: BoxFit.fill)
            ),),
            SizedBox(height: 100,),
            Text('Welcome!',style: TextStyle(color: Colors.pinkAccent.shade100		,fontSize: 50),),
            SizedBox(height: 100,),
            ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.shade100,),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>userdata()));
            }, child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Get Started',style: TextStyle(color: Colors.white,fontSize: 25),),
            ))
          ],
        ),
     /* ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>userdata()));
      }, child: Text('welcome'))*/

    );
  }
}
