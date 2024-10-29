package com.udea.modulo_pagos.repositories;

import com.udea.modulo_pagos.entities.PreferencePayment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IPreferencePaymentRepository extends JpaRepository<PreferencePayment, Long> {
    Optional<PreferencePayment> findByPaymentId(String paymentId);

    Optional<PreferencePayment> findByPreferenceId(String preferenceId);

    Optional<PreferencePayment> findByTransactionId(Long transactionId);

}

