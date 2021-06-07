{{/* Mount volume for logs */}}
{{- define "logger.mount" }}
- name: applogs 
  mountPath: /home/logs
{{- end }}

{{/* Template for adding logging sidecar */}}
{{- define "logger.sidecar" }}
- name: logger-sidecar
  image: registry.inu.gov.gn/wuriguinea/busybox:latest
  args: [/bin/sh, -c, 'tail -F /home/logs/registrationProcessor.log']
  volumeMounts:
  - name: applogs
    mountPath: /home/logs
{{- end }}

{{/* Temp volume for logs */}}
{{- define "logger.volume" }}
- name: applogs
  emptyDir: {}
{{- end }}
