awk 'NR == FNR { exclude[$0] = 1; next } { split($0, parts, "/"); filename = parts[length(parts)]; gsub(/\..*$/, "", filename); if (!(filename in exclude)) print }' snps1_imiss_99 bamlist_acropora.txt > filtered_acropora_bams.txt
awk 'NR == FNR { exclude[$0] = 1; next } { split($0, parts, "/"); filename = parts[length(parts)]; gsub(/\..*$/, "", filename); if (!(filename in exclude)) print }' snps1_imiss_98 bamlist_acropora.txt > filtered_acropora_bams98.txt

awk 'NR==FNR { sites[$1]=1; next } { match($0, /\/([A-Z0-9]{5})_/, arr); if (arr[1] in sites) print }' cebu_sites.txt Acropora_taxon1.txt > acro_cebu1.txt
awk 'NR==FNR { sites[$1]=1; next } { match($0, /\/([A-Z0-9]{5})_/, arr); if (arr[1] in sites) print }' cebu_sites.txt Acropora_taxon2.txt > acro_cebu2.txt
awk 'NR==FNR { sites[$1]=1; next } { match($0, /\/([A-Z0-9]{5})_/, arr); if (arr[1] in sites) print }' cebu_sites.txt Acropora_taxon3.txt > acro_cebu3.txt
awk 'NR==FNR { sites[$1]=1; next } { match($0, /\/([A-Z0-9]{5})_/, arr); if (arr[1] in sites) print }' cebu_sites.txt Acropora_taxon4.txt > acro_cebu4.txt

awk 'NR==FNR { sites[$1]=1; next } { match($0, /\/([A-Z0-9]{5})_/, arr); if (arr[1] in sites) print }' cebu_sites.txt Cladocopium_taxon1.txt > clad_cebu1.txt
awk 'NR==FNR { sites[$1]=1; next } { match($0, /\/([A-Z0-9]{5})_/, arr); if (arr[1] in sites) print }' cebu_sites.txt Cladocopium_taxon2.txt > clad_cebu2.txt
awk 'NR==FNR { sites[$1]=1; next } { match($0, /\/([A-Z0-9]{5})_/, arr); if (arr[1] in sites) print }' cebu_sites.txt Cladocopium_taxon3.txt > clad_cebu3.txt
awk 'NR==FNR { sites[$1]=1; next } { match($0, /\/([A-Z0-9]{5})_/, arr); if (arr[1] in sites) print }' cebu_sites.txt Cladocopium_taxon4.txt > clad_cebu4.txt