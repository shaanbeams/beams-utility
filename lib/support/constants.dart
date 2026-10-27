import 'package:gas_utility_app/modules/home/models/menu_item_menu_model.dart';
import 'package:gas_utility_app/modules/home/view/widgets/select_doc_type_widget.dart';
import 'package:gas_utility_app/support/global.dart';

// Initialize a global instance of the Global class
Global g = Global();

class Constants {
  /////////////////// Static list that holds the menu items for the app///////////////////////////
  static List<MenuItemMenuModel> menuList = [
    MenuItemMenuModel(
      name: "Assign User \n List",
      iconPath: "assets/icons/assigneduser.png",
      onPressed: () {
        selectDoctTypeDialogue(homeMenu: HomeMenuEnum.assignUserList, prvDocType: "GCT");
      },
    ),
    MenuItemMenuModel(
      name: "Contract",
      iconPath: "assets/icons/contract.png",
      onPressed: () {
        selectDoctTypeDialogue(homeMenu: HomeMenuEnum.contract, prvDocType: "GCT");
      },
    ),
    MenuItemMenuModel(
      name: "Contract \nReceipt",
      iconPath: "assets/icons/contract_receipt.png",
      onPressed: () {
        selectDoctTypeDialogue(homeMenu: HomeMenuEnum.contractReceipt, prvDocType: "GCR");
      },
    ),
    MenuItemMenuModel(
      name: "Gas Meter Reading",
      iconPath: "assets/icons/reading.PNG",
      onPressed: () {
        selectDoctTypeDialogue(homeMenu: HomeMenuEnum.gasMeterReading, prvDocType: "GRD");
      },
    ),
    MenuItemMenuModel(
      name: "Gas Meter \n Invoice",
      iconPath: "assets/icons/meter invoice.PNG",
      onPressed: () {
        selectDoctTypeDialogue(homeMenu: HomeMenuEnum.gasInvoice, prvDocType: "GIN");
      },
    ),
    MenuItemMenuModel(
      name: "Gas Meter\n Receipt",
      iconPath: "assets/icons/receipt.png",
      onPressed: () {
        selectDoctTypeDialogue(homeMenu: HomeMenuEnum.gasMeterReceipt, prvDocType: "GREC");
      },
    ),
    MenuItemMenuModel(
      name: "Reading\n Correction",
      iconPath: "assets/icons/reading_correction.PNG",
      onPressed: () {
        // selectDoctTypeDialogue(homeMenu: HomeMenuEnum.readingCorrection, prvDocType: "GRC");
        selectDoctTypeDialogue(homeMenu: HomeMenuEnum.readingCorrection, prvDocType: "GRD");
      },
    ),
    MenuItemMenuModel(
      name: "Temporary\nDisconnection",
      iconPath: "assets/icons/disconnected.png",
      onPressed: () {
        // selectDoctTypeDialogue(homeMenu: HomeMenuEnum.readingCorrection, prvDocType: "GRC");
        selectDoctTypeDialogue(
            homeMenu: HomeMenuEnum.disconnectionTemp, prvDocType: "CTD");
      },
    ),
    MenuItemMenuModel(
      name: "Temporary\n Reconnection",
      iconPath: "assets/icons/connected.png",
      onPressed: () {
        // selectDoctTypeDialogue(homeMenu: HomeMenuEnum.readingCorrection, prvDocType: "GRC");
        selectDoctTypeDialogue(
            homeMenu: HomeMenuEnum.reconnectionTemp, prvDocType: "CTR");
      },
    ),
    MenuItemMenuModel(
      name: "Disconnection\n request",
      iconPath: "assets/icons/disconnection_req.png",
      onPressed: () {
        // selectDoctTypeDialogue(homeMenu: HomeMenuEnum.readingCorrection, prvDocType: "GRC");
        selectDoctTypeDialogue(
            homeMenu: HomeMenuEnum.disconnectionRequest, prvDocType: "GDQ");
      },
    ),
    MenuItemMenuModel(
      name: "Contract\ndisconnection",
      iconPath: "assets/icons/discoonection.PNG",
      onPressed: () {
        // selectDoctTypeDialogue(homeMenu: HomeMenuEnum.readingCorrection, prvDocType: "GRC");
        selectDoctTypeDialogue(
            homeMenu: HomeMenuEnum.contractDisconnection, prvDocType: "GRF");
      },
    ),
    MenuItemMenuModel(
      name: "Final \n settlement",
      iconPath: "assets/icons/settlement.png",
      onPressed: () {
        // selectDoctTypeDialogue(homeMenu: HomeMenuEnum.readingCorrection, prvDocType: "GRC");
        selectDoctTypeDialogue(
            homeMenu: HomeMenuEnum.finalSettlement, prvDocType: "GPY");
      },
    ),
  ];
}

enum HomeMenuEnum {
  assignUserList,
  contract,
  contractReceipt,
  gasMeterReading,
  gasInvoice,
  gasMeterReceipt,
  readingCorrection,
  disconnectionTemp,
  reconnectionTemp,
  disconnectionRequest,
  contractDisconnection,
  finalSettlement
}
