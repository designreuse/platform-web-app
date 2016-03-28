package com.aladdin.platform.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;
import org.springframework.core.type.filter.AnnotationTypeFilter;
import org.springframework.core.type.filter.AssignableTypeFilter;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@SuppressWarnings("unchecked, unused")
@Component("applicationContextUtils")
public class ApplicationContextUtils implements ApplicationContextAware {

    private final static Logger LOGGER = LoggerFactory.getLogger(ApplicationContextUtils.class);

    private static ApplicationContext applicationContext;

    public <T> List<T> loadEntities(String basePackage, Class<T> typeToFind) {
        ClassPathScanningCandidateComponentProvider provider = new ClassPathScanningCandidateComponentProvider(false);
        provider.addIncludeFilter(new AssignableTypeFilter(typeToFind));
        Set<BeanDefinition> beanDefinitions = provider.findCandidateComponents(basePackage);
        List<T> results = new ArrayList<T>(beanDefinitions.size());
        try {
            for (BeanDefinition beanDefinition : beanDefinitions) {
                T t = (T) applicationContext.getAutowireCapableBeanFactory().createBean(Class.forName(beanDefinition.getBeanClassName()));
                results.add(t);
            }
        } catch (ClassNotFoundException e) {
            LOGGER.error("failed to load entities", e);
        }

        return results;
    }

    public static <T> List<Class<T>> loadClasses(String basePackage, Class<T> typeToFind) {
        ClassPathScanningCandidateComponentProvider provider = new ClassPathScanningCandidateComponentProvider(false);
        provider.addIncludeFilter(new AssignableTypeFilter(typeToFind));
        Set<BeanDefinition> beanDefinitions = provider.findCandidateComponents(basePackage);
        List<Class<T>> results = new ArrayList<Class<T>>(beanDefinitions.size());
        try {
            for (BeanDefinition beanDefinition : beanDefinitions) {
                results.add((Class<T>) Class.forName(beanDefinition.getBeanClassName()));
            }
        } catch (ClassNotFoundException e) {
            LOGGER.error("failed to load classes", e);
        }

        return results;
    }

    public static List<Class> loadClassesByAnnotation(String basePackage, Class annotationType) {
        ClassPathScanningCandidateComponentProvider provider = new ClassPathScanningCandidateComponentProvider(false);
        provider.addIncludeFilter(new AnnotationTypeFilter(annotationType));
        Set<BeanDefinition> beanDefinitions = provider.findCandidateComponents(basePackage);
        List<Class> results = new ArrayList<Class>(beanDefinitions.size());
        try {
            for (BeanDefinition beanDefinition : beanDefinitions) {
                results.add((Class) Class.forName(beanDefinition.getBeanClassName()));
            }
        } catch (ClassNotFoundException e) {
            LOGGER.error("failed to load classes ", e);
        }

        return results;
    }

    public static <T> T getBean(Class<T> typeClass) {
        return applicationContext.getBean(typeClass);
    }

    public static <T> T getBean(String beanName) {
        return (T) applicationContext.getBean(beanName);
    }

    public static <T> T createBean(Class<T> typeClass) {
        return applicationContext.getAutowireCapableBeanFactory().createBean(typeClass);
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        ApplicationContextUtils.applicationContext = applicationContext;
    }
}
