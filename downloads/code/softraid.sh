root@wgzhao-nb:~# mdadm  --detail /dev/md0
/dev/md0:
        Version : 00.90
  Creation Time : Thu Dec 24 16:11:11 2009
     Raid Level : raid1
     Array Size : 2097088 (2048.28 MiB 2147.42 MB)
  Used Dev Size : 2097088 (2048.28 MiB 2147.42 MB)
   Raid Devices : 2
  Total Devices : 2
Preferred Minor : 0
    Persistence : Superblock is persistent

    Update Time : Thu Dec 24 16:11:55 2009
          State : clean
 Active Devices : 2
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 0

           UUID : 32c53f31:ddeb40ff:06694991:8b2cae0c (local to host wgzhao-nb)
         Events : 0.18

    Number   Major   Minor   RaidDevice State
       0       8       32        0      active sync   /dev/sdc
       1       8       16        1      active sync   /dev/sdb

root@wgzhao-nb:~# mdadm  -f /dev/md0 /dev/sdb
mdadm: set /dev/sdb faulty in /dev/md0
root@wgzhao-nb:~# cat /proc/mdstat 
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md0 : active raid1 sdb[2](F) sdc[0]
      2097088 blocks [2/1] [U_]
      
unused devices: 

root@wgzhao-nb:~# mdadm --remove /dev/md0 /dev/sdb
mdadm: hot removed /dev/sdb
root@wgzhao-nb:~# cat /proc/mdstat 
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md0 : active raid1 sdc[0]
      2097088 blocks [2/1] [U_]
      
unused devices: 

root@wgzhao-nb:~# mdadm  -a /dev/md0 /dev/sdb
mdadm: added /dev/sdb

root@wgzhao-nb:~# cat /proc/mdstat 
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md0 : active raid1 sdb[2] sdc[0]
      2097088 blocks [2/1] [U_]
      [====>................]  recovery = 21.4% (451008/2097088) finish=0.2min speed=112752K/sec
      
unused devices: 

root@wgzhao-nb:~# cat /proc/mdstat 
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md0 : active raid1 sdb[1] sdc[0]
      2097088 blocks [2/2] [UU]
      
unused devices: 
