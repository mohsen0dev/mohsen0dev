import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color yelooColor = Colors.yellowAccent;
  Color whiteColor = Colors.white;
  Color blackColor = Colors.black87;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade600)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.api,
                                color: whiteColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'خوش آمدید',
                                style: TextStyle(color: yelooColor),
                              ),
                              Spacer(),
                            ],
                          ),
                          Text(
                            'لیست کالاهای موجود',
                            style: TextStyle(color: whiteColor, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: blackColor,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.info_outline,
                            color: yelooColor,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.sort_sharp,
                      color: whiteColor,
                    ),
                    Text(
                      'ترتیب نمایش',
                      style: TextStyle(color: whiteColor),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: yelooColor, shape: BoxShape.circle),
                      child: Text('2'),
                    ),
                    Icon(Icons.filter_alt_outlined, color: whiteColor),
                    Text(
                      'فیلتر',
                      style: TextStyle(color: whiteColor),
                    ),
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                  ],
                ),
                myCard(
                  title: 'سکه تمام بهار آزادی - طرح امامی',
                  price: '34/500/000',
                  price_Change: '975/000',
                  color: Colors.green,
                  src: '',
                ),
                myCard(
                  title: 'سکه تمام بهار آزادی - طرح جدید',
                  price: '32/500/000',
                  price_Change: '850/000',
                  color: Colors.red,
                  src: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class myCard extends StatelessWidget {
  const myCard({
    super.key,
    required this.color,
    required this.price,
    required this.price_Change,
    required this.title,
    required this.src,
  });

  final Color color;
  final String price, price_Change, title, src;

  @override
  Widget build(BuildContext context) {
    Color yelooColor = Colors.yellowAccent;
    Color whiteColor = Colors.white;
    Color blackColor = Colors.black87;
    return Card(
      color: blackColor,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'قیمت / تومان',
                        style: TextStyle(color: yelooColor),
                      ),
                      Text(
                        price,
                        style: TextStyle(color: yelooColor, fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      //! با دادن ادرس عکس این کامنت رو غیر فعال کنید
                      // image: DecorationImage(image: AssetImage(src)),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            color: Colors.blueGrey,
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(color: whiteColor, fontSize: 20),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text('سکه - نیم سکه',
                      style: TextStyle(color: whiteColor)),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(children: [
                  Text(
                    'تغییر قیمت',
                    style: TextStyle(color: whiteColor),
                  ),
                  Spacer(),
                  Text(
                    'واحد + موجودی کالا',
                    style: TextStyle(color: whiteColor),
                  ),
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(5)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                        child: Icon(
                          Icons.keyboard_double_arrow_down,
                          color: whiteColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        price_Change,
                        style: TextStyle(color: color, fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        'به صورت یک جا',
                        style: TextStyle(color: whiteColor, fontSize: 20),
                      ),
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
