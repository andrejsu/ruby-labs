class User < ApplicationRecord
  has_many :reports

  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 150 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  def format_user
    "#{first_name} #{last_name} [#{email}]"
  end
end
