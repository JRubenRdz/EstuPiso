import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment.development';
import { HttpClient } from '@angular/common/http';
import { ActorLogin } from '../model/ActorLogin';
import { Observable } from 'rxjs';
import { Actor } from '../model/Actor';

@Injectable({
  providedIn: 'root'
})
export class ActorService {

  private urlAPI = environment.apiUrl;

constructor(private http: HttpClient) { }

login(actorLogin: ActorLogin): Observable<any> {
  return this.http.post<any>(`${this.urlAPI}/login`, actorLogin);
}

userLogin(): Observable<any> {
  return this.http.get<any>(`${this.urlAPI}/login`);
}

actorExiste(): Observable<any> {
  return this.http.get<boolean>(`${this.urlAPI}/actorExiste`);
}

}
