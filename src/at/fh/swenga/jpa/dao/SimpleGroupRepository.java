package at.fh.swenga.jpa.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import at.fh.swenga.jpa.model.User;
import at.fh.swenga.jpa.model.UserGroup;

@Repository
@Transactional
public interface SimpleGroupRepository extends JpaRepository<UserGroup, Integer> {
	
	
	UserGroup findGroupBygroupID(int groupID);

	UserGroup findByName(String name);

}
