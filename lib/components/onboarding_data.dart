import 'package:flutter/material.dart';

class SliderModel {
  String imageAssetPath;
  String title;
  String desc;
  Color colour;

  SliderModel({this.imageAssetPath, this.title, this.desc, this.colour});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  void setCol(Color getColour) {
    colour = getColour;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }

  Color getColour() {
    return colour;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc(
      "تعرف على تاريخ استراليا و كيف \n أصبحت أحد أهم دول العالم الأول");
  sliderModel.setTitle("تاريخ أستراليا");
  sliderModel.setImageAssetPath("assets/images/map.jpg");
  sliderModel.setCol(Colors.orange[500]);
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("تعرف على أهم معالم الثقافة الأسترالية");
  sliderModel.setTitle("عن أستراليا");
  sliderModel.setImageAssetPath("assets/images/aus.jpg");
  sliderModel.setCol(Colors.blue[200]);
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("أماكن ننصح بزيارتها في أستراليا");
  sliderModel.setTitle("معالم");
  sliderModel.setImageAssetPath("assets/images/monuments.jpg");
  sliderModel.setCol(Colors.cyan[700]);
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  //4
  sliderModel.setDesc("إجراءات السفر و نصائح عامة \n عند الذهاب إلى أستراليا");
  sliderModel.setTitle("السفر");
  sliderModel.setImageAssetPath("assets/images/travel.jpg");
  sliderModel.setCol(Colors.amber);
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
