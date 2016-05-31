package at.fh.swenga.jpa.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import at.fh.swenga.jpa.model.Notification;
import at.fh.swenga.jpa.model.User;
import at.fh.swenga.jpa.model.UserGroup;

@Repository
@Transactional
public interface SimpleUserRepository extends JpaRepository<User, String> {
	
	List<User> findByUsername(String email);
	
	User findOneByUsername(String username);

	List<Notification> findAllNotificationsByUsername(String username);


}
