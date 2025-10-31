import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/service/sqlite_services.dart';



class LocalDatabaseProvider extends ChangeNotifier{
  final SqliteService _service;

  LocalDatabaseProvider(this._service);

  String _message = "";
  List<Restaurant>? _restaurantList;
  Restaurant? _restaurant;

  String get message => _message;

  List<Restaurant>? get restaurantList => _restaurantList;

  Restaurant? get restaurant => _restaurant;

  // menambahkan fungsi untuk menyimpan data profil
  Future<void> saveRestaurantValue(Restaurant value) async {
    try {
      final result = await _service.insertItem(value);
      _restaurant = value;

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save your data";
        notifyListeners();
      } else {
        _message = "Your data is saved";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to save your data";
      notifyListeners();
    }
  }

  // menambahkan fungsi untuk memuat keseluruhan data profile
  Future<void> loadAllProfileValue() async {
    try {
      _restaurantList = await _service.getAllItems();
      _message = "All of your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your all data";
      notifyListeners();
    }
  }

  // menambahkan fungsi untuk memuat data profile berdasarkan nilai id-nya
  Future<void> loadProfileValueById(String id) async {
    try {
      _restaurant = await _service.getById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  // menambahkan fungsi untuk memperbarui data profile berdasarkan nilai id-nya
  Future<void> updateProfileValueById(int id, Restaurant value) async {
    try {
      final result = await _service.updateItem(id, value);

      final isEmptyRowUpdated = result == 0;
      if (isEmptyRowUpdated) {
        _message = "Failed to update your data";
        notifyListeners();
      } else {
        _message = "Your data is updated";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to update your data";
      notifyListeners();
    }
  }

  // menambahkan fungsi untuk menghapus data profile berdasarkan nilai id-nya
  Future<void> removeProfileValueById(String id) async {
    try {
      await _service.removeItem(id);
      _restaurant = null;
      _restaurantList = await _service.getAllItems();
      _message = "Your data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }
}