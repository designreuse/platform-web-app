package com.aladdin.platform.utils;

import java.io.Serializable;

public class ErrorObject implements Serializable {

	private static final long serialVersionUID = 1L;
	private String message;

    /**
     * Instantiates a new Error object.
     *
     * @param message the message
     */
    public ErrorObject(String message) {
		this.message = message;
	}

    /**
     * Gets message.
     *
     * @return the message
     */
    public String getMessage() {
		return message;
	}

    /**
     * Sets message.
     *
     * @param message the message
     */
    public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "ErrorObject{" + "message='" + message + '\'' + '}';
	}
}