package com.udea.modulo_pagos.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="preference")
public class PreferencePayment {
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long id;

        private Long transactionId;    // ID de la transacción en tu sistema
        private String preferenceId;   // ID de la preferencia en Mercado Pago
        private String paymentId;
        private String status;

        public String getStatus() {
                return status;
        }

        public void setStatus(String status) {
                this.status = status;
        }

        public String getPaymentId() {
                return paymentId;
        }

        public void setPaymentId(String paymentId) {
                this.paymentId = paymentId;
        }

        public String getPreferenceId() {
                return preferenceId;
        }

        public void setPreferenceId(String preferenceId) {
                this.preferenceId = preferenceId;
        }

        public Long getId() {
                return id;
        }

        public void setId(Long id) {
                this.id = id;
        }

        public Long getTransactionId() {
                return transactionId;
        }

        public void setTransactionId(Long transactionId) {
                this.transactionId = transactionId;
        }
}

