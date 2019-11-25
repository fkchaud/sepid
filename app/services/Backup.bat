E:
cd E:\Proyecto final\sepid\app\Backup
C:\xampp\mysql\bin\mysqldump -hlocalhost -uroot sepid_development >"Backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.sql"