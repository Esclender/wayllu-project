import 'package:flutter/material.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class TopAppVar extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
        color: topNavBar,
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, 
            size: 30,
            color: Colors.black,
            ),
          ),
          Padding(padding: EdgeInsets.only(left:60),
          child: Text(
            "Registrar Venta",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              fontFamily: 'Gotham',
              foreground: Paint()..shader = LinearGradient(
                begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [btnprimary, btnsecondary])
      .createShader(Rect.fromLTRB(0.0, 0.0, 100.0, 60.0)),),
            ),
          ),
        ],
        ),
    );
  }
}
