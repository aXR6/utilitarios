;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     dns-master.pve.datacenter.tsc. admin.pve.datacenter.tsc. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

; name servers - NS records
    IN      NS      dns-master.pve.datacenter.tsc.
    IN      NS      dns-slave.pve.datacenter.tsc.
    
; name servers - A records
dns-master.pve.datacenter.tsc.         IN      A       192.168.2.55
dns-slave.pve.datacenter.tsc.          IN      A       192.168.2.56

; 192.168.2.0/24 - A records
ks8-vm1.pve.datacenter.tsc.        IN      A      192.168.2.51
ks8-vm2.pve.datacenter.tsc.        IN      A      192.168.2.52
ks8-vm3.pve.datacenter.tsc.        IN      A      192.168.2.53
