package com.Repo;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.pojo.Audit;

@Repository
public interface AuditRepo extends MongoRepository<Audit, String> {
	
	List<Audit> findByFlowIdAndFlowNameAndRegion(String flowId, String flowName, String region);
	
	Audit findByMessageId(String messageId);
}
