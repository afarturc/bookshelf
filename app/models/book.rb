class Book < ApplicationRecord
  enum genre: {
    software_engineering: 0,
    design: 1,
    project_management: 2,
    ruby: 3,
    rails: 4,
    elixir: 5,
    pheonix: 6,
    android: 7,
    ios: 8,
    finance: 9,
    productivity: 10,
    fantasy: 11
  }

  has_many :reservations, dependent: :destroy
  has_one :active_reservation, -> { active }, class_name: "Reservation"
  has_many :readers, through: :reservations, source: :user
  has_one :active_reader, through: :active_reservation, source: :user

  validates :title, :description, :cover_url, presence: true

  def available?
    active_reservation.blank?
  end

  def reserved?
    active_reservation.present?
  end
end
