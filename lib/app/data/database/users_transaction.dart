import 'package:logcashflow/app/data/database/db_helper.dart';
import 'package:logcashflow/app/data/models/users.dart';

class UsersTransaction {
  static const String _tableName = "users";

  static Future<Map<String, dynamic>> findUsers(
      String username, String password) async {
    var db = DbHelper();
    var query =
        'SELECT id, username, created_at FROM USERS WHERE username = ? AND password = ?';
    var resList = await db.selectQuery(query, [username, password]);
    if (resList.isEmpty) {
      return {};
    }
    return resList.first;
  }

  static Future<Map<String, dynamic>> checkPassword(
      int id, String password) async {
    var db = DbHelper();
    var query = "SELECT 1 AS RESULT FROM users WHERE id = ? AND password = ?";
    var res = await db.selectQuery(query, [id, password]);

    if (res.isEmpty) {
      return {};
    }

    return res.first;
  }

  static Future<int> update(Users user, int id) {
    var db = DbHelper();
    return db.update(_tableName, user.toMap(), id);
  }
}
