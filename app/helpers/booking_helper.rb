module BookingHelper
  def booking_progress_bar_items(booking)
    if booking.grad_sitting?
      ['Information', 'Book', 'Finished']
    else
      ['Information', 'Book', 'Finished']
    end
  end
end
