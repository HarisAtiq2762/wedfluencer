import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';

import '../../../models/blob_storage_account.dart';
import '../../../presentation/ui/config/globals.dart';
import '../../network_service_layer/api_handler.dart';

String serverUrl = serverUrlGlobal;

class FileUploadProvider {
  final APIService _apiServices = APIService(baseUrl: serverUrl);

  Future<Map<String, String>> getBlobStorageAccountsAndUrl(
      {required String filename,
      required String containerName,
      required String fileType}) async {
    try {
      final accounts = <BlobStorageAccount>[];
      final latencies = <String, double>{};
      final response = await _apiServices.apiCall(
        urlExt: 'admin/blobs',
        type: RequestType.get,
      );
      response.data.forEach((blob) {
        accounts.add(BlobStorageAccount.fromJson(blob));
      });

      for (BlobStorageAccount account in accounts) {
        latencies.addAll(
            await getLatency(url: account.url, accountName: account.account));
      }
      String smallestKey = '';
      double smallestValue = double.infinity;

      latencies.forEach((key, value) {
        if (value < smallestValue) {
          smallestValue = value;
          smallestKey = key;
        }
      });

      final token = await getSasTokenForStorage(
          accountName: smallestKey,
          container: containerName,
          fileType: fileType);
      final finalUrl =
          'https://$smallestKey.blob.core.windows.net/$containerName/$filename?$token';
      return {'url': finalUrl, 'accountName': smallestKey};
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<Map<String, double>> getLatency(
      {required String url, required String accountName}) async {
    try {
      final startTime = DateTime.now().millisecondsSinceEpoch;
      await _apiServices.apiCall(
        urlExt: url,
        useBaseUrl: false,
        type: RequestType.get,
        queryParameters: {
          'Referer':
              'https://wed-dev.ashymushroom-d0330ebd.eastus2.azurecontainerapps.io/'
        },
      );
      final endTime = DateTime.now().millisecondsSinceEpoch;
      final latency = (endTime - startTime).toDouble();
      return {accountName: latency};
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<String> getSasTokenForStorage(
      {required String accountName,
      required String container,
      required String fileType}) async {
    try {
      final ipAddress = await NetworkInfo().getWifiIP();
      final response = await _apiServices
          .apiCall(urlExt: 'storage/sas', type: RequestType.post, body: {
        "container": container,
        "account": accountName,
        "ipAddress": ipAddress,
        "fileType": fileType
      });

      return response.data['sasToken'];
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<Map<String, String>> uploadFileToBlob(
      {required File file,
      required String containerName,
      required bool isVideo}) async {
    try {
      final result = await getBlobStorageAccountsAndUrl(
        filename: file.path.split('/').last,
        containerName: containerName,
        fileType: isVideo ? "video/mp4" : "image/png",
      );
      final headers = {
        'x-ms-blob-type': 'BlockBlob',
        'Content-Type': 'application/octet-stream'
      };
      final videoAsBytes = await file.readAsBytes();
      final response = await http.put(
        headers: headers,
        Uri.parse(result['url']!),
        body: videoAsBytes,
      );

      if (response.statusCode == 201) {
        return {
          'azureAccountName': result['accountName']!,
          'url': result['url']!,
          'requestId': response.headers['x-ms-request-id']!,
        };
      }
      return {};
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
