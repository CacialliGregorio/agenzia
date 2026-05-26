package it.polimi.agenzia.repository;

import it.polimi.agenzia.entity.Foto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FotoRepository extends JpaRepository<Foto, Long> {

    List<Foto> findByImmobileIdOrderByOrdinamentoAsc(Long immobileId);

    void deleteByImmobileId(Long immobileId);
}