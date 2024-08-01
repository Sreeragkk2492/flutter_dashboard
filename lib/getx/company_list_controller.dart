import 'package:flutter_dashboard/models/company_model.dart';
import 'package:get/get.dart';

class CompanyListController extends GetxController {
  var companies = <CompanyModel>[].obs;
  var filteredCompany = <CompanyModel>[].obs;
  var nameFilter = ''.obs;
  var CompidFilter = ''.obs;
  var CompcodeFilter = ''.obs;
  var mobilenumberFilter = ''.obs;
  var statusFilter = ''.obs;
  var WhatsAppFilter = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() {
    var companyList = [
      CompanyModel(
          name: 'zsername 1', 
          Comp_id: 'name 1',
          Comp_code: 'staff',
          Status: 'id',
          Mobilenumber: '123456789',
          Whatsapp: 'comapny 1'),
      CompanyModel(
          name: 'fsername 1',
          Comp_id: 'name 1',
          Comp_code: 'staff',
          Status: 'id',
          Mobilenumber: '123456789',
          Whatsapp: 'comapny 1'),
      CompanyModel(
          name: 'gsername 1', 
          Comp_id: 'name 1',
          Comp_code: 'staff',
          Status: 'id',
          Mobilenumber: '123456789',
          Whatsapp: 'comapny 1')
      // Add more initial users
    ];
    companies.value = companyList;
    filteredCompany.value = companyList;
  }

  void updateComapny(int index, CompanyModel company) {
    companies[index] = company;
    filtereCompany();
  }

  void filtereCompany() {
    var filtered = companies;

    if (nameFilter.isNotEmpty) {
      filtered = filtered
          .where((company) => company.name.startsWith(nameFilter.value))
          .toList()
          .obs;
    }

    if (CompidFilter.isNotEmpty) {
      filtered = filtered
          .where((company) =>
              company.Comp_id.toString().startsWith(CompidFilter.value))
          .toList()
          .obs;
    }

    if (CompcodeFilter.isNotEmpty) {
      filtered = filtered
          .where(
              (company) => company.Comp_code.startsWith(CompcodeFilter.value))
          .toList()
          .obs;
    }
    if (statusFilter.isNotEmpty) {
      filtered = filtered
          .where((company) => company.Status.startsWith(statusFilter.value))
          .toList()
          .obs;
    }
    if (WhatsAppFilter.isNotEmpty) {
      filtered = filtered
          .where((company) => company.Whatsapp.startsWith(WhatsAppFilter.value))
          .toList()
          .obs;
    }
    if (mobilenumberFilter.isNotEmpty) {
      filtered = filtered
          .where((company) =>
              company.Mobilenumber.startsWith(mobilenumberFilter.value))
          .toList()
          .obs;
    }

    filteredCompany.value = filtered;
  }

  void setNameFilter(String letter) {
    nameFilter.value = letter;
    filtereCompany();
  }

  void setComidFilter(String letter) {
    CompidFilter.value = letter;
    filtereCompany();
  }

  void setCompcodeFilter(String letter) {
    CompcodeFilter.value = letter;
    filtereCompany();
  }
  void setstatusFilter(String letter) {
    statusFilter.value = letter;
    filtereCompany();
  }

  void setwhatsappFilter(String letter) {
  WhatsAppFilter.value = letter;
    filtereCompany();
  }

  void setmobileFilter(String letter) {
    mobilenumberFilter.value = letter; 
    filtereCompany();
  }
}
