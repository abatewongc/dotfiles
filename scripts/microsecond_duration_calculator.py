import sys

def format_duration(start_epoch_micros, end_epoch_micros):
   # Calculate duration in seconds
   duration_micros = end_epoch_micros - start_epoch_micros
   duration_secs = duration_micros / 1_000_000

   # Break into components
   hours = int(duration_secs // 3600)
   minutes = int((duration_secs % 3600) // 60)
   seconds = duration_secs % 60

   # Format output
   parts = []
   if hours > 0:
       parts.append(f"{hours} hour{'s' if hours != 1 else ''}")
   if minutes > 0:
       parts.append(f"{minutes} minute{'s' if minutes != 1 else ''}")
   if seconds > 0:
       parts.append(f"{seconds:.3f} second{'s' if seconds != 1 else ''}")

   if not parts:
       return "0 seconds"

   return ", ".join(parts)

if __name__ == "__main__":
   if len(sys.argv) != 3:
       print("Usage: python script.py <start_epoch_micros> <end_epoch_micros>")
       sys.exit(1)

   try:
       start = int(sys.argv[1])
       end = int(sys.argv[2])
       print(format_duration(start, end))
   except ValueError:
       print("Error: Both arguments must be integers")
       sys.exit(1)