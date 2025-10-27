# 🗺️ CONCEPTS and COMMANDS: Git Beyond Basics

## 🔧 ESSENTIAL CONFIGURATION. SOME ARBITRARY NAMES WE USE

### **REPOSITORIES AND REMOTES**
```bash
# BASIC STRUCTURE
RepoU - Upstream = https://git-lab_hub.com/PROJECT/ORIGINAL.git
RepoF - Your Fork = https://git_lab_hub.com/YOUR_USERNAME/PROJECT.git  
RepoL - Local = Clone of RepoF

# INITIAL SETUP
git clone https://git-lab_hub.com/YOUR_USERNAME/PROJECT.git
cd PROJECT
git remote add upstream https://git-lab_hub.com/PROJECT/ORIGINAL.git
```

### **CONFIGURATION VERIFICATION**
```bash
git remote -v
# Should show:
# origin    https://git-lab_hub.com/YOUR_USERNAME/PROJECT.git (fetch/push)
# upstream  https://git-lab_hub.com/PROJECT/ORIGINAL.git (fetch/push)
```

---

## 🔄 FORK SYNCHRONIZATION - COMPLETE WORKFLOW

### **ACTUAL SYNCHRONIZATION FLOW (concept)**
```
RepoU → [git fetch upstream] → RepoL → [git push origin upstream/main:main] → RepoF
```

### **BASIC SYNCHRONIZATION - 2 KEY STEPS - commands**
```bash
# STEP 1: Bring changes from RepoU to RepoL
git fetch upstream

# STEP 2: Send changes from RepoL to RepoF  
git push origin upstream/main:main

# SYNTAX EXPLANATION:
# git push [DESTINATION] [WHAT_TO_SEND]:[WHERE_TO_PUT_IT]
# git push origin   upstream/main  : main
#          ↑           ↑              ↑
#          RepoF   Reference      Branch in
#                  in RepoL        RepoF
```

### **CRITICAL TECHNICAL DETAILS - concept**
- **`upstream/main`**: Not a normal branch, it's a "remote-tracking branch" in your RepoL
- **`origin`**: Points to your RepoF (automatically configured when cloning)
- **You only need read permissions** for RepoU, but **write permissions** for RepoF

### **ADVANCED SYNCHRONIZATION - commands**
```bash
# MULTIPLE BRANCHES
git fetch upstream
git push origin upstream/main:main
git push origin upstream/develop:develop

# AUTOMATIC SCRIPT
#!/bin/bash
echo "🔄 Synchronizing fork..."
git fetch upstream
git push origin upstream/main:main
echo "✅ Fork updated"
```

### **CONFLICT RESOLUTION - commands**
```bash
# If push fails (non-fast-forward):
git push --force-with-lease origin upstream/main:main

# Nuclear synchronization (only for severely damaged forks):
git push --force origin upstream/main:main
```

---

## 💻 PRACTICAL WORKFLOWS

### **BEGINNER WORKFLOW**
```bash
# 1. Synchronize fork before working
git fetch upstream
git push origin upstream/main:main

# 2. Update local from updated fork
git pull origin main

# 3. Create feature branch
git checkout -b my-feature

# 4. Work and commit...
git add .
git commit -m "My change"

# 5. Push to fork
git push origin my-feature
```

### **CONTRIBUTION WORKFLOW**
```bash
# 1. Synchronize EVERYTHING
git fetch upstream
git push origin upstream/main:main
git checkout main
git pull origin main

# 2. Branch from updated main
git checkout -b fix-issue

# 3. Development with periodic rebase
git fetch upstream
git rebase upstream/main    # Keeps history clean

# 4. Push for PR (safe)
git push --force-with-lease origin fix-issue
```

---

## 🧩 PATCH MANAGEMENT

### **TRADITIONAL PATCHES (.diff/.patch)**
```bash
# GENERATE
git diff > change.patch
git format-patch HEAD~1

# APPLY
git apply --check change.patch    # Verify without applying
git apply change.patch           # Apply without commit
```

### **MBOX PATCHES (B4)**
```bash
# COMPLETE B4 WORKFLOW
b4 am -o ./patches MSG-ID@list.com    # Download
b4 am -l                              # List
b4 am -s MSG-ID@list.com              # Apply series

# MANUAL APPLICATION
git am *.patch                       # Apply maintaining metadata
```

### **PATCH CONFLICT RESOLUTION**
```bash
git am --show-current-patch         # View conflicting patch
# Edit files manually...
git add files/
git am --continue
```

---

## 🧹 MAINTENANCE AND CLEANUP

### **HISTORY CLEANUP**
```bash
# REMOVE LARGE FILES
git filter-repo --path large-file.zip --invert-paths

# POST-CLEANUP OPTIMIZATION
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

### **REPOSITORY ANALYSIS**
```bash
# IDENTIFY LARGE FILES
git rev-list --objects --all | \
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
  awk '/^blob/ {print substr($0,6)}' | \
  sort --numeric-sort --key=2 | \
  tail -10

# CHECK STATUS
git count-objects -v
git gc
```

---

## 🚀 QUICK DECISION TABLE

| **SCENARIO** | **OPERATION** | **COMMAND** |
|---------------|---------------|-------------|
| **Update fork** | Basic sync | `git fetch upstream && git push origin upstream/main:main` |
| **Work on feature** | Branch + development | `git checkout -b feature && git push origin feature` |
| **Keep feature updated** | Periodic rebase | `git fetch upstream && git rebase upstream/main` |
| **Push after rebase** | Safe push | `git push --force-with-lease origin feature` |
| **Apply email patches** | Complete B4 | `b4 am -s MSG-ID && git am patches/*.patch` |
| **Recover corrupt fork** | Forced synchronization | `git push --force origin upstream/main:main` |

---

## ⚠️ BEST PRACTICES - REMEMBER

### **✅ ALWAYS DO:**
- `git fetch upstream` before synchronizing
- `--force-with-lease` instead of `--force`
- `git apply --check` before applying patches
- Backup before destructive operations

### **❌ AVOID:**
- Modifying already shared history
- `git push --force` without `--force-with-lease`
- Operations without understanding consequences
- Synchronizing without verifying changes

### **🔄 REBASE vs MERGE:**
- **REBASE**: For local/non-shared work (cleans history)
- **MERGE**: For collaborative integration (preserves history)

---

## 🎯 EXECUTIVE SUMMARY

**SETUP:** `git remote add upstream` (once)  
**SYNCHRONIZATION:** Two magic commands: `fetch upstream` + `push origin upstream/main:main`  
**ACTUAL FLOW:** RepoU → RepoL → RepoF (RepoL as bridge)  
**WORKFLOW:** Branch + rebase + safe push  
**PATCHES:** B4 for email, git apply for local  
**MAINTENANCE:** filter-repo + aggressive gc  

**Ready for field operations!** 🚀
