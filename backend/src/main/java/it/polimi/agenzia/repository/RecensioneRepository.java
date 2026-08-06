package it.polimi.agenzia.repository;

import it.polimi.agenzia.entity.Recensione;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecensioneRepository extends JpaRepository<Recensione, Long> {

    Page<Recensione> findAllByOrderByVotoDescCreatoIlDesc(Pageable pageable);
}