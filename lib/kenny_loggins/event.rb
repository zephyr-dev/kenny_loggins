module KennyLoggins
  class Event < ApplicationModel
    belongs_to :application
    validate :application, presence: true
  end
end
