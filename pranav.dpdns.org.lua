-- Zone: pranav.dpdns.org
-- Source of truth for LuaDNS. This file REPLACES all records in the zone.
-- Purpose: test Cloudflare as Secondary DNS (incoming AXFR).

-- _a is set by LuaDNS to the zone name ("pranav.dpdns.org")

a(_a,         "192.0.2.1")
a("www",      "192.0.2.2")
a("mail",     "149.28.45.48")

mx(_a,        "mail.pranav.dpdns.org.", 10)

txt(_a,       "v=spf1 a mx ~all")
txt("_dmarc", "v=DMARC1; p=quarantine")
txt("cf-secondary-test", "axfr-canary-001")

-- Zone transfer ACL.
-- slave(hostname, ip) adds an NS record and allows AXFR from <ip>.
-- Cloudflare AXFR source IPs (new set; old 198.41.x ranges die 2026-12-01):
slave("ns-cf1.example.net", "104.30.167.163")
slave("ns-cf2.example.net", "104.30.167.173")

-- Your current egress IP, so you can verify with dig independently.
-- NOTE: 104.28.24.83 is a shared Cloudflare WARP egress address and will rotate.
slave("ns-me.example.net", "104.28.24.83")
