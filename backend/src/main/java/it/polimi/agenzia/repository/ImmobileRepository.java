package it.polimi.agenzia.repository;

import it.polimi.agenzia.entity.Immobile;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ImmobileRepository extends JpaRepository<Immobile, Long> {
    
    Page<Immobile> findByStato(Immobile.Stato stato, Pageable pageable);
    
    Page<Immobile> findByCittaContainingIgnoreCase(String citta, Pageable pageable);
    
    @Query("SELECT i FROM Immobile i WHERE " +
           "(:citta IS NULL OR LOWER(i.citta) LIKE LOWER(CONCAT('%', :citta, '%'))) AND " +
           "(:tipo IS NULL OR i.tipo = :tipo) AND " +
           "(:stato IS NULL OR i.stato = :stato) AND " +
           "i.prezzo BETWEEN :prezzoMin AND :prezzoMax")
    Page<Immobile> cercaImmobili(
        @Param("citta") String citta,
        @Param("tipo") Immobile.TipoImmobile tipo,
        @Param("stato") Immobile.Stato stato,
        @Param("prezzoMin") java.math.BigDecimal prezzoMin,
        @Param("prezzoMax") java.math.BigDecimal prezzoMax,
        Pageable pageable
    );
}

