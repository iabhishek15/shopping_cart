class Product < ApplicationRecord
  has_one_attached :product_image

  validates :name, presence: true

  validate :acceptable_image

  def acceptable_image
    unless product_image.attached?
      return errors.add(:product_image, " is Required")
    end

    unless product_image.byte_size <= 20.megabyte
      errors.add(:product_image, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(product_image.content_type)
      errors.add(:product_image, "must be a JPEG or PNG")
    end
  end
end
