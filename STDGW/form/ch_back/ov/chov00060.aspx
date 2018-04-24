<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
/* grdVisitor*/
var iCARD_TYPE1=2
var iAPPROVE_STATUS=3
var iCOMPANY_NM=4
var iVISITOR_NM=5
var iCONTACT_WITH=6
var iCONTACT_DEPT=7
var iCONTACT_REASON=8
var iVEHICLE_NO=9
var iREQ_TIME=10
var iTHR_APPROVER_PK1=11
var iPK=12
var istatus_code =13
var iaction1=14
var irow1=15
var ivis_status=16;
var iga_response1=17;
var bprocessing = false;
/*grdVisAppoinment*/
var iapp_pk=1
var iTHR_VIS_MASTER_PK=2 
var iAPP_DATE=3
var iAPP_TIME=4
var iCARD_TYPE2=5
var iCOMPANY_NM=6
var iVISITOR_NM2=7
var iPERSONAL_ID2=8 
var iteam_app=9
var iga_app=10
var iSEX=11 
var iVISITOR_TEL=12
var iCONTACT_TO=13
var iCONTACT_DEPT=14
var iCONTACT_POSITION=15
var iTHR_VIS_COMPANY_PK=16
var iCONTACT_REASON=17
var iVehicle_no=18
var iteam_status_code=19
var iga_status_code=20
var iTHR_APPROVER_PK2=21
var iaction2=22
var irow2=23
var iga_response2=24
var igrid=1;//grdVisitor =1,grdVisAppointment =2
function BodyInit()
{ 	
    var temp = "<%=ESysLib.SetGridColumnDataSQL("select a.CODE,a.CODE_NM from vhr_hr_code a where a.id='HR0121'  ")%>";
    grdVisitor.SetComboFormat(iCARD_TYPE1,temp);
    var temp = "<%=ESysLib.SetGridColumnDataSQL("select a.CODE,a.CODE_NM from vhr_hr_code a where a.id='HR0121'  ")%>";
    grdVisAppointment.SetComboFormat(iCARD_TYPE2,temp);
    iduser_pk.text = "<%=session("USER_PK")%>";
    grdVisitor.GetGridControl().FrozenCols =iVISITOR_NM;
    grdVisAppointment.GetGridControl().FrozenCols =iVISITOR_NM;
    grdVisAppointment.style.display="none";
    set_Interval(20000);
    
}
function OnSearch()
{
    if (bprocessing==false)
    {
        if (igrid==1)
        {
            bprocessing=true;
            datVisitor_Register.Call("SELECT");
        }
        else
            datVisitor_GA_Appr.Call("SELECT");
    }
}

//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
       if (obj.id=="datVisitor_Register")
       {
       
            lblRecord.text=grdVisitor.rows-1 + " record(s)";
            OnFillColor(igrid);
            bprocessing=false;
            auto_resize_column(grdVisitor,0,grdVisitor.cols-1,9);    
       } 
       else if (obj.id=="datVisitor_GA_Appr")
       {
            lblRecord.text=grdVisAppointment.rows-1 + " record(s)";
            OnFillColor(igrid);
            auto_resize_column(grdVisAppointment,0,grdVisAppointment.cols-1,9);    
       }
}     
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-----------------------------------
function OnFillColor(grdobj)
{
    if (grdobj==1)
    {
        for (var i=1;i<grdVisitor.rows;i++)
        {
            var sstatus=grdVisitor.GetGridData(i,istatus_code)
            var sin_out=grdVisitor.GetGridData(i,ivis_status)
            switch (sstatus)
            {
                case "02"://approval
                    grdVisitor.SetCellBgColor(i, 0,i, grdVisitor.cols-1,  0x99FF66 );   //approval + vis:waiting
                    break;
                case "03": //deni
                    grdVisitor.SetCellBgColor(i, 0,i, grdVisitor.cols-1, 0x9999FF);  //denied
                    break;
            }
            switch (sin_out)
            {
                case "I"://In
                    grdVisitor.SetCellBgColor(i, 0,i, grdVisitor.cols-1, 0x99FFff );  // vis: in
                    break;
                case "O"://OUT
                    grdVisitor.SetCellBgColor(i, 0,i, grdVisitor.cols-1,  0xff99ff  ); //vis: out
                    break;
            }
        }
    }
    else
    {
        for (var i=1;i<grdVisAppointment.rows;i++)
        {
            var sstatus=grdVisAppointment.GetGridData(i,iga_status_code)
            switch (sstatus)
            {
                case "02"://approval
                    grdVisAppointment.SetCellBgColor(i, 0,i, grdVisAppointment.cols-1,  0x99FF66 );
                    break;
                case "03": //deni
                    grdVisAppointment.SetCellBgColor(i, 0,i, grdVisAppointment.cols-1, 0x9999FF);
                    break;
            }
            
        }
    }
}

//-------------------------------------
function OnApprove(objaction)
{
    if (!(OnCheckGrid(grdVisitor,0) && igrid==1) && !(OnCheckGrid(grdVisAppointment,0) && igrid==2))
    {
        alert("Please select one visitor! \n Vui lòng chọn khách!")
        return;
    }
    var squestion;
    if (objaction =="02")
        squestion="Do you want to approve selected data? \n Bạn có muốn chấp nhận dữ liệu đã chọn?"
    else
        squestion="Do you want to deny selected data? \n Bạn có muốn hủy dữ liệu đã chọn?"
    if (confirm(squestion))
    {
        if (igrid==1)
            OnApproveVis(objaction);
        else
            OnApproveVisApp(objaction);
        
    }
}
function OnCheckGrid(grdobj,colobj)
{   
    var bresult=false;
    var vcheck;
    for (var i=1;i<grdobj.rows;i++)
    {
        vcheck=grdobj.GetGridData(i,colobj);
        if (vcheck=="-1")
        {
            bresult=true;
            return bresult;
        }    
    }
    return bresult;
}
//---------------------------
function OnApproveVis(objaction)
{
    for (var i=1;i<grdVisitor.rows;i++)
    {
        var vcheck,scard_type;
        vcheck=grdVisitor.GetGridData(i,0);
        scard_type=grdVisitor.GetGridData(i,iCARD_TYPE1);
        if (vcheck=="-1")
        {
            if (scard_type=="") 
            {
                alert("Please choose card type at row " + i + " \n Vui lòng chọn loại thẻ tại dòng " + i );
                return;
            }
            grdVisitor.SetGridText(i,iaction1,objaction);
            grdVisitor.SetGridText(i,iTHR_APPROVER_PK1,iduser_pk.text);
            grdVisitor.SetGridText(i,irow1,i);
            grdVisitor.SetRowStatus(i,16);
            
        }    
        else
            grdVisitor.SetRowStatus(i,0);
    }
    bprocessing=true;
    datVisitor_Register.Call();
}
//---------------------------
function OnApproveVisApp(objaction)
{
    for (var i=1;i<grdVisAppointment.rows;i++)
    {
        var vcheck,scard_type;
        vcheck=grdVisAppointment.GetGridData(i,0);
        scard_type=grdVisAppointment.GetGridData(i,iCARD_TYPE2);
        if (vcheck=="-1")
        {
            if (scard_type=="" && objaction=='02') 
            {
                alert("Please choose card type at row " + i + " \n Vui lòng chọn loại thẻ tại dòng " + i );
                return;
            }
            grdVisAppointment.SetGridText(i,iaction2,objaction);
            grdVisAppointment.SetGridText(i,iTHR_APPROVER_PK2,iduser_pk.text);
            grdVisAppointment.SetGridText(i,irow2,i);
            grdVisAppointment.SetRowStatus(i,16);
            
        }    
        else
            grdVisAppointment.SetRowStatus(i,0);
    }
    datVisitor_GA_Appr.Call();
}

//-------------------------------------------------
function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ov/chov00020.aspx?popup_yn=Y";
        var obj=System.OpenModal( fpath , 900 , 600 , 'resizable:yes;status:yes') ;
        if (obj!=null)
        {
            switch (lstSearch.value)
            {
                case "01":
                    txtTemp.text=obj[4];
                    break;
                case "02":
                    txtTemp.text=obj[5];
                    break;
                case "03":
                    txtTemp.text=obj[7];
                    break;    
            }
        }
}
//------------------------------------------------------------------------------------
function OnSetGrid(obj_checkbox,obj_grd,obj_col)
{	
    var tmp;
    if( obj_checkbox.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
    var ctrl = obj_grd.GetGridControl();
    
    if (ctrl.SelectedRows>0)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    obj_grd.SetGridText(row,obj_col,tmp);
			    }
		    }
	}
	else
	{
	    for ( var i =  1 ; i < ctrl.rows ; i++ )
				    obj_grd.SetGridText(i,obj_col,tmp);
	}
}
/*#######################################################################################*/
function OnDataError(obj)
{
	AlertDBError(obj.errmsg);
}

/*#######################################################################################*/
function AlertDBError(errmsg)
{
	var aTmp = new Array();
	aTmp = errmsg.split("ORA-");
	if(aTmp.length >= 2)
	{
		alert(aTmp[1]);
	}
	else 
	{
		alert(errmsg);
	}
	bprocessing = false;
}
//--------------------------------------
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
 
}
function clock(start,x) 
{
        if (!OnCheckGridStatus() && System.Menu.IsActive("Visistor-GA Approval")) //luoi khong lam viec 
        {
                if (igrid==1)
                {
                    bprocessing=true;
                    datVisitor_Register.Call("SELECT");
                }
        }
}
//---------------------------
function OnCheckGridStatus()
{
    var bupdate=false;
    if (igrid==1)
    {
        for(var i=1;i<grdVisitor.rows;i++)
        {
            if (grdVisitor.GetGridData(i,0)=="-1")
                bupdate=true;
        }
     }
     return (bupdate || bprocessing);
}
function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}
function OnWriteResponse(grdoj,colobj)
{
    var icurrow=event.row;
    var icurcol=event.col;
    if (icurcol==colobj)
    {
        var fpath = System.RootURL + "/form/ch/ov/chov00060_response.aspx?p_row=" + icurrow + "&p_col=" + icurcol ; 
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;dialogWidth:15;dialogHeight:15;dialogLeft:' + window.event.screenX + ';dialogTop:' + window.event.screenY    +';edge:sunken;scroll:no;unadorned:yes;help:no;center:yes');
    
        if (obj!=null)
        {
           
            grdoj.SetGridText(icurrow,colobj,obj);
        }
    }
}
function OnShowDetail()
{
    var icurcol=event.col
    if (igrid==1) //not appointment
    {
        if (icurcol!=iga_response1)
        {
            var p_vis_register_pk=grdVisitor.GetGridData(event.row,iPK)
            var fpath = System.RootURL + "/form/ch/ov/chov00040.aspx?p_vis_register_pk=" + p_vis_register_pk;
            var object = System.OpenModal( fpath , 900 , 300 , 'resizable:yes;status:yes'); 
        }
    }
    else //appoinment
    {
        if (icurcol!=iga_response2)
        {
            var p_vis_app_pk=grdVisAppointment.GetGridData(event.row,iapp_pk)
            var fpath = System.RootURL + "/form/ch/ov/chov00070.aspx?p_vis_app_pk=" + p_vis_app_pk;
            var object = System.OpenModal( fpath , 900 , 200 , 'resizable:yes;status:yes'); 
        }
    }
    
}
function SelectOption(igrid_number,grdobj1,grdobj2)
{
    igrid=igrid_number
    grdobj1.style.display="none";
    grdobj2.style.display="";
}
</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->



<!----------------------------------->
<gw:data id="datVisitor_Register" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_visitor_registor " procedure="hr.sp_upd_visitor_registor" parameter="2,5,11,12,14,15,17" > 
            <input> 
                <input bind="lstStatus" /> 
                <input bind="dtFromDate" /> 
                <input bind="dtToDate" /> 
                <input bind="lstSearch" /> 
                <input bind="txtTemp" /> 
            </input> 
            <output bind="grdVisitor" /> 
        </dso> 
   </xml> 
</gw:data> 
<!----------------------------------->
<gw:data id="datVisitor_GA_Appr" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_visitor_ga_appr " procedure="hr.sp_upd_visitor_ga_appr" parameter="1,5,21,22,23,24" > 
            <input> 
                <input bind="lstStatus" /> 
                <input bind="dtFromDate" /> 
                <input bind="dtToDate" /> 
                <input bind="lstSearch" /> 
                <input bind="txtTemp" /> 
            </input> 
            <output bind="grdVisAppointment" /> 
        </dso> 
   </xml> 
</gw:data> 

<!--------------table------------------------------->
<table style='margin-left:10px' align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
	<tr style="height:10%"> 
	    <td  align = top >
	        <table  width="100%" border="0" CELLSPACING="0" CELLPADDING="0" style="height:100%" >
		        <tr style="border:1;width:100%;height:5%" valign="center" >   
			        <td width="7%" height=5% align="right"><font color="black"><b >Status&nbsp;</b></td>
			        <td width="10%" ><gw:list id="lstStatus" styles="color:black;width:100%" value="ALL" onchange=""> 
                                   <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0124' order by code")%>|ALL|Select All</data>
                                   </gw:list > 
			        </td>
			        <td width="8%" align="right"><font color="black"><b >Date&nbsp;</b></td>
			        <td width="10%" ><gw:datebox id="dtFromDate"  styles='width:80%'   lang="<%=Session("Lang")%>"/>  </td>						
			        <td width="3%" align="center" ><font color="black"><b>~</b></td>
			        <td width="10%" align="right" ><gw:datebox id="dtToDate"  styles='width:80%'   lang="<%=Session("Lang")%>"/></td>
			        <td width="7%" align="right" ><a title="Click here to show visitor" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF">Visitor&nbsp;</a></td>
			        <td width="5%" align="right">
				        <gw:list  id="lstSearch" value="01" styles='width:100%' onchange=""> 
						         <data>|01|ID|02|Name|03|Tel</data>
                                          </gw:list></td>
					<td width="10%" align="right" ><gw:textbox id="txtTemp" onenterkey   ="OnSearch(datVisitor_Register)" styles='width:100%'/></td>
			        <td width="10%" align="center"><gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
			        <td width="3%" align="left">
				        <gw:imgBtn id="ibtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch()" />
			        </td>
			        <td width="2%" align="left"></td>
			        <td align = right  width="6%" ><gw:icon id="icnApprove" img="in" styles="width:100%" text="Approve" onclick="OnApprove('02')" /></td>
			        <td width="2%" align="left">
                    <td align = center width="7%" ><gw:icon id="icnDeny" img="in" styles="width:100%" text="Deny" onclick="OnApprove('03')" /></td>
		        </tr>
		        <tr style="border:1;width:100%;height:5%" valign="center" >   
			        <td width height=5% align="center"><font color="black"><gw:checkbox id="chkCheck" value="F" onclick="OnSetGrid(chkCheck,grdVisitor,0)"></gw:checkbox ></td>
			        <td colspan= 1 align = left  >Select</td>
			        <td colspan= 4 align = center  ><input type="radio"  id="optApp1" name="option" value="1" checked onclick="SelectOption(1,grdVisAppointment,grdVisitor)" /><font size="2" color="green" >Not Appointed</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
			        <td colspan= 9 align = left  ><input type="radio"  id="Radio1" name="option" value="1"  onclick="SelectOption(2,grdVisitor,grdVisAppointment)" /><font size="2" color="green" >Appointed</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			        
			        
		        </tr>
		        <tr style="border:1;width:100%;height:90%" valign="center" > 
                    <td  colspan= 15  width="100%" height=90% >
                    <gw:grid id='grdVisitor'
                    header='Check|Date|Card Type|Approve Status|Company Name|Visitor Name|Contact Person|Contact Dept|Visitor Purpose|Visiting Status|Request Times|_THR_APPROVER_PK|_PK|_Approve Status Code|_Action|_Row|_Vis_Status|Response'
                    format='3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='||||||||||||||||'
                    editcol='0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|1'
                    widths='1000|1200|1545|1650|1860|2895|1950|2400|2730|1575|1005|1100|1000|0|0|0|0|4000'
                    sorting='T'
                    styles='width:100%; height:100%'
                    oncelldblclick = "OnWriteResponse(grdVisitor,iga_response1);OnShowDetail()"
                    />
                    <gw:grid id='grdVisAppointment'
                    header='Check|_APP_PK|_THR_VIS_MASTER_PK|Date|Time|Card Type|Company Name|Visitor Name|Personal ID|Team MG Approval|GA Approval|_Sex|_Telephone|Contact Person|Contact Dept|Contact Position|_THR_VIS_COMPANY_PK|Visitor Purpose|_Vehicle No|_TEAM_MN_APPROVE_STATUS|_GA_APPROVE_STATUS|_Approval_PK|_action|_row|Response'
                    format='3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='||||||||||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1'
                    widths='0|1000|675|1200|1000|1080|1000|1080|1000|1215|1000|1455|1455|1935|1935|1365|1485|1725|1200|1000|1000|0|0|0|4000'
                    sorting='T'
                    styles='width:100%; height:100%'
                    oncelldblclick = "OnWriteResponse(grdVisAppointment,iga_response2);OnShowDetail()"
/>
                </td>
            </tr>
	        </table>
	    </td> 
	</tr>		   
	

    
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>

</body>
</html>

				
