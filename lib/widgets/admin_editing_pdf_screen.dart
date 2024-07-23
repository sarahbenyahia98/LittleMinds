import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_v1/controller/firebase_controller.dart';
import 'package:project_v1/models/pdf_model.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/widgets/input_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminEditingPdfScreen extends StatefulWidget {
  const AdminEditingPdfScreen({
    super.key,
  });

  @override
  State<AdminEditingPdfScreen> createState() => _AdminEditingPdfScreenState();
}

class _AdminEditingPdfScreenState extends State<AdminEditingPdfScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String path) async {
    if (!await launchUrl(Uri.parse(path))) {
      throw Exception('Could not launch $path');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: AppConsts.getWidth(context),
          child: FutureBuilder<List<PdfModel>?>(
            future: FirebaseController().getAllPdfs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(l10n.no_pdf_added),
                        Text(l10n.click_add_pdf),
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: snapshot.data!.map((element) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          onTap: () {},
                          title: Text(
                            "${l10n.pdf_name}${element.pdfName}",
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${l10n.created_by}${element.userName}"),
                              Text(
                                  "${l10n.created_at}${element.createdAt.split("T")[0]}"),
                            ],
                          ),
                          trailing: SizedBox(
                            width: AppConsts.getWidth(context) * 0.3,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.download,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    _launchUrl(element.pdfUrl);
                                  },
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    FirebaseController().deletePdf(
                                      element.pdfName,
                                      element.userName,
                                      element.createdAt,
                                    );
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.tale,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  l10n.add_pdf,
                  style: TextStyle(fontSize: 16),
                ),
                content: Container(
                  margin: EdgeInsets.all(10),
                  height: AppConsts.getHeight(context) * 0.3,
                  width: AppConsts.getWidth(context) * 0.8,
                  child: Column(
                    children: [
                      Spacer(),
                      InputWidget(
                        controller: controller,
                        name: l10n.pdf_name,
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                      ),
                      Spacer(),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: AppConsts.getWidth(context) * 0.8,
                          padding: EdgeInsets.all(5),
                          height: AppConsts.getHeight(context) * 0.04,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                l10n.upload_pdf,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.tale,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onTap: () {
                          if (controller.text.isNotEmpty) {
                            Navigator.pop(context);
                            uploadAndSavePDF(pdf: controller.text);
                          }
                        },
                      ),
                      Spacer(flex: 2),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<String?> pickPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      return file.path; // Return the path of the selected file
    }
    return null; // User canceled the file picker
  }

  Future<void> uploadAndSavePDF({required String pdf}) async {
    String? filePath =
        await pickPDFFile(); // Assuming you have a function to pick a PDF file path
    if (filePath != null) {
      // Replace with actual user ID logic
      String downloadUrl = await FirebaseController()
          .uploadPDFFileAndSaveToFirestore(filePath, pdf: pdf);
      if (downloadUrl.isNotEmpty) {
        setState(() {});
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.done,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.something_wrong,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.user_canceled_file_selection,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.yellowAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
