package com.estupiso.service;

import com.estupiso.model.FotoVivienda;
import com.estupiso.repository.FotoViviendaRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class FotoViviendaService {

    @Autowired
    private FotoViviendaRepository fotoViviendaRepository;

    @Transactional
    public FotoVivienda saveFotoVivienda(FotoVivienda fotoVivienda){
         return fotoViviendaRepository.save(fotoVivienda);
    }

    @Transactional
    public boolean deleteFotoVivienda(int idFotoVivienda){
        Optional<FotoVivienda> fotoViviendaO = fotoViviendaRepository.findById(idFotoVivienda);
        if(fotoViviendaO.isPresent()){
            fotoViviendaRepository.deleteById(idFotoVivienda);
            return true;
        }
        return false;
    }

    @Transactional
    public FotoVivienda updateFoto(int id){
        Optional<FotoVivienda> fotoViviendaO = fotoViviendaRepository.findById(id);
        if(fotoViviendaO.isPresent()){
            fotoViviendaO.get().setImagen(fotoViviendaO.get().getImagen());
            fotoViviendaO.get().setVivienda(fotoViviendaO.get().getVivienda());
            return fotoViviendaRepository.save(fotoViviendaO.get());
        }
        return null;
    }
}
