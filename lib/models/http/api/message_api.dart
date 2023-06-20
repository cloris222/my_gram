
import 'package:dio/dio.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/models/http/http_manager.dart';
import 'package:base_project/models/http/http_setting.dart';

import '../data/api_response.dart';

class MessageApi extends HttpManager{
  MessageApi({super.onConnectFail, super.baseUrl = HttpSetting.chatUrl});


  Future<ApiResponse> getFilePrefix(){
    return get('/file/prefix');
  }

  Future<ApiResponse> uploadFile(String fileType,String filePath) async {
    var formData = FormData();
    formData.fields.add(MapEntry('fileType', fileType));
    formData.files.add(MapEntry('file', await MultipartFile.fromFile(filePath)));
    return post('/file/upload/chat',data: formData);
  }


  
}