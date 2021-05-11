json.id product_category.id
json.title product_category.title

json.products product_category.products, partial: 'products/product', as: :product