class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings_as_guest
  end

  def create
    @listing = Listing.find(params[:booking][:listing_id])
    @booking = current_user.bookings_as_guest.new(booking_params)
    
    ActiveRecord::Base.transaction do
      begin
        @booking.save!
        @booking.update!(checkout_url: @booking.checkout_session_url)
        redirect_to @booking.checkout_url, allow_other_host: true, status: :see_other
      rescue
        flash[:errors] = @booking.errors.full_messages
        render :new, status: :unprocessable_entity
      end
    end
  end

  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:listing_id, :start_date, :end_date, :guests)
  end
end
