class ApiKey < ApplicationRecord
  belongs_to :user, optional: true

  before_create :generate_access_token, :set_active

  private

  def generate_access_token
    begin
      self.access_token ||= SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

  def set_active
    self.active ||= true
  end
end
