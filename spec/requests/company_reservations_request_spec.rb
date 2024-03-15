require 'rails_helper'

RSpec.describe "CompanyReservations", type: :request do
    context "#GET index" do
        context "when user is logged in" do
            include_context "with logged user"

            let!(:company_reservations) { create_list(:reservation, 3) }
            let!(:user_reservation) { create(:reservation, user: user) }

            it "returns the active company reservations" do
                get company_reservations_path

                aggregate_failures do
                    expect(response).to have_http_status(:ok)
                    expect(response.content_type).to eq("text/html; charset=utf-8")
                    expect(body).to include(*company_reservations.map(&:book).pluck(:title))
                    expect(body).not_to include(user_reservation.book.title)
                end
            end
        end

        context "when user is logged out" do 
            it "redirects to the sign in page" do
                get company_reservations_path
                
                aggregate_failures do
                    expect(response).to redirect_to(new_user_session_path)
                    expect(response).to have_http_status(:found)
                    expect(response.content_type).to eq("text/html; charset=utf-8")
                end
            end
        end
    end
end