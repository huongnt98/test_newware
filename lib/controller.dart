import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DataController extends GetxController{
  int page = 1;
  bool isMaxPage = false;
  List? items;
  @override
  void onInit() {
    getItems();
    super.onInit();
  }

  getItems() async {
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/discover/movie?api_key=26763d7bf2e94098192e629eb975dab0&page=' +
              page.toString());
      print('-----------------${response.data['results']}');
      if (response.data is Map && response.data['results'] is List) {
        items = response.data['results'];
      }else if(response.data is List) {
        items = response.data;

      }else{
        isMaxPage = true;
      }
      update();
    } catch (e) {
      print(e);
    }
  }
  nextPage() async{
    page++;
    await getItems();
    update();
  }
}