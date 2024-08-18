

import 'package:buyble_real/src/model/post_model.dart';
import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:buyble_real/src/utils/util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Detail extends StatefulWidget {
  // Map<String, String> oneData;
  PostModel postInfo;
  Detail({Key? key, required this.postInfo
    // , required this.oneData
  }) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> with SingleTickerProviderStateMixin {
  late Size size;
  final CarouselController _controller = CarouselController();
  int _current = 0;
  String longText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  Util util = Util();
  late AnimationController _animationController;
  late Animation _colorTween;
  double alphaValue = 0;
  final ScrollController _scrollController = ScrollController();
  bool isFav = false;
  // ContentsRepository contentsRepo = ContentsRepository();
  late List<dynamic> favList;


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(vsync: this);
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);

    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset > 255) {
          alphaValue = 255;
        } else {
          alphaValue = _scrollController.offset;
        }
        _animationController.value = alphaValue/255;
      });
    });
    // _loadFavList();
  }

  // _loadFavList() async {
  //   List<dynamic> output = await contentsRepo.loadFavList();
  //   setState(() {
  //     favList = output;
  //     if( output != null && output is List ){
  //       for( dynamic data in output){
  //         if( data["cid"] == widget.oneData["cid"] ){
  //           isFav = true;
  //         }
  //       }
  //     }
  //   });
  // }

  AnimatedBuilder _makeIcon( IconData iconName ){
    return AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) => Icon(iconName, color: _colorTween.value,));
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.white.withAlpha(alphaValue.toInt()),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: _makeIcon(Icons.arrow_back),
        color: Colors.white,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: _makeIcon(Icons.share),
          color: Colors.white,
        ),
        IconButton(
          onPressed: () {},
          icon: _makeIcon(Icons.more_vert),
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _slideImage() {
    return Stack(
      children: [
        // Hero(
          // tag: widget.oneData["cid"] as String,
          // child:
          CarouselSlider(
            items: widget.postInfo.photoUrls?.map((url) {
              return Image.network(
                url,
                fit: BoxFit.cover,
                width: size.width,
              );
            }).toList(),
            carouselController: _controller,
            options: CarouselOptions(
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                height: size.width,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        // ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.postInfo.photoUrls!.asMap().entries.map((entry) {
              return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 10.0,
                    height: 8.0,
                    margin:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                    ),
                  ));
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _sellerProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Container(
        width: size.width,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: Image.asset('assets/images/default_image.png').image,
            ),
            SizedBox(
              width: 5,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Strong Man",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("west 121st Street"),
              ],
            ),
            // MannerTemp(temp: 55),
          ],
        ),
      ),
    );
  }

  Widget _line() {
    return Container(
      height: 1,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey.withOpacity(0.2),
    );
  }

  Widget _itemInfo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(

            widget.postInfo.title.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "남성패션/잡화·Boosted 57 min. ago",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(util.descriptionConverter(widget.postInfo.description.toString())),
          SizedBox(
            height: 10,
          ),
          Text(
            "1 chat·248 views",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Report this listing",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF706F6F),
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _otherItems() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Other items by Strong Man",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Icon(Icons.arrow_right_outlined),
        ],
      ),
    );
  }

  Widget _body() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _slideImage(),
              _sellerProfile(),
              _line(),
              _itemInfo(),
              _line(),
              _otherItems(),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
              delegate: SliverChildListDelegate(
                List.generate(
                    10,
                        (index) => Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.grey,
                              height: 100,
                              child: Image.network(
                                "https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E",
                                fit: BoxFit.fitWidth,
                                width: 160,
                                height: 100,
                              ),
                            ),
                          ),
                          Text(
                            // widget.oneData["title"].toString(),
                            "Title",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          Text(Util.numToDol(
                              // widget.oneData["price"].toString()
                            "30"
                          )),
                        ],
                      ),
                    )).toList(),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10)),
        )
      ],
    );
  }

  Widget _bottom() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 55,
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.all(8),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    isFav = !isFav;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(milliseconds: 1000),
                        content: Text(isFav == true ?   "Added to the cart" :"Removed from the cart"),
                      )
                  );
                  // if( isFav == true ){
                  //   contentsRepo.addFavList(widget.oneData);
                  // }else{
                  //   contentsRepo.deleteFavList(widget.oneData["cid"].toString());
                  // }



                },
                child: SvgPicture.asset(isFav == true ?
                "assets/svg/heart_on.svg" : "assets/svg/heart_off.svg",
                  width: 20,
                  color:  BuybleColor.colorList[2],
                ),
              )),
          Container(
            width: 1,
            color: Colors.grey.withOpacity(0.4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          ),
          Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                Util.numToDol(
                  // widget.oneData["price"].toString(),
                  "30"
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              Text(
                "Fixed Price",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    color: BuybleColor.colorList[2],
                    child: Text(
                      "Make an Offer",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottom(),
    );
  }
}
