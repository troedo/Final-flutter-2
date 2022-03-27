class Model {
  String a1, a2, a3, a4, a5, im;

  Model(this.a1, this.a2, this.a3, this.a4, this.a5, this.im);

  Model.fromMap(Map<String, dynamic> map) {
    a1 = map['License'];
    a2 = map['message'];
    a3 = map['timestamp'];
    // a4 = map['A4'];
    // a5 = map['A5'];
    im = map['Pathimages'];
  }
}
