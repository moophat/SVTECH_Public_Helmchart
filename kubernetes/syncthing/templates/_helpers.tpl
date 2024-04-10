{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper Syncthing image name
*/}}
{{- define "syncthing.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}



