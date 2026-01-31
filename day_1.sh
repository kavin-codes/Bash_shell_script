gitmkdir app_logs
cd app_logs

echo "INFO App started" > app1.log
echo "ERROR DB failed" >> app1.log

echo "INFO App started" > app2.log
echo "ERROR Timeout" >> app2.log

cat *.log
tail -5 app1.log
grep -i error *.log
grep -i error *.log | wc -l

ls -l app1.log
chmod 600 app1.log
ls -l app1.log
mkdir backup
mv *.log backup/
ls backup
