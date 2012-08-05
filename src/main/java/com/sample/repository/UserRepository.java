package com.sample.repository;

import com.sample.domain.User;
import java.util.List;
import org.springframework.roo.addon.layers.repository.mongo.RooMongoRepository;

@RooMongoRepository(domainType = User.class)
public interface UserRepository {

    List<com.sample.domain.User> findAll();
}
