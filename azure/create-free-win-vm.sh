#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Azure Free-Tier-eligible Windows VM (RDP) banane wali script
#
# Kya karti hai:
#   - Standard_B2ats_v2 (free-eligible burstable) Windows Server 2022 VM
#   - 64 GiB P6 OS disk (127 GiB default NOT free hota hai)
#   - Basic + Dynamic public IP (Standard IP chargeable hai)
#   - Auto-shutdown 23:00 IST  -> bill bachata hai
#   - Monitoring / boot diagnostics OFF
#
# Use:
#   1) az login
#   2) bash azure/create-free-win-vm.sh 'YourStrongPassw0rd!'
#   3) (optional) Tailscale mode:  USE_TAILSCALE=1 bash azure/create-free-win-vm.sh 'Pass!'
#      -> public RDP port band, sirf Tailscale se RDP
#   4) Delete:  bash azure/create-free-win-vm.sh --delete
#
# NOTE: Student subscription / Free Trial subscription hona chahiye, warna
#       free 750-hour allowance apply nahi hoga.
# ---------------------------------------------------------------------------
set -euo pipefail

RG="${RG:-rg-rdp}"
LOCATION="${LOCATION:-centralindia}"
VM_NAME="${VM_NAME:-win-rdp-01}"
IMAGE="${IMAGE:-MicrosoftWindowsServer:WindowsServer:2022-datacenter-azure-edition-smalldisk:latest}"
ADMIN_USER="${ADMIN_USER:-AdminPC}"
USE_TAILSCALE="${USE_TAILSCALE:-0}"

if [[ "${1:-}" == "--delete" ]]; then
  echo "Deleting resource group '$RG' (VM + disk + IP sab delete honge)..."
  az group delete --name "$RG" --yes --no-wait
  echo "Done. Delete background me chal raha hai."
  exit 0
fi

PASSWORD="${1:-}"
if [[ -z "$PASSWORD" ]]; then
  echo "Usage: bash azure/create-free-win-vm.sh 'YourStrongPassw0rd!'   [--delete]" >&2
  echo "Password: 12+ chars, uppercase + lowercase + digit + symbol." >&2
  exit 1
fi

echo "==> Resource group $RG ($LOCATION)"
az group create --name "$RG" --location "$LOCATION" --output none

if [[ "$USE_TAILSCALE" == "1" ]]; then
  NSG_RULE=(--nsg-rule NONE)      # 3389 internet pe band
else
  NSG_RULE=(--nsg-rule RDP)       # 3389 khulega - NSG ko baad me restrict karo
fi

echo "==> VM $VM_NAME"
az vm create \
  --resource-group "$RG" \
  --name "$VM_NAME" \
  --image "$IMAGE" \
  --size Standard_B2ats_v2 \
  --admin-username "$ADMIN_USER" \
  --admin-password "$PASSWORD" \
  --location "$LOCATION" \
  --public-ip-sku Basic \
  --public-ip-address-allocation Dynamic \
  --os-disk-size-gb 64 \
  --storage-sku Premium_LRS \
  --license-type Windows_Server \
  --boot-diagnostics-storage "" \
  "${NSG_RULE[@]}" \
  --output table

echo "==> Auto-shutdown 23:00 IST (compute cost bachane ke liye)"
az vm auto-shutdown \
  --resource-group "$RG" \
  --name "$VM_NAME" \
  --time 1730 \
  --output none   # 1730 UTC == 23:00 IST

if [[ "$USE_TAILSCALE" == "1" ]]; then
  echo "==> Tailscale install (public RDP band hai, isliye ye zaroori hai)"
  az vm run-command invoke \
    --resource-group "$RG" \
    --name "$VM_NAME" \
    --command-id RunPowerShellScript \
    --scripts "\$ErrorActionPreference='Stop'; \
      Invoke-WebRequest -Uri https://pkgs.tailscale.com/stable/tailscale-setup-latest-amd64.msi -OutFile \$env:TEMP\ts.msi; \
      Start-Process msiexec.exe -ArgumentList '/i',\"\$env:TEMP\ts.msi\",'/quiet','/norestart' -Wait; \
      & \"\$env:ProgramFiles\Tailscale\tailscale.exe\" up --unattended --authkey=\$env:TS_KEY" \
    --output table
  echo "(TS_KEY ko VM extension env me daalna padega — simplest: RDP ke baad manually 'tailscale up' chala lo)"
fi

echo
echo "================ PUBLIC IP ================"
az vm show -d --resource-group "$RG" --name "$VM_NAME" \
  --query "{IP:publicIps, FQDN:fqdns, Size:hardwareProfile.vmSize}" -o table
echo "Username: $ADMIN_USER"
echo "==========================================="
echo
echo "RDP: mstsc -> <IP>:3389  (ya Tailscale IP)"
echo "SECURITY: 3389 sabke liye khula hai. Apna IP whitelist karo:"
echo "  az network nsg rule update -g $RG --nsg-name ${VM_NAME}NSG -n default-allow-rdp --source-address-prefixes <YOUR_IP>/32"
echo "BAND karna:  az vm auto-shutdown + portal > VM > Stop"
echo "DELETE:      bash azure/create-free-win-vm.sh --delete"
