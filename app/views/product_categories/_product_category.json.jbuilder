json.(product_category, :id, :title)

json.products product_category.products, partial: 'products/product', as: :product