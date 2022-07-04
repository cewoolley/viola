import sys
import viola
print(sys.argv[1])
print(sys.argv[2])
print(sys.argv[3])
print(sys.argv[4])
manta = viola.read_vcf(sys.argv[1],variant_caller="manta")
lumpy = viola.read_vcf(sys.argv[2],variant_caller='lumpy')
delly = viola.read_vcf(sys.argv[3],variant_caller='delly')
merged_vcf = viola.merge([manta, lumpy, delly], threshold=100)
filtered_vcf = merged_vcf.filter('supportingcallercount >= 2')
out = [sys.argv[4],'.consensus.100bp.vcf']
filtered_vcf.to_vcf("".join(out))
