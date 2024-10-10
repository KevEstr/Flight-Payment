package com.udea.modulo_pagos.service.implementation;

import com.stripe.exception.StripeException;
import com.udea.modulo_pagos.entities.*;
import com.udea.modulo_pagos.graphql.InputTransaction;
import com.udea.modulo_pagos.repositories.ITransactionRepository;
import com.udea.modulo_pagos.service.IBookingService;
import com.udea.modulo_pagos.service.IGatewayPaymentService;
import com.udea.modulo_pagos.service.IPaymentMethodService;
import com.udea.modulo_pagos.service.ITransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
public class TransactionServiceImpl implements ITransactionService {

    private static final Float TAXES = 0.19f;

    @Autowired
    private ITransactionRepository transactionRepository;

    @Autowired
    private IBookingService bookingService;

    @Autowired
    private IPaymentMethodService paymentMethodService;

    @Autowired
    private IGatewayPaymentService gatewayPaymentService;

    @Autowired
    private StripePaymentService stripePaymentService;

    @Autowired
    private MercadoPagoService mercadoPagoService;

    public String createTransaction(InputTransaction inputTransaction) throws StripeException {


        Transaction transaction = new Transaction();
        PaymentMethod paymentMethod = new PaymentMethod();
        transaction.setStatus((byte) 0);
        transaction.setDate(LocalDate.now());

        Booking booking = bookingService.getBookingById(inputTransaction.getBooking_id());

        if (booking.is_paid()) {
            throw new IllegalStateException("La reserva no se puede volver a pagar: Su estado es PAGADA.");
        }

        transaction.setBooking(booking);

        GatewayPayment gatewayPayment = gatewayPaymentService.findGatewayPaymentById(inputTransaction.getGateway_payment_id());
        transaction.setGateway_payment(gatewayPayment);

        Long subtotal = booking.getPrice().longValue() + booking.getAdditional_charge().longValue(); // Asegúrate de que ambos valores son Long
        Long totalPrice = subtotal + (subtotal * TAXES.longValue());
        transaction.setTotal_price(totalPrice);

        //dejaré lo de payment method de forma predeterminada por si las moscas
        paymentMethod = paymentMethodService.getPaymentMethodById(1L);
        transaction.setPayment_method(paymentMethod);


        transactionRepository.save(transaction);

        if(inputTransaction.getGateway_payment_id()==1){
            return stripePaymentService.createCheckoutSession(transaction.getId(), transaction.getTotal_price(), inputTransaction.getBooking_id());
        }
        else if(inputTransaction.getGateway_payment_id()==2){
            return mercadoPagoService.createPaymentPreference(transaction.getId(), transaction.getTotal_price());
        }

        return "Gateway payment provided does not exist";

    }

    public Transaction updateTransactionStatus(Long transactionId, byte newStatus){
        var transaction= new Transaction ();
        transaction= transactionRepository.findById(transactionId).orElseThrow();
        transaction.setStatus(newStatus);
        transactionRepository.save(transaction);
        return transaction;
    }

    public Transaction findTransactionById(Long id) {
        return transactionRepository.findById(id).orElseThrow();
    }


}