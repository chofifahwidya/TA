import '../auth/auth_util.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../sign_in_page/sign_in_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String uploadedFileUrl = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Image.network(
                    valueOrDefault<String>(
                      uploadedFileUrl,
                      'Cg5JbWFnZV92ZGNiM3pwNRgHIu8HMkAKImh0dHBzOi8vcGljc3VtLnBob3Rvcy9zZWVkLzc3OS82MDAQARgCIhYKCQkAAAAAAADwfxIJCQAAAAAAAHlAWgkhAAAAAAAAJECaAZsHCAYIASqUBwgHEg9CdXR0b25faXNsNHJrYjAaIwoZChdVUExPQURFRF9NRURJQV9WQVJJQUJMRRADOAM4BDgKMtkGCAQS1AZDaEpEYjI1MFlXbHVaWEpmTmpCMU1teDJaMklTcWdRS0RrbHRZV2RsWDNaa1kySXplbkExR0FjaWt3UXlRQW9pYUhSMGNITTZMeTl3YVdOemRXMHVjR2h2ZEc5ekwzTmxaV1F2TnpjNUx6WXdNQkFCR0FJaUZnb0pDUUFBQUFBQUFQQi9FZ2tKQUFBQUFBQUFlVUJhQ1NFQUFBQUFBQUFrUUpvQnZ3TUlCZ2dCS3JnRENBY1NEMEoxZEhSdmJsOXBjMncwY210aU1Cb2pDaGtLRjFWUVRFOUJSRVZFWDAxRlJFbEJYMVpCVWtsQlFreEZFQU00QXpnRU9Bb3kvUUlJQkJMNEFrTm9Ta1JpTWpVd1dWZHNkVnBZU21aT2FrSXhUVzE0TWxveVNWTXdRVVZMUkd0c2RGbFhaR3hZTTFwcldUSkplbVZ1UVRGSFFXTnBkVkZGZVZGQmIybGhTRkl3WTBoTk5reDVPWGRoVjA1NlpGY3dkV05IYUhaa1J6bDZURE5PYkZwWFVYWk9lbU0xVEhwWmQwMUNRVUpIUVVscFJtZHZTa05SUVVGQlFVRkJRVkJDTDBWbmEwcEJRVUZCUVVGQlFXVlZRbUZEVTBWQlFVRkJRVUZCUVd0UlNtOUNXbWRuUjBOQlJYRlpRV2RJUldjNVEyUllVakJpTWpWbVlWaE9jMDVJU25KWmFrRmhTWGR2V2tOb1pGWlZSWGhRVVZWU1JsSkdPVTVTVlZKS1VWWTVWMUZXU2twUlZVcE5VbEpCUkU5QlRUUkNSR2RMVFdsWlNVSkNTV2xoU0ZJd1kwaE5Oa3g1T1hkaFYwNTZaRmN3ZFdOSGFIWmtSemw2VEROT2JGcFhVWFpPZW1NMVRIcFpkMDFRYjBSQlIwbEJSMEZGYVV4UmIyOURhRmxMUTFGclFVRkJRVUZCUVVKYVVVSkpTa05SUVVGQlFVRkJRVVpzUVVWbmVFTkNaMnAxTTJKMkwwUXhiMEZaWjBGcFFWQnZSRUZIU1VINkF3QmlBQmdCSWpnS0tBb1dDZ2tKQUFBQUFBQUE4SDhTQ1FrQUFBQUFBQUI1UUJJTVFnWUk3dDI3L3c5YUFHSUFJZ0JhQ1NFQUFBQUFBQUFrUVBvREFHSUH6AwBiAA==',
                    ),
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 100),
                  child: FFButtonWidget(
                    onPressed: () async {
                      final selectedMedia =
                          await selectMediaWithSourceBottomSheet(
                        context: context,
                        allowPhoto: true,
                        backgroundColor:
                            FlutterFlowTheme.of(context).primaryColor,
                        textColor: FlutterFlowTheme.of(context).tertiaryColor,
                      );
                      if (selectedMedia != null &&
                          validateFileFormat(
                              selectedMedia.storagePath, context)) {
                        showUploadMessage(
                          context,
                          'Uploading file...',
                          showLoading: true,
                        );
                        final downloadUrl = await uploadData(
                            selectedMedia.storagePath, selectedMedia.bytes);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        if (downloadUrl != null) {
                          setState(() => uploadedFileUrl = downloadUrl);
                          showUploadMessage(
                            context,
                            'Success!',
                          );
                        } else {
                          showUploadMessage(
                            context,
                            'Failed to upload media',
                          );
                          return;
                        }
                      }
                    },
                    text: 'Take Picture',
                    icon: Icon(
                      Icons.add_circle,
                      size: 15,
                    ),
                    options: FFButtonOptions(
                      width: 200,
                      height: 40,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    await signOut();
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPageWidget(),
                      ),
                      (r) => false,
                    );
                  },
                  text: 'Log Out',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
