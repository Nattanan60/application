class Model{

  String a1, a2, a3, a4, a5, im;

  Model(this.a1, this.a2, this.a3, this.a4, this.a5,this.im);

  Model.fromMap(Map<String, dynamic> map){
    a1 = map['A1'];
    a2 = map['A2'];
    a3 = map['A3'];
    a4 = map['A4'];
    a5 = map['A5'];
    im = map['im'];

  }


}


