{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper rundeck image name
*/}}
{{- define "rundeck.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "rundeck.init.image" -}}
{{- if .Values.init -}}
{{ include "common.images.image" (dict "imageRoot" .Values.init.image "global" .Values.global) }}
{{- end -}}
{{- end -}}

