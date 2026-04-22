# Local Backup & Restore Specification

- Fully local encrypted .enc file
- Use isar.copyToFile() for snapshot
- AES-256 encryption using key from flutter_secure_storage
- Optional custom password during backup
- Save to Downloads folder by default using file_picker
- Restore: decrypt → replace default.isar → reopen Isar → soft restart
- Reminder logic based on user-selected interval stored in Isar AppSettings