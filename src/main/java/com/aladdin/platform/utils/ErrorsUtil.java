package com.aladdin.platform.utils;

import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;

import java.util.ArrayList;
import java.util.List;

public class ErrorsUtil {
    /**
     *
     */
    private ErrorsUtil() {
    }

    /**
     * Reject errors.
     *
     * @param model the model
     * @param errorMsgs the error msgs
     */
    public static final void rejectErrors(Model model, String... errorMsgs) {
        List<ErrorObject> errorObjects = new ArrayList<ErrorObject>();

        if (errorMsgs != null) {
            for (String message : errorMsgs) {
                errorObjects.add(new ErrorObject(message));
            }
        }
        List<ErrorObject> existed = (List<ErrorObject>) model.asMap().get("errors");
        if (existed != null) {
            errorObjects.addAll(0, existed);
        }

        model.addAttribute("errors", errorObjects);
    }

    /**
     * Reject errors.
     *
     * @param model the model
     * @param errors the errors
     */
    public static void rejectErrors(Model model, Errors errors) {
        List<ErrorObject> errorObjects = new ArrayList<ErrorObject>();

        if (errors != null) {
            for (FieldError fieldError : errors.getFieldErrors()) {
                errorObjects.add(new ErrorObject(fieldError.getDefaultMessage()));
            }
        }
        List<ErrorObject> existed = (List<ErrorObject>) model.asMap().get("errors");
        if (existed != null) {
            errorObjects.addAll(0, existed);
        }

        model.addAttribute("errors", errorObjects);

    }
}