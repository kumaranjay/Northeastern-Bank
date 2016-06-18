package com.kumaran.finalProj.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.kumaran.finalProj.model.User;

public class UserValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {

		return User.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub
		User user = (User) target;

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name",
				"validate.name", "Your Name Is Incorrect");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password",
				"validate.password", "Your password Is Incorrect");
	}

}
