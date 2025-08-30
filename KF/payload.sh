#!/bin/bash
CONFIG_PATH="/payloads/config.cfx"
FLASH_TARGET="/dev/mmcblk0"
clear

# Random quotes
QUOTES=(
    "Payloads are simple... do a lil bit of that and that idk im new"
    "KCdev - 2025, Dont attempt to use this on apple... i dont wanna get sued"
    "Don't trust a USB... unless it's KCDEV signed 🔥"
    "Flash like it's 1999. Or don't, idc."
)

RANDOM_QUOTE=${QUOTES[$RANDOM % ${#QUOTES[@]}]}
VERSION=$(jq -r '.VER' "$CONFIG_PATH")

function show_menu() {
    clear
    echo ""
    echo "     {===KERNEL FLASHER===}"
    echo "          -{V$VERSION}-"
    echo "     {==================}"
    echo "  $RANDOM_QUOTE"
    echo ""

    INDEX=1
    PAYLOAD_OPTIONS=()

    for TYPE in IMG ISO BIN; do
        COUNT=$(jq ".$TYPE | length" "$CONFIG_PATH")
        for ((i=0; i<COUNT; i++)); do
            NAME=$(jq -r ".$TYPE[$i].name" "$CONFIG_PATH")
            FILE=$(jq -r ".$TYPE[$i].file" "$CONFIG_PATH")
            echo " $INDEX. $NAME ($TYPE)"
            PAYLOAD_OPTIONS+=("$TYPE|$FILE")
            ((INDEX++))
        done
    done

    echo " $INDEX. INFO"
    INFO_INDEX=$INDEX
    ((INDEX++))
    echo " $INDEX. EXIT"
    EXIT_INDEX=$INDEX
    echo ""
}

function flash_file() {
    local TYPE="$1"
    local FILE="$2"
    echo "[*] Flashing: $FILE as $TYPE..."

    case "$TYPE" in
        IMG)
            dd if="/payloads/$FILE" of=$FLASH_TARGET bs=4M status=progress conv=fsync
            ;;
        ISO)
            mkdir -p /mnt/iso
            mount -o loop "/payloads/$FILE" /mnt/iso
            cp -r /mnt/iso/* /mnt
            ;;
        BIN)
            dd if="/payloads/$FILE" of=$FLASH_TARGET bs=4M status=progress conv=fsync
            ;;
    esac

    echo "[✅] Flash complete. Rebooting..."
    sleep 2
    reboot
}

function info() {
    echo ""
    echo "=== KCDEV FLASHER v$VERSION ==="
    echo "Target Drive: $FLASH_TARGET"
    echo "Payloads Found:"
    ls /payloads
    echo ""
    read -p "[Press Enter to go back]"
}

while true; do
    show_menu
    read -p "Select option [1-$EXIT_INDEX]: " CHOICE

    if [[ "$CHOICE" -eq "$INFO_INDEX" ]]; then
        info
    elif [[ "$CHOICE" -eq "$EXIT_INDEX" ]]; then
        echo "[!] Exiting..."; sleep 1; clear; exit 0
    elif [[ "$CHOICE" -gt 0 && "$CHOICE" -lt "$INFO_INDEX" ]]; then
        PAYLOAD="${PAYLOAD_OPTIONS[$((CHOICE - 1))]}"
        TYPE=$(echo "$PAYLOAD" | cut -d'|' -f1)
        FILE=$(echo "$PAYLOAD" | cut -d'|' -f2)
        flash_file "$TYPE" "$FILE"
    else
        echo "[X] Invalid option." ; sleep 1
    fi
done
