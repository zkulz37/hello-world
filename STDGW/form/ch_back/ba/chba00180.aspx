<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var c_adjusted_month=3;
var c_wt=9;
var c_ale=10;
var c_regime=11;
var c_ot=12;
var c_nt=13;
var c_nt2=14;
var c_ht=15;
var c_oht=16;
var c_exp=17;
var c_dil=18;
var c_remark=19;
var c_adj_wt=20;
var c_adj_ot=21;
var c_adj_amt=22;
var c_by_hand=23;
var bSal_Security;
function BodyInit()
{
    
    grdAdd.GetGridControl().ScrollTrack=true;
    grdAdd.GetGridControl().FrozenCols =8;
    var tmp="#Y;Yes|#N;No";
    grdAdd.SetComboFormat(c_by_hand,tmp);
    
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    
    CheckSecurity()
    
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        datUser_info.Call();     	    
    
}
//------------------------------
function CheckSecurity()
{
    bSal_Security="<%=ESysLib.SetDataSQL("SELECT 1 FROM THR_SAL_SECURITY WHERE DEL_IF=0 AND USER_PK=" & session("USER_PK"))%>";
    if (bSal_Security==0) //co quyen xem luong 
    {
        lstSet_Type.SetDataText("|-1|Set Time...|0|Adjusted Month|1|WT|2|ALE|3|Gegime|4|OT|5|NT|6|NT2|7|HT|8|OHT|9|Experience|10|Diligent|11|Remark");
        grdAdd.GetGridControl().ColHidden(c_adj_wt)=true;
        grdAdd.GetGridControl().ColHidden(c_adj_ot)=true;
        grdAdd.GetGridControl().ColHidden(c_adj_amt)=true;
        grdAdd.GetGridControl().ColHidden(c_by_hand)=true;
    }
}
//---------------------------------------------------
function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:200;dialogTop:200;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
             lstOrg.value=obj;
        }
}
//------------------------------------------------------------------------------------
function OnChangeDept()
{
    //txtDept.text=lstOrg.value;
    datGroupData.Call();
}
//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    if (obj.id=="datUser_info")
            datGroupData.Call();
    else if (obj.id=="datAddition_Att")
   {
        lblRecord.text=grdAdd.rows-1 + " records."
   }
}     
//------------------------------------------------------------------------------------
function OnSearch()
{
    if (dtMonth.value=="")
    {
        alert("Please input Month to search!");
        return;
    }
    datAddition_Att.Call("SELECT");  
}
//------------------------------------------------------------------------------------
function OnUpdate()
{
    if (grdAdd.rows>1)
        if(confirm("Do you want to save?\nBạn đã chắc chắn save?") )
            datAddition_Att.Call();
}
//------------------------------------------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}


//--------------------
function OnReport()
{
    var url =System.RootURL + '/reports/ch/ba/rpt_addition_att.aspx?P_ADD_WORK_MON='+dtMonth.value+'&P_NATION='+lstNation.value+'&P_WG='+lstWG.value+'&P_SECTION_TYPE='+lstSection_Type.value+'&P_SEARCH='+lstSearch.value+'&P_INPUT='+txtTmp.text+'&P_TCO_ORG_PK='+lstOrg.value + '&p_sal_secur=' + bSal_Security;
    window.open(url);
}

function OnDelete()
{
    if (grdAdd.rows>1)
        if(confirm("Do you want to save?\nBạn đã chắc chắn save?"))
            grdAdd.DeleteRow();
    
}
//--------------------
function OnSetGrid()
{
    var tmp;
    if (lstSet_Type.value==0)
        tmp=dtAdj_Month.text;
    else if (lstSet_Type.value==15)
        tmp=lstYN.value;    
    else
        tmp=txtHH_Time.text;
    
    var ctrl = grdAdd.GetGridControl();
	for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
	{
		var row = ctrl.SelectedRow(i);
		if ( row > 0 )
		{		
		    var icol;
		    if (lstSet_Type.value==0)
		        icol=c_adjusted_month;
		    else
		        icol=Number(lstSet_Type.value) + c_wt - 1 ;
			grdAdd.SetGridText(row,icol,tmp);
		}	
	}
}
//------------------------
function OnChange_List()
{
    var iobj=lstSet_Type.value;
    if (iobj==0)
        lblHH.text="Month";
    else if (iobj>=1 && iobj <=3)
        lblHH.text="Day";
    else if (iobj>=4 && iobj <=8)    
        lblHH.text="Hour";
    else if ((iobj>=9 && iobj <=10)|| (iobj>=12 && iobj<=14 ))
        lblHH.text="Amount";  
    else
        lblHH.text="";  
    if (iobj==0)
    {
          dtAdj_Month.style.display="";
          txtHH_Time.style.display="none";
          lstYN.style.display="none";
    }
    else if (iobj==15)
    {
          lstYN.style.display="";
          dtAdj_Month.style.display="none";
          txtHH_Time.style.display="none";
    }  
    else
    {
          lstYN.style.display="none";
          dtAdj_Month.style.display="none";
          txtHH_Time.style.display="";
    }      
}
	
	
</script>

<body>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datAddition_Att" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23" function="HR.SP_SEL_addition_att" procedure="HR.SP_upd_addition_att"> 
                <input bind="grdAdd" >
                    <input bind="lstOrg" />
                    <input bind="lstWG" />
                    <input bind="dtMonth" />
                    <input bind="lstSearch" />
                    <input bind="txtTmp" />
                    <input bind="lstNation" />
                    <input bind="lstSection_Type" />
                    <input bind="lstExist" />
                    
                </input>
                <output  bind="grdAdd" />
            </dso> 
        </xml> 
</gw:data>



<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<table style="width:100%;height:10%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	<tr style="height:5%;border:1">	
		<td  align=right style="width:10%;border:0" >Work Month</td>
		<td  align=center style="width:10%;border:0"><gw:datebox id="dtMonth"  maxlen = "10" text="" styles='width:50%'lang="<%=Session("Lang")%>" nullaccept type="month" /></td>
		
		<td  align=right style="width:10%;border:0" ><a title="Click here to show organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
		<td  align=right style="width:14%;border:0"><gw:list  id="lstOrg"  value="ALL" styles='width:100%' onchange="" >
                <data>
                    <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 ORDER BY NVL(A.SEQ,9999)")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
		<td  align=right style="width:10%;border:0">Work Group</td>
		<td  align=right style="width:12%;border:0"><gw:list  id="lstWG"  value="ALL" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a where a.del_if=0 ORDER BY NVL(A.SEQ,9999)")%>|ALL|Select All</data></gw:list>
        </td>
        <td  align=right style="width:6%;border:0">Search</td>
		<td align=right style="width:6%;border:0"><gw:list  id="lstSearch" value="1" styles='width:100%' onChange="">
                <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list>
        </td>
        <td  align=right style="width:10%;border:0"><gw:textbox id="txtTmp" maxlen = "50" styles="width:100%" onenterkey="OnSearch()" /></td>       
        <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnDel" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		<td  align=right style="width:3%;border:0" ><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>
    </tr>	
    <tr style="height:5%;border:1">	
		<td  align=right style="border:0" >Nation</td>
		 <td  style="border:0;" align="left" >
         <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' and code in('01','02') order by code" )%>|ALL|Select All</data></gw:list>
        </td>
        <td align=right  style="border:0;" >Section Type</td>
        <td  style="border:0;" ><gw:list  id="lstSection_Type" value='ALL' maxlen = "100" styles='width:100%'>
            <data>
                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0154' order by code_nm")%>|ALL|Select All
            </data>
            </gw:list></td>
		<td align=right  style="border:0;" >Have Data</td>
		<td style="border:0;"><gw:list  id="lstExist" value='ALL' maxlen = "100" styles='width:100%'>
            <data>|1|Exist|2|Not Exist|ALL|Select All</data>
            </gw:list></td>
		<td colspan=1 align=right style="border:0"><gw:list id="lstSet_Type"  styles="width:98%" value="-1" onchange="OnChange_List()"><data>|-1|Set Time...|0|Adjusted Month|1|WT|2|ALE|3|Gegime|4|OT|5|NT|6|NT2|7|HT|8|OHT|9|Experience|10|Diligent|11|Remark|12|Adjusted WT|13|Adjusted OT|14|Adjusted Amt|15|By Hand</data></gw:list ></td>
		<td align=right style="border:0"><gw:label id="lblHH" styles="width:100%"></gw:label></td>
		<td align=right style="border:0"><gw:textbox id="txtHH_Time" maxlen = "5" styles="width:100%" onenterkey="OnSetGrid()" />
		                                <gw:datebox id="dtAdj_Month"  maxlen = "10" text="" style='display:none' lang="<%=Session("Lang")%>" type="month" />
		                                <gw:list id="lstYN"  styles="width:98%" style='display:none' value="Y"><data>|Y|Yes|N|No</data></gw:list ></td>
		<td align=center style="border:0"><gw:imgBtn img="set" id="ibtnSet"   alt="Set Grid"  onclick="OnSetGrid()"/></td>
        <td colspan=3 align=right style="border:0"><gw:label id="lblRecord"  text="" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
    </tr>
	</table>
	<table id="tbl" style="width:100%;height:85%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid id='grdAdd'
                header='_Emp_PK|_PK|_WORK_MON|Adjusted Month|Organization|Work Group|Emp ID|Full Name|Join Date|WT|ALE Abs|Regime Abs|OT|NT|NT2|HT|OHT|Experience|Diligent|Remark|Ajusted WT|Ajusted OT|Ajusted Amt|By Hand'
                format='0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|0|1|1|1|2'
                aligns='0|0|0|1|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                check='|||||||||||||||||||||||'
                editcol='1|1|1|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                widths='1000|1000|1200|1400|1300|1200|1000|2200|1200|800|1000|1000|1000|800|800|800|1000|1200|1000|1000|1200|1200|1200|1000'
                sorting='T'
                styles='width:100%; height:100%'
                />
			</td>
		</tr>	
	</table>
</table>

	<gw:textbox id="txtResult" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
	
</body>
</html>

