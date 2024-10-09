package com.udea.modulo_pagos.entities;

import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FlightInfo {
    private Flight departureFlight;
    private Flight returnFlight;

    public FlightInfo() {
    }
}
