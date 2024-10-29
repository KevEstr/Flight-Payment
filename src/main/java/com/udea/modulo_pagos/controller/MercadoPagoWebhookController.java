package com.udea.modulo_pagos.controller;

import com.mercadopago.MercadoPagoConfig;
import com.mercadopago.client.payment.PaymentClient;
import com.mercadopago.resources.payment.Payment;
import com.udea.modulo_pagos.entities.PreferencePayment;
import com.udea.modulo_pagos.graphql.InputPayment;
import com.udea.modulo_pagos.repositories.IPreferencePaymentRepository;
import com.udea.modulo_pagos.service.IPaymentService;
import com.udea.modulo_pagos.service.ITransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
public class MercadoPagoWebhookController {

    @Autowired
    private IPreferencePaymentRepository preferenceRepository;

    @Autowired
    private ITransactionService transactionService;

    @Autowired
    private IPaymentService paymentService;

    @Value("${MERCADO_PAGO_ACCESS_TOKEN}")
    private String accessToken;

    @PostMapping("/mercadopago-webhook")
    public ResponseEntity<?> handleMercadoPagoWebhook(@RequestBody Map<String, Object> payload) {
        try {
            Map<String, Object> data = (Map<String, Object>) payload.get("data");
            String paymentId = data.get("id").toString();

            // Obtener el payment de MercadoPago
            MercadoPagoConfig.setAccessToken(accessToken);
            PaymentClient paymentClient = new PaymentClient();
            Payment payment = paymentClient.get(Long.valueOf(paymentId));

            // Obtener el transactionId del external_reference
            String externalReference = payment.getExternalReference();
            Long transactionId = Long.parseLong(externalReference);

            // Buscar la preferencia por transactionId
            PreferencePayment preference = preferenceRepository.findByTransactionId(transactionId)
                    .orElseThrow(() -> new RuntimeException("Preference not found"));

            // Actualizar el paymentId
            preference.setPaymentId(paymentId);
            preference.setStatus("COMPLETED");
            preferenceRepository.save(preference);

            // Crear el pago en la base de datos
            InputPayment inputPayment = new InputPayment();
            inputPayment.setTransaction_id(transactionId);
            inputPayment.setGateway_payment_id(2L);

            paymentService.createPayment(inputPayment);

            // Actualizar el estado de la transacción
            transactionService.updateTransactionStatus(transactionId, (byte) 1);

            return ResponseEntity.ok("Webhook procesado correctamente");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error procesando webhook: " + e.getMessage());
        }
    }
}

