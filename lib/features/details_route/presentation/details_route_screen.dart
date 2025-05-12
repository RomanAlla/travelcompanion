import 'package:flutter/material.dart';

class DetailsRouteScreen extends StatelessWidget {
  final String routeId;
  const DetailsRouteScreen({super.key, required this.routeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 40,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black87),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 40,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          child: IconButton(
                            icon: Icon(Icons.favorite_border,
                                color: Colors.redAccent),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          child: IconButton(
                            icon: Icon(Icons.ios_share, color: Colors.black87),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
            collapsedHeight: 80,
            toolbarHeight: 0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Маршрут по тропикам Бали',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 22),
                      SizedBox(width: 4),
                      Text('4.9',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(width: 6),
                      Text('120 отзывов',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 15)),
                      SizedBox(width: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('Тропики',
                            style: TextStyle(
                                color: Colors.green[900],
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  _AuthorCard(),
                  SizedBox(height: 18),
                  _InfoRow(),
                  SizedBox(height: 18),
                  _SectionCard(
                    title: 'Описание маршрута',
                    child: Text(
                      'Этот маршрут проведет вас по самым живописным местам Бали: водопады, рисовые террасы, пляжи и скрытые тропы. Подходит для любителей природы и активного отдыха.',
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                  SizedBox(height: 18),
                  _SectionCard(
                    title: 'Карта маршрута',
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text('Карта маршрута (заглушка)',
                            style: TextStyle(color: Colors.grey[600])),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  _SectionCard(
                    title: 'Точки маршрута',
                    child: Column(
                      children: [
                        _RoutePointPhotoCard(
                          title: 'Водопад Секумпул',
                          description: 'Один из самых красивых водопадов Бали',
                          photos: [
                            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
                            'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
                          ],
                        ),
                        _RoutePointPhotoCard(
                          title: 'Рисовые террасы Тегаллаланг',
                          description: 'Знаменитые рисовые поля',
                          photos: [],
                        ),
                        _RoutePointPhotoCard(
                          title: 'Пляж Баланган',
                          description: 'Идеальное место для заката',
                          photos: [
                            'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=400&q=80',
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  _SectionCard(
                    title: 'Галерея',
                    child: SizedBox(
                      height: 110,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _GalleryImage(
                              url:
                                  'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80'),
                          _GalleryImage(
                              url:
                                  'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80'),
                          _GalleryImage(
                              url:
                                  'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=400&q=80'),
                          _GalleryImage(
                              url:
                                  'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  _SectionCard(
                    title: 'Советы и лайфхаки',
                    child: Column(
                      children: [
                        _TipTile(
                            text:
                                'Возьмите с собой удобную обувь и запас воды.'),
                        _TipTile(
                            text:
                                'Лучшее время для посещения водопада — утро.'),
                        _TipTile(text: 'Не забудьте солнцезащитный крем.'),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  _SectionCard(
                    title: 'Отзывы',
                    child: Column(
                      children: [
                        _ReviewTile(
                          avatarUrl:
                              'https://randomuser.me/api/portraits/women/44.jpg',
                          name: 'Мария',
                          rating: 5,
                          text:
                              'Очень красивый маршрут! Всё понравилось, особенно водопады.',
                        ),
                        _ReviewTile(
                          avatarUrl:
                              'https://randomuser.me/api/portraits/men/45.jpg',
                          name: 'Алексей',
                          rating: 4,
                          text:
                              'Интересные места, но некоторые участки сложные для детей.',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF385C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {},
                      child: Text('Пройти маршрут',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _AuthorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
            radius: 28,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Иван Путешественник',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                SizedBox(height: 2),
                Text('Автор маршрута',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 4),
                    Text('4.8', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Text('5 маршрутов',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.verified, color: Color(0xFFFF385C)),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _InfoIconText(icon: Icons.directions_walk, label: 'Средняя сложность'),
        _InfoIconText(icon: Icons.calendar_month, label: 'Май-сентябрь'),
        _InfoIconText(icon: Icons.timer, label: '2-3 дня'),
        _InfoIconText(icon: Icons.map, label: '45 км'),
      ],
    );
  }
}

class _InfoIconText extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoIconText({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Color(0xFFFF385C), size: 22),
        ),
        SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
      ],
    );
  }
}

class _RoutePointPhotoCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> photos;
  const _RoutePointPhotoCard(
      {required this.title, required this.description, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          if (description.isNotEmpty) ...[
            SizedBox(height: 4),
            Text(description,
                style: TextStyle(color: Colors.grey[700], fontSize: 14)),
          ],
          SizedBox(height: 10),
          if (photos.isNotEmpty)
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(photos[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
          else
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child:
                    Text('Нет фото', style: TextStyle(color: Colors.grey[500])),
              ),
            ),
        ],
      ),
    );
  }
}

class _GalleryImage extends StatelessWidget {
  final String url;
  const _GalleryImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _TipTile extends StatelessWidget {
  final String text;
  const _TipTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.amber, size: 20),
          SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final int rating;
  final String text;
  const _ReviewTile(
      {required this.avatarUrl,
      required this.name,
      required this.rating,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundImage: NetworkImage(avatarUrl), radius: 22),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Row(
                      children: List.generate(
                        rating,
                        (index) =>
                            Icon(Icons.star, color: Colors.amber, size: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
