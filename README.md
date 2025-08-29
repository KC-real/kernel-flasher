
---

# 🚀 **KERNEL FLASHER \[KF]**

**KF (Kernel Flasher)** is a **custom USB flasher**.
We **DIDN’T skid** from Rufus, Ventoy, or others — this is a **fresh project**, fully **open-source**, built for everyone.

> ✦ **Fork it. Remix it. Improve it.**
> ✦ Just **give KCdev credit**, that’s all I ask. 🙏

---

## 🛠️ **How to Customize**

1. Go to the **`payloads/`** folder.

2. Inside you’ll find:

   * **`config.json`** → your boot config
   * **`default.iso`** → placeholder ISO (0KB)

3. **Drop** your own `.iso`, `.img`, or `.bin` files into **`payloads/`**

4. **Edit `config.json`** like this:

```json
{
  "name": "Arch Linux",
  "file": "archlinux.iso"
}
```

* **`name`** → what shows up in the flasher menu
* **`file`** → must match the **real filename**

Save it, boot, and you’re done. ✅

---

## 📦 **What’s Included**

* **`payload.sh`** → main script (menu system, don’t edit)
* **`config.json`** → defines payload names + paths
* **`config.txt`** → bootloader config (don’t touch)

---

## ⚡ **How It Works**

1. You **drop payloads** into `payloads/`
2. **`config.json` tells `payload.sh`** what to show
3. Boot → KF runs → **menu pops up** → flash begins

Minimal. Clean. **No GRUB needed.**

---

## ❓ **Q\&A**

**Q: Why use this instead of Rufus?**
**A:** KF is **super lightweight** and designed for **multi-device flashing**. Rufus is great, but KF is about **simplicity** and **portability**.

**Q: This looks too simple to work.**
**A:** **False.** Simplicity = power. KF boots with almost **no overhead**, so even low-spec devices can run it.

---

## 📝 **Update v1.0**

✔ **Terminal-based menu**
✔ **Easy config system**
✖ **No GRUB (on purpose)**

---

## 🖥️ **Supported Devices**

* ✅ **Raspberry Pi 4**
* ✅ **Raspberry Pi 5**
* ⚠️ **Android (USB-OTG, experimental)**
* 🔜 **More to come**

---

## ⚠️ **Warning**

This project is **entirely untested**.
We at **Kernel Core** cannot guarantee stability yet — but **in theory, it works.**

> **Use at your own risk.**
> Contributions & testing are welcome!

---

## 🔑 **Credits**

* Built by **KCdev**
* Kernel Core 2025

---

⚡ *“If it looks too simple to work, that means you’re not thinking KC enough.” – **KCdev***

---
