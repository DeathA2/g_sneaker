import 'dart:convert';

import 'package:g_sneaker/data/model/added_product.dart';

import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {

  static const _selectedShoes = '_selectedShoes';


  static Future<bool> setSelectedShoes(List<AddedProduct>? input) async {

    try {

      final prefs = await SharedPreferences.getInstance();

      if (input == null) {

        prefs.remove(_selectedShoes);

        return true;

      }

      Map<String, List> data = {};

      List<Map<String, dynamic>> rawData = [];

      for (AddedProduct product in input) {

        rawData.add(product.toJson());

      }

      data = {"selectedShoes": rawData};

      final jsonEncode = json.encode(data);

      return await prefs.setString(_selectedShoes, jsonEncode);

    } catch (error) {

      return false;

    }

  }


  static Future<List<AddedProduct>?> getSelectedShoes() async {

    try {

      final prefs = await SharedPreferences.getInstance();

      final data = prefs.getString(_selectedShoes);
      final dataEncode = json.encode(data);

      if (data == null) {

        return null;

      }

      final rawdata = json.decode(dataEncode);
      final rawData = json.decode(rawdata);

      final selectedShoes = rawData['selectedShoes'] as List<dynamic>;

      final List<AddedProduct> products =

          selectedShoes.map((e) => AddedProduct.fromJson(e)).toList();

      return products;

    } catch (error) {

      print(error);

      return null;

    }

  }

}

