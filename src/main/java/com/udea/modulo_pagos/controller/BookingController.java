package com.udea.modulo_pagos.controller;

import com.udea.modulo_pagos.entities.Booking;
import com.udea.modulo_pagos.entities.Payment;
import com.udea.modulo_pagos.graphql.InputPayment;
import com.udea.modulo_pagos.service.IBookingService;
import com.udea.modulo_pagos.service.IPaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller

public class BookingController {

    @Autowired
    private IBookingService bookingService;

    @QueryMapping
    public List<Booking> getAllUserBookings(@Argument Long user_id) {
        return bookingService.getAllUserBookings(user_id);
    }

    @QueryMapping
    public Booking getBookingById(@Argument Long booking_id) {
        return bookingService.getBookingById(booking_id);
    }

    @QueryMapping
    public List<Booking> getAllBookings() {
        return bookingService.getAllBookings();
    }
}
