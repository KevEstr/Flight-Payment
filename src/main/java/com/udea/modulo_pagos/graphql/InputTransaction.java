package com.udea.modulo_pagos.graphql;

import com.udea.modulo_pagos.entities.Booking;
import com.udea.modulo_pagos.entities.Payment;
import com.udea.modulo_pagos.entities.PaymentMethod;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Data
public class InputTransaction {
    private Long booking_id;
    private Long gateway_payment_id;
}
