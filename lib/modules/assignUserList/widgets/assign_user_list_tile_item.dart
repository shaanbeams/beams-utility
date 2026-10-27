import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:google_fonts/google_fonts.dart';

class AssignUserListTile extends StatelessWidget {
  const AssignUserListTile({
    super.key,
    required this.reqNo,
    required this.bildingNo,
    required this.apartmentNo,
    required this.partyName, required this.onPressed,
  });

  final String reqNo,  bildingNo, apartmentNo, partyName;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 100),
      onPressed: (){
        onPressed();
      },
      
     
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(30)),
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: [
            _assignUserListTitleItem(
              headingText: "Req.No : ",
              valueText: reqNo,
            ),
          
            _assignUserListTitleItem(
              headingText: "Building  No : ",
              valueText: bildingNo,
            ),
            _assignUserListTitleItem(
              headingText: "Apartment  No : ",
              valueText: apartmentNo,
            ),
            SizedBox(
              child: Row(
                children: [
                  Text("PartyName : ", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(partyName,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 12,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Row _assignUserListTitleItem({required headingText, required valueText}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(headingText, style: GoogleFonts.poppins(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
      Text(valueText,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 11,
          )),
    ],
  );
}
