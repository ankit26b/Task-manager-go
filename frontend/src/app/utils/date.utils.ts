export function parseCustomDate(dateString: string | undefined): Date | null {
  if (!dateString || dateString === '""' || dateString === '') return null;
  // It comes as "DD-MM-YYYY HH:mm"
  const parts = dateString.split(' ');
  if (parts.length !== 2) return null;
  
  const dateParts = parts[0].split('-');
  const timeParts = parts[1].split(':');
  
  if (dateParts.length !== 3 || timeParts.length !== 2) return null;
  
  // DD-MM-YYYY -> YYYY, MM (0-indexed), DD
  return new Date(
    parseInt(dateParts[2], 10),
    parseInt(dateParts[1], 10) - 1,
    parseInt(dateParts[0], 10),
    parseInt(timeParts[0], 10),
    parseInt(timeParts[1], 10)
  );
}

export function formatCustomDate(date: Date | null): string {
  if (!date) return '';
  const day = String(date.getDate()).padStart(2, '0');
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const year = date.getFullYear();
  const hours = String(date.getHours()).padStart(2, '0');
  const minutes = String(date.getMinutes()).padStart(2, '0');
  
  return `${day}-${month}-${year} ${hours}:${minutes}`;
}
