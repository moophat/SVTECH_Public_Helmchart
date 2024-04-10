{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper Debuger image name
*/}}
{{- define "debuger.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

