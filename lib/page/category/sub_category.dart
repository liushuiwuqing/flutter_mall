import 'package:flutter/material.dart';
import 'package:mall/entity/sub_category_entity.dart';
import 'package:mall/event/category_event.dart';
import 'package:mall/service/category_service.dart';
import 'package:mall/page/goods/category_goods_list.dart';
import 'package:mall/utils/navigator_util.dart';
import 'package:mall/page/goods/goods_list.dart';
import 'package:mall/widgets/cached_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SubCategoryView extends StatefulWidget {
  @override
  _SubCategoryViewState createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  CategoryService categoryService = CategoryService();
  List<SubCategoryEntity> subCategoryEntitys = List();

  var categoryName, categoryImage, categoryId;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    print("SubCategoryView_initState");
  }

  _listener() {
    eventBus
        .on<CategoryEvent>()
        .listen((CategoryEvent event) => _updateView(event));
  }

  _updateView(CategoryEvent categoryEvent) {
    if (flag) {
      flag = false;
      print("_SubCategoryViewState_updateView");
      setState(() {
        categoryName = categoryEvent.categoryName;
        categoryImage = categoryEvent.categoryImage;
        categoryId = categoryEvent.id;
      });
      _getSubCategory(categoryEvent.id);
    }
  }

//  _getSubCategory(int id) {
//    var params = {"id": id};
//    print(params);
//    print("_getSubCategory");
//    categoryService.getSubCategoryData(params,
//        onSuccess: (List<SubCategoryEntity> subCategoryEntityList) {
//      flag = true;
//      setState(() {
//        subCategoryEntitys.clear();
//        subCategoryEntitys.addAll(subCategoryEntityList);
//      });
//    });
//  }

  _getSubCategory(int id) {
    var params = {"id": id};
    categoryService.getSubCategoryData(params, (subCategoryEntityList) {
      flag = true;
      setState(() {
        subCategoryEntitys = subCategoryEntityList;
      });
    }, onFail: (value) {});
  }

  @override
  Widget build(BuildContext context) {
    _listener();
    return Container( //整个容器没有感受到作用?我添加了alignment,让其始终保持在最顶上,不然可能在界面的中间
//      alignment:Alignment.topCenter,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(ScreenUtil.instance.setWidth(20.0)),
            height: ScreenUtil.instance.setHeight(200.0),
            child: Image.network(
              categoryImage ?? "",
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
          ),
          Center(
            child: Text(
              categoryName ?? "",
              style: TextStyle(fontSize: 14.0, color: Colors.black54),
            ),
          ),
          GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: subCategoryEntitys.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //
                  crossAxisSpacing: 10.0, // 横轴元素个数
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.85 //宽与高的比例
              ),
              itemBuilder: (BuildContext context, int index) {
                return getItemView(subCategoryEntitys[index]);
              }),
          Padding(
              padding: EdgeInsets.only(top: 10.0)),
          //当向上滑动时,可保证下面还有10的空间        ),
        ],
      ),
    );
  }

  _itemClick(int id) {
//    Navigator.push(
//      context,
//      new MaterialPageRoute(builder: (context) {
//        return new GoodsList(1008002);
//      }),
//    );
    NavigatorUtils.goCategoryGoodsListPage(context, categoryName, id);
  }

  Widget getItemView(SubCategoryEntity category) {
    return GestureDetector(
      child: Container(
          alignment: Alignment.center,
          child: Card(
            child: Column(
              children: <Widget>[
                Image.network(
                  category.picUrl,
                  fit: BoxFit.fill,
                  height: 60,//这里需要设置高度,不然提示底部溢出
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                Text(
                  category.name,
                  style: TextStyle(fontSize: 14.0, color: Colors.black54),
                ),
              ],
            ),
          )),
      onTap: () => _itemClick(category.id),
    );
  }
}
