import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:instagram_app/models/list_posts_home/data_posts_response.dart';
import 'package:instagram_app/models/list_posts_home/list_posts_home_response.dart';

import '../../../api_http/handle_api.dart';
import '../../../config/share_preferences.dart';
import '../../../models/user_profile/profile_request.dart';
import '../../../models/user_profile/profile_response.dart';
import '../../../util/global.dart';

class HomeController extends GetxController {
  bool isLike = false;
  final scrollController = ScrollController();
  double previousOffset = 0.0;
  File? avatar;
  bool isNewUpdate = false;
  String userId = "";
  bool isLoading = false;
  String phone = "";


  List<DataPostsResponse>? dataPostsResponse;
  @override
  void onReady() {
    getListPosts();
    update();
    getPhoneUser();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  /// call api list post
  Future<ListPostsHomeResponse> getListPosts() async {
    isLoading = true;
    update();
    ListPostsHomeResponse listPostsHomeResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/photo/homepage-posts"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list posts $error");
      rethrow;
    }
    if (body == null) return ListPostsHomeResponse.buildDefault();
    //get data from api here
    listPostsHomeResponse = ListPostsHomeResponse.fromJson(body);
    if (listPostsHomeResponse.status == true) {
      dataPostsResponse = listPostsHomeResponse.data;
      await Future.delayed(const Duration(seconds: 1),(){});
      isLoading = false;
      update();
    }
    return listPostsHomeResponse;
  }

  // /// refresh
  Future<void> refreshData() async {
    isNewUpdate = false;
    update();
    getListPosts();
  }

  /// pull to refresh
  Future<void> pullToRefreshData({bool isRefreshIndicator = true}) async {
    isNewUpdate = false;
    getListPosts();
    update();
    return Future.delayed(const Duration(seconds: 1));
  }

  void getPhoneUser() async{
    phone = await ConfigSharedPreferences()
        .getStringValue(SharedData.PHONE.toString(),
        defaultValue: "");
    if(phone.isNotEmpty){
      ProfileRequest profileRequest = ProfileRequest(phone);
      loadUserProfile(profileRequest);
    }
  }
  /// load user profile
  Future<ProfileResponse> loadUserProfile(ProfileRequest profileRequest) async {
    ProfileResponse profileResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/user/profile"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(profileRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to user profile $error");
      rethrow;
    }
    if (body == null) return ProfileResponse.buildDefault();
    //get data from api here
    profileResponse = ProfileResponse.fromJson(body);
    if(profileResponse.status == true){
      Global.userProfileResponse = profileResponse.userProfileResponse;
      print("load profile success");
      update();
    }
    return profileResponse;
  }
}
