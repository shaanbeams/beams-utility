enum CompanyDetails { Maincompany }

extension StatusTypeExtension on CompanyDetails {
  // Return only the IconData, not the full Icon widget
}

enum SaveModes {
  add,
  edit,
  view;

  String get value {
    switch (this) {
      case SaveModes.add:
        return "ADD";
      case SaveModes.edit:
        return "EDIT";
      case SaveModes.view:
        return "VIEW";
    
    }
  }
}

enum Charges {
  insurance,
  deposit,
  connection,
  maintanance,
  disconnection,
  registration,
  othercharge1,
  othercharge2,
  othercharge3;

  int get value {
    switch (this) {
      case Charges.insurance:
        return 0;
      case Charges.deposit:
        return 1;
      case Charges.connection:
        return 2;
      case Charges.maintanance:
        return 3;
      case Charges.disconnection:
        return 4;
      case Charges.registration:
        return 5;
      case Charges.othercharge1:
        return 6;
      case Charges.othercharge2:
        return 7;
      case Charges.othercharge3:
        return 8;
    }
  }
}
