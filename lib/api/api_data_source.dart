import 'package:projectakhir_tpm_123210006/api/base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadProduct() {
    return BaseNetwork.get("products");
  }

  Future<Map<String, dynamic>> loadDetailProduct(int idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("products/$id");
  }

  Future<Map<String, dynamic>> loadProductCategory(String category) {
    return BaseNetwork.get("products/category/$category");
  }
}
