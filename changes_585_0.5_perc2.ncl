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


file1="../../corrected/ens/diff_ens_tasmax_585_2-1.5deg_TXx_timmean_perc_setmiss_3.nc"
f1 = addfile(file1,"r")
;print(f1)
file2="../../corrected/ens/diff_ens_tasmax_585_2-1.5deg_TXn_timmean_perc_setmiss_3.nc"
f2 = addfile(file2,"r")
;print(f2)
file3="../../corrected/ens/diff_ens_tasmin_585_2-1.5deg_TNx_timmean_perc_setmiss_3.nc"
f3 = addfile(file3,"r")
;print(f4)
file4="../../corrected/ens/diff_ens_tasmin_585_2-1.5deg_TNn_timmean_perc_setmiss_3.nc"
f4= addfile(file4,"r")
file5="../../corrected/ens/diff_ens_tasmax_585_2-1.5deg_SU_timmean_perc_setmiss_3.nc"
f5 = addfile(file5,"r")
;print(f5)
file6="../../corrected/ens/diff_ens_tasmax_585_2-1.5deg_ID_timmean_perc_setmiss_3.nc"
f6 = addfile(file6,"r")
;print(f2)
file7="../../corrected/ens/diff_ens_tasmin_585_2-1.5deg_TR_timmean_perc_setmiss_3.nc"
f7 = addfile(file7,"r")
;print(f4)
file8="../../corrected/ens/diff_ens_tasmin_585_2-1.5deg_FD_timmean_perc_setmiss_3.nc"
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
file11="../../corrected/ens/diff_ens_tasmax_585_2-1.5deg_TX90p_timmean_perc_setmiss_3.nc"
f11 = addfile(file11,"r")
;print(f11)
file21="../../corrected/ens/diff_ens_tasmax_585_2-1.5deg_TX10p_timmean_perc_setmiss_3.nc"
f21 = addfile(file21,"r")
;print(f21)
file31="../../corrected/ens/diff_ens_tasmin_585_2-1.5deg_TN90p_timmean_perc_setmiss_3.nc"
f31 = addfile(file31,"r")
;print(f41)
file41="../../corrected/ens/diff_ens_tasmin_585_2-1.5deg_TN10p_timmean_perc_setmiss_3.nc"
f41= addfile(file41,"r")


sim11=f11->very_warm_days_percent_wrt_90th_percentile_of_reference_period 
sim21=f21->very_cold_days_percent_wrt_10th_percentile_of_reference_period 
sim31=f31->warm_nights_percent_wrt_90th_percentile_of_reference_period 
sim41=f41->cold_nights_percent_wrt_10th_percentile_of_reference_period


;copy_VarMeta(sim1, sim2)     

;>=========================================================<
plotname="changes_585_2-1.5_gcm_perc2"
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
 res@mpMaxLatF               = 54.
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
res1@cnFillPalette  = cmap_r(9:,:)
res1@gsnCenterString = ""
res1@cnMinLevelValF=25
res1@cnMaxLevelValF=80
res1@cnLevelSpacingF=10
res1@lbBoxEndCapStyle = "TriangleBothEnds"
res1@trGridType ="TriangularMesh"
res1@gsnPanelBottom      = 0.4
plot = new(16,graphic)
plot(0)=gsn_csm_contour_map(wks,sim1(time|0,lat|:,lon|:),res1)
plot(1)=gsn_csm_contour_map(wks,sim2(time|0,lat|:,lon|:),res1)
plot(2)=gsn_csm_contour_map(wks,sim3(time|0,lat|:,lon|:),res1)
plot(3)=gsn_csm_contour_map(wks,sim4(time|0,lat|:,lon|:),res1)
plot(4)=gsn_csm_contour_map(wks,sim5(time|0,lat|:,lon|:),res1)
plot(5)=gsn_csm_contour_map(wks,sim6(time|0,lat|:,lon|:),res1)
plot(6)=gsn_csm_contour_map(wks,sim7(time|0,lat|:,lon|:),res1)
plot(7)=gsn_csm_contour_map(wks,sim8(time|0,lat|:,lon|:),res1)
plot(8)=gsn_csm_contour_map(wks,sim11(0,:,:),res1)
plot(9)=gsn_csm_contour_map(wks,sim21(0,:,:),res1)
plot(10)=gsn_csm_contour_map(wks,sim31(0,:,:),res1)
plot(11)=gsn_csm_contour_map(wks,sim41(0,:,:),res1)

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


;>============================================================<
pres                 = True
; pres@gsnPanelRowSpec = True                   ; tell panel what order to plot
pres@gsnPanelDebug            = True      ; prints debug info
  pres@gsnFrame                 = False
  pres@gsnMaximize              = True
  pres@gsnPanelMainFontHeightF  = 0.015
  pres@gsnPanelFigureStringsFontHeightF = 0.012
  pres@gsnPanelFigureStrings= (/"(a) TXx","(b) TXn","(c) TNx","(d) TNn","(e) SU","(f) ID","(g) TR","(h) FD","(i) TX90p","(j) TX10p","(k) TN90p","(l) TN10p","(m)","(n)","(o)","(p)"/) ; add strings to panel
  pres@amJust   = "TopLeft";annotation
  pres@amParallelPosF=-0.45
  pres@amOrthogonalPosF=-0.45
  pres@gsnPanelFigureStringsPerimOn             = False
 pres@gsnPanelFigureStringsBackgroundFillColor=-1
  ;---Top row
  pres@gsnPanelLabelBar         = True
  pres@pmLabelBarHeightF        = 0.05
  pres@pmLabelBarOrthogonalPosF = -0.01
  pres@lbTitleString            = "(%)"
  pres@lbTitleFontHeightF       = 0.012
  pres@lbTitlePosition          = "Bottom"      ;position of label bar
  pres@lbLabelFontHeightF       = 0.01
  pres@gsnPanelLeft   = 0.03
  pres@gsnDraw = True
  ;pplots = gsn_panel_return(wks,plot(0:3),(/1,4/),pres)
  ;bb     = NhlGetBB(pplots)
  ;height = max(bb(0:3,0)) - min(bb(0:3,1))+0.1
  ;pres@gsnPanelTop                      = 0.9  
  ;pres@gsnPanelBottom                   = pres@gsnPanelTop - height+0.03
  ;gsn_panel(wks,plot,(/1,4/),pres)
  ;fig_strs = (/"(a) TXx","(b) TXn","(c) TNx","(d) TNn","(e) SU","(f) ID","(g) TR","(h) FD","(i) TX90p","(j) TX10p","(k) TN90p","(l) TN10p","(m)","(n)","(o)","(p)"/)
  gsn_panel(wks,plot,(/3,4/),pres)
  ;do n=0,11,4
  ;  pres@gsnPanelFigureStrings = fig_strs(n:n+3)
  ;  gsn_panel(wks,plot(n:n+4),(/1,4/),pres)
  ;  pres@gsnPanelMainString = ""
  ;  pres@gsnPanelTop        = pres@gsnPanelBottom
  ;  pres@gsnPanelBottom     = pres@gsnPanelTop-height+0.03
    
  ;end do
frame(wks)
end  
