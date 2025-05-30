package com.estupiso.repository;

import com.estupiso.model.Anunciante;
import com.estupiso.model.SolicitudVivienda;
import com.estupiso.model.EstadoSolicitud;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SolicitudViviendaRepository extends JpaRepository<SolicitudVivienda, Integer> {

    // Solicitudes por estudiante
    List<SolicitudVivienda> findByEstudianteIdOrderByFechaSolicitudDesc(Integer estudianteId);

    // Solicitudes para viviendas de un anunciante
    List<SolicitudVivienda> findByAnuncianteOrderByFechaSolicitudDesc(Anunciante anunciante);

    // Verificar si ya existe solicitud pendiente
    Optional<SolicitudVivienda> findByEstudianteIdAndViviendaIdAndEstado(
            Integer estudianteId, Integer viviendaId, EstadoSolicitud estado);

    // Solicitudes por vivienda
    List<SolicitudVivienda> findByViviendaIdOrderByFechaSolicitudDesc(Integer viviendaId);

    List<SolicitudVivienda> findByViviendaIdAndEstado(Integer viviendaId, EstadoSolicitud estado);

    // Contar solicitudes pendientes para un anunciante
    int countSolicitudesPendientesByAnunciante(Anunciante anunciante);

    // AÑADIR consulta específica para verificar pertenencia
    boolean existsByEstudianteIdAndViviendaIdAndEstado(
        Integer estudianteId,
        Integer viviendaId,
        EstadoSolicitud estado
    );

    // AÑADIR estos métodos si no existen:
    int countByViviendaIdAndEstado(Integer viviendaId, EstadoSolicitud estado);
    

}