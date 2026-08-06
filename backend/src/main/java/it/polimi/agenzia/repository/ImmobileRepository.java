package it.polimi.agenzia.repository;

import it.polimi.agenzia.entity.Immobile;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

import java.math.BigDecimal;

@Repository
public interface ImmobileRepository extends JpaRepository<Immobile, Long> {

    Page<Immobile> findByStato(Immobile.Stato stato, Pageable pageable);
    List<Immobile> findByMostraInSlideTrueAndStatoOrderByIdAsc(Immobile.Stato stato);
    List<Immobile> findByCodiceRiferimentoIn(List<String> codiciRiferimento);

    Page<Immobile> findByCittaContainingIgnoreCase(String citta, Pageable pageable);

    @Query("""
        SELECT i FROM Immobile i
        WHERE (:citta IS NULL OR LOWER(i.citta) LIKE LOWER(CONCAT('%', :citta, '%')))
        AND (:tipo IS NULL OR LOWER(i.tipo) LIKE LOWER(CONCAT('%', :tipo, '%')))
        AND (:stato IS NULL OR i.stato = :stato)
        AND (:prezzoMin IS NULL OR i.prezzo >= :prezzoMin)
        AND (:prezzoMax IS NULL OR i.prezzo <= :prezzoMax)
    """)
    Page<Immobile> cercaImmobili(
            @Param("citta") String citta,
            @Param("tipo") String tipo,
            @Param("stato") Immobile.Stato stato,
            @Param("prezzoMin") BigDecimal prezzoMin,
            @Param("prezzoMax") BigDecimal prezzoMax,
            Pageable pageable
    );
}