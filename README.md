# Azure Free Tier RDP — Poora Guide (Hinglish)

Azure free account se **free Windows RDP** kaise lete hain, step by step — aur bill ₹0 kaise rakhte hain.

> **Rule yaad rakho:** Azure ka free tier "unlimited free" nahi hai. Ye 3 cheezein milti hain: **$200 credit (30 din)**, **12 mahine ke liye kuch services free (isme 750 ghante/month VM)**, aur **65+ hamesha-free services**. Free tier se bahar nikle to card se paisa katega.

---

## 1. Kya-kya milta hai (numbers)

| Cheez | Kitna | Kitne din |
|---|---|---|
| Starting credit | **$200** (~₹17,000–18,000, rate ke hisaab se) | Sirf **30 din** |
| Windows VM | **750 ghante/month** — `B1s`, `B2pts_v2` (ARM), `B2ats_v2` (AMD) | **12 mahine** |
| Managed disk | **2 × 64 GiB (P6) Premium SSD** | 12 mahine |
| Public IP | **750 ghante dynamic (Basic) IP** | 12 mahine |
| Outbound data | 15 GB/month (inbound free) | 12 mahine |
| Baaki | Blob 5 GB, SQL 250 GB, Functions 10 lakh requests, etc. | 12 mahine / always |

**750 ghante = ~31.25 din.** Matlab **ek VM 24×7** chalao to poora mahina cover ho jaata hai. Do VM saath chalaye to 15 din me hours khatam — uske baad bill.

> Free VM sizes: `Standard_B1s` (1 vCPU, 1 GiB), `Standard_B2ats_v2` (2 vCPU, 1 GiB, AMD), `Standard_B2pts_v2` (2 vCPU, 1 GiB, ARM). **`B2ats_v2` best hai** — B1s phase out ho raha hai.

---

## 2. Account banana (10 minute)

1. **https://azure.microsoft.com/en-in/free** kholo → **"Try Azure for free"** / **Start free**.
2. Microsoft account se login karo (naya bana sakte ho, ya GitHub se bhi ho jaata hai). **Jo email signup me use kar rahe ho wahi Microsoft account ka email rakho.**
3. **About you** fill karo — country: **India**, naam, email, phone, address (PIN code sahi daalo).
4. **Phone verify** — SMS ya call se 4-digit code.
5. **Card verify** — credit/debit card. **₹2 ka temporary hold** lagta hai, 3–5 din me apne aap refund ho jaata hai.
   - **Virtual card / prepaid card accept nahi hota.** International transactions card pe ON hona chahiye.
   - Debit card chal jaata hai, par credit card zyada reliable hai.
   - Billing address bank ke record se match karna chahiye.
6. Agreement accept karo → **Sign up** → **Go to the portal**.

> Ek vyakti = **ek hi free account**. Doosra banana T&C violation hai, account band ho sakta hai.

---

## 2b. Student ho? — Azure for Students (card ki zarurat nahi)

**https://azure.microsoft.com/en-us/free/students/** — college email se verify karo, bas.

### Kya milta hai

| Cheez | Student offer | Normal free account |
|---|---|---|
| Credit | **$100 (~₹8,800)** | $200 (~₹17,600) |
| Credit kitne din | **12 mahine** | sirf **30 din** |
| Credit card | **Nahi chahiye** | Card + ₹2 hold |
| Verification | College email (`.ac.in`/`.edu`) | Phone + card |
| Renewal | **Har saal renew** (jab tak student ho) | Nahi |
| Windows/Linux VM | **750 h/month × 3 sizes** (`B1s`, `B2pts_v2`, `B2ats_v2`) | Same |
| 12-mahine wale free services | **20+ services** | Same |
| Always-free services | **65+** | Same |
| Azure OpenAI / AI services | Credit se access | Credit se access (30 din) |
| Quota increase (GPU etc.) | ❌ Nahi milta | ❌ Nahi |

**Student offer me 12 mahine tak:** VM (750 h/month = ek VM 24×7), Blob 5 GB, Azure Files 5 GB, SQL Database free tier (100,000 vCore-seconds/month + 32 GB), Functions 10 lakh requests/month, App Service F1, Static Web Apps, Container Registry (1 standard, 100 GB), Azure DevOps (5 users, unlimited private repos), Cosmos DB free tier, AI services ke monthly free amounts, aur Azure Machine Learning.

### Eligibility (2026 terms)
- **18+ age**
- **Full-time** student, **accredited degree-granting** institute (2- or 4-year). MOOC / coaching / for-profit course **nahi** chalega — Bihar ka koi bhi AICTE/UGC recognised college, engineering college, ya university theek hai
- Verification: **college email** — ya agar domain registered nahi hai to **enrolment letter / dated student ID / transcript upload** karo. **Undated ya unreadable document = reject** (sabse common reason)
- **Ek subscription per person**, non-transferable

### Agar college email domain register nahi hai (kaafi Indian colleges me hota hai)
1. **Document verification** try karo — offer page pe "verify another way" / support se proof upload. Dated enrolment letter ya fees receipt pe college stamp ho to best.
2. **Azure for Students Starter** — https://azure.microsoft.com/en-us/free/students/starter — **16+** (India), koi credit nahi, koi card nahi, par App Service / Functions / MySQL / App Insights / DevOps ke free tiers milte hain. RDP VM nahi milta, lekin learning + hosting ke liye kaam chal jaata hai.
3. **GitHub Student Developer Pack** — https://education.github.com/pack — isme bhi wahi Azure offer listed hai, aur GitHub Education se verify hone par Copilot Student, GitHub Pro, Codespaces, free domain, JetBrains, DigitalOcean credit etc. milte hain. Ek hi baar verify, dono jagah kaam.
4. **College IT/office se** apne domain ko Microsoft ke education verification me register karwa lo — poore batch ke kaam aayega.

### Student offer ke catch (padh lo)
- **$100 = 12 mahine ka budget, hard stop.** Khatam hone par subscription **disable** ho jaata hai — bill nahi aata. **90 din** ke andar Pay-As-You-Go pe upgrade karoge to resources bache rehte hain, warna delete.
- **12-mahine wale free allowances sirf naye Azure customers ko** milte hain — saal ke renewal pe credit milta hai par "first 12 months free" waale quotas dobara nahi milte.
- **Unused credit roll over nahi hota.**
- **Marketplace, support plans, third-party products credit se nahi chalte.**
- **Quota increase nahi** — GPU/ML bade machines realistically nahi.
- 750 ghante = **ek** free-size VM 24×7. Do VM saath chalaoge to ~15 din me khatam.

### Budget math (Central India, indicative)
| Setup | Free period ke andar | 12 mahine ke baad |
|---|---|---|
| `B2ats_v2` Windows 24×7 | **₹0** (750 h quota) | ~$11/month ≈ **₹970/month** |
| 64 GiB P6 Premium SSD | ₹0 (2 disks free) | ~₹350/month/disk |
| Basic dynamic public IP | ₹0 (750 h) | ~₹250/month |

> **Warning:** internet pe "free edu email generator" (EduMailFree jaise) se student verify karne ki tricks milti hain — wo **fraud** hai, Microsoft pakadta hai aur account + card permanently ban ho jaata hai. Apna asli college email hi use karo.


---

## 3. Free Windows VM banana (RDP ke liye)

Portal me **"Create a resource" → "Virtual Machine"** — ya seedha free services page se banao taaki free-eligible options default ho jaayein: **https://portal.azure.com/#view/Microsoft_Azure_Billing/FreeServicesBlade**

| Tab | Setting | Value |
|---|---|---|
| Basics | Subscription | *Free Trial* / *Azure for Students* |
| Basics | Resource group | `rg-rdp` (naya banao) |
| Basics | VM name | `win-rdp-01` |
| Basics | Region | **Central India** (ya wahi jo sabse paas ho — `B2ats_v2` available hona chahiye) |
| Basics | Image | **Windows Server 2022 Datacenter: Azure Edition — x64 Gen2** (`[smalldisk]` wala best) |
| Basics | Size | **`Standard_B2ats_v2`** (ya `Standard_B1s`). **`Standard_B2ats_v2`** dhoondhne ke liye "See all sizes" → filter `basv2` |
| Basics | Inbound ports | **RDP (3389)** — neeche security note padho |
| Disks | OS disk size | **64 GiB** (Windows default 127 GiB hota hai = **not free**) |
| Disks | OS disk type | Standard SSD ya Premium SSD **P6 (64 GiB)** |
| Networking | Public IP | **Basic / Dynamic** (Standard IP ka paisa lagta hai) — Tailscale use kare to **None** |
| Networking | NIC network security group | **Basic** (free) |
| Management | Auto-shutdown | **ON, 11:00 PM IST** — bill ki sabse badi bachat |
| Management | Monitoring / Backup / Defender | **Sab OFF** (Log Analytics, Backup, Defender = chargeable) |
| Advanced | Extensions / Custom script | Skip |

**Create** dabao → 5–10 minute me deploy ho jayega.

### Connect kaise kare
- Portal me VM → **Connect → RDP** → `.rdp` file download → Windows me **Remote Desktop Connection** kholo, **Mac** pe **Microsoft Remote Desktop / Windows App**, **Android/iOS** pe "Windows App" / "RD Client".
- Username: `AdminPC` (jo aapne diya), password: jo create karte waqt set kiya tha.
- Ya phir **Tailscale** (free: 3 users, 100 devices) install karke private IP se RDP karo — port 3389 internet pe kholne ki zarurat hi nahi. Ye sabse safe.

### Security (ye skip mat karo)
- 3389 public internet pe khula = har roz automated login attempts. **Strong password** + `fDenyTSConnections=0` ke saath Network Security Group me **sirf apna IP** allow karo: `az network nsg rule update --source-address-prefixes <your-ip>/32`.
- Update ke liye RDP ke andar Windows Update chalao.
- `AdminPC / Alpha@1234` jaisa fixed password kabhi mat use karo.

---

## 4. Bill ₹0 kaise rakhein — checklist

- [ ] VM size **teen free sizes me se** hi hai (`B1s` / `B2ats_v2` / `B2pts_v2`) — `D2s`, `B2s` etc. paid hain.
- [ ] OS disk **64 GiB (P6)** hai, 127 GiB nahi.
- [ ] Public IP **Basic/Dynamic** hai ya bilkul nahi. **Standard Public IP ~₹250–350/month** charge karta hai.
- [ ] **Auto-shutdown ON** hai (11 PM). Band VM ka compute charge nahi lagta, par **disk ka thoda charge** lagta hai — poora free chahiye to disk free allowance me rakho.
- [ ] Log Analytics / Monitoring Insights / Backup / Defender for Cloud off hain.
- [ ] Sirf **ek** free-size VM chal rahi hai (750 ghante shared hain).
- [ ] **Budget alert** laga do: Portal → *Cost Management + Billing* → *Budgets* → **₹100/month**, alert 50% pe.
- [ ] Portal → *Cost Management* → **Free tier / Credits used** roz ya hafte me ek baar dekh lo.
- [ ] Kaam khatam? **Resource group delete** kar do (`az group delete -n rg-rdp`) — disk ka charge bhi band.

### 30 din ke baad kya hota hai
- $200 credit **30 din me expire** ho jaata hai. Credit khatam ya 30 din poore → trial subscription **auto-disable**. Bill nahi aata, bas services ruk jaati hain.
- **12-mahine wale free services chalte rahein iske liye 30 din ke andar Pay-As-You-Go pe upgrade karna padta hai.** Upgrade ke baad bhi free limits ke andar rehne tak kuch nahi katega — bilkul tabhi jab aap khud free limits cross karoge.
- 12 mahine poore → VM ka free quota khatam, uske baad normal rate (B1s ~$7.59/month ≈ ₹670/month).

---

## 5. Azure CLI se ek command me (jo log CLI pasand karte hain)

`azure/create-free-win-vm.sh` file me ready script hai. Pehle `az login` karo, phir:

```bash
bash azure/create-free-win-vm.sh 'YourStrongPassw0rd!'
```

Script `Standard_B2ats_v2` + 64 GiB disk + Basic IP + auto-shutdown ke saath VM banata hai — yaani free-tier compliant.

---

## 6. Ek important baat GitHub Actions ke baare me

GitHub-hosted runner ko RDP desktop banane wale workflows (windows-latest pe registry tweak + `while(true)` + Tailscale) **GitHub Acceptable Use Policy** ke against hain — Actions CI/CD ke liye hai, interactive machine chalane ke liye nahi. Isse aapka **poora GitHub account** suspend ho sakta hai, sirf repo nahi. Azure free tier exactly wahi cheez legit tarike se deta hai: asli VM, apna control, aapka hi account safe.

---

## Costs at a glance (2026)

| Item | Free tier | Free ke baad / paid |
|---|---|---|
| `B2ats_v2` Windows VM | 750 h/month, 12 months | ~₹700/month 24×7 |
| 64 GiB Premium SSD (P6) | 2 disks free | ~₹350/month per disk |
| Basic dynamic public IP | 750 h free | ~₹250/month |
| Bandwidth outbound | 15 GB/month | ~₹7/GB |

*Prices indicative hain — region aur exchange rate se badalte hain. Exact figure ke liye [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/) use karo.*
