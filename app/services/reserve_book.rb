class ReserveBook
    Result = Struct.new(:success?, :reservation, :errors, :book, keyword_init: true)

    def initialize(user, book)
        @book = book
        @user = user
    end

    def perform
       reservation = Reservation.create!(book: book, user: user) 
       send_reservation_notification(reservation)

       Result.new({success?: true, reservation: reservation})
    rescue ActiveRecord::RecordInvalid => error
        Result.new({success?: false, errors: error.record.errors.full_messages, book: book})
    end

    private 

    def send_reservation_notification(reservation)
        User.admin_users.each do |admin|
            SendNewReservationEmailJob.perform_async(reservation.user_id, admin.id, reservation.book_id)
        end
    end

    attr_reader :book, :user
end