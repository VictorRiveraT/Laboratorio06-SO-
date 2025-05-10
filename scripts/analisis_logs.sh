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
