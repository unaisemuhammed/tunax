// import 'dart:io';
// import 'package:musicplayer/colors.dart' as AppColors;
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
//
// class InnerFolder extends StatefulWidget {
//   InnerFolder({required this.filesPath});
//
//   final String filesPath;
//
//   @override
//   State<StatefulWidget> createState() {
//     return InnerFolderState();
//   }
// }
//
// class InnerFolderState extends State<InnerFolder> {
//   String get fileStr => widget.filesPath;
//
//   Future<String> createFolderInAppDocDir(String folderName) async {
//     //Get this App Document Directory
//
//     final Directory _appDocDir = await getApplicationDocumentsDirectory();
//     //App Document Directory + folder name
//     final Directory _appDocDirFolder =
//         Directory('${_appDocDir.path}/$folderName/');
//
//     if (await _appDocDirFolder.exists()) {
//       //if folder already exists return path
//       return _appDocDirFolder.path;
//     } else {
//       //if folder not exists create folder and then return its path
//       final Directory _appDocDirNewFolder =
//           await _appDocDirFolder.create(recursive: true);
//       return _appDocDirNewFolder.path;
//     }
//   }
//
//   callFolderCreationMethod(String folderInAppDocDir) async {
//     // ignore: unused_local_variable
//     String actualFileName = await createFolderInAppDocDir(folderInAppDocDir);
//     print(actualFileName);
//     setState(() {});
//   }
//
//   final folderController = TextEditingController();
//   late String nameOfFolder;
//
//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Column(
//             children: [
//               Text(
//                 'ADD FOLDER',
//                 textAlign: TextAlign.left,
//               ),
//               Text(
//                 'Type a folder name to add',
//                 style: TextStyle(
//                   fontSize: 14,
//                 ),
//               )
//             ],
//           ),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return TextField(
//                 controller: folderController,
//                 autofocus: true,
//                 decoration: InputDecoration(hintText: 'Enter folder name'),
//                 onChanged: (val) {
//                   setState(() {
//                     nameOfFolder = folderController.text;
//                     print(nameOfFolder);
//                   });
//                 },
//               );
//             },
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text(
//                 'Add',
//                 style: TextStyle(color: Colors.white),
//               ),
//               onPressed: () async {
//                 if (nameOfFolder != '') {
//                   await callFolderCreationMethod(nameOfFolder);
//                   getDir();
//                   setState(() {
//                     folderController.clear();
//                     nameOfFolder = '';
//                   });
//                   Navigator.of(context).pop();
//                 }
//               },
//             ),
//             TextButton(
//               child: Text(
//                 'No',
//                 style: TextStyle(color: Colors.white),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   late List<FileSystemEntity> _folders;
//
//   Future<void> getDir() async {
//     /* final directory = await getApplicationDocumentsDirectory();
//     final dir = directory.path;
//     String pdfDirectory = '$dir/';
//     final myDir = new Directory(pdfDirectory);*/
//
//     final myDir = new Directory(fileStr);
//
//     setState(() {
//       _folders = myDir.listSync(recursive: true, followLinks: false);
//     });
//     print(_folders);
//   }
//
//   Future<void> _showDeleteDialog(int index) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Are you sure to delete this folder?',
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Yes'),
//               onPressed: () async {
//                 await _folders[index].delete();
//                 getDir();
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('No'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     _folders = [];
//     getDir();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double Heights = MediaQuery.of(context).size.height;
//     final double Weights = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: AppColors.shade,
//       appBar: AppBar(
//         leadingWidth: 30,
//         leading: IconButton(
//           padding: EdgeInsets.only(left: 20, top: 16),
//           color: Colors.white,
//           alignment: Alignment.topLeft,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios),
//         ),
//         title: Text(
//           'Add to',
//           style:
//               TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Titil'),
//         ),
//         backgroundColor: AppColors.back,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           ListView(
//             scrollDirection: Axis.vertical,
//             children: [
//               Container(
//                 padding: EdgeInsets.only(top: 50),
//                 child: Column(
//                   children: [
//                     ListTile(
//                       leading: Icon(
//                         Icons.add_outlined,
//                         color: Colors.grey,
//                         size: 35,
//                       ),
//                       title: Text(
//                         "Create playlist",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontFamily: 'Titil'),
//                       ),
//                     ),
//                     Divider(
//                       height: 10,
//                       color: Colors.grey,
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.favorite_border,
//                         color: Colors.grey,
//                         size: 35,
//                       ),
//                       title: Text(
//                         "favourites tracks",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontFamily: 'Titil'),
//                       ),
//                       onTap: () {
//                         setState(() {});
//                       },
//                     ),
//                   ],
//                 ),
//                 width: Weights,
//                 decoration: BoxDecoration(color: AppColors.shade),
//               ),
//             ],
//           ),
//
//           /// shadedHolllow///
//           Positioned(
//             top: Heights / 2000,
//             right: 0,
//             left: 0,
//             height: Heights / 12,
//             child: Container(
//               child: ColorFiltered(
//                 colorFilter: ColorFilter.mode(AppColors.back, BlendMode.srcOut),
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           color: AppColors.shade,
//                           backgroundBlendMode: BlendMode
//                               .dstOut), // This one will handle background + difference out
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(top: 40),
//                       height: Heights,
//                       width: Weights,
//                       decoration: BoxDecoration(
//                         color: AppColors.shade,
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(30),
//                           topLeft: Radius.circular(30),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future getFileType(file) {
//     return file.stat();
//   }
// }
