package com.udea.modulo_pagos.entities;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

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
    @Column
    private Float price;

    public Booking(Long id, Double additional_charge, boolean is_paid, Float price, User user, List<FlightInfo> flight_infos) {
        this.id = id;
        this.additional_charge = additional_charge;
        this.is_paid = is_paid;
        this.price = price;
        this.user = user;
        this.flight_infos = flight_infos;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="user_id", nullable = false)
    @JsonManagedReference
    private User user;

    @OneToMany(mappedBy = "booking", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<FlightInfo> flight_infos;

    public User getUser() {
        return user;
    }

    public Booking(){

    }

}


