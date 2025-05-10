# Laboratorio 06 - Sistemas Operativos

---

```bash
# ==== PARTE I: Comandos Básicos ====

# Ejercicio 1.1
pwd
mkdir -p ~/laboratorio/datos/entrada
mkdir -p ~/laboratorio/datos/salida
mkdir -p ~/laboratorio/scripts
mkdir -p ~/laboratorio/respaldo
ls -la ~/laboratorio

# Ejercicio 1 para desarrollar
cd ~/laboratorio/datos/entrada
touch datos1.txt datos2.txt config.cfg
cp datos1.txt ~/laboratorio/respaldo/
mv config.cfg ~/laboratorio/
rm datos2.txt

# Ejercicio 1.2
echo "Esta es la primera línea del archivo" > ~/laboratorio/datos/entrada/datos1.txt
echo "Esta es la segunda línea del archivo" >> ~/laboratorio/datos/entrada/datos1.txt
echo "Esta es la tercera línea del archivo" >> ~/laboratorio/datos/entrada/datos1.txt
echo "Esta es la cuarta línea del archivo" >> ~/laboratorio/datos/entrada/datos1.txt
echo "Esta es la quinta línea del archivo" >> ~/laboratorio/datos/entrada/datos1.txt
cat ~/laboratorio/datos/entrada/datos1.txt
head -n 3 ~/laboratorio/datos/entrada/datos1.txt
tail -n 2 ~/laboratorio/datos/entrada/datos1.txt

# Ejercicio 2
cd ~/laboratorio/datos
for i in {1..20}; do echo "Línea número $i" >> registro.log; done
head -n 5 registro.log
tail -n 3 registro.log
echo "# ARCHIVO DE REGISTRO" | cat - registro.log > temp && mv temp registro.log
cat registro.log

# ==== PARTE II: Comandos Intermedios ====

# Ejercicio 2.1
cd ~/laboratorio
echo "usuario1:x:1000:1000:Juan Pérez:/home/usuario1:/bin/bash" > usuarios.txt
echo "usuario2:x:1001:1001:María García:/home/usuario2:/bin/bash" >> usuarios.txt
echo "usuario3:x:1002:1002:Carlos López:/home/usuario3:/bin/zsh" >> usuarios.txt
echo "usuario4:x:1003:1003:Ana Martínez:/home/usuario4:/bin/bash" >> usuarios.txt
echo "usuario5:x:1004:1004:Pedro Sánchez:/home/usuario5:/bin/zsh" >> usuarios.txt
grep "bash" usuarios.txt
grep -v "bash" usuarios.txt

# Ejercicio 3
find . -type f -name "*.txt"
seq 1 100 > numeros.txt
grep -E "^[0-9]*[02468]$" numeros.txt
awk '$1 % 3 == 0' numeros.txt
awk '$1 % 5 == 0' numeros.txt | wc -l
sort -nr numeros.txt > numeros_ordenados.txt

# Ejercicio 2.2
ls -la > ~/laboratorio/listado.txt
echo "Nueva línea de texto" >> ~/laboratorio/listado.txt
cat /etc/passwd | grep "bash" | wc -l

# Ejercicio 4 para desarrollar
ps aux > ~/laboratorio/procesos.txt
ps -u $USER > ~/laboratorio/mis_procesos.txt
ps aux --sort=-%mem | head -n 6 > ~/laboratorio/top_procesos.txt
find /etc -type f | wc -l

# Ejercicio 2.3
echo '#!/bin/bash' > ~/laboratorio/scripts/saludo.sh
echo 'echo "Hola, $USER. La fecha actual es $(date)"' >> ~/laboratorio/scripts/saludo.sh
chmod +x ~/laboratorio/scripts/saludo.sh
~/laboratorio/scripts/saludo.sh

# Ejercicio 5
cd ~/laboratorio
mkdir privado
echo "Contenido confidencial" > privado/confidencial.txt
chmod 600 privado/confidencial.txt
mkdir compartido
chmod 754 compartido
ls -la
ls -la privado
ls -la compartido

# ==== PARTE III: Comandos Avanzados ====

# Ejercicio 3.1
ps aux | head -10
top -n 1
sleep 300 &
jobs
kill %1

# Ejercicio 6
ping google.com > ~/laboratorio/ping_log.txt &
pgrep ping
# kill <PID>  (Reemplazar con el número real)
cat ~/laboratorio/ping_log.txt

# Ejercicio 3.2
cat > ~/laboratorio/scripts/info_sistema.sh << 'EOL'
#!/bin/bash
echo "=== Información del Sistema ==="
echo "Usuario: $USER"
echo "Hostname: $(hostname)"
echo "Fecha: $(date)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "=== Espacio en disco ==="
df -h | grep "/dev/"
EOL
chmod +x ~/laboratorio/scripts/info_sistema.sh
~/laboratorio/scripts/info_sistema.sh

# Ejercicio 7
cat > ~/laboratorio/scripts/backup.sh << 'EOF'
#!/bin/bash
if [ -z "$1" ]; then
  echo "Uso: $0 <directorio>"
  exit 1
fi
FECHA=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVO="respaldo_$FECHA.tar.gz"
tar -czf ~/laboratorio/respaldo/$ARCHIVO "$1"
echo "Respaldo exitoso: $ARCHIVO"
du -h ~/laboratorio/respaldo/$ARCHIVO
EOF
chmod +x ~/laboratorio/scripts/backup.sh
~/laboratorio/scripts/backup.sh ~/laboratorio/datos

# Ejercicio 3.3 – Reto Final
mkdir -p ~/laboratorio/datos/salida
cat > ~/laboratorio/scripts/analisis_logs.sh << 'EOF'
#!/bin/bash
LOG_DIR="/var/log"
SALIDA=~/laboratorio/datos/salida/informe_logs.md
TEMPFILE="/tmp/errores_tmp.txt"
mapfile -t archivos < <(find $LOG_DIR -type f -name "*.log" -exec du -b {} + 2>/dev/null | sort -nr | head -n 5)
echo "# Informe de Análisis de Logs" > "$SALIDA"
echo "Fecha: $(date)" >> "$SALIDA"
echo "" >> "$SALIDA"
echo "| Archivo | Tamaño (bytes) | Errores encontrados |" >> "$SALIDA"
echo "|---------|----------------|----------------------|" >> "$SALIDA"
mayor_error_count=0
archivo_mas_errores=""
for linea in "${archivos[@]}"; do
  archivo=$(echo "$linea" | cut -f2)
  tamano=$(echo "$linea" | cut -f1)
  errores=$(grep -i "error" "$archivo" 2>/dev/null | tee "$TEMPFILE" | wc -l)
  echo "| $archivo | $tamano | $errores |" >> "$SALIDA"
  if [ "$errores" -gt "$mayor_error_count" ]; then
    mayor_error_count=$errores
    archivo_mas_errores=$archivo
    cp "$TEMPFILE" /tmp/errores_mas_graves.txt
  fi
done
echo "" >> "$SALIDA"
echo "### Últimos 3 errores en $archivo_mas_errores" >> "$SALIDA"
tail -n 3 /tmp/errores_mas_graves.txt >> "$SALIDA"
echo "Resumen generado. Ver $SALIDA"
EOF
chmod +x ~/laboratorio/scripts/analisis_logs.sh
~/laboratorio/scripts/analisis_logs.sh
```

