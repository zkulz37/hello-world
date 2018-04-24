<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>APPOINTMENT EXECUTE</title>
</head>
<%  ESysLib.SetUser("HR")%>

<script>
var  user_pk   =  "<%=Session("EMPLOYEE_PK")%>"  ;
var flag;
var pk_list;
    
var G2_PK       = 0,
    G2_Slip_No  = 1,
    G2_Date     = 2,
    G2_Status   = 3,
    G2_Org      = 4;
//-------------------
var G3_Select               = 0
    G3_PK                   = 1,
    G3_THR_APPOINTMENT_PK   = 2,
    G3_App_NO               = 3,
    G3_THR_EMPLOYEE_PK      = 4,
    G3_Emp_ID               = 5,
    G3_Emp_Name             = 6,
    G3_FROM_ORG_PK         = 7,
    G3_From_Org_ID         = 8,
    G3_From_Org_NM         = 9,
    G3_From_Manager_PK      = 10
    G3_From_Position        = 11, 
    G3_Old_Salary           = 12   
    G3_TO_ORG_PK           = 13,
    G3_To_Org_ID           = 14,
    G3_To_Org_NM           = 15,
    G3_To_Manager_PK       = 16
    G3_To_Position          = 17,
    G3_New_Salary           = 18
    G3_App_Date             = 19,
    G3_Status               = 20,
    G3_Execute_DT           = 21,
    G3_Description          = 22;
//----------------------

var G4_From_Position        = 9,
    G4_Old_Salary           =10,
    G4_To_Position          =15,
    G4_New_Salary           =16,
    G4_Status               =18;
 //---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="65%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }              
//--------------------------------------------------------------------- 
function OnShowPopup(obj1)
{
    var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
			obj1.value = obj;
            //txtUpperOrg.text=obj;
            //datOrgData.Call();
            
        }
}

function BodyInit()
{
    System.Translate(document);  // Translate to language session
    //---------------------------------- 

    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //---------------------------------- 
    
    txtSlipNo.SetEnable(false);    
    lstStatus.SetEnable(false);
    txtChargerName.SetEnable(false);
    dtDocDate.SetEnable(false);
    txtDescription.SetEnable(false);
    lstOrg.SetEnable(false);
    //-------------------------
    BindingDataList();
    iduser_pk.text = "<%=session("USER_PK")%>";
    datSal_security.Call();
}
//---------------------------------------------------------------------  

 function BindingDataList()
 {      
     var data ;     
     //-----------------------
     
     data = "data|10|Saved|20|Executed";
     lstStatus.SetDataText(data);
     //----------------------- 
         
     data = "<%=ESysLib.SetListDataSQL("select pk, org_nm from comm.tco_org a where  del_if=0 order by NVL(SEQ,99999)")%>";   
     
     lstOrg.SetDataText( data );  
     lstOrgSearch2.SetDataText( data + "|ALL|Select ALL");     
     lstOrgSearch2.value = 'ALL' ;
     //-----------------------
     
     data = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm " ) %> ";       
     grdDetail.SetComboFormat( G3_From_Position, data); 
     grdDetail.SetComboFormat( G3_To_Position, data);    
     
     data = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm " ) %> ";       
     grdEvent.SetComboFormat( G4_From_Position, data); 
     grdEvent.SetComboFormat( G4_To_Position, data);
     
     data = "<%=ESysLib.SetGridColumnDataSQL("select '10', 'Saved' from dual union all select '20', 'Executed' from dual " ) %> ";       
     grdEvent.SetComboFormat( G4_Status, data); 
 
     data = "<%=ESysLib.SetGridColumnDataSQL("select pk,org_nm from comm.tco_org a where  del_if=0 order by NVL(SEQ,99999) " ) %> ";       
     grdAppList.SetComboFormat( G2_Org, data);
     
     data = "<%=ESysLib.SetGridColumnDataSQL("select '10', 'Saved' from dual union all select '20', 'Executed' from dual " ) %> ";       
     grdAppList.SetComboFormat( G2_Status, data); 
     
     data = "<%=ESysLib.SetGridColumnDataSQL("select '10', 'Saved' from dual union all select '20', 'Executed' from dual " ) %> ";       
     grdDetail.SetComboFormat( G3_Status, data);                        
 }

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdAppList':
            data_chae00180.Call("SELECT");
        break;
            
        case 'grdMaster':
            if ( grdAppList.row > 0 )
            {
                txtMasterPK.text = grdAppList.GetGridData( grdAppList.row, G2_PK );
            }
            else
            {
                txtMasterPK.text = '';
            }        
            data_chae00180_1.Call("SELECT");
        break;
        
        case 'grdDetail':            
            data_chae00180_2.Call("SELECT");
        break;     
        
        case 'grdEvent':
            data_chae00180_3.Call("SELECT");
        break;         
    }
}
//--------------------------------------------------------------------------------------------------

function OnProcess()
{
    //------------------------
    pro_chae00180.Call();     
}
//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {

        case "data_chae00180_1": 
                   
            //---------------------------- 
            OnSearch('grdDetail');   
        break;
        
        case "data_chae00180_2":
            //------------------------
            if ( grdDetail.rows >= 2 )
            {
  		        grdDetail.SetCellBgColor(1, G3_FROM_ORG_PK, grdDetail.rows - 1, G3_From_Position, 0xCCFFFF );
  		        grdDetail.SetCellBgColor(1, G3_TO_ORG_PK,   grdDetail.rows - 1, G3_To_Position,   0xd4d2ff );
            }
  		    //------------------------
        
            grdDetail.GetGridControl().AutoSize( 0, G3_Description, false, 0 );
 
        break; 
        
        case "pro_chae00180":
            alert(txtReturnValue.text);
            OnSearch('grdMaster');
        break;      
        
        case "datSal_security":
           if(txt_sal_security.text=='N') 
           {
                    grdDetail.GetGridControl().ColHidden(G3_Old_Salary)=1;
                    grdDetail.GetGridControl().ColHidden(G3_New_Salary)=1;
                    
                    grdEvent.GetGridControl().ColHidden(G4_Old_Salary)=1;
                    grdEvent.GetGridControl().ColHidden(G4_New_Salary)=1;
           }
        break;
        
        case "data_chae00180_2":
            //------------------------
            if ( grdDetail.rows >= 2 )
            {
  		        grdEvent.SetCellBgColor(1, G3_FROM_ORG_PK, grdDetail.rows - 1, G3_From_Position, 0xCCFFFF );
  		        grdEvent.SetCellBgColor(1, G3_TO_ORG_PK,   grdDetail.rows - 1, G3_To_Position,   0xd4d2ff );
            }     
    }
}
//-------------------------------------------------------------------------------------
function OnReport(obj)
{
    var rpt_no = obj;
    switch(rpt_no)
    {
        case 1: 
        {
            var url =System.RootURL + '/reports/ch/ae/rpt_employee_change_org.aspx?p_from=' + dtFrom.value+"&p_to="+ dtTo.value+"&p_user="+user_pk  ;
            window.open(url); 
            break;
        }
        case 2:
        {            
                    pk_list="";
                    
                    for (var i=1;i<=grdDetail.rows-1;i++)
                    {
                        if (grdDetail.GetGridData(i,0)=="-1")
                        {
                            pk_list = pk_list + grdDetail.GetGridData(i,G3_PK) + ",";
                            
                        }   
                    }
                    if (pk_list=="")
                        alert("Please choose employees to print");
                    else
                    {
                        pk_list=pk_list.substr(0,pk_list.length-1);
                        
                        var url =System.RootURL + '/reports/ch/ae/rpt_employee_transfer.aspx?p_pk=' + pk_list  ;
                        window.open(url);
                        
                    } 
                     
                    break;
         }
         case 3: 
            {
                var url =System.RootURL + '/reports/ch/ae/rpt_change_dept_position.aspx?p_tco_org=' + lstOrg2.value+"&p_position="+ lstPosition2.value+"&p_search_by="+ lstTemp2.value +
                                        "&p_txt="+ txtTemp2.text +"&p_app_status="+ lstStatus_App.value +"&p_emp_status="+ lstStatus2.value +"&p_from="+ dtFrom_App.value +
                                        "&p_to="+ dtTo_App.value +"&p_sal_rule="+ txt_sal_security.text ;
                window.open(url); 
                break;
            }
    }
}
</script>

<body>
<!-- Kiem tra quyen xem luong ---------------------------------------->
    <gw:data id="datSal_security" onreceive="OnDataReceive(this)"  > 
            <xml>
                <dso  type="process" procedure="hr.sp_pro_sal_display"  > 
                    <input>
                        <input bind="iduser_pk" />
                    </input> 
                    <output>
                        <output bind="txt_sal_security" />
                    </output>
                </dso> 
            </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chae00180" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso id="1" type="grid" user="prod" function="hr.sp_sel_chae00180" >
                <input  bind="grdAppList">
                    <input bind="lstOrgSearch2" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                </input> 
                <output bind="grdAppList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chae00180_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7" function="hr.sp_sel_chae00180_1" >
                <input>
                    <inout bind="txtMasterPK" />
                    <inout bind="txtSlipNo" />
                    <inout bind="dtDocDate" />
                    <inout bind="txtChargerPK" />
                    <inout bind="txtChargerName" />
                    <inout bind="lstStatus" />
                    <inout bind="txtDescription" />
                    <inout bind="lstOrg" />
                </input>
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_chae00180" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_chae00180" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chae00180_2" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso id="1" type="grid" user="hr" parameter="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22" function="hr.sp_sel_chae00180_2"  >
                <input  bind="grdDetail">
                    <input bind="txtMasterPK" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chae00180_3" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso id="1" type="grid" user="hr"  function="hr.sp_sel_chae00180_3"  >
                <input  bind="grdEvent">
                    <input bind="lstOrg2" />
                    <input bind="lstPosition2" />
                    <input bind="lstTemp2" />
                    <input bind="txtTemp2" />
                    <input bind="lstStatus_App" />
                    <input bind="lstStatus2" />
                    <input bind="dtFrom_App" />
                    <input bind="dtTo_App" />
                </input> 
                <output bind="grdEvent" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
   <gw:tab id="tabMain"  border=1 style="width:100%;height:100%;"  > 
   <table name="Execute" id="tblExecute" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;" valign="top"> 
    
        <tr style="height: 100%">
            <td id="left" style="width: 35%">
                <table style="width: 100%; height: 100%" name="App List">
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                            Date
                        </td>
                        <td style="width: 79%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch2" img="search" alt="Search" text="Search" onclick="OnSearch('grdAppList')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                            <a title="Click here to show Organization" onclick="OnShowPopup(lstOrgSearch2)" href="#tips" >Organization</a>
                        </td>
                        <td style="width: 79%" align="left">
                            <gw:list id="lstOrgSearch2" styles="width: 100%" onchange="OnSearch('grdAppList')" />
                        
                        </td>
                        <td style="width: 1%">
                        <gw:imgbtn id="btReport1" img="excel" alt="Report" text="Report" onclick="OnReport(1)" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <gw:grid id='grdAppList' header='_PK|Slip No|Date|Status|Org' format='0|0|4|0|0'
                                aligns='0|0|1|0|0' defaults='||||' editcol='0|0|0|0|0' widths='0|1500|1200|1200|1000'
                                sorting='T' styles='width:100%; height:100%' onclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 65%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%">
                            Slip No
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtSlipNo" styles="width: 100%" csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 10%">
                            Status
                        </td>
                        <td style="width: 25%">
                            <gw:list id="lstStatus" styles="width: 100%" />
                        </td>
                        <td align="right" style="width: 10%">
                            Date
                        </td>
                        <td style="width: 10%">
                            <gw:datebox id="dtDocDate" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 6%" align="right">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="idBtnProcess" img="2" text="Appointment Execute" styles='width:100%'
                                onclick="OnProcess()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%">
                            Charger
                        </td>
                        <td>
                            <gw:textbox id="txtChargerName" styles="width:100%" />
                            <gw:textbox id="txtChargerPK" styles="display:none" />
                        </td>
                        <td align="right">
                            Org
                        </td>
                        <td colspan="8">
                            <gw:list id="lstOrg" styles="width: 100%" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%">
                            Remark
                        </td>
                        <td colspan="10">
                            <gw:textbox id="txtDescription" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="left">
                            <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand"
                                onclick="OnToggle()" />
                        </td>
                        <td>
                        </td>
                        <td align="right">
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 2%" align="right">
                            <gw:imgbtn id="btReport2" img="excel" alt="Report Detail" text="Report Detail" onclick="OnReport(2)" />
                        </td>
                    </tr>
                    <tr style="height: 93%">
                        <td colspan="11">
                            <gw:grid id='grdDetail' header='Select|_PK|_THR_APPOINTMENT_PK|App NO|_THR_EMPLOYEE_PK|Emp ID|Emp Name|_FROM_DEPT_PK|From Org|Name|From Manager|From Position|Old Salary|_TO_DEPT_PK|To Org|Name|To Manager|To Position|New Salary|App Date|Status|Execute DT|Description'
                                format='3|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|1|4|0|4|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                defaults='||||||||||||||||||||||' editcol='1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' styles='width:100%; height:100%' acceptnulldate='T' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table name="Modify Event" id="tblEvent" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;" valign="top">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table1" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="10%" colspan=5 style="border:0;" align="right" ><a title="Click here to show organization" onclick="OnShowPopup(4)" href="#tips" >
                            <b>Organization</a>                  
                        </td>
                        <td width="22%" colspan=11 style="border:0;" align="left" >
                             <gw:list  id="lstOrg2" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                                <data>
                                    <%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where del_if=0 ORDER BY NVL(A.SEQ,9999)")%>|ALL|Select All
                                </data>
                            </gw:list>
                        </td>
                        <td width="6%" colspan=3 style="border:1;" align="right" ><b>Position</b></td>
                        <td width="20%" colspan=10 style="border:1;" align="left" >
                             <gw:list  id="lstPosition2" value='ALL' styles='width:100%' >
                               <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All
                                </data></gw:list>
                        </td>
                        <td  style="border:0"  width="10%" colspan=5 align="right" valign="middle">Search by</td>
					    <td  style="border:0" colspan=4 width="8%" >
					        <gw:list  id="lstTemp2" value="2" styles='width:100%'> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td width="10%" align=center  colspan=5 style="border:0" > 
					        <gw:textbox id="txtTemp2" onenterkey   ="OnSearch('grdEvent')" styles='width:95%'/>
				        </td>
                        <td width="2%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch3"   alt="Search"  onclick="OnSearch('grdEvent')"/>
                        </td>
                        <td colspan=2 width="4%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnReport3"    alt="Report"  onclick="OnReport(3)"/>
                        </td>
                         <td width="4%" colspan=2 style="border:0;" align="left" >
                         
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=4 style="border:0;" align="right" >App Status</td>
                        <td colspan=4 style="border:0;" align="left" >
                        <gw:list  id="lstStatus_App" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>|20|Execute|10|Saved|ALL|Select All</data></gw:list>
                        </td>
                       
                        <td colspan=3 style="border:0"  align="right"><b>Emp Status</b></td>
                        <td colspan=5 style="border:0"> 
					        <gw:list  id="lstStatus2" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                         <td colspan=7 style="border:0;" align="right" ><b>Appointment date </b></td>
                        
                        <td colspan=2 style="border:0;"  align="center" ></td>
                        <td colspan=4 style="border:0;"  align="left" > <gw:datebox id="dtFrom_App" nullaccept styles="width:60%" lang="<%=Session("Lang")%>" />
                            
                        </td>
                         <td align=right  colspan=2 style="border:0" ><b>~</b></td>
                         <td align=center  colspan=4 style="border:0" ><gw:datebox id="dtTo_App" nullaccept styles="width:60%" lang="<%=Session("Lang")%>" /></td>
                         <td align=right  colspan=3 style="border:0" ></td>
                       <td style="border:0" colspan=12 align="center" ><gw:label id="lblRecord4"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
                        
                    </tr>
                    <tr style="border:1;width:100%;height:85%" valign="top">
                        <td colspan=50  style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdEvent"  
                                header="_PK|App No|_THR_EMPLOYEE_PK|Emp ID|Full Name|_FROM_DEPT_PK|_From Org ID|From Organization|From Manager|From Position|Old Salary|_TO_DEPT_PK|_To Org ID|To Organization|To Manager|To Position|New Salary|App Date|Status|Execute DT|Description"
                                format='0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|1|4|0|4|0' 
                                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                defaults='||||||||||||||||||||' 
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                                widths='1000|1000|1000|1000|2500|1000|1000|1500|2000|1500|1500|1500|1500|1500|2000|1500|1500|1500|1000|1500|1000'
                                sorting='T' 
                                styles='width:100%; height:100%' 
                                acceptnulldate='T' />
                                
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>  
</gw:tab>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
    <gw:textbox id="txtReturnValue" styles="width: 100%;display:none" />
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txt_sal_security" styles="display:none"/>
    <!------------------------------------------->
</body>
</html>
