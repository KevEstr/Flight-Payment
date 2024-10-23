package com.udea.modulo_pagos.service;

import com.udea.modulo_pagos.entities.Booking;
import com.udea.modulo_pagos.entities.PaymentMethod;

import java.util.List;

public interface IBookingService {

    Booking getBookingById(Long booking_id);

    Booking updateBookingStatus(Long bookingId, boolean isPaid);

    List<Booking>  getAllUserBookings(Long user_id);

    List<Booking> getAllBookings();
}
