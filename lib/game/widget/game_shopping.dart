import 'package:flame/components.dart';
import 'package:flame/game.dart';

class GameShopping extends FlameGame {
  late List<SpriteComponent> productSprites;

  late double ScaleFactor = 2.0;
  late SpriteComponent background;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    background = SpriteComponent()
      ..sprite = await loadSprite('background/background_store.png')
      ..size = size;
    add(background);

    final products = [
      Product(name: "Áo thun nam", image: "item_store/food/item_store_017.png"),
      Product(name: "Quần jean nam", image: "item_store/food/item_store_043.png"),
      Product(name: "Giày thể thao", image: "item_store/food/item_store_044.png"),
      Product(name: "Túi xách nữ", image: "item_store/food/item_store_056.png"),
      Product(name: "Mũ nón", image: "item_store/food/item_store_057.png"),
      Product(name: "Đồng hồ", image: "item_store/food/item_store_060.png"),
      Product(name: "Điện thoại", image: "item_store/food/item_store_062.png"),
      Product(name: "Laptop", image: "item_store/food/item_store_063.png"),
      Product(name: "Áo thun nam", image: "item_store/food/item_store_067.png"),
      Product(name: "Quần jean nam", image: "item_store/food/item_store_080.png"),
      Product(name: "Giày thể thao", image: "item_store/food/item_store_085.png"),
      Product(name: "Túi xách nữ", image: "item_store/food/item_store_087.png"),
      Product(name: "Mũ nón", image: "item_store/food/item_store_089.png"),
      Product(name: "Đồng hồ", image: "item_store/food/item_store_091.png"),
      Product(name: "Điện thoại", image: "item_store/food/item_store_093.png"),
      Product(name: "Laptop", image: "item_store/food/item_store_094.png"), 
      Product(name: "Mũ nón", image: "item_store/food/item_store_095.png"),
      Product(name: "Đồng hồ", image: "item_store/food/item_store_096.png"),
      Product(name: "Điện thoại", image: "item_store/food/item_store_097.png"),
      Product(name: "Laptop", image: "item_store/food/item_store_098.png"), 
    ];

    productSprites = [];

    for (final product in products) {
      final sprite = await Sprite.load(product.image);
      final spriteComponent = SpriteComponent()
        ..sprite = sprite
        ..size = Vector2(53, 56)
        ..anchor = Anchor.center;

      // Thêm chức năng thu phóng cho hình ảnh (ví dụ: scale mỗi sản phẩm 50%)
      spriteComponent.scale = Vector2(ScaleFactor, ScaleFactor);

      productSprites.add(spriteComponent);
    }

    final screenWidth = size.x;
    final screenHeight = size.y;
    final numColumns = 4;
    final spacing = 10.0;
    final productWidth = productSprites.first.size.x * ScaleFactor; // Độ rộng sản phẩm sau khi scale
    final productHeight = productSprites.first.size.y * ScaleFactor; // Độ cao sản phẩm sau khi scale

    final totalWidth = numColumns * productWidth + (numColumns - 1) * spacing;
    final totalHeight = (productSprites.length / numColumns).ceil() * productHeight +
        ((productSprites.length / numColumns).ceil() - 1) * spacing;

    final offsetX = (screenWidth - totalWidth) / 5;
    final offsetY = (screenHeight - totalHeight) / 2;

    for (int i = 0; i < productSprites.length; i++) {
      final column = i % numColumns;
      final row = i ~/ numColumns;
      final productX = column * (productWidth + spacing) + spacing + offsetX;
      final productY = row * (productHeight + spacing) + spacing + offsetY;

      productSprites[i]
        ..x = productX
        ..y = productY;
    }
    
    productSprites.forEach(add);
  }
}

class Product {
  final String name;
  final String image;

  Product({required this.name, required this.image});
}
