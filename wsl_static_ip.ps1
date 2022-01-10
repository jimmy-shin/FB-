echo "Start sleep for 5 seconds..."
Start-Sleep -Seconds 5

bash.exe -c "sudo service ssh start"
bash.exe -c "sudo service redis-server start"
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
#[Ports]
#All the ports you want to forward separated by coma
$ports=@(50003);

#[Static ip]
#You can change the addr to your ip config to listen to a specific address
$addr='0.0.0.0';
$ports_a = $ports -join ",";

#Remove Firewall Exception Rules
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' ";

#adding Exception Rules for inbound and outbound Rules
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalPort $ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalPort $ports_a -Action Allow -Protocol TCP";
for( $i = 0; $i -lt $ports.length; $i++ )
{
    $port = $ports[$i];
    iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr";
    iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=22 connectaddress=$remoteport";
}
