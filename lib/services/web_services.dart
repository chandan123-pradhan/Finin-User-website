import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:naukri_user/models/base_response.dart';
import 'package:http/http.dart' as http;
import 'package:naukri_user/services/api_state.dart';
import 'package:naukri_user/services/web_services_params.dart';
import 'package:naukri_user/utils/logger.dart';

class WebServices {
  // Logger setup with a PrettyPrinter for better readability
  var logger = Logger(
    printer: PrettyPrinter(
      noBoxingByDefault: true,
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      dateTimeFormat:
          DateTimeFormat.onlyTimeAndSinceStart, // Time-based log output
    ),
  );

  // Method to perform a GET request
  Future<BaseResponse> getMethod({
    required String url,
    String authToken = '',
  }) async {
    http.Response response;

    // Set up the headers with optional Authorization if provided
    var headers = <String, String>{};
    if (authToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
    }

    // Log request details
    if (authToken.isNotEmpty) {
      LoggerMsg.showInfoLog(
          msg: '🔵 Calling GET Method - URL: $url, Headers: $headers');
    } else {
      LoggerMsg.showInfoLog(
          msg: '🔵 Calling GET Method - URL: $url, No Authorization Token');
    }

    try {
      // Make the GET request
      response = await http.get(
        Uri.parse(url),
        headers: headers.isNotEmpty ? headers : null,
      );

      // Handle API response
      return _handleApiResponse(
        statusCode: response.statusCode,
        responseBody: json.decode(response.body), url: url);
    } catch (e) {
      // Catch any exceptions during the request
      LoggerMsg.showErrorLog(
          msg: '❌ Error during GET request to $url \nerror: $e');
      return BaseResponse(
        status: RequestState.failed,
        message: 'An error occurred while making the request.',
        responseBody: {},
      );
    }
  }

 


Future<BaseResponse> postMethod({
  required String url,
  required Map<String, dynamic> body,
  String authToken = '',
  File? file,  // Optional parameter for a single file
  String? fileFieldName, // Field name for the file in the form data
}) async {
  // Set up headers for JSON and multipart form-data
  var headers = <String, String>{
    'Content-Type': 'application/json', // Default header, will be overridden if a file is provided
  };

  if (authToken.isNotEmpty) {
    headers['Authorization'] = 'Bearer $authToken';
  }

  // Log request details
  if (authToken.isNotEmpty) {
    LoggerMsg.showInfoLog(
        msg:
            '🟢 Calling POST Method - URL: $url, Headers: $headers, Body: $body');
  } else {
    LoggerMsg.showInfoLog(
        msg:
            '🟢 Calling POST Method - URL: $url, No Authorization Token, Body: $body');
  }

  try {
    // If a file is provided, use multipart request
    if (file != null) {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add fields from the body (JSON data)
      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Add the file to the multipart request (single file)
      
        request.files.add(await http.MultipartFile.fromPath(
          WebServicesParams.profileImage
          , file.path));
      

      // Add authorization token if it's provided
      if (authToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $authToken';
      }

      // Log the request with multipart data
      LoggerMsg.showInfoLog(
        msg: '🟢 Calling Multipart POST Method - URL: $url, Headers: $headers, Body: $body, File: $file',
      );

      // Send the request and get the response
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
   
      // Handle the API response
      return _handleApiResponse(
        statusCode: response.statusCode,
        responseBody: json.decode(responseBody), url: url);
    } else {
      // Regular POST request (JSON data only)
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body), // Encoding the body as JSON
      );

      // Handle API response
      return _handleApiResponse(
        statusCode: response.statusCode,
        responseBody: json.decode(response.body), url: url);
    }
  } catch (e) {
    // Catch any exceptions during the request
    LoggerMsg.showErrorLog(
        msg: '❌ Error during POST request to $url \n error: $e');
    return BaseResponse(
      status: RequestState.failed,
      message: 'An error occurred while making the request.',
      responseBody: {},
    );
  }
}

  // Handle the API response and map it to the BaseResponse
  BaseResponse _handleApiResponse({
    required int statusCode,
    required Map<String,dynamic> responseBody,
    required String url,
  }) {
    try {
      // Decode the response body only if the status code is valid
    

      // Handle different HTTP status codes
      switch (statusCode) {
        case 200:
        case 201:
          // Success Response
          LoggerMsg.showSuccessLog(
              msg: '✅ Success response from $url, Response: $responseBody');
          return BaseResponse(
            status: RequestState.success,
            message: 'Operation successfully done.',
            responseBody: responseBody,
          );
        case 400:
          // Bad Request
          LoggerMsg.showErrorLog(
              msg: '❌ Bad Request to $url, Response: $responseBody');
          return BaseResponse(
            status: RequestState.badRequest,
            message: 'Bad request. Please check your input data.',
            responseBody: responseBody,
          );
        case 401:
          // Unauthorized (Authentication failure)
          LoggerMsg.showErrorLog(
              msg: '❌ Unauthorized access to $url, Response: $responseBody');
          return BaseResponse(
            status: RequestState.unautherized,
            message: 'Unauthorized. Please login to continue.',
            responseBody: responseBody,
          );
        case 404:
          // Not Found (API endpoint or resource does not exist)
          LoggerMsg.showErrorLog(
              msg: '❌ API not found at $url, Response: $responseBody');
          return BaseResponse(
            status: RequestState.notFound,
            message: 'API not found. Please check the endpoint.',
            responseBody: {},
          );
        default:
          // Other failure scenarios
          LoggerMsg.showErrorLog(
              msg:
                  '❌ Unexpected error with status code ${statusCode} from $url, Response: $responseBody');
          return BaseResponse(
            status: RequestState.failed,
            message: 'Unexpected error. Please try again later.',
            responseBody: responseBody,
          );
      }
    } catch (e) {
      // Handle JSON parsing errors or other unexpected issues
      LoggerMsg.showErrorLog(
          msg: '❌ Error parsing response from $url \n error: $e');
      return BaseResponse(
        status: RequestState.failed,
        message: 'Error parsing response. Invalid JSON format.',
        responseBody: {},
      );
    }
  }
}
