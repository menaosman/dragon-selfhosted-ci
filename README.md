# Self-Hosted Runner Demo — ASCII Dragon with `cowsay`

This repo demonstrates a GitHub Actions workflow that runs on a **self-hosted runner** and prints an ASCII **dragon** using `cowsay` with the exact message:

```
Run for cover, i am a Dragon
```

## 1) Register your self-hosted runner

1. In your GitHub repo, go to **Settings → Actions → Runners → New self-hosted runner**.
2. Choose your OS (Linux/macOS or WSL for Windows users) and **follow the commands shown** to download and extract the runner bundle.
3. Configure the runner, adding a custom label (e.g., `local`) so the workflow can target it:
   ```bash
   ./config.sh --url https://github.com/<OWNER>/<REPO> --token <TOKEN> --labels local
   ```
   > You can add more labels (e.g., `linux`, `x64`) if you like.

4. Start it in the foreground (good for testing):
   ```bash
   ./run.sh
   ```

   Or install as a service (Linux/macOS):
   ```bash
   sudo ./svc.sh install
   sudo ./svc.sh start
   ```

   **Stop / status / uninstall**:
   ```bash
   sudo ./svc.sh stop
   sudo ./svc.sh status
   sudo ./svc.sh uninstall
   ```

> **Network note:** The runner needs outbound access to GitHub over HTTPS (port 443). Ensure your firewall/proxy allows this.

## 2) Workflow: target your self-hosted runner

The workflow is in **`.github/workflows/dragon.yml`** and uses:
```yaml
runs-on: [self-hosted, local]
```
Replace `local` with whatever custom label you used during runner setup.

## 3) Cowsay + Dragon script

The job installs `cowsay` if needed and then executes **`scripts/dragon.sh`**, which prints:

```
Run for cover, i am a Dragon
```

If the `dragon` cowfile is available (standard in most cowsay packages), it will render the **dragon**. Otherwise, it falls back to the default cow and warns in the logs.

## 4) Triggering & viewing logs

- Manually trigger via **Actions → Dragon on Self-Hosted Runner → Run workflow**.
- Or push a change touching the workflow/script paths:
  - `.github/workflows/dragon.yml`
  - `scripts/dragon.sh`

In the job logs you should see the ASCII output from `cowsay`.

## 5) Start/Stop & Re-run quick reference

- **Start (foreground):**
  ```bash
  cd ~/actions-runner && ./run.sh
  ```
- **Start (service):**
  ```bash
  sudo ./svc.sh start
  ```
- **Stop (service):**
  ```bash
  sudo ./svc.sh stop
  ```
- **Re-run the job:** In **Actions**, open the run → **Re-run all jobs** (or **Re-run failed jobs**).

---

### Troubleshooting

- **Runner offline?** Make sure `./run.sh` is running or the service is started, and that the label in the workflow matches the label you configured.
- **cowsay not found?** The workflow tries to install it. If your OS/package manager differs, install cowsay manually:
  - Debian/Ubuntu: `sudo apt-get install cowsay`
  - Fedora/RHEL: `sudo dnf install cowsay` or `sudo yum install cowsay`
  - macOS (Homebrew): `brew install cowsay`
- **No `dragon` cowfile?** Check available cowfiles with `cowsay -l`. If `dragon` isn’t listed, install the full cowsay package or add custom cowfiles to your `COWPATH`.
