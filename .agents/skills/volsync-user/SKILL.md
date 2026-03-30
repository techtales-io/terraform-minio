# Volsync user skill (backup bucket)

Create or update MinIO manifests for a Volsync user in `data/users/nas.techtales.io` with access to the `backup` bucket.

## Goal

- Add a new `MinioUser` manifest in `data/users/nas.techtales.io`.
- Ensure it follows the existing Volsync naming conventions.
- Ensure `backup` bucket manifest exists in `data/buckets/nas.techtales.io`.
- If missing, create the bucket manifest.
- Use git workflow: sync latest `main`, create `feature/<topic>` branch, commit, push.

## Required inputs

- Cluster name (default: `kube-lab`)
- Volume name (required)
- Optional path segment or namespace (required)

If volume name is not provided, ask:

> "Please provide the volume name (kebab-case), e.g. `bazarr-config` or `minecraft-public-forge-world-data`."

If path segement or namespace is not provided, ask:

> "Please provide the namespace (kebab-case), e.g. `media` or `gaming`."

## Naming rules

- File name: `volsync-<cluster>-<volume>.yaml`
- `metadata.name`: `volsync-<cluster>-<volume>`
- `metadata.namespace`: `nas.techtales.io`
- Lowercase only, words separated by `-`, no `_`.

## User manifest template

Create file: `data/users/nas.techtales.io/volsync-<cluster>-<volume>.yaml`

```yaml
---
apiVersion: terraform.techtales.io/v1alpha1
kind: MinioUser
metadata:
  name: volsync-<cluster>-<volume>
  namespace: nas.techtales.io
spec:
  description: volsync <cluster> backup account
  disabled: false
  permissions:
    - bucket: backup
      path: /*
      actions:
        - ListBucket
    - bucket: backup
      path: /<cluster>/<path-segment>/<volume>/*
      actions:
        - GetObject
        - PutObject
        - DeleteObject
```

Notes:

- Keep style aligned with existing Volsync files.
- If user gives a custom prefix path, replace `/<cluster>/<path-segment>/<volume>/*` accordingly.

## Backup bucket existence check

Check whether `data/buckets/nas.techtales.io/backup.yaml` exists.

- If it exists: do nothing.
- If missing: create it with:

```yaml
---
apiVersion: terraform.techtales.io/v1alpha1
kind: MinioBucket
metadata:
  name: backup
  namespace: nas.techtales.io
spec:
  acl: private
  description: user backups
  locking: false
```

## Validation checklist

- File path and `metadata.name` match exactly.
- `namespace` is `nas.techtales.io`.
- Bucket name is `backup` in all permissions.
- Prefix path is scoped to the specific volume.
- YAML is valid and consistent with repository formatting.

## Git workflow (mandatory)

After changes are ready:

- Ensure local default branch is up to date: `git pull`
- Create branch using `feature/<topic>`
- Use lowercase only
- Use `-` as separator
- Do not use `_`
- Commit changes with a clear message
- Push branch to origin

Suggested topic: `volsync-backup-user-<cluster>-<volume>`
