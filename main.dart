import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  final List<String> name = <String>['Aby'];
  final List<String> assignmentNumber = <String>['1'];
  final List<String> description = <String>['The overwhelming assignment'];

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController assignmentNumberController = TextEditingController();

  void addItemToList(){
    setState(() {
      name.insert(0,nameController.text);
      description.insert(0, descriptionController.text);
      assignmentNumber.insert(0, assignmentNumberController.text);
      nameController.clear();
      descriptionController.clear();
      assignmentNumberController.clear();
    });
  }

  bool _isCr = true;

  showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed:  () {Navigator.pop(context);},
  );
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );
  Widget launchButton = FlatButton(
    child: Text("Launch"),
    onPressed:  () {},
  );

  Widget sorryButton = FlatButton(
    child: Text("I am SORRY"),
    onPressed:  () {Navigator.pop(context);},
  );

  // set up the AlertDialog
  AlertDialog alert1 = AlertDialog(
    title: Text("Notice"),
    content: Text("You think this is a joke?? Name of assignment cannot be empty!"),
    actions: [
      okButton,
      sorryButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert1;
    },
  );
}

  String _value = '';

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2025)
    );
    if(picked != null) setState(() => _value = _dateFormat.format(picked));
  }

  DateFormat _dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Assignment'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30),
            child: Visibility(
                visible: _isCr,
                child: Column(
                children: <Widget>[
                    Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Subject',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: TextField(
                      controller: assignmentNumberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'AssignmentNumber',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top : 10.0),
                    child: TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description of assignment',
                      ),
                    ),
                  ),
                  Container(
                    child: Text(_value,
                    style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  Container(
                    child: IconButton(
                    icon: new Icon(
                    Icons.date_range,
                    color: Colors.black,
                  ),
                      onPressed: () => _selectDate(),
                    )
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isCr,
            child:FloatingActionButton(
            child: Text('Add'),
            onPressed: () {
              if(nameController.text != ''){addItemToList();}
              else {showAlertDialog(context);}
            },
          ), 
        ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: name.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  //height: 50,
                  margin: EdgeInsets.all(15),
                  //color: description[index]>=10? Colors.blue[400]:
                    //description[index]>3? Colors.blue[100]: Colors.grey,
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        Text('${name[index] } (${assignmentNumber[index]})',
                          style: TextStyle(fontSize: 24),
                        ),
                        Text('${description[index]}',
                          style: TextStyle(fontSize: 18),
                        ),
                          Text('$_value',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  ),
                );
              }
            )
          )
        ]
      )
    );
  }
}