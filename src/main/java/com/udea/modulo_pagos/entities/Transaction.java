package com.udea.modulo_pagos.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.graphql.data.method.annotation.SchemaMapping;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@Table(name="transaction")
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private byte status;
    private LocalDate date;
    private Long total_price;

    @ManyToOne
    @JoinColumn(name="booking_id", nullable = false)
    private Booking booking;

    @ManyToOne
    @JoinColumn(name="payment_method_id", nullable = false)
    private PaymentMethod payment_method;

    @ManyToOne
    @JoinColumn(name="gateway_payment_id", nullable = false)
    private GatewayPayment gateway_payment;

    public Transaction(Long id, byte status, LocalDate date, Booking booking, PaymentMethod payment_method) {
        this.id = id;
        this.status = status;
        this.date = date;
        this.booking = booking;  // Relación con Booking
        this.payment_method = payment_method;  // Relación con Payment

    }

    public Transaction (){

    }
}
