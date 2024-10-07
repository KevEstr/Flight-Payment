package com.udea.modulo_pagos.utils;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.testcontainers.containers.PostgreSQLContainer;

public class TestConfig {
    public static PostgreSQLContainer<?> postgresContainer;

    @BeforeAll
    public static void setup() {
        postgresContainer = new PostgreSQLContainer<>("postgres:13")
                .withUsername("postgres")
                .withPassword("postgres")
                .withDatabaseName("postgres");
        postgresContainer.start();
        System.setProperty("POSTGRES_URL", postgresContainer.getJdbcUrl());
        System.setProperty("POSTGRES_USER", postgresContainer.getUsername());
        System.setProperty("POSTGRES_PASSWORD", postgresContainer.getPassword());
    }

    @AfterAll
    public static void tearDown() {
        postgresContainer.stop();
    }
}
