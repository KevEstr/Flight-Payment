package com.udea.modulo_pagos.service.implementation;

import com.mercadopago.MercadoPagoConfig;
import com.mercadopago.client.preference.PreferenceClient;
import com.mercadopago.client.preference.PreferenceRequest;
import com.mercadopago.client.preference.PreferenceItemRequest;
import com.mercadopago.client.preference.PreferenceBackUrlsRequest;
import com.mercadopago.exceptions.MPApiException;
import com.mercadopago.exceptions.MPException;
import com.mercadopago.resources.preference.Preference;
import com.udea.modulo_pagos.entities.PreferencePayment;
import com.udea.modulo_pagos.repositories.IPreferencePaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class MercadoPagoService {

    @Value("${MERCADO_PAGO_ACCESS_TOKEN}")
    private String accessToken;

    @Autowired
    private IPreferencePaymentRepository preferenceRepository;

    public String createPaymentPreference(Long transactionId, Long amount) {
        try {
            MercadoPagoConfig.setAccessToken(accessToken);
            PreferenceClient client = new PreferenceClient();

            // Crear ítem y URLs de retorno
            PreferenceItemRequest item = PreferenceItemRequest.builder()
                    .title("Transaction ID: " + transactionId)
                    .quantity(1)
                    .unitPrice(BigDecimal.valueOf(amount.floatValue()))
                    .build();

            // Agregar external_reference con el transactionId
            PreferenceBackUrlsRequest backUrls = PreferenceBackUrlsRequest.builder()
                    .success("https://codefact.udea.edu.co/modulo-03/success")
                    .failure("https://codefact.udea.edu.co/modulo-03/failure")
                    .pending("https://codefact.udea.edu.co/modulo-03/pending")
                    .build();

            PreferenceRequest preferenceRequest = PreferenceRequest.builder()
                    .items(List.of(item))
                    .backUrls(backUrls)
                    .externalReference(transactionId.toString()) // Agregamos el external_reference
                    .build();

            Preference preference = client.create(preferenceRequest);

            // Guardar en la base de datos
            PreferencePayment newPreference = new PreferencePayment();
            newPreference.setTransactionId(transactionId);
            newPreference.setPreferenceId(preference.getId());
            newPreference.setStatus("PENDING");
            preferenceRepository.save(newPreference);

            return preference.getInitPoint();

        } catch (MPException | MPApiException e) {
            throw new RuntimeException("Error al crear la preferencia de Mercado Pago", e);
        }
    }
}
