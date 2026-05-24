#!/usr/bin/env bash
set -euo pipefail

# Configura acesso remoto ao QG via Tailscale (VPN mesh) + Tailscale SSH.
# Uso: bash scripts/setup-vpn.sh [hostname]
#
# Roda na MÁQUINA que hospeda o QG (servidor/desktop sempre ligado).
# Depois de rodar, qualquer dispositivo seu na mesma tailnet acessa via SSH.

HOSTNAME_ARG="${1:-mundoterra-qg}"

QG_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$QG_ROOT"

echo "==> Setup de VPN (Tailscale) para o Mundo Terra QG"
echo ""

# 1. Detectar SO
OS="$(uname -s)"
echo "==> Sistema: $OS"

# 2. Instalar Tailscale se necessário
if ! command -v tailscale >/dev/null 2>&1; then
  echo "==> Tailscale não encontrado. Instalando..."
  case "$OS" in
    Linux)
      curl -fsSL https://tailscale.com/install.sh | sh
      ;;
    Darwin)
      if command -v brew >/dev/null 2>&1; then
        brew install --cask tailscale
      else
        echo "ERRO: instale o Homebrew ou baixe o Tailscale em https://tailscale.com/download/mac"
        exit 1
      fi
      ;;
    *)
      echo "ERRO: SO não suportado automaticamente. Baixe em https://tailscale.com/download"
      exit 1
      ;;
  esac
else
  echo "  ✓ Tailscale já instalado ($(tailscale version | head -1))"
fi

# 3. Subir a tailnet com SSH habilitado
echo ""
echo "==> Conectando à tailnet com SSH habilitado (hostname: $HOSTNAME_ARG)..."
echo "    Uma URL de login vai aparecer — abra no navegador e autorize este dispositivo."
sudo tailscale up --ssh --hostname="$HOSTNAME_ARG"

# 4. Mostrar o IP/endereço da tailnet
echo ""
TS_IP="$(tailscale ip -4 2>/dev/null | head -1 || true)"
echo "==> Pronto! Este QG está acessível na sua tailnet."
[ -n "$TS_IP" ] && echo "    IP Tailscale: $TS_IP"
echo "    Hostname:     $HOSTNAME_ARG"
echo ""
echo "==> A partir de QUALQUER dispositivo seu (com Tailscale logado na mesma conta):"
echo "    ssh $(whoami)@$HOSTNAME_ARG"
[ -n "$TS_IP" ] && echo "    ssh $(whoami)@$TS_IP"
echo ""
echo "Dicas:"
echo "  - Use Tailscale SSH (sem gerenciar chaves): o acesso é autorizado pela tailnet."
echo "  - Para o QG ficar sempre online: 'sudo tailscale set --auto-update' e mantenha a máquina ligada."
echo "  - Apps Tailscale: https://tailscale.com/download (iOS, Android, macOS, Windows, Linux)."
