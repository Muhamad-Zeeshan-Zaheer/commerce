class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :category
  before_create :set_expiry_date
  before_validation :set_default_name
  after_validation :log_validation_errors
  before_save :capitalize_name
  around_create :track_create_time
  after_save :clear_cache
  validates :name, presence: true  # Ensures that name cannot be blank

  private

  def set_default_name
    self.name = "Default" if self.name.blank?
  end

  def set_expiry_date
    self.expires_on = Date.today + 30.days
  end

  def capitalize_name
    self.name = name.capitalize
  end

  def track_create_time
    start_time = Time.now
    yield  # This runs the actual create operation
    end_time = Time.now
    Rails.logger.info("Create completed in #{end_time - start_time} seconds")
  end




  def log_validation_errors
    Rails.logger.error("Validation errors: #{errors.full_messages.join(', ')}") if errors.any?
  end
end
