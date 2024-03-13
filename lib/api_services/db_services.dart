import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class DBServices {
  static const apiUrl = "https://api.multiavatar.com/";
  static Future<Uint8List?> fetchCustomAvatar({ String name = "Default User"})async{
    try {

      http.Response response = await http.get(Uri.parse("$apiUrl$name.png?apikey=your-api-key"));
    log('Response: ${response.body}');
      if(response.statusCode == 200){
        List<int> bytes = response.body.codeUnits;
        log("Response Status code: ${response.statusCode}");
        return Uint8List.fromList(bytes);
    }
    } catch (e) {
      if (e is HttpException) {
        // Handle specific HTTP exceptions
        log('HTTP Exception: $e');
      } else {
        // Handle other types of exceptions
        log('Other Exception: $e');
      }

    }
    return null;

  }
}