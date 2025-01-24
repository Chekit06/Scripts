# Define the log file path
log_file_path = "nginx.log"

# Initialize an empty set for unique IPs
unique_ips = set()

# Open the log file and process it line by line
with open(log_file_path, "r") as log_file:
    for line in log_file:
        # Extract the first column (IP address)
        ip = line.split()

        if not line:
            continue
        
        try:
            ip = line.split()[0]
            unique_ips.add(ip)
        except IndexError:

            continue

        

# Print unique IPs and their count
print("Unique IPs:")
for ip in unique_ips:
    print(ip)

print(f"\nTotal number of unique IPs: {len(unique_ips)}")