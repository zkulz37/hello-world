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
                //MandatoryColor();
                grdCourse.MergeByCol(0);
                grdCourse.MergeByCol(1); 
				HighLightColor(grdCourse,17);	
                dso_grdCourse1.Call('SELECT');
        break;
        case "dso_grdCourse1":
                //MandatoryColor1();
                grdCourse1.MergeByCol(0);
                grdCourse1.MergeByCol(1);
				HighLightColor(grdCourse1,17);
                dso_grdCourse2.Call('SELECT');
        break;
        case "dso_grdCourse2":
               //MandatoryColor2();
               grdCourse2.MergeByCol(0);
               grdCourse2.MergeByCol(1);
        break;
     }
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
	    var status = ctrl.GetGridData(i, 6);
		
		if(status == "3"){
			ctrl.SetCellBgColor(i, 2, i, 2,0x00CD00);
		}
		else if(status == "2"){
			ctrl.SetCellBgColor(i, 2, i, 2,0x00FFFF);
		}
		///the second player
		status = ctrl.GetGridData(i, 11);
		
		if(status == "3"){
			ctrl.SetCellBgColor(i, 7, i, 7,0x00CD00);
		}
		else if(status == "2"){
			ctrl.SetCellBgColor(i, 7, i, 7,0x00FFFF);
		}
		///the third player
		status = ctrl.GetGridData(i, 16);
		
		if(status == "3"){
			ctrl.SetCellBgColor(i, 12, i, 12,0x00CD00);
		}
		else if(status == "2"){
			ctrl.SetCellBgColor(i, 12, i, 12,0x00FFFF);
		}
		///the fourth player
		status = ctrl.GetGridData(i, 21);
		
		if(status == "3"){
			ctrl.SetCellBgColor(i, 17, i, 17,0x00CD00);
		}
		else if(status == "2"){
			ctrl.SetCellBgColor(i, 17, i, 17,0x00FFFF);
		}
	}
}
function OnGridCellClick(ctrl){
    var info;
	if(event.col == 2){
	   info = "Golfer: "+ctrl.GetGridData(event.row, 2)+ "\n\n Member#: "+ ctrl.GetGridData(event.row, 3) +"\n\n Caddie#: " + ctrl.GetGridData(event.row, 4) +"\n\n Locker#: "+ ctrl.GetGridData(event.row, 5);
	   alert(info);
	}   
	else if(event.col == 7){   
		info = "Golfer: "+ctrl.GetGridData(event.row, 7)+ "\n\n Member#: "+ ctrl.GetGridData(event.row, 8)  +"\n\n Caddie#: " +  ctrl.GetGridData(event.row, 9) +"\n\n Locker#: "+ ctrl.GetGridData(event.row, 10);
		alert(info);
	}
	else if(event.col == 12){   
		info = "Golfer: "+ctrl.GetGridData(event.row, 12)+ "\n\n Member#: "+ ctrl.GetGridData(event.row, 13)  +"\n\n Caddie#: " +  ctrl.GetGridData(event.row, 14) +"\n\n Locker#: "+ ctrl.GetGridData(event.row, 15);
		alert(info);
	}
    else if(event.col == 17){   
		info = "Golfer: "+ctrl.GetGridData(event.row, 17)+ "\n\n Member#: "+ ctrl.GetGridData(event.row, 18) +"\n\n Caddie#: " +  ctrl.GetGridData(event.row, 19) +"\n\n Locker#: "+ ctrl.GetGridData(event.row, 20);
		alert(info);
    }
    
    	
}
</script>

<body>
    <gw:data id="dso_grdCourse" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" function="crm.sp_sel_jast00070_1" >  
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
            <dso  type="grid" function="crm.sp_sel_jast00070_1" >  
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
            <dso  type="grid" function="crm.sp_sel_jast00070_1" >  
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
                                                    header  ="_Group|Time|Player A|_Member No|_CD#|_Locker|_Status1|Player B|_Member No|_CD#|_Locker|_Status2|Player C|_Member No|_CD#|_Locker|_Status3|Player D|_Member No|_CD#|_Locker|_Status4" 
                                                    format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                                    sorting ='T'
													debug="false"
													autosize="T"
                                                    styles  ="width:100%; height:100%" 
                                                    oncellclick="OnGridCellClick(this)"
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
                                                    header  ="_Group|Time|Player A|_Member No|_CD#|_Locker|_Status1|Player B|_Member No|_CD#|_Locker|_Status2|Player C|_Member No|_CD#|_Locker|_Status3|Player D|_Member No|_CD#|_Locker|_Status4" 
                                                    format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                                    sorting ='T'
													debug="false"
													autosize="T"
                                                    styles  ="width:100%; height:100%" 
                                                    oncellclick="OnGridCellClick(this)"
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
                                                    header  ="_Group|Time|Player A|_Member No|_CD#|_Locker|_Status1|Player B|_Member No|_CD#|_Locker|_Status2|Player C|_Member No|_CD#|_Locker|_Status3|Player D|_Member No|_CD#|_Locker|_Status4" 
                                                    format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                                    sorting ='T'
													autosize="T"
                                                    styles  ="width:100%; height:100%" 
                                                    oncellclick="OnGridCellClick(this)"
                                                    />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
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
