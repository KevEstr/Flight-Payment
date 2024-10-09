package com.udea.modulo_pagos.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="flight")
@Getter
@Setter
public class Flight {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String departure_date;
    private String departure_time;
    private String arrival_time;
    private String departure_airport;
    private String arrival_airport;
    private String duration;
    private String flight_number;
    private String flight_class;
    private String stops;

}
