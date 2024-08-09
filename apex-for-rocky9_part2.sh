#!/bin/bash

# Start the timer
start_time=$(date +%s)

# Get APEX
curl -O https://download.oracle.com/otn_software/apex/apex-latest.zip

# Enter APEX Folder
unzip -q apex-latest.zip
cd apex

# Install APEX
sqlplus / as sysdba <<EOF
ALTER SESSION SET CONTAINER = FREEPDB1;
@apexins.sql SYSAUX SYSAUX TEMP /i/
EXIT;
EOF

# Set Accounts
sqlplus / as sysdba <<EOF
ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER USER APEX_PUBLIC_USER ACCOUNT UNLOCK;
ALTER USER APEX_PUBLIC_USER IDENTIFIED BY ApexForRocky9!;
EXIT;
EOF

# Create ADMIN Account silently
sqlplus / as sysdba <<EOF
ALTER SESSION SET CONTAINER = FREEPDB1;
BEGIN
    APEX_UTIL.set_security_group_id( 10 );
    
    APEX_UTIL.create_user(
        p_user_name       => 'ADMIN',
        p_email_address   => 'aaa@bbb.com',
        p_web_password    => 'ApexForRocky9!',
        p_developer_privs => 'ADMIN' );
        
    APEX_UTIL.set_security_group_id( null );
    COMMIT;
END;
/
EOF


# Calculate the elapsed time
end_time=$(date +%s)
elapsed_time=$((end_time - start_time))

# Convert elapsed time to human-readable format (optional)
hours=$((elapsed_time / 3600))
minutes=$(( (elapsed_time % 3600) / 60 ))
seconds=$((elapsed_time % 60))

# Print the elapsed time
echo "Elapsed time: ${hours}h ${minutes}m ${seconds}s"

                                                                 