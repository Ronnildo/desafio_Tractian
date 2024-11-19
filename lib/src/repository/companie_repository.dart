import 'package:dio/dio.dart';
import 'package:treeviewapp/src/repository/repository.dart';

class CompanieRepository extends Repository {
  Future getCompanies() async {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://fake-api.tractian.com",
      ),
    );
    try {
      Response res = await dio!.get("/companies");
      return res.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
