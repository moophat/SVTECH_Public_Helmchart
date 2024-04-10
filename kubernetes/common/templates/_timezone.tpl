{{/* vim: set filetype=mustache: */}}
{{/*
Return the proper timezone
{{ include "common.timezone" ( dict "timezone" .Values.timezone "global" .Values.global) }}
*/}}

{{- define "common.timezone" -}}
{{- $TZ := .timezone -}}
{{- if .global }}
    {{- if .global.timezone }}
     {{- $TZ = .global.timezone -}}
    {{- end -}}
{{- end -}}
{{- if $TZ }}
{{- printf "%s" $TZ -}}
{{- end -}}
{{- end -}}
