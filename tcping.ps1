$ip = "192.168.210.10"
$port = 445

try {
    $client = New-Object System.Net.Sockets.TcpClient
    $async = $client.BeginConnect($ip, $port, $null, $null)

    if ($async.AsyncWaitHandle.WaitOne(500)) {
        "[+] {$ip}:{$port} OPEN"
    }

    $client.Close()
}
catch {
    # cerrado o filtrado
}
