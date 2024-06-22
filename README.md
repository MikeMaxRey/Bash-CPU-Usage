# Average CPU Usage Script
This script calculates the average CPU usage of Linux Machines in a 6sec interval. It repeatedly samples the current CPU usage and adds it to an array, then calculates the average and exits it when the user presses Ctrl+c.

## Usage
- Make the script executable by running chmod +x cpuload_loop.sh.
- Run the script using ./
- Press Ctrl+c to calculate and print the average CPU usage before exiting.

## Script Flow (in Detail)
- script starts by defining a function called 'calculate_average_and_exit' that will be called when user interrupts or exit
- then it initializes an empty array called 'cpu_usage_array' to store the CPU usage samples, and sets variables total and count to 0.
- The script enters an infinite loop, where it repeatedly samples the current CPU usage and adds it to the previously defined 'cpu_usage_array'.
- To sample the CPU usage, the script first gets the current time using the 'date command.
- Then, it uses the awk command to parse the /proc/stat file
- 'awk' calculates CPU Usage which processes the ouput of 'grep', which reads /proc/stat file twice in 5sec interval
- 'awk' calculates CPU Time (u) System CPU time (t) and idle CPU time ($5)
- $2(User), $4(System), $5(Idle) refer to the fields inside the proc/stat file
- script calc difference between current and previous CPU Usage by subtracting the previous user CPU time (u1) and the System CPU time (t1) from the current CPU time ($2+$4) and system CPU time (t)
- Then it shifts the decimal point of the CPU usage two places to the right to convert it to a percentage, and prints the current CPU usage
- After that it adds the current CPU usage to the 'cpu_usage_array', and updates the 'total' and 'count' variables.
- waits 1sec before repeating process
- The script then waits for the user to Ctrl+C. If the user triggers this it calls the 'calculate_average_and_exit' function to calculate and print the average CPU usage before exiting

