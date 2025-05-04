package com.estupiso.service;

import com.estupiso.model.Actor;
import com.estupiso.repository.ActorRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Service
public class ActorService implements UserDetailsService {

    @Autowired
    private ActorRepository actorRepository;

    @Transactional
    public Actor saveActor(Actor actor) {
        return actorRepository.save(actor);
    }

    public Optional<Actor> findByUsuario(String username) {
        return actorRepository.findByUsuario(username);
    }

    @Override
    public UserDetails loadUserByUsername(String usuario) throws UsernameNotFoundException {
        Optional<Actor> actorO = this.findByUsuario(usuario);
        if (actorO.isPresent()) {
            Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
            authorities.add(new SimpleGrantedAuthority(actorO.get().getRol().toString()));
            User user = new User(actorO.get().getUsuario(), actorO.get().getContraseña(), authorities);
            return user;
        } else {
            throw new UsernameNotFoundException("Usuario no encontrado");
        }
    }

}
