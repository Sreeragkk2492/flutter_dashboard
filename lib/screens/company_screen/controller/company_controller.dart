import 'dart:convert';

import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/models/company_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class CompanyController extends GetxController{
   var companydetails = <Company>[].obs;
 @override
  void onInit() {
 
    fetchCompanyDetails();
   
    super.onInit();
  }

    fetchCompanyDetails() async {
    try {
      // Making the GET request to the API
      var response =
          await http.get(Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY));
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        companydetails.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return Company.fromJson(jsonItem);
          } else {
            throw Exception("Unexpected data format");
          }
        }).toList();
      }
    } catch (e) {
      print("Error$e");
    }
  }
}