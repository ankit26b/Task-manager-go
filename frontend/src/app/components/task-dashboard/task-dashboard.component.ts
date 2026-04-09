import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { TaskService } from '../../services/task.service';
import { Task } from '../../models/task.model';
import { parseCustomDate } from '../../utils/date.utils';

@Component({
  selector: 'app-task-dashboard',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './task-dashboard.component.html',
  styleUrls: ['./task-dashboard.component.css']
})
export class TaskDashboardComponent implements OnInit {
  tasks: Task[] = [];
  loading = true;

  constructor(private taskService: TaskService, private cdr: ChangeDetectorRef) {}

  ngOnInit(): void {
    this.loadTasks();
  }

  loadTasks(): void {
    this.loading = true;
    this.taskService.getTasks().subscribe({
      next: (data) => {
        this.tasks = data || [];
        this.loading = false;
        this.cdr.markForCheck();
      },
      error: (err) => {
        console.error('Failed to load tasks', err);
        this.loading = false;
        this.cdr.markForCheck();
      }
    });
  }

  deleteTask(id: number | undefined): void {
    if (!id) return;
    if (confirm('Are you sure you want to delete this task?')) {
      this.taskService.deleteTask(id).subscribe({
        next: () => {
          this.tasks = this.tasks.filter(t => t.id !== id);
          this.cdr.markForCheck();
        },
        error: (err) => console.error('Failed to delete task', err)
      });
    }
  }

  formatDate(dateString: string | undefined): Date | null {
    return parseCustomDate(dateString);
  }

  getStatusClass(status: string | undefined): string {
    const s = (status || '').toLowerCase();
    if (s === 'done' || s === 'completed') return 'status-done';
    if (s === 'in progress') return 'status-progress';
    return 'status-todo';
  }

  getPriorityClass(priority: string | undefined): string {
    const p = (priority || '').toLowerCase();
    if (p === 'high') return 'priority-high';
    if (p === 'medium') return 'priority-medium';
    return 'priority-low';
  }
}
