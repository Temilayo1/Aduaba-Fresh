class AddNewCard {
  String id;
  String cardHolderName;
  String cardType;
  String cardNumber;
  String expiryDate;
  String ccv;

  AddNewCard(
      {this.id,
      this.cardHolderName,
      this.cardNumber,
      this.expiryDate,
      this.cardType,
      this.ccv});

  AddNewCard.fromJson(Map<String, dynamic> json) {
    cardHolderName = json['cardHolderName'];
    cardNumber = json['cardNumber'];
    expiryDate = json['expiryDate'];
    cardType = json['cardType'];
    ccv = json['ccv'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardHolderName'] = this.cardHolderName;
    data['cardNumber'] = this.cardNumber;
    data['expiryDate'] = this.expiryDate;
    data['ccv'] = this.ccv;
    return data;
  }
}
