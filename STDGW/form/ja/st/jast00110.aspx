<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Correct Bill</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
var g_status = 0;
function BodyInit()
{
    var data="";
    data = "<%=ESysLib.SetListDataSQL("SELECT A.PK, A.COURSE_ID ||' - '|| A.COURSE_NAME FROM CRM.TGM_GOLF_COURSE A WHERE A.DEL_IF =0 " ) %> ";	
	lstGolfer.SetDataText(data);
	lstGolfer.value=1;
	data = "<%=ESysLib.SetListDataSQL("SELECT A.PK, A.COURSE_ID ||' - '|| A.COURSE_NAME FROM CRM.TGM_GOLF_COURSE A WHERE A.DEL_IF =0 " ) %> ";	
	lstGolfer1.SetDataText(data);
	lstGolfer1.value=2;
	data = "<%=ESysLib.SetListDataSQL("SELECT A.PK, A.COURSE_ID ||' - '|| A.COURSE_NAME FROM CRM.TGM_GOLF_COURSE A WHERE A.DEL_IF =0 " ) %> ";	
	lstGolfer2.SetDataText(data);
	lstGolfer2.value=3;
	lstGolfer.SetEnable(false);
	lstGolfer1.SetEnable(false);
	lstGolfer2.SetEnable(false);
	chkE9.value="Y";
    chkOutCourse.value="Y";
    chkInCourse.value="Y";
	OnSearch(1);
}
function MandatoryColor()
{
    if (grdCourse.rows >1)
    {
		for(var i=1;i<grdCourse.rows;i++)
         {
            if(grdCourse.GetGridData(i,6) != "" )//6 is locker#
            {
		            grdCourse.SetCellBgColor( i, 0 , i, grdCourse.cols-3 , 0x00FFFF );
		    }
			if(grdCourse.GetGridData(i,2) == "Y" )//print yn
            {
		            grdCourse.SetCellBgColor( i, 0 , i, grdCourse.cols-3 , 0x00CD00 );
		    }
		 }
    }
}
function MandatoryColor1()
{
    if (grdCourse1.rows >1)
    {
		for(var i=1;i<grdCourse1.rows-1;i++)
         {
            if(grdCourse1.GetGridData(i,6) !="")//6 is locker#
                {
		            grdCourse1.SetCellBgColor( i, 0 , i, grdCourse1.cols-3 , 0x00FFFF );
		         }
		 }
    }
}
function MandatoryColor2()
{
    if (grdCourse2.rows >1)
    {
		for(var i=1;i<grdCourse2.rows-1;i++)
         {
            if(grdCourse2.GetGridData(i,6) !="")//6 is locker#
                {
		            grdCourse2.SetCellBgColor( i, 0 , i, grdCourse2.cols-3 , 0x00FFFF );
		        }
		 }
    }
}
function OnSearch(pos)
 {
     switch(pos)
     {
        case 1:
             lstGolfer.value=1;
             dso_grdCourse.Call('SELECT');
        break;
        case 2: //search master
             lstGolfer1.value=2;   
             dso_grdCourse1.Call('SELECT')
        break;
        case 3: //search master
             lstGolfer2.value=3;   
             dso_grdCourse2.Call('SELECT')
        break;
     }
 }
var mTimer;
function SettimeReSearch()
{
  mTimer = setTimeout('OnSearch(1);',120000); //Refresh every 2 minutes
}
function OnDataReceive(po_oData)
 {
     clearInterval(mTimer);
     
     switch(po_oData.id)
     {
        case "dso_grdCourse":
                MandatoryColor();
                grdCourse.MergeByCol(0);
                grdCourse.MergeByCol(1); 
				HighLightColor(grdCourse,17);	
                dso_block.Call('SELECT');
        break;
        case "dso_grdCourse1":
                MandatoryColor1();
                grdCourse1.MergeByCol(0);
                grdCourse1.MergeByCol(1);
				HighLightColor(grdCourse1,17);
                dso_block1.Call('SELECT');
        break;
        case "dso_grdCourse2":
               MandatoryColor2();
               grdCourse2.MergeByCol(0);
               grdCourse2.MergeByCol(1);
               dso_block2.Call('SELECT');
        break;
        case "dso_block":
                gridSetColor(grdCourse, grdBlock);
                OnSearch(2);
        break;
        case "dso_block1":
                gridSetColor(grdCourse1, grdBlock1);
                OnSearch(3);
        break;
        case "dso_block2":
                gridSetColor(grdCourse2, grdBlock2);
                SettimeReSearch();
        break;
     }
 }
 function gridOnbeforeedit(obj){
    if(obj.GetGridData(obj.row,16) != ""){
        alert("Cannot modify or insert!");return false;
    }
 }
 function gridOnafteredit(obj){
    switch(obj.id){
        case "grdCourse":
            gridOnAddNew(grdBlock, obj, obj.row, obj.col, lstGolfer, dso_block);
        break;
        case "grdCourse1":
            gridOnAddNew(grdBlock1, obj, obj.row, obj.col, lstGolfer1, dso_block1);
        break;
        case "grdCourse2":
            gridOnAddNew(grdBlock2, obj, obj.row, obj.col, lstGolfer2, dso_block2);
        break;
    }
 }
 function gridSetColor(obj_mt, obj_dt){
    if(obj_dt.rows == 1){
        for(var i = 1; i < obj_mt.rows; i++){
            if(obj_mt.GetGridData(i,16) != ""){
                for(var y = 0; y < obj_mt.cols-1; y++){
                    switch(y){
                        case 1: obj_mt.SetCellBgColor(i,y,i,y,0x5c5ccd); break;
                        case 2:
                        case 5:
                        case 8:
                        case 11:if(obj_mt.GetGridData(i,y) != "")obj_mt.SetCellBgColor(i,y,i,y,0x5c5ccd);break;
                    }
                }
            }
        }
    }else{
        for(var x = 1; x < obj_dt.rows; x++){
            for(var i = 1; i < obj_mt.rows; i++){
                if(obj_mt.GetGridData(i,16) != ""){
                    for(var y = 0; y < obj_mt.cols-1; y++){
                        switch(y){
                            case 1: obj_mt.SetCellBgColor(i,y,i,y,0x5c5ccd); break;
                            case 2:
                            case 5:
                            case 8:
                            case 11:if(obj_mt.GetGridData(i,y) != "")obj_mt.SetCellBgColor(i,y,i,y,0x5c5ccd);break;
                        }
                    }
                }else{
                    if(obj_dt.GetGridData(x,2) == obj_mt.GetGridData(i,1)){
                        obj_mt.SetCellBgColor(i,1,i,1,0x00ff00);
                        for(var y = 0; y < obj_dt.cols-1; y++){
                            switch(y){
                                case 4: if(obj_dt.GetGridData(x,y) != ""){obj_mt.SetGridText(i,2,obj_dt.GetGridData(x,y)); obj_mt.SetCellBgColor(i,2,i,2,0x00ff00); }break;
                                case 5: if(obj_dt.GetGridData(x,y) != ""){obj_mt.SetGridText(i,5,obj_dt.GetGridData(x,y)); obj_mt.SetCellBgColor(i,5,i,5,0x00ff00); }break;
                                case 6: if(obj_dt.GetGridData(x,y) != ""){obj_mt.SetGridText(i,8,obj_dt.GetGridData(x,y)); obj_mt.SetCellBgColor(i,8,i,8,0x00ff00); }break;
                                case 7: if(obj_dt.GetGridData(x,y) != ""){obj_mt.SetGridText(i,11,obj_dt.GetGridData(x,y)); obj_mt.SetCellBgColor(i,11,i,11,0x00ff00); }break;
                            }
                        }
                    }
                }
            }
        }
    }
 }
 function gridOnAddNew(obj, obj_mt, row, col, list, dso){
    var idx = 0, obj_col = 0;
    for(var i=1; i < obj.rows; i++)
        if(obj_mt.GetGridData(row, 1) == obj.GetGridData(i, 2)){
            idx = i; i = obj.rows;
        }
    switch(col){
        case 2:     obj_col = 4; break;
        case 5:     obj_col = 5; break;
        case 8:     obj_col = 6; break;
        case 11:    obj_col = 7; break;}
    if(idx == 0){
        obj.AddRow();
        obj.SetGridText(obj.rows-1  ,1      , dtDate.value);
        obj.SetGridText(obj.rows-1  ,2      , obj_mt.GetGridData(row, 1));
        obj.SetGridText(obj.rows-1  ,3      , list.value);
        obj.SetGridText(obj.rows-1  ,obj_col, obj_mt.GetGridData(row, col));
    }else{
        obj.SetGridText(idx  ,1      , dtDate.value);
        obj.SetGridText(idx  ,2      , obj_mt.GetGridData(row, 1));
        obj.SetGridText(idx  ,3      , list.value);
        obj.SetGridText(idx  ,obj_col, obj_mt.GetGridData(row, col));
    }
    dso.Call();
 }
 function OnShowCheck()
 {
    
    var Left  = document.all("OnLeft");    
    var Center  = document.all("OnCenter");  
    var Right  = document.all("OnRight");  
    if(chkOutCourse.value == 'N')
    {
        Left.style.display="none";
    }
    else
    {
       Left.style.display="";
    }
    if(chkInCourse.value == 'N')
    {
        Center.style.display="none";
    }
    else
    {
        
        Center.style.display="";
    }
    if(chkE9.value == 'N')
    {
        Right.style.display="none";
    }
    else
    {
        Right.style.display="";
    }
     //3 if/else 2  are "N"
    if(chkOutCourse.value == 'N' && chkInCourse.value == 'N') ///chkE9 chkOutCourse chkInCourse
    {
        Left.style.display="none";
        Center.style.display="none";
        Right.style.width="99%";
    }
    else if(chkOutCourse.value == 'N' && chkE9.value == 'N') ///chkE9 chkOutCourse chkInCourse
    {
        Left.style.display="none";
        Center.style.width="99%";
        Right.style.display="none";
    }
    else if(chkInCourse.value == 'N' && chkE9.value == 'N') ///chkE9 chkOutCourse chkInCourse
    {
        Left.style.width="99%";
        Center.style.display="none";
        Right.style.display="none";
    }
     //1 if/else 3  are "N"
    else if(chkInCourse.value == 'Y' && chkE9.value == 'Y' && chkE9.value == 'Y') 
    {
        Left.style.width="33%";
        Center.style.width="33%";
        Right.style.width="33%";
    }
    else if(chkOutCourse.value == 'Y' && chkInCourse.value == 'Y' &&chkE9.value == 'N') 
    {
        Left.style.width="50%";
        Center.style.width="50%";
        Right.style.display="none";
    }
    else if(chkOutCourse.value == 'Y' && chkInCourse.value == 'N' &&chkE9.value == 'Y') 
    {
        Left.style.width="50%";
        Center.style.display="none";
        Right.style.width="50%";
    }
    else if(chkOutCourse.value == 'N' && chkInCourse.value == 'Y' &&chkE9.value == 'Y') 
    {
        Left.style.display="none";
        Center.style.width="50%";
        Right.style.width="50%";
    }
 }
 function OnShowCheck1() // show grid 2
 {
    
    var Left  = document.all("OnLeft");    
    var Center  = document.all("OnCenter");  
    var Right  = document.all("OnRight");  
    if(chkOutCourse.value == 'N')
    {
        //alert(chkOutCourse.value);
        Left.style.display="none";
    }
    else
    {
       //alert(chkOutCourse.value);
       Left.style.display="";
    }
    if(chkInCourse.value == 'N')
    {
        Center.style.display="none";
    }
    else
    {
        
        Center.style.display="";
    }
    if(chkE9.value == 'N')
    {
        Right.style.display="none";
    }
    else
    {
        Right.style.display="";
    }
     //3 if/else 2  are "N"
    if(chkOutCourse.value == 'N' && chkInCourse.value == 'N') 
    {
        Left.style.display="none";
        Center.style.display="none";
        Right.style.width="99%";
    }
    else if(chkOutCourse.value == 'N' && chkE9.value == 'N') 
    {
        Left.style.display="none";
        Center.style.width="99%";
        Right.style.display="none";
    }
    else if(chkInCourse.value == 'N' && chkE9.value == 'N') 
    {
        Left.style.width="99%";
        Center.style.display="none";
        Right.style.display="none";
    }
     //1 if/else 3  are "N"
    else if(chkInCourse.value == 'Y' && chkE9.value == 'Y' && chkE9.value == 'Y') 
    {
        Left.style.width="33%";
        Center.style.width="33%";
        Right.style.width="33%";
    }
    
    else if(chkOutCourse.value == 'Y' && chkInCourse.value == 'Y' &&chkE9.value == 'N') 
    {
        Left.style.width="50%";
        Center.style.width="50%";
        Right.style.display="none";
    }
    else if(chkOutCourse.value == 'Y' && chkInCourse.value == 'N' &&chkE9.value == 'Y') 
    {
        Left.style.width="50%";
        Center.style.display="none";
        Right.style.width="50%";
    }
    else if(chkOutCourse.value == 'N' && chkInCourse.value == 'Y' &&chkE9.value == 'Y') 
    {
        Left.style.display="none";
        Center.style.width="50%";
        Right.style.width="50%";
    }
 }
 
 function OnPrint3(){
    var url = '/reports/ja/st/rpt_jast00110.aspx?p_dt='+ dtDate.GetData();
	System.OpenTargetPage( System.RootURL+url , "newform" );
 }
 function OnPrint(){
    var url = '/reports/ja/st/jast00110.aspx?p_dt='+ dtDate.GetData();
	System.OpenTargetPage( System.RootURL+url , "newform" );
 }
 function OnPrintColor(){
    var url = '/reports/ja/st/jast00110_color.aspx?p_dt='+ dtDate.GetData();
	System.OpenTargetPage( System.RootURL+url , "newform" );
 }
 function OnShowCheck2()// show grid 3
 {
    
    var Left  = document.all("OnLeft");    
    var Center  = document.all("OnCenter");  
    var Right  = document.all("OnRight");  
    if(chkOutCourse.value == 'N')
    {
        //alert(chkOutCourse.value);
        Left.style.display="none";
    }
    else
    {
       //alert(chkOutCourse.value);
       Left.style.display="";
    }
    if(chkInCourse.value == 'N')
    {
        Center.style.display="none";
    }
    else
    {
        
        Center.style.display="";
    }
    if(chkE9.value == 'N')
    {
        Right.style.display="none";
    }
    else
    {
        Right.style.display="";
    }
     //3 if/else 2  are "N"
    if(chkOutCourse.value == 'N' && chkInCourse.value == 'N') 
    {
        Left.style.display="none";
        Center.style.display="none";
        Right.style.width="99%";
    }
    else if(chkOutCourse.value == 'N' && chkE9.value == 'N') 
    {
        Left.style.display="none";
        Center.style.width="99%";
        Right.style.display="none";
    }
    else if(chkInCourse.value == 'N' && chkE9.value == 'N') 
    {
        Left.style.width="99%";
        Center.style.display="none";
        Right.style.display="none";
    }
     //1 if/else 3  are "N"
    else if(chkOutCourse.value == 'Y' && chkInCourse.value == 'Y' &&chkE9.value == 'Y') 
    {
        Left.style.width="33%";
        Center.style.width="33%";
        Right.style.width="33%";
    }
    //xet grid end
    else if(chkOutCourse.value == 'Y' && chkInCourse.value == 'Y' &&chkE9.value == 'N') 
    {
        Left.style.width="50%";
        Center.style.width="50%";
        Right.style.display="none";
    }
    else if(chkOutCourse.value == 'Y' && chkInCourse.value == 'N' &&chkE9.value == 'Y') 
    {
        Left.style.width="50%";
        Center.style.display="none";
        Right.style.width="50%";
    }
    else if(chkOutCourse.value == 'N' && chkInCourse.value == 'Y' &&chkE9.value == 'Y') 
    {
        Left.style.display="none";
        Center.style.width="50%";
        Right.style.width="50%";
    }
 }
 function HighLightColor(ctrl,col){
	for(var i=1;i<ctrl.rows;i++){
		if(ctrl.GetGridData(i, col) == "Y"){
			ctrl.SetCellBgColor(i, 0, i, ctrl.cols-1,0XEE82EE);
		}
	}
}
</script>

<body>
    <gw:data id="dso_grdCourse" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" function="crm.sp_sel_jast00110" >  
                <input bind="grdCourse" >
                    <input bind="dtDate" />
                    <input bind="txtAMPM" />  
                    <input bind="lstGolfer" /> 
                </input> 
                <output bind="grdCourse" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------->
    <gw:data id="dso_grdCourse1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" function="crm.sp_sel_jast00110" >  
                <input bind="grdCourse1" >
                    <input bind="dtDate" />
                    <input bind="txtAMPM" />  
                    <input bind="lstGolfer1" /> 
                </input> 
                <output bind="grdCourse1" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------->
    <gw:data id="dso_grdCourse2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" function="crm.sp_sel_jast00110" >  
                <input bind="grdCourse2" >
                    <input bind="dtDate" />
                    <input bind="txtAMPM" />  
                    <input bind="lstGolfer2" /> 
                </input> 
                <output bind="grdCourse2" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------->
    <gw:data id="dso_block" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" user="crm" function="crm.sp_sel_jast00110_block" parameter="0,1,2,3,4,5,6,7" procedure="sp_upd_jast00110_block" > 
                <input> 
                    <input bind="dtDate" />
                    <input bind="lstGolfer" />
                </input> 
                <output bind="grdBlock" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------->
    <gw:data id="dso_block1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm" function="crm.sp_sel_jast00110_block" parameter="0,1,2,3,4,5,6,7" procedure="sp_upd_jast00110_block" > 
                <input> 
                    <input bind="dtDate" />
                    <input bind="lstGolfer1" />
                </input> 
                <output bind="grdBlock1" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------->
    <gw:data id="dso_block2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" user="crm" function="crm.sp_sel_jast00110_block" parameter="0,1,2,3,4,5,6,7" procedure="sp_upd_jast00110_block" > 
                <input> 
                    <input bind="dtDate" />
                    <input bind="lstGolfer2" />
                </input> 
                <output bind="grdBlock2" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 2%" valign="top">
            <td>
                <table style="height: 100%; width: 100%">
                    <tr style="height: 2%">
                        <td style="width: 10%;">
                            <gw:datebox id="dtDate" type="date" lang="1" onchange="OnSearch(1)" />
                        </td>
                        <td style="width: 20%;">
                            <gw:list id="lstGolfer" styles='width:100%' onchange="OnSearch(1)" />
                        </td>
                        <td style="width: 3%;">
                            <gw:checkbox id="chkOutCourse" defaultvalue="Y|N" onclick="OnShowCheck()" />
                        </td>
                        <td style="width: 1%;">
                        </td>
                        <td style="width: 10%;">
                            <td style="width: 2%;">
                            <gw:imgbtn id="ibtnReport3" img="printer" alt="Print" onclick="OnPrint3()" />
                        </td>
                        </td>
                        <td style="width: 20%;">
                            <gw:list id="lstGolfer1" styles='width:100%' onchange="OnSearch(2)" />
                        </td>
                        <td style="width: 2%;">
                            <gw:checkbox id="chkInCourse" defaultvalue="Y|N" onclick="OnShowCheck1()" />
                        </td>
                         <td style="width: 2%;">
                        </td>
                        <td style="width: 6%;">
                            
                        </td>
                        <td style="width: 20%;">
                            <gw:list id="lstGolfer2" styles='width:100%' onchange="OnSearch(3)" />
                        </td>
                        <td style="width: 2%;">
                            <gw:checkbox id="chkE9" defaultvalue="Y|N" onclick="OnShowCheck2()" />
                        </td>
                        <td style="width: 2%;">
                            <gw:imgbtn id="ibtnReport" img="printer" alt="Print Name" onclick="OnPrint()" />
                        </td>
                        <td style="width: 2%;">
                            <gw:imgbtn id="ibtnReport" img="printer" alt="Print Color" onclick="OnPrintColor()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 98%">
            <td style="width: 100%;">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 50%">
                        <td style="width: 33%;" id="OnLeft">
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 98%">
                                    <td colspan="5">
                                        <table style="height: 100%; width: 100%" border="1">
                                            <tr style="height: 100%">
                                                <td>
                                                    <gw:grid id="grdCourse" 
                                                    header  ="_Group|T.O.Time|Player A|_Member No|_CD#|Player B|_Member No|_CD#|Player C|_Member No|_CD#|Player D|_Member No|_CD#|_1|_2|_3|_LockYN" 
                                                    format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                                    widths  ="700|850|1500|1100|700|1500|1100|700|1500|1100|700|1500|1100|700|0|0|0|0" 
                                                    sorting ='T'
                                                    styles  ="width:100%; height:100%" 
                                                    onbeforeedit = "gridOnbeforeedit(this)"
                                                    onafteredit  = "gridOnafteredit(this)"
                                                    />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 33%;" id="OnCenter">
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 98%">
                                    <td colspan="5">
                                        <table style="height: 100%; width: 100%" border="1">
                                            <tr style="height: 100%">
                                                <td>
                                                    <gw:grid id="grdCourse1" 
                                                    header  ="_Group|T.O.Time|Player A|_Member No|_CD#|Player B|_Member No|_CD#|Player C|_Member No|_CD#|Player D|_Member No|_CD#|_1|_2|_3|_LockYN" 
                                                    format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                                    widths  ="700|850|1500|1100|700|1500|1100|700|1500|1100|700|1500|1100|700|0|0|0|0|0" 
                                                    sorting ='T'
                                                    styles  ="width:100%; height:100%" 
                                                    onbeforeedit    = "gridOnbeforeedit(this)"
                                                    onafteredit     = "gridOnafteredit(this)"
                                                    />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 33%;" id="OnRight">
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 98%">
                                    <td colspan="5">
                                        <table style="height: 100%; width: 100%" border="1">
                                            <tr style="height: 100%">
                                                <td>
                                                    <gw:grid id="grdCourse2" 
                                                    header  ="_Group|T.O.Time|Player A|_Member No|_CD#|Player B|_Member No|_CD#|Player C|_Member No|_CD#|Player D|_Member No|_CD#|_1|_2|_3|_LockYN" 
                                                    format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                                    widths  ="700|850|1500|1100|700|1500|1100|700|1500|1100|700|1500|1100|700|0|0|0|0" 
                                                    sorting ='T'
                                                    styles  ="width:100%; height:100%" 
                                                    onbeforeedit = "gridOnbeforeedit(this)"
                                                    onafteredit     = "gridOnafteredit(this)"
                                                    />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <!--An-->
                    <tr style="display:none;">
                        <td>
                            <gw:grid id="grdBlock" 
                            header  ="PK|Play Date|Tee Time|Golf Course|Player A|Player B|Player C|Player D" 
                            format  ="0|0|0|0|0|0|0|0" 
                            aligns  ="0|0|0|0|0|0|0|0" 
                            defaults="|||||||"
                            editcol ="0|0|0|0|0|0|0|0" 
                            widths  ="700|700|700|700|700|700|700|700" 
                            sorting ='T'
                            styles  ="width:100%; height:100%" 
                            />
                        </td>
                        <td>
                            <gw:grid id="grdBlock1" 
                            header  ="PK|Play Date|Tee Time|Golf Course|Player A|Player B|Player C|Player D" 
                            format  ="0|0|0|0|0|0|0|0" 
                            aligns  ="0|0|0|0|0|0|0|0" 
                            defaults="|||||||"
                            editcol ="0|0|0|0|0|0|0|0" 
                            widths  ="700|700|700|700|700|700|700|700" 
                            sorting ='T'
                            styles  ="width:100%; height:100%" 
                            />
                        </td>
                        <td>
                            <gw:grid id="grdBlock2" 
                            header  ="PK|Play Date|Tee Time|Golf Course|Player A|Player B|Player C|Player D" 
                            format  ="0|0|0|0|0|0|0|0" 
                            aligns  ="0|0|0|0|0|0|0|0" 
                            defaults="|||||||"
                            editcol ="0|0|0|0|0|0|0|0" 
                            widths  ="700|700|700|700|700|700|700|700" 
                            sorting ='T'
                            styles  ="width:100%; height:100%" 
                            />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <gw:textbox id="txtInvoiceM_PK" styles="width:100%; display:none" />
    <gw:textbox id="txtAMPM" style="display:none" />
    <!------------------------------------------------------------------------>
</body>
</html>
