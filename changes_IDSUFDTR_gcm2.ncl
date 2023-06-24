;***********************************************************;
;                                                           ;
;  This script is a example to plot contours on China map.  ;
;  Written by Liu Pei(CUIT) and Huang Yongjie(IAP/CAS)      ;
;  DEC 19, 2012.                                            ;
;                                                           ;
;***********************************************************;
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/cnmap/cnmap.ncl"
load "./panel_two_sets.ncl"
function get_title_position(plot)
local vpy, vpx, vph
begin
  getvalues plot
      "vpYF"       : vpy
      "vpXF"       : vpx
      "vpHeightF"  : vph
  end getvalues
  pos = (/vpx*0.75,vpy-(vph/2.)/)
  return(pos)
end
undef("createLabelBar")
undef("createLabelBar1")
function createLabelBar(wks: graphic, plt:graphic, lbres:logical)
begin
   getvalues plt@contour               ; object from which info extracted
      "cnFillColors"   : fill_colors   ; get the colors used
      "lbLabelStrings" : lbstrings     ; get the labels used
   end getvalues
   ;print(lbstrings)
   lbres@lbFillColors = fill_colors    ; associate with input lnres argument
   lbid = gsn_create_labelbar(wks,dimsizes(lbstrings)+1,lbstrings,lbres)
   return(lbid)
end

begin
plotname="changes_IDSU_gcm2"

file1="../../corrected/ens/diff_ens_tasmax_245_1.5deg_SU_timmean.nc"
f1 = addfile(file1,"r")
;print(f1)
file2="../../corrected/ens/diff_ens_tasmin_245_1.5deg_TR_timmean.nc"
f2 = addfile(file2,"r")
;print(f2)
file3="../../corrected/ens/diff_ens_tasmax_245_2deg_SU_timmean.nc"
f3 = addfile(file3,"r")
;print(f4)
file4="../../corrected/ens/diff_ens_tasmin_245_2deg_TR_timmean.nc"
f4= addfile(file4,"r")
file5="../../corrected/ens/diff_ens_tasmax_585_1.5deg_SU_timmean.nc"
f5 = addfile(file5,"r")
;print(f5)
file6="../../corrected/ens/diff_ens_tasmin_585_1.5deg_TR_timmean.nc"
f6 = addfile(file6,"r")
;print(f2)
file7="../../corrected/ens/diff_ens_tasmax_585_2deg_SU_timmean.nc"
f7 = addfile(file7,"r")
;print(f4)
file8="../../corrected/ens/diff_ens_tasmin_585_2deg_TR_timmean.nc"
f8= addfile(file8,"r")

sim1=f1->tem 
sim2=f2->tem 
sim3=f3->tem 
sim4=f4->tem
sim5=f5->tem
sim6=f6->tem
sim7=f7->tem
sim8=f8->tem
sim1!0="time"
sim1!1="lon"
sim1!2="lat"
sim2!0="time"
sim2!1="lon"
sim2!2="lat"
sim3!0="time"
sim3!1="lon"
sim3!2="lat"
sim4!0="time"
sim4!1="lon"
sim4!2="lat"
sim5!0="time"
sim5!1="lon"
sim5!2="lat"
sim6!0="time"
sim6!1="lon"
sim6!2="lat"
sim7!0="time"
sim7!1="lon"
sim7!2="lat"
sim8!0="time"
sim8!1="lon"
sim8!2="lat"
file11="../../corrected/ens/diff_ens_tasmax_245_1.5deg_ID_timmean.nc"
f11 = addfile(file11,"r")
print(f11)
file21="../../corrected/ens/diff_ens_tasmin_245_1.5deg_FD_timmean.nc"
f21 = addfile(file21,"r")
;print(f21)
file31="../../corrected/ens/diff_ens_tasmax_245_1.5deg_ID_timmean.nc"
f31 = addfile(file31,"r")
;print(f41)
file41="../../corrected/ens/diff_ens_tasmin_245_1.5deg_FD_timmean.nc"
f41= addfile(file41,"r")
file51="../../corrected/ens/diff_ens_tasmax_585_2deg_ID_timmean.nc"
f51 = addfile(file51,"r")
;print(f51)
file61="../../corrected/ens/diff_ens_tasmin_585_2deg_FD_timmean.nc"
f61 = addfile(file61,"r")
;print(f21)
file71="../../corrected/ens/diff_ens_tasmax_585_2deg_ID_timmean.nc"
f71 = addfile(file71,"r")
;print(f41)
file81="../../corrected/ens/diff_ens_tasmin_585_2deg_FD_timmean.nc"
f81= addfile(file81,"r")

sim11=f11->tem 
sim21=f21->tem 
sim31=f31->tem 
sim41=f41->tem
sim51=f51->tem
sim61=f61->tem
sim71=f71->tem
sim81=f81->tem
sim11!0="time"
sim11!1="lon"
sim11!2="lat"
sim21!0="time"
sim21!1="lon"
sim21!2="lat"
sim31!0="time"
sim31!1="lon"
sim31!2="lat"
sim41!0="time"
sim41!1="lon"
sim41!2="lat"
sim51!0="time"
sim51!1="lon"
sim51!2="lat"
sim61!0="time"
sim61!1="lon"
sim61!2="lat"
sim71!0="time"
sim71!1="lon"
sim71!2="lat"
sim81!0="time"
sim81!1="lon"
sim81!2="lat"

;copy_VarMeta(sim1, sim2)     

;>=========================================================<
 wks       = gsn_open_wks("png",plotname) 
 gsn_define_colormap( wks ,"BlGrYeOrReVi200")  
 
        
 res                         = True            
 ;res@tiMainString            ="china_map" 
 res@gsnMaximize             = True
 res@gsnDraw                 = False
 res@gsnFrame                = False

;>--------------------------------------------<
;            set for the map 
;>--------------------------------------------<
 res@mpMinLatF               = 17.                         
 res@mpMaxLatF               = 52.
 res@mpMinLonF               = 83.
 res@mpMaxLonF               = 130.

 res@mpFillOn                = True
 res@mpOutlineOn             = False  ; Use outlines from shapefile
 res@cnFillDrawOrder         = "PreDraw"
 res@mpDataBaseVersion       = "MediumRes"
 res@mpDataSetName           = "Earth..4"
 res@mpAreaMaskingOn         = True
 res@mpMaskAreaSpecifiers    = (/"China","Taiwan","Disputed area between India and China","India:Arunachal Pradesh"/)
 res@mpLandFillColor         = "white"
 res@mpInlandWaterFillColor  = "white"
 res@mpOceanFillColor        = "white"
 res@mpOutlineBoundarySets   = "NoBoundaries"
 
 res@mpProjection ="LambertConformal"   ;
  res@mpLambertMeridianF =110.0
  res@mpLimitMode = "LatLon"
  res@mpLambertParallel1F =.001      ;Default:.001 ;
  res@mpLambertParallel2F =89.999   ;Default: 89.999
 
;>--------------------------------------------<
; set for the plot
 res@gsnAddCyclic  =False  
 res@cnFillOn                = True               
 res@cnLinesOn               = False
 res@cnLineLabelsOn = False
 res@cnFillDrawOrder ="PreDraw"
 ;res@cnLevelSpacingF         = 20.             
 ;res@gsnSpreadColors         = True         
 ;res@lbLabelAutoStride       = True               

res@cnLevelSelectionMode="ManualLevels"

res@lbTopMarginF=-0.3
res@lbBoxSeparatorLinesOn=False
res@tiMainFont           = "helvetica"
res@tiMainOffsetYF       = 0.02  ;set place for main title alongY,offset
res@tiMainFontHeightF    = 0.02   ;set main title fontsize

res@lbLabelBarOn        = False            ; turn off individual cb's
res@gsnRightString=""
res@gsnLeftString=""
res@tmYRBorderOn =        True
res@tmYLBorderOn =        True
res@tmXTBorderOn =        True
res@tmXBBorderOn =        True
res@tmYRLabelsOn =        True
res@tmYROn =      False
res@tmXTOn =      False
res@gsnStringFontHeightF = 0.028

res1=res
cmap_r  = read_colormap_file("gui_default")
res1@cnFillPalette  = cmap_r(0:,:)
res1@gsnCenterString = ""
res1@cnMinLevelValF=-4
res1@cnMaxLevelValF=25
res1@cnLevelSpacingF=2  
res1@lbBoxEndCapStyle = "TriangleBothEnds"
res1@trGridType ="TriangularMesh"
res1@gsnPanelBottom      = 0.4
plot = new(16,graphic)
res1@gsnCenterString = "SU"
plot(0)=gsn_csm_contour_map(wks,sim1(time|0,lat|:,lon|:),res1)
res1@gsnCenterString = "TR"
plot(1)=gsn_csm_contour_map(wks,sim2(time|0,lat|:,lon|:),res1)
res1@gsnCenterString = ""
plot(2)=gsn_csm_contour_map(wks,sim3(time|0,lat|:,lon|:),res1)
plot(3)=gsn_csm_contour_map(wks,sim4(time|0,lat|:,lon|:),res1)
res1@gsnCenterString = ""
res1@cnMinLevelValF=-24
res1@cnMaxLevelValF=10
res1@cnLevelSpacingF=2
plot(4)=gsn_csm_contour_map(wks,sim5(time|0,lat|:,lon|:),res1)
plot(5)=gsn_csm_contour_map(wks,sim6(time|0,lat|:,lon|:),res1)
plot(6)=gsn_csm_contour_map(wks,sim7(time|0,lat|:,lon|:),res1)
plot(7)=gsn_csm_contour_map(wks,sim8(time|0,lat|:,lon|:),res1)
res1@gsnCenterString = "ID"
plot(8)=gsn_csm_contour_map(wks,sim11(time|0,lat|:,lon|:),res1)
res1@gsnCenterString = "FD"
plot(9)=gsn_csm_contour_map(wks,sim21(time|0,lat|:,lon|:),res1)
res1@gsnCenterString = ""
plot(10)=gsn_csm_contour_map(wks,sim31(time|0,lat|:,lon|:),res1)
plot(11)=gsn_csm_contour_map(wks,sim41(time|0,lat|:,lon|:),res1)
plot(12)=gsn_csm_contour_map(wks,sim51(time|0,lat|:,lon|:),res1)
plot(13)=gsn_csm_contour_map(wks,sim61(time|0,lat|:,lon|:),res1)
plot(14)=gsn_csm_contour_map(wks,sim71(time|0,lat|:,lon|:),res1)
plot(15)=gsn_csm_contour_map(wks,sim81(time|0,lat|:,lon|:),res1)

;cmap_r2  = read_colormap_file("BlueDarkRed18")
;  res1@cnFillPalette  = cmap_r2(0:,:)

;>============================================================<
;                      add China map
;>------------------------------------------------------------<
 cnres           = True
 
 cnres@china     = True       ;draw china map or not
 cnres@river     = False       ;draw changjiang&huanghe or not
 cnres@province  = True       ;draw province boundary or not
 cnres@nanhai    = True       ;draw nanhai or not 
 cnres@diqu      = False       ; draw diqujie or not

chinamap = add_china_map(wks,plot(0),cnres)
chinamap1 = add_china_map(wks,plot(1),cnres)
chinamap2 = add_china_map(wks,plot(2),cnres)
chinamap3 = add_china_map(wks,plot(3),cnres)
chinamap4 = add_china_map(wks,plot(4),cnres)
chinamap5 = add_china_map(wks,plot(5),cnres)
chinamap6 = add_china_map(wks,plot(6),cnres)
chinamap7 = add_china_map(wks,plot(7),cnres)
chinamap8 = add_china_map(wks,plot(8),cnres)
chinamap9 = add_china_map(wks,plot(9),cnres)
chinamap10 = add_china_map(wks,plot(10),cnres)
chinamap11 = add_china_map(wks,plot(11),cnres)
chinamap12 = add_china_map(wks,plot(12),cnres)
chinamap13 = add_china_map(wks,plot(13),cnres)
chinamap14 = add_china_map(wks,plot(14),cnres)
chinamap15 = add_china_map(wks,plot(15),cnres)

;>============================================================<
pres                 = True
; pres@gsnPanelRowSpec = True                   ; tell panel what order to plot
pres@gsnPanelDebug            = True      ; prints debug info
  pres@gsnFrame                 = False
  pres@gsnMaximize              = True
  pres@gsnPanelMainFontHeightF  = 0.015
  pres@gsnPanelFigureStringsFontHeightF = 0.012
  pres@gsnPanelFigureStrings= (/"(a)","(b)","(e)","(f)","(i)","(j)","(m)","(n)"/) ; add strings to panel
  pres@amJust   = "TopLeft"
  pres@gsnPanelFigureStringsPerimOn             = False
  ;---Top row
  pres@gsnPanelLabelBar         = True
  pres@pmLabelBarHeightF        = 0.05
  pres@pmLabelBarOrthogonalPosF = -0.01
  pres@lbTitleString            = "(days)"
  pres@lbTitleFontHeightF       = 0.012
  pres@lbTitlePosition          = "Bottom"      ;position of label bar
  pres@lbLabelFontHeightF       = 0.01
  pres@gsnPanelLeft   = 0.03
  ;gsn_panel(wks,plot,(/4,4/),pres)
  pres1                     = True
  pres2                     = True
  pres1=pres
  pres2=pres
 pres2@gsnPanelFigureStrings= (/"(c)","(d)","(g)","(h)","(k)","(l)","(o)","(p)"/) ;

  pos1 = get_title_position(plot(0))         ; 1st row leftmost plot
  print(pos1)
  pos2 = get_title_position(plot(2))        ; 2nd row leftmost plot
  print(pos2)
  pos3 = get_title_position(plot(4))         ; 3rd row leftmost plot
  pos4 = get_title_position(plot(6))        ; 4th row leftmost plot   
  txres               = True
  txres@txFontHeightF = 0.012
  txres@txAngleF      = 90.
  gsn_text_ndc(wks, "1.5~S~o~N~C",   pos1(0), 0.894956-0.177233/2, txres)
  gsn_text_ndc(wks, "2.0~S~o~N~C",   pos2(0), 0.700151-0.177233/2, txres)
  gsn_text_ndc(wks, "1.5~S~o~N~C",   pos3(0), 0.505345-0.177233/2, txres)
  gsn_text_ndc(wks, "2.0~S~o~N~C",   pos4(0), 0.31054-0.177233/2, txres)

   panel_two_sets(wks,plot(0:7),plot(8:),(/4,2/),(/4,2/),pres1,pres2,pres)

frame(wks)
end  
