import winsound
frequency = 2500  # Set Frequency To 2500 Hertz
duration = 1000  # Set Duration To 1000 ms == 1 second
aprx = arcpy.mp.ArcGISProject('current')
for lyr in aprx.listMaps()[0].listLayers():
    if lyr.name == 'AiGreenGrid6x10':
        grid = lyr
        break


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

