package com.udea.modulo_pagos.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="booking")
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private boolean is_paid;
    private Double additional_charge;
    private byte status;
    @Column
    private Float price;


    public Booking(Long id, boolean is_paid, float price) {
        this.id = id;
        this.is_paid = is_paid;
        this.price = price;
        this.additional_charge= price*0.1;
    }

    @ManyToOne
    @JoinColumn(name="user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "departure_flight_id")
    private Flight departureFlight;

    @ManyToOne
    @JoinColumn(name = "return_flight_id")
    private Flight returnFlight;

    public Booking(){

    }

    public FlightInfo getFlightInfo() {
        FlightInfo flightInfo = new FlightInfo();
        flightInfo.setDepartureFlight(this.departureFlight);
        flightInfo.setReturnFlight(this.returnFlight);
        return flightInfo;
    }
}


