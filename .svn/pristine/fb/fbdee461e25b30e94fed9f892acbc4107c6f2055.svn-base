package at.fh.swenga.jpa.dao;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import at.fh.swenga.jpa.model.Notification;
import at.fh.swenga.jpa.model.User;
import at.fh.swenga.jpa.model.UserRole;

@Repository
@Transactional
public interface SimpleNotificationRepository extends JpaRepository<Notification, Integer> {

	List<Notification> findAllByUsername(String username);

	List<Notification> removeByNotId(int notId);

	Notification findByEventIdAndNotificationTypeAndEventStartAndUsername(int id, int notificationType, Date eventStart, String username);

	List<Notification> findByEventId(Integer id);

	List<Notification> findByUsername(String username);

}
