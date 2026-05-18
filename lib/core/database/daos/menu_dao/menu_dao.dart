import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/params/menu_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/menus.dart';

part 'menu_dao.g.dart';

@DriftAccessor(tables: [Menus])
class MenuDao extends DatabaseAccessor<AppDatabase> with _$MenuDaoMixin {
  MenuDao(super.db);

  Future<int> insertItem(MenuParams menuItem) async {
    return await db
        .into(db.menus)
        .insert(MenusCompanion(title: Value(menuItem.title)));
  }

  Future<List<MenusData>> getAllMenus() async {
    return await (db.select(
      db.menus,
    )..where((tbl) => tbl.isActive.equals(true))).get();
  }

  Future<MenusData> getMenu(int id) async {
    return (db.select(db.menus)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> updateMenu(MenuParams menuItem) async {
    await (db.update(
      db.menus,
    )..where((tbl) => tbl.id.equals(menuItem.id!))).write(
      MenusCompanion(
        title: Value(menuItem.title),
        isActive: Value(menuItem.isActive ?? true),
        modifiedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> archiveMenu(int id) async {
    await (db.update(db.menus)..where((tbl) => tbl.id.equals(id))).write(
      MenusCompanion(
        isActive: Value(false),
        modifiedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> deleteItem(int id) async {
    await (db.delete(db.menus)..where((tbl) => tbl.id.equals(id))).go();
  }
}
