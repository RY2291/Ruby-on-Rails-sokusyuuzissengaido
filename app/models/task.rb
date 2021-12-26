class Task < ApplicationRecord
  # before_validation :set_nameless_name

  validates :name, presence: true, length: { maximum: 30 }
  validate :validete_name_not_incliding_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  def self.csv_attributes
    ["name", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{ |attr| task.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.forseach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      taks.save!
    end
  end

  private
  def validete_name_not_incliding_comma
    errors.add(:name, "カンマを含めることはできません") if name&.include?(",")
  end

  # def set_nameless_name
  #   self.name = "名前なし" if name.blank?
  # end


  def self.ransackable_attributes(auth_objrct = nil)
    %w[name created_at]
  end

  def self.ransackable_associtations(auth_objrct = nil)
    []
  end

end
