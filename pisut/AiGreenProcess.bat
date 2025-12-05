import winsound
frequency = 2500  # Set Frequency To 2500 Hertz
duration = 1000  # Set Duration To 1000 ms == 1 second
aprx = arcpy.mp.ArcGISProject('current')
for lyr in aprx.listMaps()[0].listLayers():
    if lyr.name == 'AiGreenGrid6x10':
        grid = lyr
        break

#------------------------------------------------------------
grid.definitionQuery = "col = 1 and row = 2"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_001002.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_001002.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_001002_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_001002";
arcpy.CalculateField_management("AiGreenClasses6x10_001002", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001002",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_001002", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_001002")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_001002', "CLEAR_SELECTION")
print("Start Union","001002")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_001002 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_001002_Type.shp", "ALL", None, "GAPS")
print("Finish Union","001002")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001002_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_001002_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001002_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_001002_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_001002_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_001002_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001002_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_001002_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_001002_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_001002_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_001002_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_001002_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_001002_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","001002")
arcpy.management.DeleteField("AiGreenClasses6x10_001002_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_001002_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_001002_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_001002_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_001002_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","001002")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 1 and row = 3"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_001003.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_001003.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_001003_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_001003";
arcpy.CalculateField_management("AiGreenClasses6x10_001003", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001003",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_001003", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_001003")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_001003', "CLEAR_SELECTION")
print("Start Union","001003")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_001003 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_001003_Type.shp", "ALL", None, "GAPS")
print("Finish Union","001003")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001003_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_001003_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001003_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_001003_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_001003_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_001003_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001003_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_001003_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_001003_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_001003_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_001003_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_001003_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_001003_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","001003")
arcpy.management.DeleteField("AiGreenClasses6x10_001003_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_001003_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_001003_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_001003_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_001003_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","001003")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 1 and row = 7"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_001007.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_001007.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_001007_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_001007";
arcpy.CalculateField_management("AiGreenClasses6x10_001007", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001007",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_001007", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_001007")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_001007', "CLEAR_SELECTION")
print("Start Union","001007")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_001007 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_001007_Type.shp", "ALL", None, "GAPS")
print("Finish Union","001007")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001007_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_001007_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001007_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_001007_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_001007_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_001007_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001007_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_001007_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_001007_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_001007_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_001007_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_001007_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_001007_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","001007")
arcpy.management.DeleteField("AiGreenClasses6x10_001007_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_001007_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_001007_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_001007_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_001007_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","001007")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 1 and row = 9"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_001009.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_001009.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_001009_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_001009";
arcpy.CalculateField_management("AiGreenClasses6x10_001009", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001009",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_001009", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_001009")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_001009', "CLEAR_SELECTION")
print("Start Union","001009")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_001009 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_001009_Type.shp", "ALL", None, "GAPS")
print("Finish Union","001009")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001009_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_001009_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001009_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_001009_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_001009_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_001009_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001009_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_001009_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_001009_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_001009_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_001009_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_001009_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_001009_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","001009")
arcpy.management.DeleteField("AiGreenClasses6x10_001009_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_001009_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_001009_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_001009_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_001009_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","001009")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 1 and row = 10"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_001010.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_001010.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_001010_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_001010";
arcpy.CalculateField_management("AiGreenClasses6x10_001010", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001010",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_001010", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_001010")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_001010', "CLEAR_SELECTION")
print("Start Union","001010")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_001010 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_001010_Type.shp", "ALL", None, "GAPS")
print("Finish Union","001010")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001010_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_001010_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001010_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_001010_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_001010_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_001010_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_001010_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_001010_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_001010_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_001010_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_001010_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_001010_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_001010_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","001010")
arcpy.management.DeleteField("AiGreenClasses6x10_001010_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_001010_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_001010_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_001010_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_001010_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","001010")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 2 and row = 1"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002001.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002001.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_002001_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_002001";
arcpy.CalculateField_management("AiGreenClasses6x10_002001", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002001",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_002001", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_002001")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_002001', "CLEAR_SELECTION")
print("Start Union","002001")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_002001 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_002001_Type.shp", "ALL", None, "GAPS")
print("Finish Union","002001")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002001_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_002001_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002001_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_002001_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_002001_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_002001_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002001_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_002001_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_002001_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_002001_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_002001_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_002001_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_002001_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","002001")
arcpy.management.DeleteField("AiGreenClasses6x10_002001_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_002001_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_002001_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_002001_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_002001_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","002001")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 2 and row = 2"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002002.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002002.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_002002_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_002002";
arcpy.CalculateField_management("AiGreenClasses6x10_002002", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002002",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_002002", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_002002")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_002002', "CLEAR_SELECTION")
print("Start Union","002002")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_002002 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_002002_Type.shp", "ALL", None, "GAPS")
print("Finish Union","002002")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002002_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_002002_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002002_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_002002_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_002002_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_002002_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002002_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_002002_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_002002_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_002002_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_002002_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_002002_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_002002_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","002002")
arcpy.management.DeleteField("AiGreenClasses6x10_002002_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_002002_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_002002_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_002002_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_002002_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","002002")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 2 and row = 3"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002003.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002003.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_002003_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_002003";
arcpy.CalculateField_management("AiGreenClasses6x10_002003", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002003",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_002003", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_002003")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_002003', "CLEAR_SELECTION")
print("Start Union","002003")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_002003 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_002003_Type.shp", "ALL", None, "GAPS")
print("Finish Union","002003")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002003_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_002003_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002003_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_002003_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_002003_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_002003_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002003_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_002003_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_002003_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_002003_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_002003_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_002003_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_002003_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","002003")
arcpy.management.DeleteField("AiGreenClasses6x10_002003_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_002003_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_002003_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_002003_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_002003_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","002003")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 2 and row = 4"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002004.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002004.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_002004_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_002004";
arcpy.CalculateField_management("AiGreenClasses6x10_002004", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002004",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_002004", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_002004")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_002004', "CLEAR_SELECTION")
print("Start Union","002004")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_002004 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_002004_Type.shp", "ALL", None, "GAPS")
print("Finish Union","002004")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002004_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_002004_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002004_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_002004_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_002004_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_002004_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002004_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_002004_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_002004_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_002004_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_002004_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_002004_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_002004_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","002004")
arcpy.management.DeleteField("AiGreenClasses6x10_002004_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_002004_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_002004_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_002004_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_002004_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","002004")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 2 and row = 5"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002005.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002005.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_002005_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_002005";
arcpy.CalculateField_management("AiGreenClasses6x10_002005", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002005",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_002005", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_002005")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_002005', "CLEAR_SELECTION")
print("Start Union","002005")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_002005 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_002005_Type.shp", "ALL", None, "GAPS")
print("Finish Union","002005")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002005_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_002005_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002005_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_002005_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_002005_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_002005_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002005_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_002005_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_002005_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_002005_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_002005_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_002005_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_002005_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","002005")
arcpy.management.DeleteField("AiGreenClasses6x10_002005_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_002005_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_002005_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_002005_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_002005_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","002005")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 2 and row = 6"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002006.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002006.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_002006_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_002006";
arcpy.CalculateField_management("AiGreenClasses6x10_002006", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002006",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_002006", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_002006")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_002006', "CLEAR_SELECTION")
print("Start Union","002006")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_002006 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_002006_Type.shp", "ALL", None, "GAPS")
print("Finish Union","002006")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002006_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_002006_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002006_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_002006_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_002006_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_002006_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002006_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_002006_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_002006_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_002006_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_002006_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_002006_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_002006_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","002006")
arcpy.management.DeleteField("AiGreenClasses6x10_002006_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_002006_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_002006_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_002006_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_002006_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","002006")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 2 and row = 7"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002007.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002007.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_002007_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_002007";
arcpy.CalculateField_management("AiGreenClasses6x10_002007", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002007",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_002007", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_002007")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_002007', "CLEAR_SELECTION")
print("Start Union","002007")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_002007 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_002007_Type.shp", "ALL", None, "GAPS")
print("Finish Union","002007")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002007_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_002007_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002007_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_002007_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_002007_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_002007_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002007_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_002007_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_002007_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_002007_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_002007_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_002007_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_002007_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","002007")
arcpy.management.DeleteField("AiGreenClasses6x10_002007_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_002007_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_002007_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_002007_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_002007_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","002007")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 2 and row = 8"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002008.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002008.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_002008_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_002008";
arcpy.CalculateField_management("AiGreenClasses6x10_002008", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002008",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_002008", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_002008")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_002008', "CLEAR_SELECTION")
print("Start Union","002008")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_002008 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_002008_Type.shp", "ALL", None, "GAPS")
print("Finish Union","002008")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002008_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_002008_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002008_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_002008_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_002008_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_002008_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002008_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_002008_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_002008_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_002008_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_002008_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_002008_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_002008_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","002008")
arcpy.management.DeleteField("AiGreenClasses6x10_002008_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_002008_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_002008_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_002008_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_002008_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","002008")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 2 and row = 9"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002009.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002009.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_002009_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_002009";
arcpy.CalculateField_management("AiGreenClasses6x10_002009", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002009",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_002009", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_002009")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_002009', "CLEAR_SELECTION")
print("Start Union","002009")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_002009 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_002009_Type.shp", "ALL", None, "GAPS")
print("Finish Union","002009")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002009_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_002009_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002009_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_002009_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_002009_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_002009_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002009_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_002009_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_002009_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_002009_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_002009_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_002009_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_002009_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","002009")
arcpy.management.DeleteField("AiGreenClasses6x10_002009_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_002009_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_002009_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_002009_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_002009_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","002009")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 2 and row = 10"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002010.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002010.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_002010_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_002010";
arcpy.CalculateField_management("AiGreenClasses6x10_002010", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002010",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_002010", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_002010")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_002010', "CLEAR_SELECTION")
print("Start Union","002010")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_002010 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_002010_Type.shp", "ALL", None, "GAPS")
print("Finish Union","002010")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002010_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_002010_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002010_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_002010_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_002010_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_002010_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002010_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_002010_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_002010_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_002010_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_002010_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_002010_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_002010_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","002010")
arcpy.management.DeleteField("AiGreenClasses6x10_002010_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_002010_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_002010_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_002010_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_002010_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","002010")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 2 and row = 11"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002011.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_002011.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_002011_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_002011";
arcpy.CalculateField_management("AiGreenClasses6x10_002011", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002011",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_002011", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_002011")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_002011', "CLEAR_SELECTION")
print("Start Union","002011")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_002011 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_002011_Type.shp", "ALL", None, "GAPS")
print("Finish Union","002011")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002011_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_002011_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002011_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_002011_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_002011_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_002011_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_002011_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_002011_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_002011_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_002011_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_002011_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_002011_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_002011_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","002011")
arcpy.management.DeleteField("AiGreenClasses6x10_002011_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_002011_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_002011_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_002011_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_002011_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","002011")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 3 and row = 1"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003001.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003001.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_003001_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_003001";
arcpy.CalculateField_management("AiGreenClasses6x10_003001", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003001",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_003001", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_003001")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_003001', "CLEAR_SELECTION")
print("Start Union","003001")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_003001 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_003001_Type.shp", "ALL", None, "GAPS")
print("Finish Union","003001")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003001_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_003001_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003001_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_003001_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_003001_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_003001_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003001_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_003001_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_003001_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_003001_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_003001_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_003001_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_003001_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","003001")
arcpy.management.DeleteField("AiGreenClasses6x10_003001_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_003001_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_003001_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_003001_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_003001_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","003001")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 3 and row = 2"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003002.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003002.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_003002_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_003002";
arcpy.CalculateField_management("AiGreenClasses6x10_003002", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003002",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_003002", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_003002")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_003002', "CLEAR_SELECTION")
print("Start Union","003002")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_003002 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_003002_Type.shp", "ALL", None, "GAPS")
print("Finish Union","003002")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003002_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_003002_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003002_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_003002_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_003002_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_003002_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003002_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_003002_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_003002_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_003002_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_003002_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_003002_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_003002_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","003002")
arcpy.management.DeleteField("AiGreenClasses6x10_003002_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_003002_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_003002_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_003002_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_003002_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","003002")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 3 and row = 3"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003003.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003003.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_003003_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_003003";
arcpy.CalculateField_management("AiGreenClasses6x10_003003", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003003",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_003003", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_003003")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_003003', "CLEAR_SELECTION")
print("Start Union","003003")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_003003 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_003003_Type.shp", "ALL", None, "GAPS")
print("Finish Union","003003")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003003_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_003003_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003003_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_003003_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_003003_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_003003_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003003_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_003003_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_003003_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_003003_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_003003_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_003003_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_003003_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","003003")
arcpy.management.DeleteField("AiGreenClasses6x10_003003_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_003003_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_003003_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_003003_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_003003_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","003003")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 3 and row = 4"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003004.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003004.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_003004_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_003004";
arcpy.CalculateField_management("AiGreenClasses6x10_003004", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003004",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_003004", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_003004")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_003004', "CLEAR_SELECTION")
print("Start Union","003004")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_003004 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_003004_Type.shp", "ALL", None, "GAPS")
print("Finish Union","003004")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003004_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_003004_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003004_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_003004_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_003004_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_003004_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003004_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_003004_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_003004_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_003004_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_003004_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_003004_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_003004_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","003004")
arcpy.management.DeleteField("AiGreenClasses6x10_003004_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_003004_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_003004_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_003004_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_003004_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","003004")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 3 and row = 5"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003005.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003005.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_003005_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_003005";
arcpy.CalculateField_management("AiGreenClasses6x10_003005", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003005",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_003005", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_003005")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_003005', "CLEAR_SELECTION")
print("Start Union","003005")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_003005 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_003005_Type.shp", "ALL", None, "GAPS")
print("Finish Union","003005")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003005_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_003005_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003005_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_003005_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_003005_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_003005_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003005_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_003005_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_003005_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_003005_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_003005_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_003005_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_003005_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","003005")
arcpy.management.DeleteField("AiGreenClasses6x10_003005_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_003005_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_003005_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_003005_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_003005_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","003005")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 3 and row = 6"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003006.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003006.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_003006_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_003006";
arcpy.CalculateField_management("AiGreenClasses6x10_003006", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003006",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_003006", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_003006")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_003006', "CLEAR_SELECTION")
print("Start Union","003006")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_003006 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_003006_Type.shp", "ALL", None, "GAPS")
print("Finish Union","003006")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003006_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_003006_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003006_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_003006_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_003006_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_003006_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003006_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_003006_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_003006_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_003006_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_003006_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_003006_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_003006_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","003006")
arcpy.management.DeleteField("AiGreenClasses6x10_003006_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_003006_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_003006_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_003006_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_003006_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","003006")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 3 and row = 7"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003007.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003007.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_003007_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_003007";
arcpy.CalculateField_management("AiGreenClasses6x10_003007", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003007",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_003007", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_003007")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_003007', "CLEAR_SELECTION")
print("Start Union","003007")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_003007 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_003007_Type.shp", "ALL", None, "GAPS")
print("Finish Union","003007")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003007_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_003007_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003007_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_003007_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_003007_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_003007_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003007_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_003007_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_003007_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_003007_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_003007_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_003007_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_003007_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","003007")
arcpy.management.DeleteField("AiGreenClasses6x10_003007_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_003007_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_003007_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_003007_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_003007_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","003007")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 3 and row = 8"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003008.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003008.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_003008_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_003008";
arcpy.CalculateField_management("AiGreenClasses6x10_003008", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003008",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_003008", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_003008")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_003008', "CLEAR_SELECTION")
print("Start Union","003008")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_003008 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_003008_Type.shp", "ALL", None, "GAPS")
print("Finish Union","003008")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003008_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_003008_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003008_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_003008_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_003008_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_003008_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003008_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_003008_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_003008_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_003008_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_003008_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_003008_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_003008_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","003008")
arcpy.management.DeleteField("AiGreenClasses6x10_003008_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_003008_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_003008_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_003008_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_003008_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","003008")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 3 and row = 9"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003009.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003009.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_003009_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_003009";
arcpy.CalculateField_management("AiGreenClasses6x10_003009", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003009",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_003009", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_003009")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_003009', "CLEAR_SELECTION")
print("Start Union","003009")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_003009 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_003009_Type.shp", "ALL", None, "GAPS")
print("Finish Union","003009")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003009_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_003009_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003009_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_003009_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_003009_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_003009_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003009_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_003009_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_003009_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_003009_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_003009_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_003009_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_003009_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","003009")
arcpy.management.DeleteField("AiGreenClasses6x10_003009_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_003009_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_003009_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_003009_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_003009_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","003009")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 3 and row = 10"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003010.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003010.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_003010_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_003010";
arcpy.CalculateField_management("AiGreenClasses6x10_003010", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003010",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_003010", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_003010")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_003010', "CLEAR_SELECTION")
print("Start Union","003010")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_003010 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_003010_Type.shp", "ALL", None, "GAPS")
print("Finish Union","003010")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003010_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_003010_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003010_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_003010_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_003010_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_003010_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003010_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_003010_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_003010_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_003010_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_003010_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_003010_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_003010_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","003010")
arcpy.management.DeleteField("AiGreenClasses6x10_003010_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_003010_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_003010_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_003010_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_003010_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","003010")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 3 and row = 11"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003011.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_003011.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_003011_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_003011";
arcpy.CalculateField_management("AiGreenClasses6x10_003011", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003011",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_003011", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_003011")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_003011', "CLEAR_SELECTION")
print("Start Union","003011")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_003011 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_003011_Type.shp", "ALL", None, "GAPS")
print("Finish Union","003011")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003011_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_003011_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003011_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_003011_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_003011_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_003011_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_003011_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_003011_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_003011_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_003011_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_003011_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_003011_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_003011_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","003011")
arcpy.management.DeleteField("AiGreenClasses6x10_003011_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_003011_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_003011_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_003011_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_003011_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","003011")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 4 and row = 1"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004001.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004001.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_004001_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_004001";
arcpy.CalculateField_management("AiGreenClasses6x10_004001", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004001",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_004001", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_004001")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_004001', "CLEAR_SELECTION")
print("Start Union","004001")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_004001 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_004001_Type.shp", "ALL", None, "GAPS")
print("Finish Union","004001")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004001_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_004001_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004001_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_004001_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_004001_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_004001_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004001_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_004001_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_004001_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_004001_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_004001_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_004001_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_004001_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","004001")
arcpy.management.DeleteField("AiGreenClasses6x10_004001_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_004001_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_004001_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_004001_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_004001_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","004001")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 4 and row = 2"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004002.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004002.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_004002_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_004002";
arcpy.CalculateField_management("AiGreenClasses6x10_004002", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004002",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_004002", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_004002")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_004002', "CLEAR_SELECTION")
print("Start Union","004002")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_004002 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_004002_Type.shp", "ALL", None, "GAPS")
print("Finish Union","004002")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004002_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_004002_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004002_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_004002_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_004002_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_004002_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004002_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_004002_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_004002_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_004002_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_004002_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_004002_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_004002_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","004002")
arcpy.management.DeleteField("AiGreenClasses6x10_004002_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_004002_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_004002_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_004002_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_004002_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","004002")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 4 and row = 5"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004005.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004005.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_004005_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_004005";
arcpy.CalculateField_management("AiGreenClasses6x10_004005", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004005",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_004005", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_004005")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_004005', "CLEAR_SELECTION")
print("Start Union","004005")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_004005 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_004005_Type.shp", "ALL", None, "GAPS")
print("Finish Union","004005")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004005_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_004005_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004005_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_004005_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_004005_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_004005_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004005_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_004005_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_004005_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_004005_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_004005_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_004005_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_004005_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","004005")
arcpy.management.DeleteField("AiGreenClasses6x10_004005_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_004005_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_004005_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_004005_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_004005_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","004005")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 4 and row = 6"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004006.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004006.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_004006_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_004006";
arcpy.CalculateField_management("AiGreenClasses6x10_004006", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004006",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_004006", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_004006")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_004006', "CLEAR_SELECTION")
print("Start Union","004006")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_004006 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_004006_Type.shp", "ALL", None, "GAPS")
print("Finish Union","004006")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004006_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_004006_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004006_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_004006_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_004006_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_004006_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004006_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_004006_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_004006_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_004006_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_004006_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_004006_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_004006_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","004006")
arcpy.management.DeleteField("AiGreenClasses6x10_004006_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_004006_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_004006_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_004006_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_004006_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","004006")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 4 and row = 7"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004007.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004007.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_004007_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_004007";
arcpy.CalculateField_management("AiGreenClasses6x10_004007", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004007",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_004007", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_004007")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_004007', "CLEAR_SELECTION")
print("Start Union","004007")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_004007 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_004007_Type.shp", "ALL", None, "GAPS")
print("Finish Union","004007")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004007_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_004007_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004007_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_004007_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_004007_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_004007_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004007_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_004007_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_004007_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_004007_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_004007_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_004007_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_004007_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","004007")
arcpy.management.DeleteField("AiGreenClasses6x10_004007_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_004007_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_004007_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_004007_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_004007_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","004007")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 4 and row = 8"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004008.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004008.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_004008_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_004008";
arcpy.CalculateField_management("AiGreenClasses6x10_004008", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004008",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_004008", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_004008")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_004008', "CLEAR_SELECTION")
print("Start Union","004008")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_004008 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_004008_Type.shp", "ALL", None, "GAPS")
print("Finish Union","004008")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004008_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_004008_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004008_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_004008_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_004008_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_004008_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004008_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_004008_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_004008_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_004008_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_004008_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_004008_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_004008_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","004008")
arcpy.management.DeleteField("AiGreenClasses6x10_004008_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_004008_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_004008_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_004008_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_004008_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","004008")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 4 and row = 9"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004009.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004009.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_004009_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_004009";
arcpy.CalculateField_management("AiGreenClasses6x10_004009", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004009",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_004009", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_004009")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_004009', "CLEAR_SELECTION")
print("Start Union","004009")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_004009 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_004009_Type.shp", "ALL", None, "GAPS")
print("Finish Union","004009")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004009_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_004009_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004009_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_004009_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_004009_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_004009_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004009_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_004009_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_004009_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_004009_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_004009_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_004009_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_004009_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","004009")
arcpy.management.DeleteField("AiGreenClasses6x10_004009_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_004009_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_004009_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_004009_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_004009_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","004009")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 4 and row = 10"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004010.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_004010.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_004010_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_004010";
arcpy.CalculateField_management("AiGreenClasses6x10_004010", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004010",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_004010", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_004010")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_004010', "CLEAR_SELECTION")
print("Start Union","004010")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_004010 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_004010_Type.shp", "ALL", None, "GAPS")
print("Finish Union","004010")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004010_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_004010_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004010_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_004010_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_004010_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_004010_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_004010_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_004010_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_004010_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_004010_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_004010_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_004010_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_004010_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","004010")
arcpy.management.DeleteField("AiGreenClasses6x10_004010_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_004010_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_004010_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_004010_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_004010_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","004010")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 5 and row = 5"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005005.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005005.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_005005_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_005005";
arcpy.CalculateField_management("AiGreenClasses6x10_005005", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005005",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_005005", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_005005")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_005005', "CLEAR_SELECTION")
print("Start Union","005005")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_005005 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_005005_Type.shp", "ALL", None, "GAPS")
print("Finish Union","005005")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005005_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_005005_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005005_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_005005_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_005005_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_005005_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005005_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_005005_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_005005_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_005005_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_005005_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_005005_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_005005_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","005005")
arcpy.management.DeleteField("AiGreenClasses6x10_005005_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_005005_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_005005_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_005005_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_005005_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","005005")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 5 and row = 6"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005006.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005006.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_005006_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_005006";
arcpy.CalculateField_management("AiGreenClasses6x10_005006", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005006",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_005006", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_005006")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_005006', "CLEAR_SELECTION")
print("Start Union","005006")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_005006 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_005006_Type.shp", "ALL", None, "GAPS")
print("Finish Union","005006")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005006_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_005006_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005006_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_005006_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_005006_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_005006_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005006_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_005006_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_005006_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_005006_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_005006_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_005006_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_005006_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","005006")
arcpy.management.DeleteField("AiGreenClasses6x10_005006_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_005006_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_005006_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_005006_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_005006_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","005006")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 5 and row = 7"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005007.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005007.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_005007_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_005007";
arcpy.CalculateField_management("AiGreenClasses6x10_005007", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005007",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_005007", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_005007")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_005007', "CLEAR_SELECTION")
print("Start Union","005007")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_005007 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_005007_Type.shp", "ALL", None, "GAPS")
print("Finish Union","005007")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005007_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_005007_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005007_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_005007_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_005007_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_005007_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005007_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_005007_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_005007_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_005007_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_005007_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_005007_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_005007_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","005007")
arcpy.management.DeleteField("AiGreenClasses6x10_005007_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_005007_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_005007_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_005007_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_005007_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","005007")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 5 and row = 8"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005008.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005008.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_005008_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_005008";
arcpy.CalculateField_management("AiGreenClasses6x10_005008", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005008",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_005008", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_005008")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_005008', "CLEAR_SELECTION")
print("Start Union","005008")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_005008 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_005008_Type.shp", "ALL", None, "GAPS")
print("Finish Union","005008")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005008_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_005008_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005008_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_005008_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_005008_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_005008_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005008_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_005008_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_005008_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_005008_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_005008_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_005008_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_005008_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","005008")
arcpy.management.DeleteField("AiGreenClasses6x10_005008_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_005008_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_005008_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_005008_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_005008_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","005008")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 5 and row = 9"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005009.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005009.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_005009_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_005009";
arcpy.CalculateField_management("AiGreenClasses6x10_005009", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005009",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_005009", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_005009")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_005009', "CLEAR_SELECTION")
print("Start Union","005009")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_005009 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_005009_Type.shp", "ALL", None, "GAPS")
print("Finish Union","005009")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005009_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_005009_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005009_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_005009_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_005009_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_005009_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005009_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_005009_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_005009_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_005009_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_005009_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_005009_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_005009_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","005009")
arcpy.management.DeleteField("AiGreenClasses6x10_005009_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_005009_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_005009_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_005009_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_005009_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","005009")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 5 and row = 10"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005010.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_005010.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_005010_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_005010";
arcpy.CalculateField_management("AiGreenClasses6x10_005010", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005010",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_005010", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_005010")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_005010', "CLEAR_SELECTION")
print("Start Union","005010")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_005010 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_005010_Type.shp", "ALL", None, "GAPS")
print("Finish Union","005010")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005010_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_005010_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005010_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_005010_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_005010_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_005010_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_005010_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_005010_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_005010_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_005010_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_005010_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_005010_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_005010_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","005010")
arcpy.management.DeleteField("AiGreenClasses6x10_005010_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_005010_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_005010_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_005010_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_005010_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","005010")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 6 and row = 7"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_006007.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_006007.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_006007_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_006007";
arcpy.CalculateField_management("AiGreenClasses6x10_006007", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006007",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_006007", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_006007")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_006007', "CLEAR_SELECTION")
print("Start Union","006007")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_006007 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_006007_Type.shp", "ALL", None, "GAPS")
print("Finish Union","006007")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006007_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_006007_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006007_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_006007_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_006007_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_006007_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006007_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_006007_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_006007_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_006007_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_006007_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_006007_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_006007_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","006007")
arcpy.management.DeleteField("AiGreenClasses6x10_006007_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_006007_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_006007_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_006007_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_006007_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","006007")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 6 and row = 8"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_006008.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_006008.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_006008_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_006008";
arcpy.CalculateField_management("AiGreenClasses6x10_006008", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006008",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_006008", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_006008")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_006008', "CLEAR_SELECTION")
print("Start Union","006008")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_006008 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_006008_Type.shp", "ALL", None, "GAPS")
print("Finish Union","006008")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006008_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_006008_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006008_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_006008_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_006008_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_006008_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006008_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_006008_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_006008_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_006008_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_006008_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_006008_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_006008_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","006008")
arcpy.management.DeleteField("AiGreenClasses6x10_006008_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_006008_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_006008_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_006008_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_006008_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","006008")
winsound.Beep(frequency, duration)

#------------------------------------------------------------
grid.definitionQuery = "col = 6 and row = 9"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_006009.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_006009.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_006009_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_006009";
arcpy.CalculateField_management("AiGreenClasses6x10_006009", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006009",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_006009", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_006009")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_006009', "CLEAR_SELECTION")
print("Start Union","006009")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_006009 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_006009_Type.shp", "ALL", None, "GAPS")
print("Finish Union","006009")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006009_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_006009_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006009_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_006009_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_006009_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_006009_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_006009_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_006009_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_006009_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_006009_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_006009_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_006009_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_006009_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","006009")
arcpy.management.DeleteField("AiGreenClasses6x10_006009_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_006009_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_006009_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_006009_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_006009_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","006009")
winsound.Beep(frequency, duration)

