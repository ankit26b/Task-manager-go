import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router, ActivatedRoute, RouterModule } from '@angular/router';
import { TaskService } from '../../services/task.service';
import { Task } from '../../models/task.model';
import { formatCustomDate, parseCustomDate } from '../../utils/date.utils';

@Component({
  selector: 'app-task-form',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  templateUrl: './task-form.component.html',
  styleUrls: ['./task-form.component.css']
})
export class TaskFormComponent implements OnInit {
  taskForm: FormGroup;
  isEditMode = false;
  taskId: number | null = null;
  loading = false;
  submitting = false;

  constructor(
    private fb: FormBuilder,
    private taskService: TaskService,
    private router: Router,
    private route: ActivatedRoute,
    private cdr: ChangeDetectorRef
  ) {
    this.taskForm = this.fb.group({
      title: ['', [Validators.required, Validators.minLength(3)]],
      status: ['To Do'],
      priority: ['Medium'],
      dueDateInput: [''] // We'll bind this to HTML datetime-local input
    });
  }

  ngOnInit(): void {
    const idParam = this.route.snapshot.paramMap.get('id');
    if (idParam && idParam !== 'new') {
      this.isEditMode = true;
      this.taskId = Number(idParam);
      this.loadTask(this.taskId);
    }
  }

  loadTask(id: number): void {
    this.loading = true;
    this.taskService.getTask(id).subscribe({
      next: (task) => {
        // Parse "DD-MM-YYYY HH:mm" to local datetime string for input type="datetime-local"
        let htmlDate = '';
        if (task.due_date) {
            const parsed = parseCustomDate(task.due_date);
            if (parsed) {
               const pad = (n: number) => n < 10 ? '0' + n : n;
               htmlDate = `${parsed.getFullYear()}-${pad(parsed.getMonth()+1)}-${pad(parsed.getDate())}T${pad(parsed.getHours())}:${pad(parsed.getMinutes())}`;
            }
        }

        this.taskForm.patchValue({
          title: task.title,
          status: task.status || 'To Do',
          priority: task.priority || 'Medium',
          dueDateInput: htmlDate
        });
        this.loading = false;
        this.cdr.markForCheck();
      },
      error: (err) => {
        console.error('Failed to load task', err);
        this.loading = false;
        this.cdr.markForCheck();
      }
    });
  }

  onSubmit(): void {
    if (this.taskForm.invalid) return;

    this.submitting = true;
    const formVals = this.taskForm.value;

    let dueDateFormatted = '';
    if (formVals.dueDateInput) {
       // user picked a date like '2026-04-08T15:30'
       const d = new Date(formVals.dueDateInput);
       // Format to "DD-MM-YYYY HH:mm" for backend
       dueDateFormatted = formatCustomDate(d);
    }

    const taskData: Task = {
      title: formVals.title,
      status: formVals.status,
      priority: formVals.priority,
      due_date: dueDateFormatted
    };

    if (this.isEditMode && this.taskId) {
      this.taskService.updateTask(this.taskId, taskData).subscribe({
        next: () => this.router.navigate(['/']),
        error: (err) => {
          console.error(err);
          this.submitting = false;
          this.cdr.markForCheck();
        }
      });
    } else {
      this.taskService.createTask(taskData).subscribe({
        next: () => this.router.navigate(['/']),
        error: (err) => {
          console.error(err);
          this.submitting = false;
          this.cdr.markForCheck();
        }
      });
    }
  }
}
