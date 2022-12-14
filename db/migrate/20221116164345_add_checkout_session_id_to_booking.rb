# frozen_string_literal: true

class AddCheckoutSessionIdToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :checkout_session_id, :string
  end
end
