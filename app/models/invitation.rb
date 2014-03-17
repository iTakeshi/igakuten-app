
class Invitation
  include ActiveModel::Model

  attr_accessor :email

  validates :email,
    presence: true,
    format: { with: /[^\s@]+@[^\s@]+/ }

  def exec
    # WIP
  end
end
