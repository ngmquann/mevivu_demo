import 'package:get/get.dart';
import 'package:test1_mevivu/model/post.dart';
import 'package:test1_mevivu/service/post_service.dart';

class PostBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(() => PostController());
  }
}

class PostController extends GetxController {
  var isLoading = false.obs;
  var posts = <Post>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    try{
      isLoading.value = true;
      var getPosts = await PostService().getAllPosts();
      posts.assignAll(getPosts);
    } catch(e) {
      if (Get.context != null) {
        Get.snackbar(
          'Error',
          'An error occurred while fetching posts',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}