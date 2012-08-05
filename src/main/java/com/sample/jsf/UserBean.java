package com.sample.jsf;

import com.sample.domain.User;
import org.springframework.roo.addon.jsf.managedbean.RooJsfManagedBean;
import org.springframework.roo.addon.serializable.RooSerializable;

@RooSerializable
@RooJsfManagedBean(entity = User.class, beanName = "userBean")
public class UserBean {
}
