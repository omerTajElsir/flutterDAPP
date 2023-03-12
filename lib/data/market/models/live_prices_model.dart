class LivePricesModel {
  const LivePricesModel(
      this.name, this.icon, this.short, this.price, this.percent, this.isUp);
  final String name;
  final String icon;
  final String short;
  final String price;
  final double percent;
  final bool isUp;
}
