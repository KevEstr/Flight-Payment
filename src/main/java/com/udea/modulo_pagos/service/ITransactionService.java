package com.udea.modulo_pagos.service;

import com.stripe.exception.StripeException;
import com.udea.modulo_pagos.entities.Transaction;
import com.udea.modulo_pagos.graphql.InputTransaction;

public interface ITransactionService {

    String payTransaction(InputTransaction inputTransaction) throws StripeException;

    Transaction updateTransactionStatus(Long id, byte status);

    Transaction findTransactionById(Long id);
}
