package com.udea.modulo_pagos;
import com.udea.modulo_pagos.entities.*;
import com.udea.modulo_pagos.repositories.*;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Testcontainers
@ActiveProfiles("integration-test")

class ModuloPagosIntegrationTests {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:13")
            .withDatabaseName("testdb")
            .withUsername("testuser")
            .withPassword("testpass");

    @DynamicPropertySource
    static void databaseProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
    }

    @Autowired
    private IPaymentRepository paymentRepository;

    @Autowired
    private ITransactionRepository transactionRepository;

    @Autowired
    private IGatewayPaymentRepository gatewayPaymentRepository;

    @Autowired
    private IBookingRepository bookingRepository;

    @Autowired
    private IUserRepository userRepository;

    // Pruebas de Payment
    @Test
    void testCreateAndRetrievePayment() {
        // Crear entidades relacionadas
        Transaction transaction = new Transaction();
        transaction.setDate(LocalDate.now());
        transactionRepository.save(transaction);

        GatewayPayment gatewayPayment = new GatewayPayment();
        gatewayPayment.setName("Stripe");
        gatewayPaymentRepository.save(gatewayPayment);

        // Crear Payment
        Payment payment = new Payment();
        payment.setDate(LocalDate.now());
        payment.setTransaction(transaction);
        payment.setGatewayPayment(gatewayPayment);
        paymentRepository.save(payment);

        // Recuperar Payment
        Optional<Payment> retrievedPayment = paymentRepository.findById(payment.getId());
        assertTrue(retrievedPayment.isPresent());
        assertEquals(payment.getTransaction().getDate(), retrievedPayment.get().getDate());
        assertEquals(payment.getGatewayPayment().getName(), retrievedPayment.get().getGatewayPayment().getName());
    }

    // Pruebas de Booking
    @Test
    void testCreateAndRetrieveBooking() {
        // Crear usuario relacionado
        User user = new User();
        user.setId(1L);
        userRepository.save(user);

        // Crear Booking
        Booking booking = new Booking();
        booking.setUser(user);
        booking.setPrice(100.0f);
        booking.setAdditional_charge(10.0);
        booking.set_paid(false);
        bookingRepository.save(booking);

        // Recuperar Booking
        Optional<Booking> retrievedBooking = bookingRepository.findById(booking.getId());
        assertTrue(retrievedBooking.isPresent());
        assertEquals(user.getId(), retrievedBooking.get().getUser().getId());
        assertEquals(100.0f, retrievedBooking.get().getPrice());
        assertFalse(retrievedBooking.get().is_paid());
    }

    @Test
    void testGetAllUserBookings() {
        // Crear usuario relacionado
        User user = new User();
        user.setId(1L);
        userRepository.save(user);

        // Crear Bookings
        Booking booking1 = new Booking();
        booking1.setUser(user);
        booking1.setPrice(200.0f);
        booking1.set_paid(true);
        bookingRepository.save(booking1);

        Booking booking2 = new Booking();
        booking2.setUser(user);
        booking2.setPrice(300.0f);
        booking2.set_paid(false);
        bookingRepository.save(booking2);

        // Recuperar Bookings del usuario
        List<Booking> userBookings = bookingRepository.findByUserId(user.getId());
        assertEquals(2, userBookings.size());
        assertTrue(userBookings.stream().anyMatch(booking -> booking.getPrice() == 200.0f));
        assertTrue(userBookings.stream().anyMatch(booking -> booking.getPrice() == 300.0f));
    }
}
