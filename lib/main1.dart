import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF00C853)); // เขียวโทน webtoon-ish
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ThaiWebToon (UI Clone)',
      theme: ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
      ),
      home: const RootScaffold(),
    );
  }
}

/// --------------------------- Root + Navigation ----------------------------
class RootScaffold extends StatefulWidget {
  const RootScaffold({super.key});
  @override
  State<RootScaffold> createState() => _RootScaffoldState();
}

class _RootScaffoldState extends State<RootScaffold> {
  int _index = 0;

  final _pages = const [
    HomePage(),
    GenresPage(),
    RankingPage(),
    LibraryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'หน้าหลัก'),
          NavigationDestination(icon: Icon(Icons.category_outlined), selectedIcon: Icon(Icons.category), label: 'หมวดหมู่'),
          NavigationDestination(icon: Icon(Icons.leaderboard_outlined), selectedIcon: Icon(Icons.leaderboard), label: 'แรงก์กิ้ง'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'คลัง'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'โปรไฟล์'),
        ],
      ),
    );
  }
}

/// ------------------------------- Mock Data --------------------------------
class Webtoon {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final double rating;
  final bool isNew;
  final bool isFree;

  const Webtoon({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.rating,
    this.isNew = false,
    this.isFree = false,
  });
}

final mockBanners = List.generate(
  4,
  (i) => 'https://picsum.photos/seed/banner$i/1200/500',
);

final mockToons = List.generate(
  16,
  (i) => Webtoon(
    id: 'toon_$i',
    title: 'ซีรีส์หมายเลข #$i',
    author: 'ผู้เขียน $i',
    coverUrl: 'https://picsum.photos/seed/cover$i/600/900',
    rating: 3.5 + (i % 5) * 0.3,
    isNew: i % 4 == 0,
    isFree: i % 3 == 0,
  ),
);

final mockGenres = [
  'โรแมนซ์','แอ็กชัน','สืบสวน','แฟนตาซี','คอมเมดี้',
  'ดราม่า','สยองขวัญ','ไลฟ์','ออฟฟิศ','โรงเรียน',
];

/// ------------------------------ Common Widgets ----------------------------
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onMore;
  const SectionHeader(this.title, {super.key, this.onMore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const Spacer(),
          if (onMore != null)
            TextButton(onPressed: onMore, child: const Text('ดูทั้งหมด')),
        ],
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final double rating;
  const RatingBadge(this.rating, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.star, size: 14, color: Colors.amber),
        const SizedBox(width: 2),
        Text(rating.toStringAsFixed(1), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final int count;
  final int index;
  const DotIndicator({super.key, required this.count, required this.index});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: active ? 18 : 8,
          decoration: BoxDecoration(
            color: active ? cs.primary : cs.outlineVariant,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

class WebtoonCard extends StatelessWidget {
  final Webtoon toon;
  final VoidCallback onTap;
  const WebtoonCard({super.key, required this.toon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 3/4,
                    child: Image.network(toon.coverUrl, fit: BoxFit.cover),
                  ),
                ),
                Positioned(top: 8, right: 8, child: RatingBadge(toon.rating)),
                if (toon.isNew)
                  Positioned(
                    left: 8, top: 8,
                    child: _chip('ใหม่', cs.primary, Colors.white),
                  ),
                if (toon.isFree)
                  Positioned(
                    left: 8, top: toon.isNew ? 36 : 8,
                    child: _chip('ฟรี', cs.secondary, Colors.white),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(toon.title, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700)),
          Text(toon.author, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _chip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(99)),
      child: Text(text, style: TextStyle(color: fg, fontWeight: FontWeight.w700)),
    );
  }
}

/// --------------------------------- Home -----------------------------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bannerCtrl = PageController(viewportFraction: 0.9);
  int _bannerIndex = 0;

  @override
  void dispose() {
    _bannerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: _SearchBar(),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          ],
        ),

        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 12),
              SizedBox(
                height: 170,
                child: PageView.builder(
                  controller: _bannerCtrl,
                  onPageChanged: (i) => setState(() => _bannerIndex = i),
                  itemCount: mockBanners.length,
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(mockBanners[i], fit: BoxFit.cover),
                          Positioned(
                            left: 12, bottom: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('โปรโมชั่น/อัปเดตล่าสุด', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DotIndicator(count: mockBanners.length, index: _bannerIndex),
              const SizedBox(height: 8),

              // Quick categories
              SizedBox(
                height: 40,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) => FilterChip(
                    label: Text(mockGenres[i]),
                    onSelected: (_) {},
                    selected: i == 0,
                    selectedColor: cs.primary.withOpacity(.15),
                    side: BorderSide(color: cs.outlineVariant),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: mockGenres.length,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),

        SliverToBoxAdapter(child: SectionHeader('อัปเดตวันนี้', onMore: () {})),
        _gridToons(mockToons.take(6).toList()),

        SliverToBoxAdapter(child: SectionHeader('มาแรง 🔥', onMore: () {})),
        _gridToons(mockToons.skip(6).take(8).toList()),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }

  Widget _gridToons(List<Webtoon> items) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: SliverGrid.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.56),
        itemBuilder: (_, i) => WebtoonCard(
          toon: items[i],
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DetailPage(toon: items[i]),
          )),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.outlineVariant),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.black54),
            const SizedBox(width: 8),
            const Expanded(child: Text('ค้นหาเรื่อง/ผู้เขียน', style: TextStyle(color: Colors.black54))),
            Icon(Icons.tune, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}

/// -------------------------------- Genres ----------------------------------
class GenresPage extends StatelessWidget {
  const GenresPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('หมวดหมู่')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 8, runSpacing: 8,
            children: mockGenres.map((g) =>
              ActionChip(label: Text(g), onPressed: () {})
            ).toList(),
          ),
          const SizedBox(height: 16),
          SectionHeader('รวมเรื่องตามหมวด'),
          GridView.builder(
            itemCount: mockToons.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.56),
            itemBuilder: (_, i) => WebtoonCard(
              toon: mockToons[i],
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailPage(toon: mockToons[i]),
              )),
            ),
          )
        ],
      ),
    );
  }
}

/// ------------------------------- Ranking ----------------------------------
class RankingPage extends StatefulWidget {
  const RankingPage({super.key});
  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> with SingleTickerProviderStateMixin {
  late final TabController _tab = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แรงก์กิ้ง'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [Tab(text: 'รายวัน'), Tab(text: 'รายสัปดาห์'), Tab(text: 'รายเดือน')],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: List.generate(3, (ti) => _rankingList(context, ti)),
      ),
    );
  }

  Widget _rankingList(BuildContext context, int tab) {
    final items = List.of(mockToons)..shuffle();
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final t = items[i];
        return ListTile(
          leading: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(t.coverUrl, width: 54, height: 72, fit: BoxFit.cover),
              ),
              Positioned(
                left: -4, top: -4,
                child: CircleAvatar(
                  radius: 12, backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text('${i+1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          title: Text(t.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Row(children: [
            const Icon(Icons.star, size: 16, color: Colors.amber),
            const SizedBox(width: 4),
            Text(t.rating.toStringAsFixed(1)),
          ]),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailPage(toon: t))),
        );
      },
    );
  }
}

/// -------------------------------- Library ---------------------------------
class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});
  @override
  Widget build(BuildContext context) {
    final tabs = ['ที่ชอบ', 'ประวัติ', 'ดาวน์โหลด'];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('คลังของฉัน'),
          bottom: TabBar(tabs: tabs.map((e) => Tab(text: e)).toList()),
        ),
        body: TabBarView(children: [
          _grid(mockToons.take(9).toList(), context),
          _history(context),
          _downloads(context),
        ]),
      ),
    );
  }

  Widget _grid(List<Webtoon> items, BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.56),
      itemBuilder: (_, i) => WebtoonCard(
        toon: items[i],
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DetailPage(toon: items[i]),
        )),
      ),
    );
  }

  Widget _history(BuildContext context) {
    final items = mockToons.take(8).toList();
    return ListView.separated(
      itemCount: items.length,
      padding: const EdgeInsets.all(12),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final t = items[i];
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
          leading: ClipRRect(borderRadius: BorderRadius.circular(8),
            child: Image.network(t.coverUrl, width: 48, height: 64, fit: BoxFit.cover)),
          title: Text(t.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: const Text('อ่านค้างที่ ตอนที่ 12'),
          trailing: FilledButton.tonal(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => ReaderPage(title: t.title)));
          }, child: const Text('อ่านต่อ')),
        );
      },
    );
  }

  Widget _downloads(BuildContext context) {
    return const Center(child: Text('ยังไม่มีดาวน์โหลด'));
  }
}

/// -------------------------------- Detail ----------------------------------
class DetailPage extends StatelessWidget {
  final Webtoon toon;
  const DetailPage({super.key, required this.toon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(toon.title)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(12),
                  child: Image.network(toon.coverUrl, width: 120, height: 160, fit: BoxFit.cover)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(toon.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text('โดย ${toon.author}', style: const TextStyle(color: Colors.black54)),
                    const SizedBox(height: 8),
                    Row(children: [
                      RatingBadge(toon.rating),
                      const SizedBox(width: 8),
                      if (toon.isNew) _pill('ใหม่', cs.primary),
                      if (toon.isFree) const SizedBox(width: 6),
                      if (toon.isFree) _pill('ฟรี', cs.secondary),
                    ]),
                    const SizedBox(height: 12),
                    Wrap(spacing: 6, runSpacing: -6, children: mockGenres.take(3).map((g) => Chip(label: Text(g))).toList()),
                  ]),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'คำโปรยเรื่องอย่างย่อ… ใช้ข้อความ mock เพื่อแสดงเลย์เอาต์ของหน้ารายละเอียด สามารถกดอ่านตอนล่าสุดหรือเริ่มตอนที่ 1 ได้',
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              Expanded(child: FilledButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ReaderPage(title: toon.title)));
              }, child: const Text('อ่านตอนล่าสุด'))),
              const SizedBox(width: 12),
              Expanded(child: FilledButton.tonal(onPressed: () {}, child: const Text('เริ่มตอนที่ 1'))),
            ]),
          ),
          const SizedBox(height: 16),
          const SectionHeader('ตอนทั้งหมด'),
          ListView.separated(
            itemCount: 20,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) => ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network('https://picsum.photos/seed/ep$i/300/200', width: 72, height: 48, fit: BoxFit.cover),
              ),
              title: Text('ตอนที่ ${i+1} • ชื่อตอน'),
              subtitle: const Text('อัปเดต • 12 นาทีที่แล้ว'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ReaderPage(title: '${toon.title} - ตอนที่ ${i+1}'))),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _pill(String text, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: ShapeDecoration(
      color: color.withOpacity(.15),
      shape: StadiumBorder(side: BorderSide(color: color)),
    ),
    child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
  );
}

/// -------------------------------- Reader ----------------------------------
class ReaderPage extends StatelessWidget {
  final String title;
  const ReaderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final images = List.generate(12, (i) => 'https://picsum.photos/seed/read$i/1080/1600');

    return Scaffold(
      appBar: AppBar(
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(bottom: 72 + MediaQuery.of(context).padding.bottom),
            itemCount: images.length,
            itemBuilder: (_, i) => Image.network(images[i], fit: BoxFit.cover),
          ),
          Positioned(
            left: 16, right: 16, bottom: 16 + MediaQuery.of(context).padding.bottom,
            child: Row(
              children: [
                Expanded(child: FilledButton.tonal(
                  onPressed: () {},
                  child: const Text('ตอนก่อนหน้า'),
                )),
                const SizedBox(width: 12),
                Expanded(child: FilledButton(
                  onPressed: () {},
                  child: const Text('ตอนถัดไป'),
                )),
              ],
            ),
          ),
          Positioned(
            right: 12, bottom: 92 + MediaQuery.of(context).padding.bottom,
            child: FloatingActionButton.small(
              heroTag: 'commentBtn',
              backgroundColor: cs.primary,
              foregroundColor: Colors.white,
              onPressed: () {},
              child: const Icon(Icons.mode_comment_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

/// -------------------------------- Profile ---------------------------------
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('โปรไฟล์')),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          ListTile(
            leading: CircleAvatar(
              radius: 28, backgroundColor: cs.primary.withOpacity(.2),
              child: const Icon(Icons.person, size: 28),
            ),
            title: const Text('ผู้ใช้ใหม่'),
            subtitle: const Text('อีเมล: user@example.com'),
            trailing: FilledButton.tonal(onPressed: () {}, child: const Text('แก้ไขโปรไฟล์')),
          ),
          const Divider(height: 24),
          _tile(Icons.bookmark_border, 'ที่บันทึกไว้', () {}),
          _tile(Icons.history, 'ประวัติการอ่าน', () {}),
          _tile(Icons.settings, 'การตั้งค่า', () {}),
          _tile(Icons.help_outline, 'ศูนย์ช่วยเหลือ', () {}),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _tile(IconData ic, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(ic),
      title: Text(text),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
