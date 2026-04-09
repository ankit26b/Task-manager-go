import { Routes } from '@angular/router';
import { TaskDashboardComponent } from './components/task-dashboard/task-dashboard.component';
import { TaskFormComponent } from './components/task-form/task-form.component';

export const routes: Routes = [
  { path: '', component: TaskDashboardComponent },
  { path: 'task/new', component: TaskFormComponent },
  { path: 'task/:id', component: TaskFormComponent },
  { path: '**', redirectTo: '' }
];
