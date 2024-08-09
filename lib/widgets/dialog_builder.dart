
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:k24/widgets/labels.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';

import '../helpers/storage.dart';
import '../pages/more_provider.dart';

final labels = Labels();

/// loading dialog ///
Future<void> dialogBuilder(BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          // onTap: () => Navigator.of(context).pop(),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8)),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const CircularProgressIndicator(strokeWidth: 3),
                  ),
                ],
              ),
            ),
          ),
        );
      }
  );
}

void showActionSheet(BuildContext context, List<MoreTypeInfo> listMore) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        for (final type in listMore) CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            type.onTap!();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(type.icon != null) ...[
                Icon(type.icon, size: 18, color: Colors.blue.shade700,),
                const SizedBox(width: 8,),
              ],
              labels.label(type.description, color: Colors.blue.shade700, fontSize: 16, fontWeight: FontWeight.w500),
            ],
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        isDestructiveAction: true,
        child: labels.label('Cancel', color: Colors.red, fontSize: 18,),
      ),
    ),
  );
}


Future<void> viewImage(BuildContext context, String image) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8)),
            child: GestureDetector(
              onTap: () {},
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: PhotoView(
                      imageProvider: NetworkImage(image),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      padding: const EdgeInsets.all(14.0),
                      icon: const Icon(Icons.arrow_back, color: Colors.white,),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () async {
                        final imageUrl = image;
                        try {
                          dialogBuilder(context);
                          await downloadAndSaveImage(imageUrl);
                          // print(file.path);
                          // close //
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Image\'s downloaded successfully.', maxLines: 1, overflow: TextOverflow.ellipsis,),
                            ),
                          );
                        } catch (e) {
                          // Handle error
                          print('Error: $e');
                        }
                        Navigator.of(context).pop();
                      },
                      padding: const EdgeInsets.all(14.0),
                      icon: const Row(
                        children: [
                          Icon(Icons.cloud_download_outlined, color: Colors.white,),
                          SizedBox(width: 10,),
                          Text('Save', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
  );
}


void showActionSheet2(BuildContext context, List<MoreTypeInfo> listMore, {
    String? title,
  }) {
  showBarModalBottomSheet(context: context,
    builder: (context) => Material(
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(title != null) ListTile(
                title: labels.label(title, color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500, textAlign: TextAlign.center),
                shape: const Border(bottom: BorderSide(color: Colors.black12)),
                tileColor: Colors.black12,
              ),

              for (final type in listMore) ListTile(
                onTap: () {
                  Navigator.pop(context);
                  type.onTap!();
                },
                leading: (type.icon != null) ? Icon(type.icon, size: 22, color: Colors.black87,) : null,
                title: labels.label(type.name, color: Colors.black87, fontSize: 16),
                shape: const Border(bottom: BorderSide(color: Colors.black12)),
                subtitle: (type.description.isNotEmpty) ? labels.label(type.description, color: Colors.black87, fontSize: 13) : null,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

