json.(restaurant, 
  :id, :name, :description, :delivery_tax, :city, 
  :street, :neighborhood, :number, :complement)

json.category_title restaurant.category.title
json.image_url polymorphic_url(restaurant.image) if restaurant.image.attached?

json.product_categories restaurant.product_categories, partial: 'product_categories/product_category', as: :product_category