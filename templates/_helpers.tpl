{{/*
Expand the name of the chart.
*/}}
{{- define "openllm-oneshot.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "openllm-oneshot.fullname" -}}
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
{{- define "openllm-oneshot.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openllm-oneshot.labels" -}}
helm.sh/chart: {{ include "openllm-oneshot.chart" . }}
{{ include "openllm-oneshot.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openllm-oneshot.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openllm-oneshot.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openllm-oneshot.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openllm-oneshot.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the HuggingFace token secret name
*/}}
{{- define "openllm-oneshot.hfSecretName" -}}
{{- if .Values.huggingface.existingSecret }}
{{- .Values.huggingface.existingSecret }}
{{- else }}
{{- printf "%s-hf-token" (include "openllm-oneshot.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the PVC name for model cache
*/}}
{{- define "openllm-oneshot.pvcName" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- printf "%s-model-cache" (include "openllm-oneshot.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Generate OpenLLM command arguments
*/}}
{{- define "openllm-oneshot.args" -}}
- "start"
- {{ .Values.model.id | quote }}
{{- if .Values.model.backend }}
- "--backend"
- {{ .Values.model.backend | quote }}
{{- end }}
{{- if .Values.model.quantization }}
- "--quantize"
- {{ .Values.model.quantization | quote }}
{{- end }}
{{- if .Values.model.maxModelLen }}
- "--max-model-len"
- {{ .Values.model.maxModelLen | quote }}
{{- end }}
{{- if .Values.model.trustRemoteCode }}
- "--trust-remote-code"
{{- end }}
{{- if .Values.gpu.enabled }}
- "--device"
- "cuda"
{{- if .Values.gpu.memoryUtilization }}
- "--gpu-memory-utilization"
- {{ .Values.gpu.memoryUtilization | quote }}
{{- end }}
{{- end }}
{{- if .Values.server.workers }}
- "--workers"
- {{ .Values.server.workers | quote }}
{{- end }}
{{- if .Values.server.maxConcurrentRequests }}
- "--max-concurrent-requests"
- {{ .Values.server.maxConcurrentRequests | quote }}
{{- end }}
{{- end }}
