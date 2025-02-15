package com.udea.modulo_pagos.repositories;

import com.udea.modulo_pagos.entities.PaymentMethod;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IPaymentMethodRepository extends CrudRepository<PaymentMethod, Long> {
}
