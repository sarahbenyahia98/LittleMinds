import 'package:flutter/material.dart';
import 'package:project_v1/models/pdf_model.dart';
import 'package:project_v1/screens/pdf_read_screen.dart';
import 'package:project_v1/utils/app_consts.dart';

class PdfCardWidget extends StatelessWidget {
  const PdfCardWidget({super.key, required this.pdfModel});
  final PdfModel pdfModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context,  
          MaterialPageRoute(builder: (context) => PdfViewerPage(pdfModel: pdfModel)
        ));
      },
      child: Container(
          padding: EdgeInsets.all(10),
          width: AppConsts.getWidth(context),
          margin: EdgeInsets.symmetric(horizontal: AppConsts.getWidth(context)*0.05),
          decoration: BoxDecoration(
            border: Border.all(),
              color: Colors.white38, borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: [
              SizedBox(height: 10,),
              CircleAvatar(
                  radius: AppConsts.getWidth(context) * 0.12,
                  backgroundColor: Colors.redAccent.withOpacity(0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      child: Icon(Icons.picture_as_pdf),
                      radius: AppConsts.getWidth(context) * 0.1,
                      backgroundColor: Colors.redAccent.withOpacity(0.4),
                    ),
                  )),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(pdfModel.pdfName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),)),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(pdfModel.userName,style: TextStyle(color: Colors.black,),overflow: TextOverflow.ellipsis,)),
                  Row(
                   
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(pdfModel.createdAt,style: TextStyle(color: Colors.black,),overflow: TextOverflow.ellipsis,)),
                        Spacer(),
                      Icon(Icons.remove_red_eye,size: 25,),
                      SizedBox(width: 20,)
                      
                    ],
                  ),
      
            ],
          )),
    );
  }
}
