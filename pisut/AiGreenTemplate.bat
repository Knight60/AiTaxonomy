#------------------------------------------------------------
grid.definitionQuery = "col = 0 and row = 0"
aprx.listMaps()[0].defaultView.camera.setExtent(arcpy.Describe(grid).extent)
try:
   arcpy.management.AddField(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_000000.shp","StripIndex", 'SHORT')
except:
   pass
lyr = arcpy.management.AddJoin(r"E:\Projects\AIGreenArea\@ AiGreenClassesShp\AiGreenClasses6x10_000000.shp", "FID",r"E:\Projects\AIGreenArea\@ AiGreenClassesBuff\AiGreenClasses6x10_000000_Buff.shp", "ORIG_FID")
lyr.getOutput(0).name = "AiGreenClasses6x10_000000";
arcpy.CalculateField_management("AiGreenClasses6x10_000000", 'StripIndex',"0")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_000000",'NEW_SELECTION', "ORIG_FID IS NULL")
arcpy.management.CalculateField("AiGreenClasses6x10_000000", "StripIndex","(((4*math.pi*!shape.area@squaremeters!)/(!shape.length@meters!**2))<0.2)*1")
arcpy.management.RemoveJoin("AiGreenClasses6x10_000000")
arcpy.SelectLayerByAttribute_management('AiGreenClasses6x10_000000', "CLEAR_SELECTION")
print("Start Union","000000")
with arcpy.EnvManager(extent='MINOF'):
      arcpy.analysis.Union("AiGreenClasses6x10_000000 #;OSM_Lulc_Pofw_Park_Golf_PRTC_Commu_DMCR_FIO_PRTC_Commu_BKC_Mangrove_RSPG #", r"E:\Projects\AIGreenArea\@ AiGreenClassesType\AiGreenClasses6x10_000000_Type.shp", "ALL", None, "GAPS")
print("Finish Union","000000")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_000000_Type", "NEW_SELECTION","FID_AiGree = -1")
arcpy.management.DeleteFeatures("AiGreenClasses6x10_000000_Type")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_000000_Type", "NEW_SELECTION","(GCode = 0 Or GCode > 51) And StripIndex = 1")
arcpy.CalculateField_management("AiGreenClasses6x10_000000_Type", 'GCode',"30")
arcpy.CalculateField_management("AiGreenClasses6x10_000000_Type", 'gtype',"'S'")
arcpy.CalculateField_management("AiGreenClasses6x10_000000_Type", 'Src',"'gis_strip'")
arcpy.management.SelectLayerByAttribute("AiGreenClasses6x10_000000_Type", 'NEW_SELECTION',"GCode = 0")
arcpy.CalculateField_management("AiGreenClasses6x10_000000_Type", 'GCode',"40")
arcpy.CalculateField_management("AiGreenClasses6x10_000000_Type", 'gtype',"'E'")
arcpy.CalculateField_management("AiGreenClasses6x10_000000_Type", 'Src',"'others'")
arcpy.SelectLayerByAttribute_management("AiGreenClasses6x10_000000_Type", "CLEAR_SELECTION")
arcpy.analysis.Intersect("AiGreenClasses6x10_000000_Type #;Admin_DOPA_DLA #;AiGreenGrid6x10 #", r"E:\Projects\AIGreenArea\@ AiGreenClassesAdmin\AiGreenClasses6x10_000000_Admin.shp", "ALL", None, "INPUT")
print("Finish Intersect","000000")
arcpy.management.DeleteField("AiGreenClasses6x10_000000_Admin", "FID_AiGree;FID_AiGr_1;Id;FID_OSM_Lu;Shape_Leng;Shape_Area;Shape_Le_1;Shape_Ar_1;FID_Admin_;FID_AiGr_2", "DELETE_FIELDS")
arcpy.CalculateField_management("AiGreenClasses6x10_000000_Admin", 'AMP_CODE',"!PROV_CODE!+!AMP_CODE!")
arcpy.CalculateField_management("AiGreenClasses6x10_000000_Admin", 'TAM_CODE',"!dopa_code!")
arcpy.management.AddField("AiGreenClasses6x10_000000_Admin","area_rai", 'DOUBLE')
arcpy.CalculateField_management("AiGreenClasses6x10_000000_Admin", 'area_rai',"!shape.area@squaremeters!*0.000625")
print("Finish All","000000")
winsound.Beep(frequency, duration)

