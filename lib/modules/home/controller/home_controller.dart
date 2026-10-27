import 'package:gas_utility_app/modules/home/models/menu_item_menu_model.dart';
import 'package:gas_utility_app/modules/home/repository/select_doc_type_repo.dart';
import 'package:gas_utility_app/modules/lookup/repository/look_up_repo.dart';
import 'package:gas_utility_app/support/constants.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<MenuItemMenuModel> filteredMenuList = Constants.menuList.obs;
  RxList docTypes = [].obs;
  RxBool docIsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    filteredMenuList.value = Constants.menuList;
    fnGetMonthlyFeeVariable();
  }

  void findMenu({required String searchWord}) {
    if (searchWord.isEmpty) {
      filteredMenuList.value = Constants.menuList;
    } else {
      filteredMenuList.value = Constants.menuList
          .where((menuItem) =>
              menuItem.name.toLowerCase().contains(searchWord.toLowerCase()))
          .toList();
    }

    logger.i(filteredMenuList);
  }

  fnSelectDocType({required String docType}) async {
    docIsLoading(true);
    Helper.fngetTocken().then(
      (value) {
        if (value != null) {
          logger.d(docType);
          SelectDocTypeRepository()
              .selectDoxType(mDoc: docType, token: value)
              .then(
            (value) {
              logger.f(value);
              if (value[0]["Table1"] != null && value[0]["Table1"].isNotEmpty) {
                docTypes.assignAll(value[0]["Table1"]);
                docIsLoading(false);
              } else {
                if (value[0]["Table1"].isEmpty) {
                  docIsLoading(false);
                  docTypes.value = [];
                } else {
                  docIsLoading(false);
                  Get.snackbar("", "Doc Selection Field");
                }
              }
            },
          );
        }
      },
    );

    // .then((val) {
    //   fnLoginSuccess();
    // });
  }

  fnGetMonthlyFeeVariable() {
    print("function for the monthlyfee is called");
    var searchColumn = [
      {
        "showItem": true,
        "columnName": "MONTHLY_FEES_YN",
        "showName": "monthly fees yn"
      },
      {
        "showItem": true,
        "columnName": "ENABLE_FUEL_SURCHAGE_OPTION",
        "showName": 'Surcharge'
      }
    ];
    String searchColumnString =
        '${searchColumn.map((item) => item['columnName']).join('|')}|';
    Helper.fngetTocken().then((token) {
      if (token != null) {
        LookUpRepository()
            .getLookListData(
                token: token,
                filter: [
                  {
                    'Column': "COMPANY_CODE",
                    'Operator': '=',
                    'Value': Global.selectedCompanyCode,
                    'JoinType': 'AND'
                  },
                ],
                searchColumn: searchColumnString,
                tableName: 'COMPANYPARA1')
            .then((list) {
          Global.monthlyFeeYn =
              list[0]["MONTHLY_FEES_YN"] == "Y" ? true : false;
          Global.enableFuelSurcharge = list[0]["ENABLE_FUEL_SURCHAGE_OPTION"];
        });
      }
    });
  }
}
