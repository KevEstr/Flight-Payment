package com.udea.modulo_pagos.repositories;

import com.udea.modulo_pagos.entities.Payment;
import com.udea.modulo_pagos.entities.PaymentMethodXUser;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IPaymentMethodXUserRepository extends CrudRepository<PaymentMethodXUser, Long> {

    List<PaymentMethodXUser> findByUserId(Long userId);

}
