package com.aladdin.platform.taglibs.menu;

import java.util.ArrayList;
import java.util.List;

public class Menu {

    private String code;

    private String name;

    private String path;
    
    private Integer seq;

    private Menu parent;

    private boolean root = false;

    private List<Menu> children = new ArrayList<Menu>(0);

	private String description;

    public Menu(String code, String name, String path, Integer seq) {
        this.code = code; 
        this.name = name;
        this.path = path;
        this.seq = seq;
    }
    
    public Menu(String code, String name, String path, String description) {
        this.code = code; 
        this.name = name;
        this.path = path;
        this.description = description;
    }

    private Menu(String code, String name, String path, Integer seq, boolean isRoot) {
        this.code = code;
        this.name = name;
        this.path = path;
        this.seq = seq;
        this.root = isRoot;
    }

    public void addChild(Menu child) {
        child.setParent(this);
        this.children.add(child);
    }

    public String getName() {
        return name;
    }

    public Integer getSeq() {
		return seq;
	}

	public String getPath() {
        return path;
    }

    public void setParent(Menu parent) {
        this.parent = parent;
    }

    public Menu getParent() {
        return parent;
    }

    public List<Menu> getChildren() {
        return children;
    }

    public static Menu buildRoot(String appCode, String rootPath) {
        return new Menu(appCode, "首页", rootPath, 0, true);
    }

    public Menu findLeaf(String code) {
        if (code == null || code.length() == 0) return null;
        if (this.code.equalsIgnoreCase(code)) {
            return this;
        }
        for (Menu child : this.children) {
            Menu leaf = child.findLeaf(code);
            if (leaf != null) return leaf;
        }
        return null;
    }

    public boolean hasChildren() {
        return this.children != null && this.children.size() > 0;
    }

    public boolean isRoot() {
        return root;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", path='" + path + '\'' +
                ", seq='" + seq + '\'' +
                ", parent=" + parent +
                ", root=" + root +
                '}';
    }

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
    
    
}
