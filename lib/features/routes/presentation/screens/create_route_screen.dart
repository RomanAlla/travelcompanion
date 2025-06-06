import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelcompanion/core/router/router.dart';
import 'package:travelcompanion/features/auth/presentation/providers/auth_provider.dart';
import 'package:travelcompanion/features/routes/data/models/interesting_point_model.dart';
import 'package:travelcompanion/features/routes/presentation/providers/interesting_route_points_repository_provider.dart';
import 'package:travelcompanion/features/routes/presentation/providers/map_state.dart';
import 'package:travelcompanion/features/routes/presentation/providers/route_repository_provider.dart';
import 'package:travelcompanion/features/routes/presentation/providers/routes_list_provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

@RoutePage()
class CreateRouteScreen extends ConsumerStatefulWidget {
  const CreateRouteScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateRouteScreen> createState() => _CreateRouteScreenState();
}

class _CreateRouteScreenState extends ConsumerState<CreateRouteScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  String? _routeType;
  List<String> _coverImagePaths = [];
  Point? _selectedPoint;

  final List<String> _routeTypes = [
    "Тропики",
    "Острова",
    "Пещеры",
    "Особые",
  ];

  final List<Map<String, dynamic>> _routePoints = [];

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      setState(() {
        _coverImagePaths = images.map((image) => image.path).toList();
      });
    }
  }

  Future<void> createRoute() async {
    if (_selectedPoint == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('поставь точку')));
      return;
    }
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _startDate == null ||
        _endDate == null ||
        _coverImagePaths.isEmpty ||
        _routeType == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Заполни все данные')));
      return;
    }

    final userId = ref.watch(authProvider).user!.id;
    try {
      final route = await ref.read(routeRepositoryProvider).createRoute(
          userId: userId,
          name: _nameController.text,
          description: _descriptionController.text,
          longitude: _selectedPoint!.longitude,
          routeType: _routeType,
          latitude: _selectedPoint!.latitude);

      if (_coverImagePaths.isNotEmpty) {
        final files = _coverImagePaths.map((path) => File(path)).toList();
        await ref
            .read(routeRepositoryProvider)
            .updateRoutePhotos(id: route.id, files: files);
      }
      if (_routePoints.isNotEmpty) {
        final intRep = ref.read(interestingRoutePointsModelProvider);
        for (var point in _routePoints) {
          await intRep.createPoint(
              routeId: route.id,
              name: point['name'],
              description: point['description'],
              latitude: point['point'].latitude,
              longitude: point['point'].longitude);
        }
      }
      if (mounted) {
        ref.invalidate(routesListProvider);
        ref.invalidate(userRoutesListProvider);
        context.router.pushPath('user-routes');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mapControllerProvider);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Создать маршрут',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _coverImagePaths.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate,
                                  size: 48, color: Colors.grey[400]),
                              SizedBox(height: 8),
                              Text(
                                'Добавить фотографии',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                            ),
                            itemCount: _coverImagePaths.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Image.file(
                                    File(_coverImagePaths[index]),
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: IconButton(
                                      icon: Icon(Icons.close,
                                          color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          _coverImagePaths.removeAt(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Основная информация',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Название маршрута',
                        prefixIcon: const Icon(Icons.edit_location_alt_rounded,
                            color: Colors.black87),
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _descriptionController,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        labelText: 'Описание маршрута',
                        prefixIcon: const Icon(Icons.notes_rounded,
                            color: Colors.black87),
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Даты и тип',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickDate(isStart: true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      color: Colors.black87, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    _startDate != null
                                        ? _startDate!.toString().split(' ')[0]
                                        : 'Дата начала',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: _startDate != null
                                          ? Colors.black87
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickDate(isStart: false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      color: Colors.black87, size: 20),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      _endDate != null
                                          ? _endDate!.toString().split(' ')[0]
                                          : 'Дата окончания',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _endDate != null
                                            ? Colors.black87
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.white,
                          value: _routeType,
                          isExpanded: true,
                          hint: const Text('Тип местности маршрута'),
                          items: _routeTypes
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  ))
                              .toList(),
                          onChanged: (val) => setState(() => _routeType = val),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: pointAndTipsContainer(
                  context,
                  'Интересные точки',
                  Icons.location_on,
                  'Добавьте интересные точки маршрута',
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: pointAndTipsContainer(
                  context,
                  'Советы',
                  Icons.light,
                  'Добавьте советы путешественникам, чтобы им было легче',
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Точка на карте',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      state.placemarks.isEmpty
                          ? 'Нажмите на карту, чтобы поставить точку старта маршрута'
                          : 'Точка выбрана: ${state.placemarks.last.point.latitude.toStringAsFixed(5)}, ${state.placemarks.last.point.longitude.toStringAsFixed(5)}',
                      style: TextStyle(
                        color: state.placemarks.isEmpty
                            ? Colors.grey
                            : Colors.green,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        final result = await context.router.push<Point>(
                            SelectRoutePosOnMapRoute(
                                initialPoint: state.placemarks.isNotEmpty
                                    ? state.placemarks.last.point
                                    : null));
                        if (result != null) {
                          ref
                              .read(mapControllerProvider.notifier)
                              .clearPlacemarks();
                          ref.read(mapControllerProvider.notifier).addPlacemark(
                                PlacemarkMapObject(
                                  mapId: MapObjectId(
                                      '${result.latitude}_${result.longitude}_${DateTime.now().millisecondsSinceEpoch}'),
                                  point: result,
                                  icon: PlacemarkIcon.single(
                                    PlacemarkIconStyle(
                                      image: BitmapDescriptor.fromAssetImage(
                                          'lib/core/images/marker.png'),
                                      scale: 0.5,
                                    ),
                                  ),
                                ),
                              );
                          setState(() {
                            _selectedPoint = result;
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: Container(
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: YandexMap(
                              mapObjects: state.placemarks,
                              onMapCreated: (controller) {
                                if (state.placemarks.isNotEmpty) {
                                  controller.moveCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                          target: state.placemarks.last.point,
                                          zoom: 12),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF6C5CE7).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: createRoute,
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline,
                              color: Colors.white, size: 24),
                          SizedBox(width: 8),
                          Text(
                            'Сохранить маршрут',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget pointAndTipsContainer(
      BuildContext context, String title, IconData icon, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final pointDetails = await context.router
                    .pushPath<InterestingPointModel?>('point-selection');

                if (pointDetails != null && context.mounted) {
                  setState(() {
                    _routePoints.add({
                      'name': pointDetails.name,
                      'description': pointDetails.description,
                      'point': pointDetails.point,
                    });
                  });
                }
              },
              icon: const Icon(Icons.add, color: Colors.black87),
              label: const Text(
                'Добавить',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_routePoints.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Icon(icon, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 8),
                  Text(
                    textAlign: TextAlign.center,
                    text,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _routePoints.length,
            itemBuilder: (context, index) {
              final point = _routePoints[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF6C5CE7).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: Colors.black87),
                  ),
                  title: Text(
                    point['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    point['description'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black87),
                        onPressed: () => _showEditPointDialog(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deletePoint(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  void _showEditPointDialog(int index) {
    final point = _routePoints[index];
    final nameController = TextEditingController(text: point['name']);
    final descriptionController =
        TextEditingController(text: point['description']);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Редактировать точку',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Название',
                  prefixIcon: Icon(Icons.title, color: Colors.black87),
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Описание',
                  prefixIcon: Icon(Icons.description, color: Colors.black87),
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Отмена'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        setState(() {
                          _routePoints[index] = {
                            ...point,
                            'name': nameController.text,
                            'description': descriptionController.text,
                          };
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6C5CE7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Сохранить'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deletePoint(int index) {
    setState(() {
      _routePoints.removeAt(index);
    });
  }
}
