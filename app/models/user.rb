# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timetable, :trackable and :omniauthable
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :omniauthable
  )

  # associations
  has_one :profile, inverse_of: :user, dependent: :destroy

  accepts_nested_attributes_for :profile, allow_destroy: true

  # Validations
  validates :email, presence: true
  validates :password, presence: true, on: :create

  def full_name
    "#{profile.first_name} #{profile.last_name}"
  end
end
