"""
Script for calculating distance to shore for A tenuis samples
Author: Jaelyn Bos
2025
"""

'Import libraries'
import numpy as np
import pandas as pd
import geopandas as gpd
import xrspatial as xrs
from geocube.api.core import make_geocube
from shapely.geometry import Polygon

'Path to folder where logger data is saved'
path = '/hb/home/jbos/'

'Path to folder whre shoreline data is saved'
shore_path = '/hb/scratch/jbos/coastlines/'

'Path to folder where logger data with calculated distances will be saved'
out_path = '/hb/home/jbos/'

'Import shoreline data. Data is open source line map from OpenStreetMap project'
shoreline = gpd.read_file(shore_path + 'lines.shp')

'Remove data outside the study area'
philippines_mask = Polygon([(123,9),(123,12),(126,12),(126,9)])
shoreline = gpd.clip(shoreline,philippines_mask)
shoreline['SHORE'] = 1

'Convert shoreline data to raster (geocube), define resolution and CRS based on metadata'
shorecube =  make_geocube(vector_data=shoreline, output_crs="EPSG:4326",resolution=(0.001,0.001), fill=0)['SHORE']

'Use proximity function from the xarray-spatial packages to calculate the great circle distance between each non-shoreline pixel and the nearest shoreline'
shoredist = xrs.proximity(shorecube,distance_metric='GREAT_CIRCLE')

'Import site data and add region column before concatenating'
locs = pd.read_csv(path + 'merged_metadat.csv')

'Calculte distance to shore for each logger by finding the nearest pixel centroid of the distance surface to each logger lat/lon pair'
dists = []
for i in range(0,len(locs)):
    row = locs.iloc[i,:]
    x = (shoredist.sel(x = row['lon'], y = row['lat'], method="nearest"))
    y = x.values.item()
    dists.append(y)

'Add SHOREDIST column, with distance to shore in meters, to the logger dataset and export as csv'
locs['SHOREDIST'] = pd.Series(dists) 
locs.to_csv(out_path + 'metadata_shoredist.csv')
