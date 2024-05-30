import 'package:hive/hive.dart';
import 'package:projectakhir_tpm_123210006/hive/datauser_model.dart';

class HiveDatabase {
  static final Box<DataUserModel> _localDB =
      Hive.box<DataUserModel>("data_user");

  void addData(DataUserModel data) {
    _localDB.add(data);
  }

  int getLength() {
    return _localDB.length;
  }

  bool checkLogin(String username, String password) {
    bool found = false;
    for (int i=0; i<getLength(); i++) {
      if (username == _localDB.getAt(i)!.username &&
          password == _localDB.getAt(i)!.password) {
        print("Login Berhasil");
        found = true;
        break;
      } else {
        found = false;
      }
    }
    return found;
  }
}
