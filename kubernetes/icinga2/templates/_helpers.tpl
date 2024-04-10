{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper Icinga2 image name
*/}}
{{- define "icinga2.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "icinga2.init.image" -}}
{{- if .Values.init -}}
{{ include "common.images.image" (dict "imageRoot" .Values.init.image "global" .Values.global) }}
{{- end -}}
{{- end -}}

{{- define "icinga2.sidecar.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.sidecar.image "global" .Values.global) }}
{{- end -}}

