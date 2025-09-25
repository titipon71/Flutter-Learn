import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_app/screens/navbar2_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:my_app/assets/widgets/example_sidebarx.dart';

final List<String> imgList = [
  'lib/assets/images/welcome.png',
  'lib/assets/images/99b.png',
];

final List<String> imgListmangapop = [
  'lib/assets/images/popular/I-made-a-Deal_1_1757569497.jpg',
  'lib/assets/images/popular/madam_1-(2)_1757569729.jpg',
  'lib/assets/images/popular/madam_1-(3)_1757569781.jpg',
  'lib/assets/images/popular/Untitled-1_1757570500.jpg',
  'lib/assets/images/popular/1.png',
];

final MyColor = Color(0xFFF6B606);

// หน้าจอหลักที่มี AppBar เป็นรูปภาพและเลื่อนภาพไปทางขวาแบบอัตโนมัติ
class Home2Screen extends StatefulWidget {
  const Home2Screen({super.key});

  @override
  State<Home2Screen> createState() => _Home2ScreenState();
}

// State ของ Home2Screen สำหรับควบคุม animation
class _Home2ScreenState extends State<Home2Screen>
    with SingleTickerProviderStateMixin {
  // สำหรับ carousel (ไม่ใช้ controller)
  int _current = 0;
  int _currentPopular = 0;
  // ตัวควบคุม animation
  late final AnimationController _AnimationController;
  // animation สำหรับเลื่อนตำแหน่ง alignment ของรูปภาพ
  late final Animation<double> _alignmentAnim;
  // controller ของ carousel (ใช้ controller)
  final CarouselSliderController _carouselCtrl = CarouselSliderController();
  final CarouselSliderController _carouselCtrlmangapop =
      CarouselSliderController();
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  @override
  void initState() {
    super.initState();
    // สร้าง AnimationController ให้วนซ้ำเรื่อยๆ (repeat)
    _AnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 50), // ระยะเวลา 50 วินาทีต่อรอบ
    )..repeat();
    // Tween สำหรับเลื่อน alignment จากซ้ายสุดไปขวาสุด
    _alignmentAnim = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _AnimationController, curve: Curves.linear),
    );
  }

  @override
  @override
  void dispose() {
    // ทำลาย controller เมื่อปิดหน้าจอ
    _AnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const Navbar2(),
      drawer: ExampleSidebarX(controller: _controller),
      body: SingleChildScrollView(
        // 👈 เพิ่มบรรทัดนี้
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            CarouselSlider(
              carouselController: _carouselCtrl,
              items: imgList
                  .map(
                    (p) => ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        p,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                viewportFraction: 0.9,
                padEnds: true,
                enlargeCenterPage: true,
                onPageChanged: (i, _) => setState(() => _current = i),
              ),
            ),
            const SizedBox(height: 8),
            AnimatedSmoothIndicator(
              activeIndex: _current,
              count: imgList.length,
              effect: const WormEffect(dotWidth: 8, dotHeight: 8 , activeDotColor: Color(0xFFF6B606)),
              onDotClicked: (i) => _carouselCtrl.animateToPage(i),
            ),
            const SizedBox(height: 16),

            // 👇 เพิ่ม widget ใต้ AnimatedSmoothIndicator
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFF6B606),
                  borderRadius: BorderRadius.circular(37),
                ),
                child: Wrap(
                  spacing: 20, // ระยะห่างแนวนอน
                  runAlignment: WrapAlignment.center, // จัดกลางในแนวตั้ง
                  crossAxisAlignment:
                      WrapCrossAlignment.center, // ✅ ดึง Text มาชิดกลางแกนตั้ง
                  alignment: WrapAlignment.center, // จัดกลางในแนวนอน
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text("โรแมนซ์"),
                    ),
                    const SizedBox(width: 1),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text("แอ็กชัน"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text("วาย"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            CarouselSlider(
              carouselController: _carouselCtrlmangapop,
              items: imgListmangapop
                  .map(
                    (p) => ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        p,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                viewportFraction: 0.9,
                padEnds: true,
                enlargeCenterPage: true,
                onPageChanged: (i, _) => setState(() => _currentPopular = i),
              ),
            ),
            const SizedBox(height: 8),
            AnimatedSmoothIndicator(
              activeIndex: _currentPopular,
              count: imgListmangapop.length,
              effect: const WormEffect(dotWidth: 8, dotHeight: 8, activeDotColor: Color(0xFFF6B606)),
              onDotClicked: (i) => _carouselCtrlmangapop.animateToPage(i),
            ),
            const SizedBox(height: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFF6B606),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "เรื่องแนะนำ!",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  Column(
                    children: [
                      Image.asset('lib/assets/images/manga/1.jpg', width: 150),
                      SizedBox(height: 8),

                      Text(
                        "Manga Name",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('lib/assets/images/manga/1.jpg', width: 150),
                      SizedBox(height: 8),
                      Text(
                        "Manga Name",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                  right: 8,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF6B606),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "อัปเดตล่าสุด!",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  Column(
                    children: [
                      Image.asset('lib/assets/images/manga/1.jpg', width: 150),
                      SizedBox(height: 8),

                      Text(
                        "Manga Name",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('lib/assets/images/manga/1.jpg', width: 150),
                      SizedBox(height: 8),
                      Text(
                        "Manga Name",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            //ปุ่มดูเพิ่มเติม
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Action when button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Color(0xFFF6B606)),
                    backgroundColor: Color.fromARGB(0, 0, 0, 0),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "ดูเพิ่มเติม",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
