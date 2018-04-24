<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var iapp_pk=1
var iTHR_VIS_MASTER_PK=2 
var iVISITOR_NM=3
var iPERSONAL_ID=4 
var iAPP_DATE=5
var iAPP_TIME=6
var iteam_app=7
var iga_app=8  
var iCARD_TYPE=9
var iSEX=10 
var iVISITOR_TEL=11
var iCONTACT_TO=12
var iCONTACT_POSITION=13
var iTHR_VIS_COMPANY_PK=14 
var iCOMPANY_NM=15
var iCONTACT_DEPT=16 
var iCONTACT_REASON=17 
var iVehicle_no=18
var iteam_status_code=19
var iga_status_code=20
var iTHR_APPROVER_PK=21
var iaction=22
var irow=23
var bprocessing = false;
function BodyInit()
{ 	
    iduser_pk.text = "<%=session("USER_PK")%>";
    grdVisitor.GetGridControl().FrozenCols =5;
    //alert(iduser_pk.text);
    OnSearch();
    
}
function OnSearch()
{
    if (bprocessing==false)
    {
        bprocessing=true;
        datVisitor_App_Team.Call("SELECT");
    }
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
       if (obj.id=="datVisitor_App_Team")
       {
            lblRecord.text=grdVisitor.rows-1 + " record(s)";
            OnFillColor();
            bprocessing=false;
            auto_resize_column(grdVisitor,0,grdVisitor.cols-1,0)
            //clear_Interval(idInterval);
            //set_Interval(1000);
       } 
}     
//-----------------------------------
function OnFillColor()
{
    for (var i=1;i<grdVisitor.rows;i++)
    {
        var sstatus=grdVisitor.GetGridData(i,iteam_status_code)
        switch (sstatus)
        {
            case "02"://approval
                grdVisitor.SetCellBgColor(i, 0,i, grdVisitor.cols-1,  0x99FF66 );
                break;
            case "03": //deni
                grdVisitor.SetCellBgColor(i, 0,i, grdVisitor.cols-1, 0x9999FF);
                break;
        }
    }
}
//-------------------------------------
function OnApprove(objaction)
{
    if (!(OnCheckGrid(grdVisitor,0)))
    {
        alert("Please select one visitor! \n Vui lòng chọn khách!")
        return;
    }
    var squestion;
    if (objaction =="02")
        squestion="Do you want to approve selected rows? \n Bạn có muốn chấp nhận cuộc hẹn này không?"
    else
        squestion="Do you want to deny selected rows? \n Bạn có muốn từ chối cuộc hẹn này không?"
    if (confirm(squestion))
    {
        for (var i=1;i<grdVisitor.rows;i++)
        {
            var vcheck;
            vcheck=grdVisitor.GetGridData(i,0);
            if (vcheck=="-1")
            {
                grdVisitor.SetGridText(i,iaction,objaction);
                grdVisitor.SetGridText(i,iTHR_APPROVER_PK,iduser_pk.text);
                grdVisitor.SetGridText(i,irow,i);
                grdVisitor.SetRowStatus(i,16);
                
            }    
            else
                grdVisitor.SetRowStatus(i,0);
        }
        bprocessing=true;
        datVisitor_App_Team.Call();
    }
}
//---------------------------------------------
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
}
//--------------------------------------
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
 
}

//------------------------------------
function OnShowDetail()
{
    var icurcol=event.col
    var p_vis_app_pk=grdVisitor.GetGridData(event.row,iapp_pk)
    var fpath = System.RootURL + "/form/ch/ov/chov00070.aspx?p_vis_app_pk=" + p_vis_app_pk;
    var object = System.OpenModal( fpath , 900 , 200 , 'resizable:yes;status:yes'); 
    
}

</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->



<!----------------------------------->
<gw:data id="datVisitor_App_Team" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
    <xml> 
        <dso  type="grid" function="hr.SP_SEL_VISITOR_APP_TEAM " procedure="hr.SP_upd_VISITOR_APP_TEAM" parameter="1,21,22,23" > 
            <input> 
                <input bind="lstStatus" /> 
                <input bind="dtFromDate" /> 
                <input bind="dtToDate" /> 
                <input bind="txtSearch" />
                <input bind="iduser_pk" />  
            </input> 
            <output bind="grdVisitor" /> 
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
			        <td width="12%" colspan=2 align="right" >Search&nbsp;</td>
			        <td width="10%" align="right" ><gw:textbox id="txtSearch" onenterkey   ="OnSearch()" styles='width:100%'/></td>
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
			        <td colspan= 14 align = left  >Select</td>
		        </tr>
		        <tr style="border:1;width:100%;height:90%" valign="center" > 
                    <td  colspan= 15  width="100%" height=90% >
                    <gw:grid id='grdVisitor'
                    header='Check|_APP_PK|_THR_VIS_MASTER_PK|Visitor Name|Personal ID|Date|Time|Team MG Approval|_GA Approval|Card Type|Sex|Telephone|Contact to|Contact Position|_THR_VIS_COMPANY_PK|Company Name|Contact Dept|Contact Reason|Vehicle No|_TEAM_MN_APPROVE_STATUS|_GA_APPROVE_STATUS|_Approval_PK|_action|_row|Applicant|Applicant ID|Organization'
                    format='3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='||||||||||||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1000|675|1410|1350|1080|1000|1080|1000|1215|1000|1455|1455|1935|1935|1365|1485|1725|1200|1000|1000|0|0|0|1500|1500|2500'
                    sorting='T'
                    styles='width:100%; height:100%'
                    oncelldblclick = "OnShowDetail()"
/>
                </td>
            </tr>
	        </table>
	    </td> 
	</tr>		   
	

    
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="idInterval" styles="display:none"/>

</body>
</html>

				
