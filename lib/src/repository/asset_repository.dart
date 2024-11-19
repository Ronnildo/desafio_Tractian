import 'package:dio/dio.dart';
import 'package:treeviewapp/src/repository/repository.dart';

class AssetRepository extends Repository {
  Future getAssets(String companieId) async {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://fake-api.tractian.com",
      ),
    );
    try {
      Response res = await dio!.get("/companies/$companieId/assets");
      return res.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}