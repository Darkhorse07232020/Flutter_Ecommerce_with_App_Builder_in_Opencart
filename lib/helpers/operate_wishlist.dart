import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Login.dart';
import 'package:shop_app/models/TokenData.dart';
import 'package:shop_app/models/Variable.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/detail_state.dart';
import 'package:shop_app/screens/main/home_screen.dart';
import 'package:toast/toast.dart';

Future<bool> addToWishlist(context, productId) async {
  if (loginState == true) {
    var map = new Map<String, dynamic>();
    map['id_currency'] = idCurrency;
    map['iso_code'] = isoCode;
    map['email'] = loginVariable.email;
    map['product_id'] = productId;

    final response = await http.post(
      'https://easycartapp.com/index.php?route=webservices/api&method=appAddToWishlist&version=1.6&api_token=' +
          apiTokenKey,
      headers: {
        'Cookie': 'language=' +
            isoCode +
            '; OCSESSID=' +
            sessionData +
            '; currency=' +
            idCurrency
      },
      body: map,
    );
    Map<String, dynamic> responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseJson['status'] == 'success') {
        Toast.show(
          responseJson['message'],
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
        Provider.of<DetailState>(context, listen: false).setWishlistCount(
            int.parse(responseJson['wishlist_count'].toString()));
        return true;
      }
    } else {
      throw Exception('Failed to load LangClass');
    }
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(initTab: 3),
      ),
    );
  }
  return false;
}

Future<bool> removeToWishlist(context, productId) async {
  if (loginState == true) {
    var map = new Map<String, dynamic>();
    map['id_currency'] = idCurrency;
    map['iso_code'] = isoCode;
    map['email'] = loginVariable.email;
    map['product_id'] = productId;

    final response = await http.post(
      'https://easycartapp.com/index.php?route=webservices/api&method=appRemoveWishlist&version=1.6&api_token=' +
          apiTokenKey,
      headers: {
        'Cookie': 'language=' +
            isoCode +
            '; OCSESSID=' +
            sessionData +
            '; currency=' +
            idCurrency
      },
      body: map,
    );
    Map<String, dynamic> responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseJson['status'] == 'success') {
        Toast.show(
          responseJson['message'],
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
        Provider.of<DetailState>(context, listen: false).setWishlistCount(
            int.parse(responseJson['wishlist_count'].toString()));
        return true;
      }
    } else {
      throw Exception('Failed to load LangClass');
    }
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(initTab: 3),
      ),
    );
  }
  return false;
}
