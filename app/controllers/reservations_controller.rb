class ReservationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_reservations, only: %i[index]

    def index 
    end

    private 

    def set_reservations
        @reservations = current_user.reservations.order(created_at: :desc)
    end
end