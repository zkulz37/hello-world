<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var binit=true;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
   iduser_pk.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>";
   user="<%=session("USER_ID")%>";
   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
    {
        datUser_info.Call();     	    
    }
    
   
}
//----------------------------------
function OnShowPopup()
{
    
    var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:240;edge:sunken;scroll:no;unadorned:yes;help:no');
    if (obj!=null)
    {
        alert("vao");
        txtUpperDept.text=obj;
        datDeptData.Call();
    }
}
//-----------------------------------------------------

function TabPopUp()
{
    
    var fpath = System.RootURL + "/form/fp/ab/PopUpGetOneItem.aspx?purchase_yn=N&item_code=" + txtItemCode.text + "&item_name=" + txtItemName.text; 	
    var aValue  = System.OpenModal(  fpath , 800 , 550 , 'resizable:no;status:yes');	
    if ( aValue != null )  
    {            
        txt_tco_item_pk.text = aValue[0] ;
        txtItemCode.text     = aValue[1];					
        txtItemName.text     = aValue[2];
    }
}
//--------------------------
function OnSearch()
{
    datItemResult.Call("SELECT");
}
//------------------------------------------------
function OnChangeDept()
{
    datGroupData.Call();
}
//-------------------------------------------------
function OnDataReceive(obj)
{
   if (obj.id=="datDeptData")
   {
        if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            lstDept_Code.SetDataText(txtDeptData.text)    ;
            
              obj=lstDept_Code.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=0;
        datGroupData.Call();
   }
   else if (obj.id=="datUser_info")
   {
        lstDept_Code.SetDataText(txtDeptData.text);
        datGroupData.Call();
   }
   else if (obj.id=="datGroupData")
   {
        obj=lstGrp_Code.GetControl();
	    if (obj.options.length ==2)
		    obj.options.selectedIndex=0;
	    else
		    obj.options.selectedIndex=obj.options.length-1;
        
        
   }
   else if (obj.id=="datItemResult")
   {
        lblRecord.text=grdItemResult.rows-1 + " rec(s)";
   }
   else if (obj.id=="datFind_Report")
   {
        var url=System.RootURL;
        url=url + '/reports/ch/gc/'+txtReport_tmp.text+'?p_tco_dept_pk=' + lstDept_Code.value + '&p_thr_group_pk=' + lstGrp_Code.value 
        + '&p_month=' + dtMonth.value + '&p_tco_item_pk=' + txt_tco_item_pk.text + '&p_itemcode=' + txtItemCode.text + '&p_itemname=' + txtItemName.text ;
        window.open(url); 
   }
}
function OnReport(obj)
{
    txtReport_tmp.text="rpt_item_result.aspx";
    datFind_Report.Call();
}
//---------------------------------------------------------------------
function SearchItem()
{
    OnSearch();           
}
//-----------------------------------------------
function OnReset()
{
    txt_tco_item_pk.text="";
    txtItemCode.text="";
    txtItemName.text="";
}
</script>
<body >

<!------------------------------------->
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                    <input bind="lstDept_Code" /> 
                </input> 
                <output>
                    <output bind="lstGrp_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->

<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstDept_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:data id="datItemResult" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_item_result"> 
            <input  bind="grdItemResult" > 
                <input bind="lstDept_Code" /> 
                <input bind="lstGrp_Code" /> 
                <input bind="dtMonth" /> 
                <input bind="txt_tco_item_pk" /> 
                <input bind="txtItemCode" /> 
                <input bind="txtItemName" /> 
            </input> 
            <output bind="grdItemResult" /> 
        </dso> 
   </xml> 
</gw:data> 
<!-------------------data control----------------------->
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
   <table  id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td width="12%" align="right" style="border:0;"><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" >Department</a>                  
                        </td>
                        <td width="15%" align="left" style="border:0;">
                         <gw:list  id="lstDept_Code" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeDept(lstDept_Code)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select pk,dept_nm from comm.tco_dept a where del_if=0 order by a.dept_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="12%" align="right" style="border:0;">Group</td>
                        <td width="15%"  align="left" style="border:0;">
                         <gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y'  order by seq, Group_NM" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  width="12%"  align="right" valign="middle" style="border:0;">Month</td>
					    <td   width="15%" style="border:0;">
					        <gw:datebox id="dtMonth"  text="" maxlen = "10" styles='width:90%' lang="<%=Session("Lang")%>" type="month"  />                  
				        </td>
				        
                        <td width="14%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>
                        <td width="5%" style="border:0" align="right">
                        <gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport()"/></td>
                    </tr>
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td  align="right" style="border:0;"><a title="Click here to show Item"  onclick="TabPopUp()" href="#tips" >Item</a></td>
                        <td  align="left" style="border:0;">
                         <gw:textbox id="txtItemCode"	styles="width:100%" onenterkey="SearchItem()" />
                        </td>
                        <td  colspan=3 align="right" style="border:0;"><gw:textbox id="txtItemName"	styles="width:100%" onenterkey="SearchItem()" /></td>
                        <td   style="border:0;" align="center" ><gw:imgBtn img="Reset" id="ibtnReset"   alt="Reset Item"  onclick="OnReset()"/></td>
                        <td  colspan=2 style="border:0;" align="right" >
                        <gw:label id="lblRecord" styles="width:100%;color:red"></gw:label></td>
                    </tr>
                    <tr style="border:1;width:100%;height:90%" valign="center" >
                       <td colspan=8  style="width:100%;height:100%;"> 
                             <gw:grid id='grdItemResult'
                                header='Group|Item Code|Item Name|Working Description|Unit Price|Quantity|Amount'
                                format='0|0|0|0|1|0|1'
                                aligns='0|0|0|0|0|1|0'
                                defaults='||||||'
                                editcol='1|0|0|0|0|0|0'
                                widths='2300|1200|3500|3675|1000|1000|1000'
                                sorting='T'
                                styles='width:100%; height:100%'
                                />
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    
</body>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txt_tco_item_pk" styles="display:none"/>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>  
<gw:textbox id="txtUpperDept" styles="display:none"/>


</html>
