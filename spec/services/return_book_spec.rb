require 'rails_helper'

RSpec.describe ReturnBook do
    let!(:admin_user) { create(:user, is_admin: true) }
    let(:return_book) { described_class.new(reservation).perform }

    describe "#perform" do
        context "on active reservation" do
            let(:reservation) { create(:reservation) }

            before do
                return_book
            end
            it "a return date is set" do
                aggregate_failures do
                    expect(return_book.success?).to eq(true)
                    expect(reservation.returned_on).to eq(Date.today)
                    expect(SendEndingReservationEmailJob).to have_enqueued_sidekiq_job(reservation.user_id, admin_user.id, reservation.book_id)
                end
            end
        end

        context "on closed reservation" do
            let(:reservation) { create(:reservation, returned_on: Date.today) }

            before do
                return_book
            end
            it "the return date cannot be revised" do
                aggregate_failures do
                    expect(return_book.success?).to eq(false)
                    expect(reservation.returned_on).to eq(Date.today)
                    expect(SendEndingReservationEmailJob).not_to have_enqueued_sidekiq_job(any_args)
                    expect(*return_book.errors).to eq("Returned on cannot be revised.")
                end
            end
        end
    end
end