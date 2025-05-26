package com.estupiso.service;

import com.estupiso.dto.MunicipioDto;
import com.estupiso.model.Municipio;
import com.estupiso.model.Provincia;
import com.estupiso.repository.MunicipioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class MunicipioService {

    @Autowired
    private MunicipioRepository municipioRepository;

    @Autowired
    private ProvinciaService provinciaService;

    public List<Municipio> findAll() {
        return municipioRepository.findAll();
    }

    public Optional<Municipio> findById(Integer id) {
        return municipioRepository.findById(id);
    }

    public Optional<Municipio> findByNombre(String nombre) {
        return municipioRepository.findByNombre(nombre);
    }

    public List<Municipio> findByProvincia(Provincia provincia) {
        return municipioRepository.findByProvincia(provincia);
    }

    public List<MunicipioDto> findByProvinciaId(Integer provinciaId) {
        Optional<Provincia> provincia = provinciaService.findById(provinciaId);
        if (provincia.isPresent()) {
            List<Municipio> municipios = municipioRepository.findByProvincia(provincia.get());
            return municipios.stream()
                    .map(this::convertToDto)
                    .collect(Collectors.toList());
        }
        return List.of();
    }

    private MunicipioDto convertToDto(Municipio municipio) {
        MunicipioDto dto = new MunicipioDto();
        dto.setId(municipio.getId());
        dto.setCodMunicipio(municipio.getCodMunicipio());
        dto.setDc(municipio.getDc());
        dto.setNombre(municipio.getNombre());
        dto.setProvinciaId(municipio.getProvincia().getId());
        dto.setProvinciaNombre(municipio.getProvincia().getNombre());
        return dto;
    }

}
