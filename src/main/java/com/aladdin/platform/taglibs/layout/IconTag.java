package com.aladdin.platform.taglibs.layout;

public class IconTag {

	private String iconCls;

	private String iconAction;

	public IconTag(String iconCls, String iconAction) {
		this.iconCls = iconCls;
		this.iconAction = iconAction;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public String getIconAction() {
		return iconAction;
	}

	public void setIconAction(String iconAction) {
		this.iconAction = iconAction;
	}
}
