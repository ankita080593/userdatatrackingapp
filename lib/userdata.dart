import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:newuser/home.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class userdata extends StatefulWidget {
  const userdata({Key? key}) : super(key: key);

  @override
  State<userdata> createState() => _userdataState();
}

class _userdataState extends State<userdata> {
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  TextEditingController cpass=TextEditingController();
  TextEditingController mob=TextEditingController();
  TextEditingController Inputdate=TextEditingController();
  String?gender;
  var groupValue=0;
  bool value1=false;
  String?selectedValue;
  String?formattedDate;
  File?_imageFile;
  var colorcode;
  var secure=true;
  var set=true;
  final List<String>items=[
    'Surat',
    'Ahemdabad',
    'Bharuch',
    'Baroda'
  ];
  late LocationData _currentPosition;
  var lat;
  var long;
  final _formKey = GlobalKey<FormState>();
  void getLocation() async {
    if (await Permission.location.isGranted) {
      _currentPosition = await Location().getLocation();
      print(_currentPosition.latitude);
      print(_currentPosition.longitude);

      setState(() {
        lat = _currentPosition.latitude.toString();
        long = _currentPosition.longitude.toString();
      });
    } else {
      Permission.location.request();
    }
  }

  Future<void> submitform() async {}
  @override
  void initState(){
    Inputdate.text='';
    super.initState();
     getLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(scrollDirection: Axis.vertical,
            child: Form(key: _formKey,
                  child: Container(height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(image: DecorationImage(image:AssetImage('assets/image/new.png'),fit: BoxFit.cover)),
                      child: Center(widthFactor: 100,heightFactor: 100,
                            child: SingleChildScrollView(scrollDirection: Axis.vertical,
                              child: Column(
                                children: [SizedBox(height: 30,width: 450,),

                                  Container(child: _imageFile==null?
                                  GestureDetector(onTap:(){ showModalBottomSheet(context: context,
                                      builder: (context) {
                                        return Wrap(children: [ListTile(onTap: () {
                                          getfromcamera();
                                        },
                                          leading: Icon(Icons.camera_alt),
                                          title: Text('Camera'),),
                                          ListTile(onTap: () {
                                            getfromgallery();
                                          },
                                              leading: Icon(Icons.image),
                                              title: Text('Gallery')
                                          ),
                                        ],
                                        );
                                      }
                                  );
                                  },
                                      child: CircleAvatar(radius:40,child: CircleAvatar(backgroundImage:AssetImage("assets/image/user.png") ,
                                        backgroundColor:Colors.white,radius: 40,),)
                                  ):
                                  CircleAvatar(radius:40,child: CircleAvatar(backgroundImage: Image.file(_imageFile!,fit: BoxFit.cover,).image,radius: 40,))),
                                  SizedBox(height: 5,),
                                      SizedBox(width:305,child: Text('Name',
                                        style: TextStyle(color: Colors.pinkAccent[100],fontSize: 20,fontWeight: FontWeight.w600),)),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(height: 40,width: MediaQuery.of(context).size.width/1.3,
                                          child:TextFormField(controller: name,
                                              cursorColor: Colors.pinkAccent[100],
                                              validator: (value){
                                                if(value==null||value.isEmpty){
                                                  return 'Name is required';
                                                }
                                              },
                                              decoration: InputDecoration(hintText: 'Name',border: InputBorder.none,
                                                  contentPadding: EdgeInsets.all(5),
                                                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                      borderSide: BorderSide(color: Colors.red,width: 1)),
                                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                      borderSide:BorderSide(width: 1,color: Colors.black) ),
                                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                      borderSide:BorderSide(width: 1,color: Colors.pinkAccent.shade100) ),prefixIcon: Padding(
                                                        padding: const EdgeInsets.all(5),
                                                        child: Icon(Icons.person,color: Colors.pinkAccent[100],),
                                                      )),
                                            ),
                                        ),
                                      ),
                                  SizedBox(height: 2,),
                                      SizedBox(width:305,child: Text('Email',
                                          style: TextStyle(color: Colors.pinkAccent[100],fontSize: 20,fontWeight: FontWeight.w600))),
                                      Container(height: 40,width: MediaQuery.of(context).size.width/1.3,
                                        child: TextFormField(controller:email,
                                            cursorColor: Colors.pinkAccent[100],
                                            validator: (value){
                                              if(value==null||value.isEmpty){
                                                return 'Email address is required';
                                              }else if (!value.contains('@')) {
                                                return 'please enter a valid emaiil ';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(hintText: 'Email Address',border:InputBorder.none,
                                                contentPadding: EdgeInsets.all(5),
                                                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                    borderSide: BorderSide(color: Colors.red,width: 1)),

                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                    borderSide:BorderSide(width: 1,color: Colors.black) ),
                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                    borderSide:BorderSide(width: 1,color: Colors.pinkAccent.shade100) ),prefixIcon: Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: Icon(Icons.email,color: Colors.pinkAccent[100],),
                                                    )),
                                          ),

                                      ),
                                  SizedBox(height: 2,),
                                      SizedBox(width:305,child: Text('Password',style: TextStyle(color: Colors.pinkAccent[100],fontSize: 20,fontWeight: FontWeight.w600))),
                                      Container(height: 40,width: MediaQuery.of(context).size.width/1.3,
                                        child: TextFormField(controller: pass,
                                            cursorColor: Colors.pinkAccent[100],
                                            obscureText: secure,
                                            validator: (value){
                                              if(value==null||value.isEmpty){
                                                return 'Password is required';
                                              }
                                              else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
                                                return 'please enter a valid password ';
                                              }
                                              if(value.toString()!=cpass.text){
                                                return 'pass is not match';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(hintText: 'Password',border: InputBorder.none,
                                              contentPadding: EdgeInsets.all(5),
                                              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                  borderSide: BorderSide(color: Colors.red,width: 1)),

                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                    borderSide:BorderSide(width: 1,color: Colors.black) ),
                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                    borderSide:BorderSide(width: 1,color: Colors.pinkAccent.shade100),
                                                ),prefixIcon: Icon(Icons.lock,color: Colors.pinkAccent[100],),

                                              suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        secure = !secure;
                                                      });
                                                    },
                                                    icon: secure == true
                                                        ? Icon(Icons.visibility_off,color: Colors.pinkAccent[100],)

                                                        : Icon(Icons.visibility,color: Colors.pinkAccent[100],)),
                                            ),
                                          ),
                                      ),
                                  SizedBox(height: 2,),
                                        SizedBox(width:305,child: Text('Confirm Password',style: TextStyle(color: Colors.pinkAccent[100],fontSize: 20,fontWeight: FontWeight.w600))),
                                      Container(height: 40,width: MediaQuery.of(context).size.width/1.3,
                                        child: TextFormField(controller: cpass,
                                          cursorColor: Colors.pinkAccent[100],
                                          obscureText: set,
                                          validator: (value){
                                            if(value==null||value.isEmpty){
                                              return 'Confirm password is required';
                                            }else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
                                              return 'please enter a valid password ';
                                            }
                                            if(value.toString()!=pass.text){
                                              return 'pass is not match';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(hintText: 'Confirm Password',border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(5),
                                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                borderSide: BorderSide(color: Colors.red,width: 1)),

                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                  borderSide:BorderSide(width: 1,color: Colors.black) ),
                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                  borderSide:BorderSide(width: 1,color: Colors.pinkAccent.shade100) ),prefixIcon: Icon(Icons.lock,color: Colors.pinkAccent[100],),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    set = !set;
                                                  });
                                                },
                                                icon: set == true
                                                    ? Icon(Icons.visibility_off,color: Colors.pinkAccent[100],)
                                                    : Icon(Icons.visibility,color: Colors.pinkAccent[100],)),
                                          ),
                                        ),
                                      ),
                                  SizedBox(height: 2,),
                                        SizedBox(width:305,child: Text('Mobile Number',style: TextStyle(color: Colors.pinkAccent[100],fontSize: 20,fontWeight: FontWeight.w600))),
                                      Container(height: 40,width: MediaQuery.of(context).size.width/1.3,
                                        child: TextFormField(controller: mob,
                                          cursorColor: Colors.pinkAccent[100],
                                          validator: (value){
                                            if(value==null||value.isEmpty){
                                              return 'Mobile number is required';
                                            }else if (value.length != 10) {
                                              return 'please enter a valid mobile number';
                                            }
                                            return null;

                                          },
                                          decoration: InputDecoration(hintText: 'Enter your 10 digit mobile number',
                                              contentPadding: EdgeInsets.all(5),
                                              border: InputBorder.none,
                                              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                  borderSide: BorderSide(color: Colors.red,width: 1)),

                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                  borderSide:BorderSide(width: 1,color: Colors.black) ),
                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,
                                                  borderSide:BorderSide(width: 1,color: Colors.pinkAccent.shade100) ),prefixIcon: Icon(Icons.call,color: Colors.pinkAccent[100],)),
                                        ),
                                      ),
                                  SizedBox(height: 2,),
                                  SizedBox(width:305,child: Text('Gender',style: TextStyle(color: Colors.pinkAccent[100],fontSize: 20,fontWeight: FontWeight.w600))),
                                     SizedBox(height:0.5 ,),
                                     Row(
                                      children: [SizedBox(width:20 ,),
                                        SizedBox(width: 142,
                                          child: RadioListTile(title:Text('Male'),
                                            value: 'Male',
                                            groupValue: gender,
                                            onChanged: (value){
                                              setState(() {
                                                gender=value;
                                                print('$gender');
                                              });
                                            },
                                            activeColor: Colors.pinkAccent[100],),
                                        ),
                                        SizedBox(width: 15,),
                                        SizedBox(width: 170,

                                          child:RadioListTile(activeColor: Colors.pinkAccent[100],
                                            title:Text('Female'),
                                            value: 'Female',
                                            groupValue: gender,
                                            onChanged: (value){
                                              setState(() {
                                                gender=value;
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),

                                  SizedBox(height: 2,),
                                      SizedBox(width:305,child: Text('Select City',style: TextStyle(color: Colors.pinkAccent[100],fontSize: 20,fontWeight: FontWeight.w600))),
                                      Container(height: 40,width: MediaQuery.of(context).size.width/1.3,decoration: BoxDecoration(borderRadius:BorderRadius.zero,
                                          border:Border.all(color: Colors.black,width: 1)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              items: items
                                                  .map((item) => DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                                  .toList(),
                                              value: selectedValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedValue = value as String;
                                                });
                                              },
                                              buttonStyleData: const ButtonStyleData(
                                                height: 50,
                                                width: 140,

                                              ),
                                              menuItemStyleData: const MenuItemStyleData(
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        ),

                                      ),
                                  SizedBox(height: 2),
                                      SizedBox(width:305,child: Text('Date of Birth',
                                          style: TextStyle(color: Colors.pinkAccent[100],fontSize: 20,fontWeight: FontWeight.w600))),
                                      Container(height:40,width:MediaQuery.of(context).size.width/1.3,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1),borderRadius: BorderRadius.zero),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.2),
                                            child: TextFormField(
                                                controller: Inputdate,
                                                cursorColor: Colors.pinkAccent[100],
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'DD/MM/YYYY',
                                                  suffixIcon: Icon(Icons.date_range,color: Colors.pinkAccent[100],),
                                                ),
                                                readOnly: true,
                                                onTap: ()async {
                                                  DateTime?PickedDate = await
                                                  showDatePicker(context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(1950),
                                                      lastDate: DateTime(2100));
                                                  if (PickedDate != null) {
                                                    print(PickedDate);
                                                    String formattedDate = DateFormat('yyyy-MM-dd').format(PickedDate);
                                                    print(formattedDate);
                                                    setState(() {
                                                      Inputdate.text = formattedDate;
                                                    });
                                                  } else {
                                                    print('Date is not selected ');
                                                  }

                                                }
                                            ),
                                          )),
                                  SizedBox(height: 2,),
                                  Row(
                                    children: [SizedBox(width: 45,),
                                      Column(
                                        children: [
                                          SizedBox(width:132,child: Text('Lattitude',style: TextStyle(color: Colors.pinkAccent[100],fontSize: 20,fontWeight: FontWeight.w600))),
                                          SizedBox(height: 5,),
                                            Container(height: 40,width: MediaQuery.of(context).size.width/3,
                                              decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('$lat'),
                                              ),),
                                        ],
                                      ),
                                      SizedBox(width: 41,),
                                      Column(
                                        children: [
                                          SizedBox(width:132,child: Text('Longitude',style: TextStyle(color: Colors.pinkAccent[100],fontSize: 20,fontWeight: FontWeight.w600))),
                                          SizedBox(height: 5,),
                                          Container(height: 40,width: MediaQuery.of(context).size.width/3,
                                            decoration: BoxDecoration(border:Border.all(color: Colors.black,width: 1)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text('$long'),
                                            ),),
                                        ],
                                      ),

                                    ],
                                  ),





                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(activeColor: Colors.pinkAccent[100],
                                          checkColor: Colors.white,
                                          value: this.value1, onChanged: (bool?value){
                                            setState(() {
                                              this.value1=value!;
                                            }
                                            );
                                            if(this.value1=value!){
                                              setState(() {
                                                colorcode=1;
                                              });
                                            }else{
                                              setState(() {
                                                colorcode=2;
                                              });
                                            }
                                          }

                                      ),
                                      Text('Check',style: TextStyle(color: Colors.pinkAccent[100],fontSize: 20,fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  IgnorePointer(ignoring: !value1,
                                    child: ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:colorcode==1?Colors.pinkAccent[100]: Colors.grey),onPressed: ()async {
                                     // if (_formKey.currentState!.validate())
                                      if (_formKey.currentState?.validate() == true){
                                        var submitdata = {};
                                        var postUri = Uri.parse(
                                            'http://samshera.000webhostapp.com/api.php');
                                        http.MultipartRequest request = http.MultipartRequest(
                                            'post', postUri);
                                        if (_imageFile != null) {
                                          request.files.add(http.MultipartFile.fromBytes(
                                              'photo',
                                              File(_imageFile!.path).readAsBytesSync(),
                                              filename: _imageFile!.path));
                                        }
                                        request.fields['name'] = name.text;
                                        request.fields['email'] = email.text;
                                        request.fields['pass'] = pass.text;
                                        request.fields['cpass'] = cpass.text;
                                        request.fields['mob'] = mob.text;
                                        request.fields['gender'] = gender.toString();
                                        request.fields['city'] = selectedValue.toString();
                                        request.fields['dob'] = Inputdate.text;
                                        request.fields['latitude']=lat.toString();
                                        request.fields['longitude']=long.toString();
                                        var streamedResponse = await request.send();
                                        print(request.fields);
                                        var response = await http.Response.fromStream(
                                            streamedResponse);
                                        if (response.statusCode == 200) {
                                          var data = await jsonDecode(response.body);
                                          print(response.body);
                                          if (data['status'] == 1) {
                                            Get.defaultDialog(
                                                title: 'Submited succesfully',
                                                middleText: '',
                                                actions: [
                                                  CircleAvatar(
                                                    child: IconButton(onPressed: () {
                                                      Navigator.pushReplacement(context,
                                                          MaterialPageRoute(
                                                              builder: (contex) => home()));
                                                    },
                                                      icon: Icon(Icons.check),
                                                      color: Colors.pinkAccent[100],
                                                    ),
                                                    backgroundColor: Colors.white,
                                                  )
                                                ],
                                                backgroundColor: Colors.pinkAccent[100],
                                                titleStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                radius: 30);
                                          } else {
                                            Get.defaultDialog(
                                                title: 'Error in Submition',
                                                middleText: 'Try again',
                                                backgroundColor: Colors.redAccent,
                                                titleStyle: TextStyle(color: Colors.white));
                                          }
                                        }
                                      }
                                    }, child: Text('submit',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600))),
                                  )
                                ],
                              ),
                            ),

                      ),
                    ),

              ),
          ),
    );
  }
  getfromgallery()async{
    final pickedFile=await ImagePicker().pickImage(source:ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 150,
    );
    if(pickedFile==null)return;
    setState((){
      _imageFile=File(pickedFile.path);
    });

  }
  getfromcamera()async{
    final pickedFile=await ImagePicker().pickImage(source:ImageSource.camera,
      maxWidth: 100,
      maxHeight: 100,);
    if(pickedFile!=null){
      setState((){
        _imageFile=File(pickedFile.path);
      });
    }
  }

}
