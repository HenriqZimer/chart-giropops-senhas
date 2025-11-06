{{/*
Criar as nosssas tags
*/}}
{{- define "app.labels" -}}
app: {{ .labels.app }}
env: {{ .labels.env }}
{{- end -}}

{{/*
Definir limits e requests de recursos
*/}}
{{- define "app.resources" -}}
resources:
  requests:
    memory: {{ .resources.requests.memory }}
    cpu: {{ .resources.requests.cpu }}
  limits:
    memory: {{ .resources.limits.memory }}
    cpu: {{ .resources.limits.cpu }}
{{- end -}}

{{/*
Definir portas dos serviços
*/}}
{{- define "app.ports" -}}
{{ range .ports}}
- containerPort: {{ .port }}
{{- end -}}
{{- end -}}

{{/*
Definir os configMaps do banco de dados
*/}}
{{- define "database.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-database-config
data:
  app-config.yaml: |
    {{- toYaml .config | nindent 4 }}
{{- end }}

{{/*
Definir os serviços do observability
*/}}
{{- define "observability.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-observability-config
data:
  app-config.json: |
    {{ toJson .config }}
{{- end }}