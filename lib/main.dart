import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FormPTBacHai(),
    );
  }
}

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class FormPTBacHai extends StatefulWidget {
  const FormPTBacHai({super.key});

  @override
  State<FormPTBacHai> createState() => _FormPTBacHaiState();
}

class _FormPTBacHaiState extends State<FormPTBacHai> {
  double sliderVal=0;
  String _result='';
  bool isA=true;
  bool isB=true;
  bool isC=true;
  TextEditingController aController = TextEditingController();
  TextEditingController bController = TextEditingController();
  TextEditingController cController = TextEditingController();
  
  void checkPTbac1(){
    double a=double.parse(aController.text);
    double b=double.parse(bController.text);
    if(a!=0){
      _result="Nghiệm Của Phương Trình:  x= ${-b/a}";
    }
  }

  void checkPTbac2(){
    double a=double.parse(aController.text);
    double b= double.parse(bController.text);
    double c= double.parse(cController.text);
    double delta=(b*b) - (4*a*c);
    double x1, x2;
    if(a!=0){
      if(delta<0){
        _result="Phương Trình Vô Nghiệm";
      }else if(delta==0){
        x1=-b/(2*a);
        _result="Phương Trình Có Nghiệm Kép: x= $x1";
      }else{
        x1=(-b+sqrt(delta))/(2*a);
        x2=(-b-sqrt(delta))/(2*a);
        _result="Phương Trình Có Hai Nghiệm: \nx1= $x1,    x2= $x2";
      }
    }
  }

  Widget slider(){
    return Slider(
      value: sliderVal,
      min: 0,
      max: 100, 
      onChanged: (val){
        setState(() {
          sliderVal = val;
        });
      }
    );
  }

  Widget rotate(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: Transform.rotate(
        angle: sliderVal,
        origin:const Offset(0, 0),
        child: Container(
          height: 100,
          width: 100,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget scale(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: Transform.scale(
        origin:const Offset(0, 0),
        scale: sliderVal,
        child: Container(
          width: 3,
          height: 3,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget trainsLate(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: Transform.translate(
        offset: Offset(0, sliderVal),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.amber,
        ),
      ),
    );
  }
  

  String dropValue=list.first;
  
  DropdownButton dropdownButton(){
    return DropdownButton(
      items: list.map((value) => DropdownMenuItem(
        value: value,
        child: Text(value),
      )).toList(), 
      onChanged: (value){
        setState(() {
          dropValue=value;
        });
      },
      value: dropValue,
      underline: Container(
        height: 2, color: Colors.pink,
      ),
      style:const TextStyle(color: Colors.amber),
      icon:const Icon(Icons.person_2_outlined),
      dropdownColor: Colors.black,

    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:const Text("Giải Phương Trình", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
          bottom:const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.abc),child: Padding(
                padding: EdgeInsets.only(left: 23, right: 25),
                child: Text("PT Bậc 1"),
              ),),
              Tab(icon: Icon(Icons.abc),child: Padding(
                padding: EdgeInsets.only(left: 23, right: 25),
                child: Text("PT Bậc 2"),
              ),),
              Tab(icon: Icon(Icons.abc),child: Padding(
                padding: EdgeInsets.only(left: 23, right: 25),
                child: Text("test"),
              ),)
            ],
            indicator: ShapeDecoration(
              shape: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  style: BorderStyle.solid
                )
              ),
              gradient: LinearGradient(colors: [Colors.yellow, Colors.white])
            ),
          ),
    
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 500,
            child: TabBarView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textFieldWidget(
                      labelText: "Nhập A",
                      hintText: null,
                      obscureText: false,
                      errorText: isA ? null : "Không Được Bỏ Trống",
                      controller: aController
                    ),
                    textFieldWidget(
                      labelText: "Nhập B",
                      hintText: null,
                      obscureText: false,
                      errorText: isB ? null : "Không Được Bỏ Trống",
                      controller: bController
                    ),
                    
                    buttonWidget(
                      onPressed: (){
                        setState(() {
                          if(aController.text ==""){
                            isA=false;
                          }else{
                            isA=true;
                          }
                          if(bController.text == ""){
                            isB=false;
                          }else{
                            isB=true;
                          }
                          if(isA && isB){
                            checkPTbac1();
                          }
                        });
                      }, 
                      child:"Submit"
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: 400,
                      height: 100,
                      color: Colors.black,
                      child: Text("Kết quả:  $_result", style:const TextStyle(color: Colors.white),),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textFieldWidget(
                      labelText: "Nhập A x^2",
                      hintText: null,
                      obscureText: false,
                      errorText: isA ? null : "Không Được Bỏ Trống",
                      controller: aController
                    ),
                    textFieldWidget(
                      labelText: "Nhập B X",
                      hintText: null,
                      obscureText: false,
                      errorText: isB ? null : "Không Được Bỏ Trống",
                      controller: bController
                    ),
                    textFieldWidget(
                      labelText: "Nhập C",
                      hintText: null,
                      obscureText: false,
                      errorText: isC ? null : "Không Được Bỏ Trống",
                      controller: cController
                    ),
                    
                    buttonWidget(
                      onPressed: (){
                        setState(() {
                          if(aController.text == ""){
                            isA=false;
                          }else{
                            isA=true;
                          }
                          if(bController.text == ""){
                            isB=false;
                          }else{
                            isB=true;
                          }
                          if(cController.text == ""){
                            isC=false;
                          }else{
                            isC=true;
                          }
                          if(isA && isB && isC){
                            checkPTbac2();
                          }   
                        });
                      }, 
                      child:"Submit"
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: 400,
                      height: 100,
                      color: Colors.black,
                      child: Text("Kết quả:  $_result", style:const TextStyle(color: Colors.white),),
                    )
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      dropdownButton(),
                      slider(),
                      rotate(),
                      const SizedBox(height: 100,),
                      scale(),
                      trainsLate(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              ListTile(
                leading:const Icon(Icons.remove_red_eye_outlined),
                title:const Text("yeye"),
                onTap: (){},
              ),
              ListTile(
                leading:const Icon(Icons.remove_red_eye_outlined),
                title:const Text("yeye"),
                onTap: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldWidget({required labelText, required hintText,
    required obscureText, required errorText, required controller,
    }){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 10),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border:const OutlineInputBorder(),
            labelText: labelText,
            hintText: hintText,
            errorText: errorText,
            
          ),
        ),
      );
    }

  Widget buttonWidget({required onPressed,required child, }){
    return SizedBox(
      width: 200,
      height: 60,
      child: ElevatedButton(onPressed: onPressed, 
        child:Text(child,),),
    );
  }
}