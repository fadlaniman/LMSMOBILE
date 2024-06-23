import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile/constants.dart';
import 'package:mobile/controller/attachmentController.dart';
import 'package:mobile/controller/commentsController.dart';
import 'package:mobile/controller/submissionController.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/widgets/navigationDrawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';

class StudentAssignmentPage extends StatefulWidget {
  const StudentAssignmentPage({super.key});

  @override
  State<StudentAssignmentPage> createState() => _StudentAssignmentPageState();
}

class _StudentAssignmentPageState extends State<StudentAssignmentPage> {
  final AttachmentsController attachmentsController = Get.find();
  final submissionsController = Get.put(SubmissionController());
  final commentsController = Get.put(CommentsController());
  final _text = TextEditingController();
  File? _files;
  final _file = TextEditingController();
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10.0),
            child: Container(
              color: const Color.fromARGB(255, 138, 138, 138),
              height: 0.5,
            ),
          ),
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      attachmentsController.attachment.value.classes?.name ??
                          '',
                      style: GoogleFonts.poppins(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                        attachmentsController
                                .attachment.value.classes?.description ??
                            '',
                        style: GoogleFonts.poppins(fontSize: 14.0))
                  ],
                ),
                Container(
                  child:
                      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                )
              ],
            ),
          ),
        ),
        drawer: NavigationDrawerWidget(),
        body: Obx(() {
          return Expanded(
              child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: attachmentsController.attachment.value.type ==
                            'assignment'
                        ? primaryColor
                        : const Color.fromRGBO(251, 192, 45, 1),
                  ))),
                  child: ListTile(
                    leading: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: attachmentsController.attachment.value.type ==
                                  'assignment'
                              ? primaryColor
                              : const Color.fromRGBO(251, 192, 45, 1),
                          shape: BoxShape.circle,
                        ),
                        child: attachmentsController.attachment.value.type ==
                                'assignment'
                            ? Icon(
                                Icons.assignment_outlined,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.book_outlined,
                                color: Colors.white,
                              )),
                    title: Text(
                      attachmentsController.attachment.value.title ?? '',
                      style: GoogleFonts.poppins(
                          color: attachmentsController.attachment.value.type ==
                                  'assignment'
                              ? primaryColor
                              : const Color.fromRGBO(251, 192, 45, 1),
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                        '${attachmentsController.attachment.value.users?.firstName} ${attachmentsController.attachment.value.users?.lastName} - ${DateFormat('d MMMM').format(attachmentsController.attachment.value.createdAt ?? DateTime.now())}',
                        style: GoogleFonts.poppins(fontSize: 12.0)),
                  ),
                ),
                Container(
                  child: ListTile(
                    title: Text(
                        attachmentsController.attachment.value.description ??
                            '',
                        style: GoogleFonts.poppins(fontSize: 14.0)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return path.extension(attachmentsController
                                        .attachment.value.file ??
                                    '') ==
                                '.jpg'
                            ? Dialog(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${Url.baseUrl}/storage/files/${attachmentsController.attachment.value.file ?? ''}',
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              )
                            : Container();
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: path.extension(
                                  attachmentsController.attachment.value.file ??
                                      '') ==
                              '.jpg'
                          ? Container(
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${Url.baseUrl}/storage/files/${attachmentsController.attachment.value.file ?? ''}',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            )
                          : Container(),
                      title: Text(
                        attachmentsController.attachment.value.file.toString(),
                        style: GoogleFonts.poppins(fontSize: 12.0),
                      ),
                    ),
                  ),
                ),
                attachmentsController.attachment.value.type == 'assignment'
                    ? Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Warna latar belakang
                          borderRadius: BorderRadius.circular(
                              8.0), // BorderRadius untuk sudut melengkung
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(
                                  0.3), // Warna shadow dan opasitasnya
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3), // Posisi shadow (x, y)
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Your Work',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            ListTile(
                              title: TextFormField(
                                textAlign: TextAlign.center,
                                readOnly: true,
                                controller: _file,
                                decoration: InputDecoration(
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 12.0,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: _file.text.isEmpty
                                      ? '+ Add or Create'
                                      : _file.text,
                                  border: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  FilePickerResult? picked =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'ppt',
                                      'pdf',
                                      'doc',
                                      'mp4',
                                      'jpg',
                                      'pdf'
                                    ],
                                  );
                                  setState(() {
                                    if (picked != null) {
                                      _files =
                                          File(picked.files.first.path ?? '');
                                      _file.text = picked.files.first.name;
                                    }
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: ElevatedButton(
                                onPressed: () {
                                  submissionsController.send(
                                      attachmentsController
                                              .attachment.value.classes!.id ??
                                          '',
                                      attachmentsController.attachment.value.id
                                          .toString(),
                                      _files!);
                                },
                                child: Text(
                                  'Done',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(double.infinity, 50)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  backgroundColor: _file.text.isNotEmpty
                                      ? MaterialStateProperty.all<Color>(
                                          primaryColor)
                                      : MaterialStateProperty.all<Color>(
                                          Colors.grey.shade200),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.person_outline),
                        title: Text(
                          'Comments',
                          style: GoogleFonts.poppins(fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: commentsController.comments.length,
                      itemBuilder: (context, index) {
                        return commentsController.loading.value
                            ? const CircularProgressIndicator()
                            : ListTile(
                                leading: Icon(
                                  Icons.circle,
                                  size: 25.0,
                                  color: attachmentsController
                                              .attachment.value.type ==
                                          'assignment'
                                      ? primaryColor
                                      : const Color.fromRGBO(251, 192, 45, 1),
                                ),
                                title: Text(
                                  '${commentsController.comments[index].users.firstName} ${commentsController.comments[index].users.lastName}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  commentsController.comments[index].text,
                                  style: GoogleFonts.poppins(fontSize: 12.0),
                                ),
                              );
                      }),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          style: GoogleFonts.poppins(fontSize: 12.0),
                          controller: _text,
                          decoration: InputDecoration(
                            hintText: 'Add Comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          maxLines: null,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send_rounded),
                        onPressed: () {
                          commentsController.send(
                              attachmentsController.attachment.value.classId ??
                                  '',
                              attachmentsController.attachment.value.id ?? 0,
                              _text.text.trim());
                        },
                        color: Colors.grey,
                        iconSize: 32.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
        }));
  }
}
