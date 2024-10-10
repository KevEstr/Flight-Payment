package com.udea.modulo_pagos.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Table(name="flight_info")
@Entity
public class FlightInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "booking_id")
    @JsonBackReference
    private Booking booking;

    @ManyToOne
    @JoinColumn(name = "flight_id")
    private Flight flight;

    public FlightInfo() {
    }
}
