Product.destroy_all
ProductCategory.destroy_all
Restaurant.destroy_all
Category.destroy_all

MAIN_PATH = 'public/images'
CATEGORIES_PATH = "#{MAIN_PATH}/categories"
RESTAURANTS_PATH = "#{MAIN_PATH}/restaurants"
PRODUCTS_PATH = "#{MAIN_PATH}/products"

puts 'Cadastrando Categorias'

File.open('db/categories.txt').each_line do |line|
  title, path = line.strip.split('|')
  c = Category.find_or_create_by(title: title)
  c.image.attach(io: File.open("#{CATEGORIES_PATH}/#{path}"), filename: path)
end

puts 'Cadastrando Restaurantes'
11.times do |i|
  r = Restaurant.create_with(
    delivery_tax: Faker::Number.between(from: 1.0, to: 7.0).round(1),
    city: Faker::Address.city,
    street: Faker::Address.street_name,
    number: Faker::Address.building_number,
    neighborhood: Faker::Address.community,
    category_id: rand(1..5)
  ).find_or_create_by(
    name: Faker::Restaurant.name,
    description: Faker::Restaurant.description,
  )
  r.image.attach(io: File.open("#{RESTAURANTS_PATH}/#{i+1}.jpeg"), filename: "#{i+1}.jpeg")
end

puts 'Cadastrando categorias de produtos'
File.open('db/product_categories.txt').each_line do |line|
  title = line.strip
  ProductCategory.create(
    title: title,
    restaurant: Restaurant.order(Arel.sql('RANDOM()')).first
  )
end

puts 'Cadastrando produtos'
File.open('db/products.txt').each_line do |line|
  name, price, description, pc_id, path = line.strip.split('|')
  prod = Product.create(
    name: name,
    price: price,
    description: description,
    product_category_id: pc_id
  )
  prod.image.attach(io: File.open("#{PRODUCTS_PATH}/#{path}"), filename: path)
end