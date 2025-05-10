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
