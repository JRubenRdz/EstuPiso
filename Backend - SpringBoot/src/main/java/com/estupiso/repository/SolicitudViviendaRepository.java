package com.estupiso.repository;

import com.estupiso.model.SolicitudVivienda;
import com.estupiso.model.EstadoSolicitud;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SolicitudViviendaRepository extends JpaRepository<SolicitudVivienda, Integer> {

    // Solicitudes por estudiante
    List<SolicitudVivienda> findByEstudianteIdOrderByFechaSolicitudDesc(Integer estudianteId);

    // Solicitudes para viviendas de un anunciante
    @Query("SELECT s FROM SolicitudVivienda s WHERE s.vivienda.anunciante.id = :anuncianteId ORDER BY s.fechaSolicitud DESC")
    List<SolicitudVivienda> findByAnuncianteIdOrderByFechaSolicitudDesc(@Param("anuncianteId") Integer anuncianteId);

    // Verificar si ya existe solicitud pendiente
    Optional<SolicitudVivienda> findByEstudianteIdAndViviendaIdAndEstado(
            Integer estudianteId, Integer viviendaId, EstadoSolicitud estado);

    // Solicitudes por vivienda
    List<SolicitudVivienda> findByViviendaIdOrderByFechaSolicitudDesc(Integer viviendaId);

    // Contar solicitudes pendientes para un anunciante
    @Query("SELECT COUNT(s) FROM SolicitudVivienda s WHERE s.vivienda.anunciante.id = :anuncianteId AND s.estado = 'PENDIENTE'")
    Long countSolicitudesPendientesByAnunciante(@Param("anuncianteId") Integer anuncianteId);
}