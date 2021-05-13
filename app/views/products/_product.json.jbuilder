json.(product, :id, :name, :description, :price)
json.image_url polymorphic_url(product.image) if product.image.attached?