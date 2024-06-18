{{/* Generate a default fully qualified app name */}}  
{{- define "mychart.name" -}}  
{{- default .Chart.Name .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}  
{{- end -}}  
