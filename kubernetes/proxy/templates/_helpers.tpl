{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper proxy image name
*/}}
{{- define "proxy.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "proxy.init.image" -}}
{{- if .Values.init -}}
{{ include "common.images.image" (dict "imageRoot" .Values.init.image "global" .Values.global) }}
{{- end -}}
{{- end -}}