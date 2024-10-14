package com.udea.modulo_pagos.repositories;

import com.udea.modulo_pagos.entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IUserRepository extends CrudRepository<User, Long> {
}
