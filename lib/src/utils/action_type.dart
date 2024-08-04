enum ActionType {
  navigate,
  none,
  networkRequest,
  showModalBottomSheet,
  showDialog,
  getFormValue,
  validateForm;

  static ActionType fromString(String name) {
    return ActionType.values.firstWhere((e) => e.name == name);
  }
}
