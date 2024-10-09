package com.udea.modulo_pagos.graphql;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Data
public class InputPayment {
    private LocalDate date;
    private Integer total_paid;
    private Long transaction_id;
    private Long gateway_payment_id;
}


