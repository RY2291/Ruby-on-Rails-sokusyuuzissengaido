class Task < ApplicationRecord
  # before_validation :set_nameless_name

  validates :name, presence: true, length: { maximum: 30 }
  validate :validete_name_not_incliding_comma

  belongs_to :user

  private
  def validete_name_not_incliding_comma
    errors.add(:name, "カンマを含めることはできません") if name&.include?(",")
  end

  # def set_nameless_name
  #   self.name = "名前なし" if name.blank?
  # end

end
