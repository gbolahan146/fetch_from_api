    import 'package:flutter/material.dart';
    import 'dart:async';
    import 'package:http/http.dart' as http;
import 'dart:convert';
    void main() => runApp(new MyApp());

    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return new MaterialApp(
          
          title: 'Contacts', 
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: new MyHomePage(title: 'Contact List of Bad guys',),
        );
      }
    }

    class MyHomePage extends StatefulWidget {
      MyHomePage({Key key, this.title}) : super(key: key);
      final String title;

      @override
      _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<User>> _getUsers() async {
    var data = await http.get("https://jsonplaceholder.typicode.com/users");

    var jsonData = json.decode(data.body);

    List<User> users = [];
    for(var u in jsonData){
      User user = User( u["name"], u["email"], u["username"], u["phone"]);

      users.add(user);
      
    }
    print(users.length);

    return users;
  }
  
  @override
  Widget build(BuildContext context){
    

    // final icons = [Icons.directions_bike, Icons.directions_boat,
    //   Icons.directions_bus, Icons.directions_car, Icons.directions_railway,
    //   Icons.directions_run, Icons.directions_subway, Icons.directions_transit,
    //   Icons.directions_walk, Icons.person] ;
    

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
    ), body: Container(
      child: FutureBuilder(
        future: _getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot ){

          if (snapshot.data == null){
            return Container(child: Center(child: Text("Loading...")
            )
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int id){
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 35.0,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.cyanAccent,
                    child: Text(snapshot.data[id].name[0].toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                  ),
                           title: Text(snapshot.data[id].name),
                trailing: Icon(Icons.keyboard_arrow_right),
                subtitle: Text(snapshot.data[id].email),
                onTap: (){

                  Navigator.push(context,
                   new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[id]))
                   );
             
                 } ),
              );

            },
          );
        },
      ),

    ),
    );
  }

}

class DetailPage extends StatelessWidget{
 TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final User user;
  

  DetailPage(this.user);
  @override
  Widget build(BuildContext context){
    
      return Scaffold(
        appBar: AppBar(title: Text(user.name),
        ),
          body: 
          Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(23.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.contact_phone, size: 50,),
                    SizedBox(height: 45.0),
                    
                    Center(child: CircleAvatar(
                    radius: 60.0,
                    
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.cyanAccent,
                    child: Text(user.name[0].toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50.0),),
                  )
                  ,),
                    
                  SizedBox(height: 25.0),
                  Divider(
              color: Colors.black
            ),
                    Text('Name: '+user.name, style: style,),
                    SizedBox(height: 25.0),
                    Divider(
              color: Colors.black
            ),
                    Text('Username: '+ user.username, style: style,),
                    SizedBox(height: 25.0),
                    Divider(
              color: Colors.black
            ),
                    Text('Email: '+ user.email, style: style,),
                    SizedBox(height: 25.0),
                    Divider(
              color: Colors.black
            ),
                    Text('Phone Number: '+ user.phone, style: style,),
                    SizedBox(height: 25.0),
                    
                    
                    
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

class User{
  
  final String name;
  final String email;
  final String username;
  final String phone;
  

  User(this.name, this.email, this.username, this.phone);
  
}