package at.fh.swenga.jpa.dao;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import at.fh.swenga.jpa.model.Event;
import at.fh.swenga.jpa.model.User;

@Repository
@Transactional
public interface SimpleEventRepository extends JpaRepository<Event, Integer> {
	
	Event findEventById(int id);


}
