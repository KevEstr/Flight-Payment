package com.udea.modulo_pagos.repositories;

import com.udea.modulo_pagos.entities.Booking;
import com.udea.modulo_pagos.entities.PaymentMethodXUser;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface IBookingRepository extends CrudRepository<Booking, Long> {
    List<Booking> findByUserId(Long user_id);
}
