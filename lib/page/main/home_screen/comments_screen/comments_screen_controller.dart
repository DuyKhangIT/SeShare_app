import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/add_coment_post/add_comment_post_request.dart';
import 'package:instagram_app/models/add_coment_post/add_comment_post_response.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/list_comments_post/list_comments_post_request.dart';
import '../../../../models/list_comments_post/list_comments_post_response.dart';
import '../../../../models/list_posts_home/list_posts_home_response.dart';
import '../../../../util/global.dart';
import '../../../navigation_bar/navigation_bar_view.dart';

class CommentsController extends GetxController {
  TextEditingController cmtController = TextEditingController();
  bool isTyping = false;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadListCmt() {
    ListCommentsPostRequest request = ListCommentsPostRequest(Global.idPost);
    getListCommentsPost(request);
    update();
  }

  /// handle add comment api
  Future<AddCommentPostResponse> addCommentPost(
      AddCommentPostRequest request) async {
    AddCommentPostResponse addCommentPostResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/photo/add-comment"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(request.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to get add cmt $error");
      rethrow;
    }
    if (body == null) return AddCommentPostResponse.buildDefault();
    //get data from api here
    addCommentPostResponse = AddCommentPostResponse.fromJson(body);
    if (addCommentPostResponse.status == true) {
      loadListCmt();
      cmtController.text = "";
      update();
    }
    return addCommentPostResponse;
  }

  /// handle get list comment api
  Future<ListCommentsPostResponse> getListCommentsPost(
      ListCommentsPostRequest request) async {
    ListCommentsPostResponse listCommentsPostResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/photo/list-comment-of-post"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(request.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to get list cmt $error");
      rethrow;
    }
    if (body == null) return ListCommentsPostResponse.buildDefault();
    //get data from api here
    listCommentsPostResponse = ListCommentsPostResponse.fromJson(body);
    if (listCommentsPostResponse.status == true) {
      Global.dataListCmt = listCommentsPostResponse.data;
      update();
    }
    return listCommentsPostResponse;
  }

  /// call api update list post after cmt
  Future<ListPostsHomeResponse> updateListPosts() async {
    ListPostsHomeResponse listPostsHomeResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/photo/homepage-posts"),
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
      debugPrint("----------Update list post after cmt---------");
      Global.listPostInfo = listPostsHomeResponse.data!;
      update();
      Get.to(() => NavigationBarView(currentIndex: 0));
    }
    return listPostsHomeResponse;
  }
}
