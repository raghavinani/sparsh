import 'package:dio/dio.dart';

import '../services/dio_client.dart';

class Tokenapi {
     static const String baseUrl = 'https://qa.birlawhite.com:55232';
  final dioClient = DioClient();

    //After token/QR Scan get the Tokennumber then call for the details
Future<String?> getTokenDetails(String tokenid) async{
  final body= {"tokenNum" : "5GLAU2LBWC09"};  // would be $tokenid

  try {
      final response = await dioClient.dio.post(
        '$baseUrl/api/TokenScan/scan',
        data: body,
        options: Options(headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },),
      );

      if(response.statusCode == 200)
     { // Log response data
      print('Received response from API:');
      print(response.data);

      return response.data;
      }
      else{
        throw Exception('Token Details not found');
      }
}catch(e)
{
  print("Error in fetchind the tokendetail $e");
  throw Exception('Token Details EROR IN FETCHING');
}
}
  }