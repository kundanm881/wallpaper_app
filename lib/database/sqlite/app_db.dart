import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallpaper/database/model/images_model.dart';

class AppDb {
  static AppDb? _appDb;
  static const String _databaseName = "fav.db";
  static const String _favTable = "favs";
  static const String _favSrc = "favSrc";
  static late Database _db;

  // final Database database;

  AppDb._() {
    _setdbPath();
  }

  static _setdbPath() async {
    var path = join(await getDatabasesPath(), _databaseName);

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE $_favTable'
            '(id INTEGER PRIMARY KEY,'
            'width INTEGER,'
            'height INTEGER,'
            'url TEXT,'
            'photographer TEXT,'
            'photographer_url TEXT,'
            'photographer_id INTEGER,'
            'avg_color TEXT,'
            'liked INTEGER,'
            'alt TEXT'
            ')');

        await db.execute('CREATE TABLE $_favSrc'
            '(id INTEGER PRIMARY KEY,'
            'original_src TEXT,'
            'large2x_src TEXT,'
            'large_src TEXT,'
            'medium_src TEXT,'
            'small_src TEXT,'
            'portrait_src TEXT,'
            'landscape_src TEXT,'
            'tiny_src TEXT,'
            ')');

        // return db;
      },
    );
  }

  static get init async {
    await _setdbPath();
    return _appDb ?? AppDb._();
  }

  // print(await database.query('Fav'));

  // print(database.runtimeType);

  // database.delete("Fav");

  insertFav({required Photos photo}) async {
    print(photo.toJson());

    // _db.insert(
    //   _favTable,
    //   {
    //     "id": 1,
    //     "width": 100,
    //     "height": 100,
    //     "url": "main Image",
    //     "photographer": "Ph Name",
    //     "photographer_url": "TEXT",
    //     "photographer_id": 123,
    //     "avg_color": "TEXT",
    //     "liked": 0,
    //     "alt": "sdas"
    //   },
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
    // _db.insert(
    //   _favSrc,
    //   {
    //     "id": 1,
    //     "name": "Kundan",
    //   },
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  }

  getFavs() async {
    var x = await _db.query(_favTable);
    print(x);
    var y = await _db.query(_favSrc);
    print(y);
  }
}

// class _FabDataBase {}
