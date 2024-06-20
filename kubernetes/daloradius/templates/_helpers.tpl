{{/*
Expand the name of the chart.
*/}}
{{- define "daloradius.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "daloradius.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "daloradius.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "daloradius.labels" -}}
helm.sh/chart: {{ include "daloradius.chart" . }}
{{ include "daloradius.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "daloradius.selectorLabels" -}}
app.kubernetes.io/name: {{ include "daloradius.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return the proper daloradius image name
*/}}
{{- define "daloradius.image" -}}
{{- $registryName := .Values.image.registry -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := .Values.image.tag | toString -}}
{{- if .global }}
    {{- if .global.imageRegistry }}
     {{- $registryName = .global.imageRegistry -}}
    {{- end -}}
{{- end -}}
{{- if $registryName }}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- else -}}
{{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/* Create the name of the SSL certificate to use */}}
{{ define "daloradius.tlsSecretName" }}
{{- if .Values.tls.certificatesSecret }}
  {{ .Values.tls.certificatesSecret }}
{{- else }}
  {{- default (printf "%s-tls" (include "daloradius.fullname" .)) }}
{{- end }}
{{- end }}

{{/* Return the proper Docker Image Registry Secret Names */}}
{{- define "daloradius.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) -}}
{{- end -}}

{{/* Create the name of the service account to use */}}
{{- define "daloradius.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
  {{- default (include "daloradius.fullname" .) .Values.serviceAccount.name }}
{{- else }}
  {{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the secret with MariaDB credentials
*/}}
{{- define "mariadb.secretName" -}}
    {{- if .Values.auth.existingSecret -}}
        {{- printf "%s" .Values.auth.existingSecret -}}
    {{- else -}}
        {{- printf "%s" (include "common.names.fullname" .) -}}
    {{- end -}}
{{- end -}}

