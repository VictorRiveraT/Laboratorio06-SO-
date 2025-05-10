# Laboratorio 06 - Sistemas Operativos 🧠💻

Este laboratorio tuvo como objetivo familiarizarnos con comandos básicos, intermedios y avanzados de Linux a través de la terminal. A continuación, se presenta el desarrollo manual de cada ejercicio propuesto.

---

## Parte I: Comandos Básicos

### 📁 Estructura de directorios y navegación
```bash
pwd
mkdir -p ~/laboratorio/datos/entrada
mkdir -p ~/laboratorio/datos/salida
mkdir -p ~/laboratorio/scripts
mkdir -p ~/laboratorio/respaldo
cd ~/laboratorio/datos/entrada
touch datos1.txt datos2.txt config.cfg
cp datos1.txt ~/laboratorio/respaldo/
mv config.cfg ~/laboratorio/
rm datos2.txt
```

### 📄 Visualización y edición
```bash
echo "Esta es la primera línea del archivo" > datos1.txt
echo "Esta es la segunda línea del archivo" >> datos1.txt
echo "Esta es la tercera línea del archivo" >> datos1.txt
echo "Esta es la cuarta línea del archivo" >> datos1.txt
echo "Esta es la quinta línea del archivo" >> datos1.txt

cat datos1.txt
head -n 3 datos1.txt
tail -n 2 datos1.txt
```

---

## Parte II: Comandos Intermedios

### 🔍 Búsqueda y filtrado
```bash
cd ~/laboratorio
echo "usuario1:x:1000:1000:Juan:/home/u1:/bin/bash" > usuarios.txt
echo "usuario2:x:1001:1001:Ana:/home/u2:/bin/bash" >> usuarios.txt
echo "usuario3:x:1002:1002:Leo:/home/u3:/bin/zsh" >> usuarios.txt

grep "bash" usuarios.txt
grep -v "bash" usuarios.txt
find . -name "*.txt"

seq 1 100 > numeros.txt
awk '$1 % 2 == 0' numeros.txt
awk '$1 % 3 == 0' numeros.txt
awk '$1 % 5 == 0' numeros.txt | wc -l
sort -nr numeros.txt > numeros_ordenados.txt
```

### ➡️ Redirección y pipes
```bash
ls -la > listado.txt
echo "Línea extra" >> listado.txt
cat /etc/passwd | grep bash | wc -l
```

### 👥 Permisos y usuarios
```bash
echo '#!/bin/bash' > saludo.sh
echo 'echo Hola $USER, hoy es $(date)' >> saludo.sh
chmod +x saludo.sh
./saludo.sh

mkdir privado
echo "confidencial" > privado/confidencial.txt
chmod 600 privado/confidencial.txt

mkdir compartido
chmod 754 compartido
```

---

## Parte III: Comandos Avanzados

### 📊 Procesos y monitoreo
```bash
ps aux | head -10
top -n 1
sleep 300 &
jobs
kill %1
```

### 📡 Ping en segundo plano
```bash
ping google.com > ping_log.txt &
pgrep ping
kill <PID>  # Reemplazar por el PID real
cat ping_log.txt
```

### 🛠️ Script: Información del sistema
```bash
#!/bin/bash
echo "Usuario: $USER"
echo "Host: $(hostname)"
echo "Kernel: $(uname -r)"
```

### 🗃️ Script de backup
```bash
#!/bin/bash
tar -czf respaldo_$(date +%F).tar.gz "$1"
```

### 📑 Análisis de logs del sistema
```bash
find /var/log -name "*.log" -exec du -h {} + | sort -hr | head -n 5
grep -i "error" archivo.log | tail -n 3
```
