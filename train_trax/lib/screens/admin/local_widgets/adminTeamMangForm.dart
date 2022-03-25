import 'package:flutter/material.dart';


class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);
  

  @override
  State<DropDown> createState() => _MyDropDown();
}

class _MyDropDown extends State<DropDown> {
  List<String> listOfTeams = ['Team 1', 'Team 2', 'Team 3', 'Team 4'];
  late String dropdownValue= listOfTeams.elementAt(0);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: listOfTeams
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
