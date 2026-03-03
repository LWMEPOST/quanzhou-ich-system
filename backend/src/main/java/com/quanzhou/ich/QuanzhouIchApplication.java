package com.quanzhou.ich;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@EnableCaching
@MapperScan("com.quanzhou.ich.mapper")
public class QuanzhouIchApplication {

    public static void main(String[] args) {
        SpringApplication.run(QuanzhouIchApplication.class, args);
    }

}
