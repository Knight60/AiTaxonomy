import winsound
frequency = 2500  # Set Frequency To 2500 Hertz
duration = 1000  # Set Duration To 1000 ms == 1 second
aprx = arcpy.mp.ArcGISProject('current')
for lyr in aprx.listMaps()[0].listLayers():
    if lyr.name == 'AiGreenGrid6x10':
        grid = lyr
        break

