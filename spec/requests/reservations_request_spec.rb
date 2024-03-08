require 'rails_helper'

RSpec.describe Reservation, type: :request do
    describe "#GET index" do
        context "when user is logged in" do
            include_context "with logged user"

            before { create(:reservation, user: user) }

            it "returns existing user reservation collection" do
                get reservations_path

                aggregate_failures do
                    expect(response).to have_http_status(:ok)
                    expect(response.content_type).to eq("text/html; charset=utf-8")
                    expect(body).to include(*Reservation.find_by(user: user).book.title)
                end
            end
        end

        context "when user is logged out" do
            it "redirects to login" do
                get reservations_path

                aggregate_failures do
                    expect(response).to redirect_to(new_user_session_path)
                    expect(response).to have_http_status(:found)
                    expect(response.content_type).to eq("text/html; charset=utf-8")
                end
            end
        end
    end

    describe "#PATCH update" do
        context "when user is logged in" do
            include_context "with logged user"

            context "when reservation is active" do
                let(:reservation) { create(:reservation, user: user) }

                it "ends the reservation and sets the returned date" do
                    patch reservation_path(reservation.id)

                    aggregate_failures do
                        expect(reservation.reload.returned_on).not_to eq(nil)
                        expect(response).to have_http_status(:found)
                    end
                end
            end

            context "when reservation is inactive" do
                let(:reservation) { create(:reservation, returned_on: Date.today, user: user) }

                it "raises an exception" do
                    aggregate_failures do
                        expect { patch reservation_path(reservation.id) }.to raise_error(ActiveRecord::RecordNotFound)
                        expect(response).to have_http_status(:not_found)
                    end
                end
            end
        end

        context "when user is logged out" do
            let(:reservation) { create(:reservation) }

            it "redirects to login" do
                patch reservation_path(reservation.id)

                aggregate_failures do
                    expect(response).to redirect_to(new_user_session_path)
                    expect(response).to have_http_status(:found)
                    expect(response.content_type).to eq("text/html; charset=utf-8")
                end
            end
        end
    end
end