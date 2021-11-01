import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        email TEXT,
        password TEXT
      )
    """);
    await database.execute("""
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        email TEXT,
        name TEXT,
        text1 TEXT,
        text2 TEXT,
        text3 TEXT
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'task3.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      } 
    );
  }

  //Create new user
  static Future<int> createUser(String username, String email, String password) async {
    final db = await SQLHelper.db();

    final data = {'username': username, 'email': email, 'password': password};
    final id = await db.insert('users', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all users
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await SQLHelper.db();
    return db.query('users', orderBy: 'id');
  }

  //Read a single user by id
  static Future<List<Map<String, dynamic>>> getUserID(int id) async {
    final db = await SQLHelper.db();
    return db.query('users', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  //Read a single user by username and password
  static Future<List<Map<String, dynamic>>> getUserUsernamePassword(String username, String password) async {
    final db = await SQLHelper.db();
    return db.query('users', where: 'username = ?  and password = ?', whereArgs: [username, password]);
  }

  //Read a single user by email and password
  static Future<List<Map<String, dynamic>>> getUserEmailPassword(String email, String password) async {
    final db = await SQLHelper.db();
    return db.query('users', where: 'email = ? and password = ?', whereArgs: [email, password]);
  }

  //Read a single user by username
  static Future<List<Map<String, dynamic>>> getUserByUsername(String username) async {
    final db = await SQLHelper.db();
    return db.query('users', where: 'username = ?', whereArgs: [username]);
  }
  //Read a single user by email
  static Future<List<Map<String, dynamic>>> getUserByEmail(String email) async {
    final db = await SQLHelper.db();
    return db.query('users', where: 'email = ?', whereArgs: [email]);
  }

  //Update a user by id
  static Future<int> updateUser(
    int id, String username, String email, String password) async {
      final db = await SQLHelper.db();

      final data = {
        'username': username,
        'email': email,
        'password': password,
      };

      final result = await db.update('users', data, where: "id = ?", whereArgs: [id]);
      return result;
    }

  //Delete
  static Future<void> deleteUser(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('users', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleteing an user: $err");
    }
  }

  //Create new user
  static Future<int> createItem(String email, String name, String text1, String text2, String text3) async {
    final db = await SQLHelper.db();

    final data = {'email': email, 'name': name, 'text1': text1, 'text2': text2, 'text3': text3};
    final id = await db.insert('items', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //Delete item
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try{
      await db.delete('items', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went worng whene deleting an item: $err");
    }
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: 'id');
  }

  // Read all items of the user
  static Future<List<Map<String, dynamic>>> getAllItemsbyEmail(String email) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "email = ?", whereArgs: [email]);
  }

  // Read single item of the user
  static Future<List<Map<String, dynamic>>> getOneItemOfUser(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id]);
  }

  // Read single item of the user for editing
  // static Future<List<Map<String, dynamic>>> updateSingleItemOfUserForEditing(int id, String email, String name) async {
  //   final db = await SQLHelper.db();
  //   final 
  //   return db.update('items', )
  // }
  static Future<int> updateSingleItemOfUserForEditing(
    int id, String name, String text1, String text2, String text3) async {
      final db = await SQLHelper.db();

      final data = {
        'name': name,
        'text1': text1,
        'text2': text2,
        'text3': text3,
      };

      final result = await db.update('items', data, where: "id = ?", whereArgs: [id]);
      return result;
    }

  // Read Old Passwrod
  static Future<List<Map<String, dynamic>>> readOldPassword(int id) async {
    final db = await SQLHelper.db();
    return db.query('users', where: "id = ?", whereArgs: [id]);
  }

  // Update New Password
  static Future<int> updatePassword(
  int id, String password) async {
    final db = await SQLHelper.db();

    final data = {
      'password': password,
    };

    final result = await db.update('users', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Read Username and Email
  static Future<List<Map<String, dynamic>>> readUsernameAndEmail(String username, String email) async {
    final db = await SQLHelper.db();
    return db.query('users', where: "username = ? and email = ?", whereArgs: [username, email]);
  }

  // Update New Password
  static Future<int> forgotPassword(
  String username, String email, String password) async {
    final db = await SQLHelper.db();

    final data = {
      'password': password,
    };

    final result = await db.update('users', data, where: "username = ? and email = ?", whereArgs: [username, email]);
    return result;
  }
}