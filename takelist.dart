import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class takelist extends StatefulWidget {
  const takelist({Key? key}) : super(key: key);



  @override
  State<takelist> createState() => _takelistState();

}

class _takelistState extends State<takelist> {
  final List<String> items = ['처방기록', '최근기록', '복용기록'];
  final TextEditingController txtPlace = TextEditingController();
  String? selecteditems;
  get url => 'https://google.com';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: DropdownButton(
            underline: SizedBox.shrink(),
            hint: Text('복용기록'
              , style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
              ),
            ),
            items: items.map(
                  (String item) => DropdownMenuItem(
                child: Text(item,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0
                  ),
                ),
                value : item,
              ),
            ).toList(),
            onChanged: (String? value) => setState(() {
              this.selecteditems = value;
              if (value == '복용기록') {
                print('현재 위치함');
              } else if (value == '최근기록') {
                Navigator.pushNamed(context, '/recently');
              } else if (value == '처방기록') {
                Navigator.pushNamed(context, '/pslist');
              }
            }),
            value: selecteditems,
          ),


          centerTitle: true,
          elevation: 0.0,
          actions: [
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 0.0,

                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/home',(route)=>false);
                },
                child: const Icon(Icons.home,size:30.0,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
            children: <Widget>[
              Text('  메뉴', style: TextStyle(
                fontSize: 30.0,
              ),
              ),
              Container(
                  width: 1,
                  child: Divider(color: Colors.black, thickness: 2.0)
              ),

              ListTile(
                title: Text('처방약'),
                onTap: () {
                  Navigator.pushNamed(context, '/prescription');
                },
              ),
              ListTile(
                title: Text('알약'),
                onTap: () {
                  Navigator.pushNamed(context, '/pill');
                },
              ),
              ListTile(
                title: Text('처방기록'),
                onTap: () {
                  Navigator.pushNamed(context, '/pslist');
                },
              ),
              ListTile(
                title: Text('복용기록'),
                onTap: () {
                  Navigator.pushNamed(context, '/takelist');
                },
              ),
              ListTile(
                title: Text('설정'),
                onTap: () {
                  Navigator.pushNamed(context, '/alarm');
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 40.0,20.0, 20.0),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.calendar_month, size: 40.0,),
                    SizedBox(
                      width: 200.0,
                    ),
                    Expanded(child: Container(
                      width: double.infinity,
                      child: TextField(
                        controller: txtPlace,
                        decoration: InputDecoration(
                          hintText: '',
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: (){
                                print('text');
                              }
                          ),
                        ),
                      ),
                    ),)
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Expanded(child: Container(

                height:500,
                child:  ListView(
                  children: [
                    Text("2023-11-01 16:57 감기약 복용",style: TextStyle(fontSize: 20.0,),),
                    Text("2023-11-01 16:57 타이레놀 복용",style: TextStyle(fontSize: 20.0,),),
                    Text("2023-11-01 16:57 감기약 복용",style: TextStyle(fontSize: 20.0,),),

                  ],
                ),
              ),),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        )
    );



  }
}