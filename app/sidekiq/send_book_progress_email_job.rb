class SendBookProgressEmailJob
    include Sidekiq::Job
    sidekiq_options queue: 'default'
  
    def perform(reservation_id)
        reservation = Reservation.find(reservation_id)
        UserMailer.with(recipient: reservation.user, book: reservation.book)
                    .reading_progress
                    .email_now
    end
end