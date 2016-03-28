package com.aladdin.platform.taglibs.menu;

import com.wl.framework.permission.entity.MenuEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

public class MenuBuilder {

    private final static Logger LOGGER = LoggerFactory.getLogger(MenuBuilder.class);

    public static Menu build(String applicationCode, List<MenuEntity> menuEntities, String rootPath) {
        Menu root = Menu.buildRoot(applicationCode, rootPath);
		build(applicationCode, menuEntities, root);

        return root;
    }

    /**
	 * permissions要求的数据结构为，
	 * 先父级菜单，然后在子菜单【排序和sequence有关】，类型为2
	 */
	private static void build(String applicationCode, List<MenuEntity> menuEntities, Menu root) {
        if (applicationCode == null || applicationCode.length() == 0) {
            LOGGER.warn("applicationCode should be assigned");
            return;
        }

        if (menuEntities == null || menuEntities.size() == 0) {
        	LOGGER.debug("there are no permisssions");
            return;
        }

        List<MenuEntity> toBeRemoved = new ArrayList<MenuEntity>();
        for (MenuEntity menuEntity : menuEntities) {
            Menu menu = new Menu(menuEntity.getPermissCode(), menuEntity.getPermissName(), menuEntity.getPath(), menuEntity.getDescription());
            if (menuEntity.getParentId() == null) {
                root.addChild(menu);
                toBeRemoved.add(menuEntity);
            } else {
                Menu parentMenu = root.findLeaf(menuEntity.getParentPermissionCode());
                if (parentMenu != null) {
                    parentMenu.addChild(menu);
                    toBeRemoved.add(menuEntity);
                }else{
                	StringBuilder builder=new StringBuilder();
                	builder.append("权限ID:") ;
                	builder.append(menuEntity.getId());
                	builder.append("生成菜单异常");
                	LOGGER.error(builder.toString());
                }
            }
        }

        menuEntities.removeAll(toBeRemoved);
		build(applicationCode, menuEntities, root);

    }
}
