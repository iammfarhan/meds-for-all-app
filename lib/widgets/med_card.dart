/*import 'package:flutter/material.dart';
import 'package:medicine_donation_app/pages/view_meds_details.dart';

Widget MedCard (context, index, controller) {
  return (Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Color(0xFFF5F5F5),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.blue.shade100,
            child: Image.network(
              storedocs[index]['waist'].toString(),
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, -0.15),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        '${index.company_name}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF151B1E),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.1, -0.05),
                        child: Text(
                          index.rating.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Text(
              index.description.length > 80
                  ? "${index.description.substring(0, 80)}..."
                  : '${index.description}',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 13),
            ),
          ),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ViewMedDetails(
                                        /*indexxxx*/)));
                      },
                      child:
                          Text("View Details", style: TextStyle(fontSize: 12)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.blue)))))
                ],
              ))
        ],
      )));
}
*/