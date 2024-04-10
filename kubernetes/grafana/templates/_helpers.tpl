{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper grafana image name
*/}}
{{- define "grafana.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "common.init.image" -}}
{{- if .Values.init -}}
{{ include "common.images.image" (dict "imageRoot" .Values.init.image "global" .Values.global) }}
{{- end -}}
{{- end -}}

