echo "Start sleep for 10 seconds..."
Start-Sleep -Seconds 10

bash.exe -c "sudo service ssh start"
bash.exe -c "sudo service redis-server start"
bash.exe -c "sudo service xrdp-sesman start"
bash.exe -c "sudo service xrdp start"
bash.exe -c "sudo fallocate -l 8G /swapfile"
bash.exe -c "sudo chmod 600 /swapfile"
bash.exe -c "sudo mkswap /swapfile"
bash.exe -c "sudo swapon /swapfile"
bash.exe -c "sudo echo /swapfile none swap sw 0 0 | sudo tee -a /etc/fstab"

$remoteport = bash.exe -c "ifconfig eth0 | grep 'inet '"
$found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';
if( $found )
{
    $remoteport = $matches[0];
}
else
{
    echo "The Script Exited, the ip address of WSL 2 cannot be found";
    exit;
}
#[host_ports]
#All the host_ports you want to forward separated by coma
$host_ports=@(50003, 50004);

#[wsl_ports]
$wsl_ports=@(22, 3389);

#[Static ip]
#You can change the addr to your ip config to listen to a specific address
$addr='0.0.0.0';
$host_ports_a = $host_ports -join ",";

#Remove Firewall Exception Rules
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' ";

#adding Exception Rules for inbound and outbound Rules
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalPort $host_ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalPort $host_ports_a -Action Allow -Protocol TCP";
for( $i = 0; $i -lt $host_ports.length; $i++ )
{
    $host_port = $host_ports[$i];
    $wsl_port = $wsl_ports[$i];
    iex "netsh interface portproxy delete v4tov4 listenport=$host_port listenaddress=$addr";
    iex "netsh interface portproxy add v4tov4 listenport=$host_port listenaddress=$addr connectport=$wsl_port connectaddress=$remoteport";
}
