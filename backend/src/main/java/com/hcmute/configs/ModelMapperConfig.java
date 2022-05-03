package com.hcmute.configs;

import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ModelMapperConfig {
	@Bean
	public ModelMapper mapper() {
		ModelMapper mapper = new ModelMapper();
		mapper.getConfiguration()
			.setMatchingStrategy(MatchingStrategies.STANDARD);
		return mapper;
	}
}
