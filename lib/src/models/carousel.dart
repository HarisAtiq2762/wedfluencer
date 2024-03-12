class CarouselSliderData {
  String title;
  String imagePath;
  CarouselSliderData({required this.title, required this.imagePath});
}

class CarouselPlanData {
  String title;
  String price;
  List<PlanFeature> features;
  CarouselPlanData(
      {required this.title, required this.price, required this.features});
}

class PlanFeature {
  String feature;
  bool isIncluded;
  PlanFeature({required this.feature, required this.isIncluded});
}
