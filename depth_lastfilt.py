import numpy as np
import pandas as pd

dp = pd.read_table('/hb/scratch/jbos/spp1/filt_depth.gdepth')
dp[dp.iloc[:,3:len(dp.columns)]<0] = np.nan
mean_dps=np.nanmean(dp.iloc[:,3:len(dp.columns)],axis=1)
highdp=dp.iloc[mean_dps>np.quantile(mean_dps,0.98),0:2]

highdp.to_csv('/hb/scratch/jbos/spp1/highdp2.txt',index=False,sep ='\t')