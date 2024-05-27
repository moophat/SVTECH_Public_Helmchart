{{/* vim: set filetype=mustache: */}}
{{/*
Return the proper replicaCount
{{ include "common.replicas" ( dict "replicaCount" .Values.path.to.replicaCount "global" $) }}
*/}}
{{- define "common.replicas" -}}
{{- $replica := .replicaCount -}}
{{- if .global }}
    {{- if .global.ci }}
     {{- $replica = 1 -}}
    {{- end -}}
{{- end -}}
{{- $replica -}}
{{- end -}}
