<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=30&pause=1000&color=00FF00&center=true&vCenter=true&width=850&lines=HashBreaker+Framework;Offline+Hash+Cracking+Tool;Built+with+Bash+%F0%9F%94%A5;By+Rushi20Pute" alt="Typing SVG" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Bash-green?style=for-the-badge">
  <img src="https://img.shields.io/badge/Platform-Linux-blue?style=for-the-badge">
  <img src="https://img.shields.io/badge/Category-Cyber%20Security-red?style=for-the-badge">
  <img src="https://img.shields.io/badge/Status-Stable-success?style=for-the-badge">
</p>

---

### 🕶️ HashBreaker Framework

**HashBreaker** is a **Bash-based Offline hash cracking framework** designed to help learners understand **password hashing, brute-force techniques, and encoding/decoding mechanisms** at a practical level.

This project follows a **framework-style architecture**, where each module has a specific responsibility, making it easy to understand, maintain, and extend.

> **⚠️ Strictly for educational and ethical hacking purposes only.**

---

## 🚀 Key Features

- 🔐 Offline hash cracking using wordlists
- 🧠 Multi-algorithm hash support
- ⚙️ Automatic wordlist handling in cracking module
- 🧪 Hash generator for testing & learning
- 🔄 Encoder & Decoder utilities (Base64)
- 🎨 Interactive terminal UI with banners
- ⌨️ Stable input handling (backspace issues fixed)
- 🧩 Modular & scalable framework design

---

### 🔥 Supported Hash Algorithms

🔹 **MD5**  
🔹 **SHA1**  
🔹 **SHA224**  
🔹 **SHA256**  
🔹 **SHA384**  
🔹 **SHA512**  
🔹 **NTLM**

> ℹ️ 32-character hashes are handled carefully to avoid MD5 / NTLM confusion.

---
### 🔁 Encoding & Decoding Support

HashBreaker is not limited to hash cracking only.
It also provides dedicated Encoder and Decoder modules to handle common data encodings used in real-world security analysis.

### 📦 Supported Encoding / Decoding Formats

🔹 **Base64**  
🔹 **Base32**  
🔹 **Hexadecimal**  
🔹 **URL Encoding**  
🔹 **Binary**  
🔹 **ROT13**  
🔹 **ASCII**

> ⚠️ Note: Hashing and encoding are different concepts.
> This framework supports offline hash cracking and data encoding/decoding as separate utilities for learning purposes.

---

### 💻 Installation & Usage
**📥 Clone the Repository**
```
https://github.com/Rushi20pute/The_HashBreaker

```
**🔓 Grant Permissions**
```
chmod +x hashbreaker.sh
chmod +x core/*.sh utils/*.sh
```
**▶️ Run the Framework**
```
./hashbreaker.sh
```
### 📚 Notes
- Linux system required (Kali recommended)
- Uses offline wordlists from wordlists/
- Educational & authorized use only

---

## 📂 Project Structure

```text
The_Hashbreaker/
│
├── ⚙️  hashbreaker.sh
│   └── Main framework controller
│
├── 🧠 core/
│   ├── 🔓 cracker.sh
│   │   └── Hash cracking engine
│   │
│   ├── 🧪 generator.sh
│   │   └── Hash generator module
│   │
│   └── 🕵️ detector.sh
│       └── Hash detection logic
│
├── 🛠️ utils/
│   ├── 🔄 decoder.sh
│   │   └── Decode encoded data
│   │
│   └── 🔁 encoder.sh
│       └── Encode plain text
│
├── 📚 wordlists/
│   ├── 🔑 common.txt
│   │   └── Common frequently used passwords
│   │
│   ├── 🔢 numeric.txt
│   │   └── Common numeric passwords (PINs, years, patterns)
│   │
│   ├── 🇮🇳 indian_male_names.txt
│   │   └── Common Indian male names
│   │
│   └── 🇮🇳 indian_female_names.txt
│       └── Common Indian female names
│
└── 📘 README.md
    └── Project documentation

```
---
### 🧠 Use Case

- Cybersecurity learning & experimentation
- Ethical hacking practice labs
- Understanding password weaknesses
- Bash scripting portfolio projects
- College / academic cybersecurity projects

---

### 🔮 Planned Enhancements

**Future versions of HashBreaker may include:**

- ➕ Additional hash algorithms

- 📚 Expanded and optimized wordlists

- ⚡ Performance improvements in cracking engine

- 🧩 Plugin-based module architecture

- 🖥️ Logging, reporting & result export features

> ❗ Usage is restricted to authorized and educational environments only.
 
---

## 👨‍💻 Author

**Rushi20Pute**    
> **Ethical Hacking | Cybersecurity | Bash Scripting**

---

### ⭐ Disclaimer

This project is created strictly for educational purposes.
Any unauthorized usage against systems without explicit permission is **illegal and unethical**.










