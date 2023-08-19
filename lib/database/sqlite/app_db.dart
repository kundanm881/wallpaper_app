import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallpaper/database/model/images_model.dart';

class AppDb {
  static AppDb? _appDb;
  static const String _databaseName = "fav.db";
  static const String _favTable = "favs";
  static const String _favSrc = "fav_src";
  static Database? _db;

  AppDb._() {
    _setdbPath();
  }

  static _setdbPath() async {
    var dir = await getExternalStorageDirectory();
    // print(dir!.path);

    _db = await openDatabase(
      join(dir!.path, _databaseName),
      version: 1,
      onCreate: (db, version) async {
        db.execute(
          'CREATE TABLE $_favTable'
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
          ')',
        );

        await db.execute('CREATE TABLE $_favSrc '
            '(id INTEGER PRIMARY KEY,'
            'original TEXT,'
            'large2x TEXT,'
            'large TEXT,'
            'medium TEXT,'
            'small TEXT,'
            'portrait TEXT,'
            'landscape TEXT,'
            'tiny TEXT'
            ')');

        // return db;
      },
    );
  }

  static get init async {
    if (_db == null) {
      await _setdbPath();
    }
    return _appDb ?? AppDb._();
  }

  // print(await database.query('Fav'));

  // print(database.runtimeType);

  // remove fav
  Future removeFav({required int id}) async {
    await _db!.rawDelete('DELETE FROM $_favSrc WHERE id = $id');
    await _db!.rawDelete('DELETE FROM $_favTable WHERE id = $id');
  }
  // database.delete("Fav");

  // get all favs
  Future<int> insertFav({required Photos photo}) async {
    int id;
    id = await _db!.insert(
      _favTable,
      {
        "id": photo.id,
        "width": photo.width,
        "height": photo.height,
        "url": photo.url,
        "photographer": photo.photographer,
        "photographer_url": photo.photographerUrl,
        "photographer_id": photo.photographerId,
        "avg_color": photo.avgColor,
        "liked": (photo.liked == true) ? 1 : 0,
        "alt": photo.alt
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await _db!.insert(
      _favSrc,
      {
        "id": photo.id,
        'original': photo.src?.original ?? "",
        'large2x': photo.src?.large2x ?? "",
        'large': photo.src?.large ?? "",
        'medium': photo.src?.medium ?? "",
        'small': photo.src?.small ?? "",
        'portrait': photo.src?.portrait ?? "",
        'landscape': photo.src?.landscape ?? "",
        'tiny': photo.src?.tiny ?? ""
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<List<Map<String, dynamic>>> getAllFavs() async {
    List<Map<String, dynamic>> images = await _db!.query(_favTable);

    List<Map<String, dynamic>> data = [];

    for (var element in images) {
      Map<String, dynamic> elv = {};
      elv.addAll(element);
      final src =
          await _db!.query(_favSrc, where: "id = ${elv['id']}", limit: 1);
      elv['src'] = src.first;

      data.add(elv);
    }
    // print(data);
    return data;
  }
}
