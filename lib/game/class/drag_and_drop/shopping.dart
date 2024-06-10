class Product {
  final int price;
  final String image;

  Product({required this.price, required this.image});
}

List<Product> upper = [];
List<Product> lower = [];
List<Product> startLower = [
  Product(price: 5, image: "/images/item_store/food/item_store_017.png"),
  Product(price: 7, image: "/images/item_store/food/item_store_043.png"),
  Product(price: 8, image: "/images/item_store/food/item_store_044.png"),
  Product(price: 6, image: "/images/item_store/food/item_store_056.png"),
  Product(price: 10, image: "/images/item_store/food/item_store_057.png"),
  Product(price: 12, image: "/images/item_store/food/item_store_060.png"),
  Product(price: 15, image: "/images/item_store/food/item_store_062.png"),
  Product(price: 20, image: "/images/item_store/food/item_store_063.png"),
  Product(price: 9, image: "/images/item_store/food/item_store_067.png"),
  Product(price: 18, image: "/images/item_store/food/item_store_080.png"),
  Product(price: 22, image: "/images/item_store/food/item_store_085.png"),
  Product(price: 17, image: "/images/item_store/food/item_store_087.png"),
  Product(price: 11, image: "/images/item_store/food/item_store_089.png"),
  Product(price: 14, image: "/images/item_store/food/item_store_091.png"),
  Product(price: 19, image: "/images/item_store/food/item_store_093.png"),
  Product(price: 23, image: "/images/item_store/food/item_store_094.png"),
  Product(price: 13, image: "/images/item_store/food/item_store_095.png"),
  Product(price: 16, image: "/images/item_store/food/item_store_096.png"),
  Product(price: 21, image: "/images/item_store/food/item_store_097.png"),
  Product(price: 25, image: "/images/item_store/food/item_store_098.png"),
];

void loadProduct() {
  upper = [];
  lower = [];
  lower = startLower;
}

int balance = 100;
int lastbalance = 20;

