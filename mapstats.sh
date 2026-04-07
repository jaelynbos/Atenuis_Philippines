#!/bin/bash

#SBATCH --job-name=mapping_stats
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH -o mapstats-%A_%a.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=END
#SBATCH --mem=112G
#SBATCH --time=2:00:00
OUTPUT="mapping_stats.txt"

cd /hb/scratch/jbos/samfiles
OUTPUT="atenuis_mapping.txt"

# Write header
echo -e "sample_id\tmapped_reads\tunmapped_reads" > $OUTPUT

# Loop through all SAM files
# Adjust the path pattern as needed for your files
for sam in /hb/scratch/jbos/samfiles/*.sam; do
    # Extract sample name (remove .sam extension)
    sample=$(basename "$sam" .sam)
    
    # Count mapped reads (exclude unmapped flag 4)
    mapped=$(samtools view -c -F 4 -S "$sam")
    
    # Count unmapped reads (require unmapped flag 4)
    unmapped=$(samtools view -c -f 4 -S "$sam")
    
    # Write to output file
    echo -e "${sample}\t${mapped}\t${unmapped}" >> $OUTPUT
    
    # Optional: print progress to screen
    echo "Processed: $sample (mapped: $mapped, unmapped: $unmapped)"
done

echo "Done! Results saved to $OUTPUT"


cd /hb/scratch/jbos/amuricata_samfiles
OUTPUT="amuricata_mapping.txt"

# Write header
echo -e "sample_id\tmapped_reads\tunmapped_reads" > $OUTPUT

# Loop through all SAM files
# Adjust the path pattern as needed for your files
for sam in /hb/scratch/jbos/amuricata_samfiles/*.sam; do
    # Extract sample name (remove .sam extension)
    sample=$(basename "$sam" .sam)
    
    # Count mapped reads (exclude unmapped flag 4)
    mapped=$(samtools view -c -F 4 -S "$sam")
    
    # Count unmapped reads (require unmapped flag 4)
    unmapped=$(samtools view -c -f 4 -S "$sam")
    
    # Write to output file
    echo -e "${sample}\t${mapped}\t${unmapped}" >> $OUTPUT
    
    # Optional: print progress to screen
    echo "Processed: $sample (mapped: $mapped, unmapped: $unmapped)"
done

echo "Done! Results saved to $OUTPUT"

cd /hb/scratch/jbos/amillepora_samfiles
OUTPUT="amillepora_mapping.txt"

# Write header
echo -e "sample_id\tmapped_reads\tunmapped_reads" > $OUTPUT

# Loop through all SAM files
# Adjust the path pattern as needed for your files
for sam in /hb/scratch/jbos/amillepora_samfiles/*.sam; do
    # Extract sample name (remove .sam extension)
    sample=$(basename "$sam" .sam)
    
    # Count mapped reads (exclude unmapped flag 4)
    mapped=$(samtools view -c -F 4 -S "$sam")
    
    # Count unmapped reads (require unmapped flag 4)
    unmapped=$(samtools view -c -f 4 -S "$sam")
    
    # Write to output file
    echo -e "${sample}\t${mapped}\t${unmapped}" >> $OUTPUT
    
    # Optional: print progress to screen
    echo "Processed: $sample (mapped: $mapped, unmapped: $unmapped)"
done

echo "Done! Results saved to $OUTPUT"

cd /hb/scratch/jbos/aselago_samfiles
OUTPUT="aselago_mapping.txt"

# Write header
echo -e "sample_id\tmapped_reads\tunmapped_reads" > $OUTPUT

# Loop through all SAM files
# Adjust the path pattern as needed for your files
for sam in /hb/scratch/jbos/aselago_samfiles/*.sam; do
    # Extract sample name (remove .sam extension)
    sample=$(basename "$sam" .sam)
    
    # Count mapped reads (exclude unmapped flag 4)
    mapped=$(samtools view -c -F 4 -S "$sam")
    
    # Count unmapped reads (require unmapped flag 4)
    unmapped=$(samtools view -c -f 4 -S "$sam")
    
    # Write to output file
    echo -e "${sample}\t${mapped}\t${unmapped}" >> $OUTPUT
    
    # Optional: print progress to screen
    echo "Processed: $sample (mapped: $mapped, unmapped: $unmapped)"
done

echo "Done! Results saved to $OUTPUT"

cd /hb/scratch/jbos/agemmifera_samfiles

# Write header
echo -e "sample_id\tmapped_reads\tunmapped_reads" > $OUTPUT
OUTPUT="agemmifera_mapping.txt"

# Loop through all SAM files
# Adjust the path pattern as needed for your files
for sam in /hb/scratch/jbos/agemmifera_samfiles/*.sam; do
    # Extract sample name (remove .sam extension)
    sample=$(basename "$sam" .sam)
    
    # Count mapped reads (exclude unmapped flag 4)
    mapped=$(samtools view -c -F 4 -S "$sam")
    
    # Count unmapped reads (require unmapped flag 4)
    unmapped=$(samtools view -c -f 4 -S "$sam")
    
    # Write to output file
    echo -e "${sample}\t${mapped}\t${unmapped}" >> $OUTPUT
    
    # Optional: print progress to screen
    echo "Processed: $sample (mapped: $mapped, unmapped: $unmapped)"
done

echo "Done! Results saved to $OUTPUT"

cd /hb/scratch/jbos/cladocopium_sam

# Write header
echo -e "sample_id\tmapped_reads\tunmapped_reads" > $OUTPUT
OUTPUT="cladocopium_mapping.txt"

# Loop through all SAM files
# Adjust the path pattern as needed for your files
for sam in /hb/scratch/jbos/cladocopium_sam/*.sam; do
    # Extract sample name (remove .sam extension)
    sample=$(basename "$sam" .sam)
    
    # Count mapped reads (exclude unmapped flag 4)
    mapped=$(samtools view -c -F 4 -S "$sam")
    
    # Count unmapped reads (require unmapped flag 4)
    unmapped=$(samtools view -c -f 4 -S "$sam")
    
    # Write to output file
    echo -e "${sample}\t${mapped}\t${unmapped}" >> $OUTPUT
    
    # Optional: print progress to screen
    echo "Processed: $sample (mapped: $mapped, unmapped: $unmapped)"
done

echo "Done! Results saved to $OUTPUT"