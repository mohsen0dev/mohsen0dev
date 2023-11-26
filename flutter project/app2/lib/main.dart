import 'package:app2/carsoul/carousel_slider.dart';
import 'package:app2/data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final primeryTextColoro = Color(0xff0D253C);
    final secendaryTextColoro = Color(0xff2D4379);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: TextTheme(
              bodyMedium: TextStyle(
                  fontSize: 18,
                  fontFamily: 'avenir',
                  color: secendaryTextColoro),
              titleLarge: TextStyle(
                  fontFamily: 'avenir',
                  fontWeight: FontWeight.w800,
                  color: primeryTextColoro)),
        ),
        home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Story = AppDatabase.stories;
    final category = AppDatabase.categories;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          label: 'home',
          icon: Icon(Icons.abc),
        ),
        BottomNavigationBarItem(
          label: 'search',
          icon: Icon(Icons.abc),
        )
      ]),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24, top: 16),
                  //! appbar
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hi, Jonathan!'),
                      Image.asset(
                        'assets/img/icons/notification.png',
                        height: 32,
                      ),
                    ],
                  ),
                ),
                //! exprore text
                Text(
                  'Explore today’s',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                sizedBox(),
                //! story
                StoryList(Storyy: Story),
                sizedBox(),
                //! category
                CategoryList(category: category),
                sizedBox(),
                //! news text
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest News',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        child: Text('More'),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                NewsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox sizedBox([double? size = 16]) {
    return SizedBox(
      height: size,
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 24),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // color: Colors.amber,
      ),
      child: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(12)),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BIG DATA',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(color: Colors.blue.shade700, fontWeightDelta: 6),
              ),
              Wrap(children: [
                Text(
                  'Why Big Data Needs \nThick Data?',
                ),
              ]),
            ],
          )
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.category,
  });

  final List<Category> category;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: category.length,
        itemBuilder: (context, index, realIndex) {
          final categoryItem = category[index];
          return Stack(
            children: [
              Positioned.fill(
                  top: 100,
                  right: 65,
                  left: 65,
                  bottom: 20,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 0),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(blurRadius: 20, color: Color(0xaa0d253c)),
                    ]),
                  )),
              Positioned(
                child: Container(
                  // margin: EdgeInsets.fromLTRB(8, 8, 10, 8),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(32)),
                  foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: LinearGradient(
                          colors: [Color(0xaa0D253C), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.center)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      'assets/img/posts/large/${categoryItem.imageFileName}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 34,
                  left: 24,
                  child: Text(
                    categoryItem.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: Colors.white),
                  ))
            ],
          );
        },
        options: CarouselOptions(
            viewportFraction: 0.8,
            // height: 150,
            padEnds: false,
            // enableInfiniteScroll: false,
            aspectRatio: 1.2,
            // autoPlay: true,
            disableCenter: true,
            enlargeCenterPage: true,
            pageSnapping: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale));
  }
}

class StoryList extends StatelessWidget {
  const StoryList({
    super.key,
    required this.Storyy,
  });

  final List<Story> Storyy;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 14),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Storyy.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    margin: EdgeInsets.all(8),
                    height: 68,
                    width: 68,
                    decoration: BoxDecoration(

                        // color: Colors.amber,
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade800,
                              Colors.lightBlue.shade200
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight)),
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          'assets/img/stories/${Storyy[index].imageFileName}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundImage: AssetImage(
                          'assets/img/icons/${Storyy[index].iconFileName}'),
                    ),
                  ),
                ],
              ),
              Text(
                AppDatabase.stories[index].name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        },
      ),
    );
  }
}
