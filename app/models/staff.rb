class Staff < ActiveRecord::Base
  validates :family_name do
    presence
  end
  validates :family_name_yomi do
    presence
  end
  validates :given_name do
    presence
  end
  validates :given_name_yomi do
    presence
  end
  validates :grade do
    presence
    numericality only_integer: true,
                 greater_than_or_equal_to: 1,
                 less_than_or_equal_to: 6
  end
  validates :gender do
    presence
    numericality only_integer: true,
                 greater_than_or_equal_to: 0,
                 less_than_or_equal_to: 1
  end
  validates :phone do
    presence
    uniqueness
    format with: /\d{2,4}-\d{2,4}-\d{4}/
  end
  validates :email do
    presence
    uniqueness
    format with: /[^\s@]+@[^\s@]+/
  end
  validates :email_verification_code do
    presence
    uniqueness
  end
end
