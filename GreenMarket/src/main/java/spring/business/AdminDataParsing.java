package spring.business;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import spring.dao.AdminDao;

@Component
@Service
public class AdminDataParsing {

	@Autowired
	private AdminDao dao;
	
	
	
}
