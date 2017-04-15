// src/app/app.component.ts

import { Component } from '@angular/core';
import { Http } from '@angular/http';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app works!';
  bowlers;

  constructor(private http: Http) {
    http.get('http://localhost:3000/api/v1/bowlers.json')
        .subscribe(res => this.bowlers = res.json());
  }
}
