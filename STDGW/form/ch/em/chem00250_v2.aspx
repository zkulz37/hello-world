<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Approval Mapping</title>
</head>
<script>
    var user;
    var v_language = "<%=Session("SESSION_LANG")%>";
    
    var c_manager_abs_pk = 0;
    var c_org_nm = 1;
    var c_wg_nm = 2;
    var c_emp_id = 3;
    var c_full_nm = 4;
    var c_app_l1 = 5;
    var c_app_l2 = 6;
    var c_app_l3 = 7;
    var c_remark = 8;
    var c_app_l1_pk = 9;
    var c_app_l2_pk = 10;
    var c_app_l3_pk = 11;
    var c_emp_pk = 12;

    var p_level = 0;

function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    //lstWeek.SetEnable(0);
   
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user= "<%=session("USER_ID")%>";
    
    idID_Manager_l1.SetEnable(false);
    idID_Manager_l2.SetEnable(false);
    idID_Manager_l3.SetEnable(false);

    idName_Manager_l1.SetEnable(false);
    idName_Manager_l2.SetEnable(false);
    idName_Manager_l3.SetEnable(false);

    idGrid.GetGridControl().ScrollTrack=true;

    
}

//-------------------------------------------------
function OnDataReceive(obj)
{
    
    var obj_lst;
       if (obj.id=="datApprover_mapping")
       {
           idRecord.text = idGrid.rows - 1 + " (s).";
           auto_resize_column(idGrid, 0, idGrid.cols - 1, 0)
       }
       
}   
    
//-------------------------------------------------
function OnShowPopup(n)
{
    var irow;
    switch(n)
    {
        case 1:
            var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
            var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:270;edge:sunken;scroll:no;unadorned:yes;help:no');
            if (obj!=null)
            {
                lstOrg.value=obj
            }
            break;

        case 2:
            var fpath = System.RootURL + "/form/ch/em/chem00250_v2_01.aspx?p_level="+1;
            var aValue = System.OpenModal(fpath, 900, 600, 'resizable:yes;status:yes');
            if ((aValue != null) && (aValue[0] != "")) {
                txtManager1_pk.text = aValue[0];
                idID_Manager_l1.text = aValue[3];
                idName_Manager_l1.text = aValue[5];
            }
            break;

        case 3:
            var fpath = System.RootURL + "/form/ch/em/chem00250_v2_01.aspx?p_level="+2;
            var aValue = System.OpenModal(fpath, 900, 600, 'resizable:yes;status:yes');
            if ((aValue != null) && (aValue[0] != "")) {
                txtManager2_pk.text = aValue[0];
                idID_Manager_l2.text = aValue[3];
                idName_Manager_l2.text = aValue[5];
            }
            break;
        case 4:
            if (idGrid.col == c_app_l1 ) {
                p_level= 1;
                irow = idGrid.row;
            }
            else if ( idGrid.col == c_app_l2)
            {
                p_level=2 ;
                irow = idGrid.row;
            }
            else if ( idGrid.col == c_app_l3)
            {
                p_level=3 ;
                irow = idGrid.row;
            }
            
            else 
            {            
                return;
            }

            var fpath = System.RootURL + "/form/ch/em/chem00250_v2_01.aspx?p_level="+p_level;
            var aValue = System.OpenModal(fpath, 900, 600, 'resizable:yes;status:yes');
            if ((aValue != null) && (aValue[0] != "")) {
                if (idGrid.col == c_app_l1) //manager l1
                {
                    idGrid.SetGridText(irow, c_app_l1, aValue[3] + "-" + aValue[5]);
                    idGrid.SetGridText(irow, c_app_l1_pk, aValue[0]);
                }
                else if (idGrid.col == c_app_l2) //manager l2
                {
                    idGrid.SetGridText(irow, c_app_l2, aValue[3] + "-" + aValue[5]);
                    idGrid.SetGridText(irow, c_app_l2_pk, aValue[0]);
                }
                else if (idGrid.col == c_app_l3) //manager l2
                {
                    idGrid.SetGridText(irow, c_app_l3, aValue[3] + "-" + aValue[5]);
                    idGrid.SetGridText(irow, c_app_l3_pk, aValue[0]);
                }
            }
            
            break;
        case 5:
            var fpath = System.RootURL + "/form/ch/em/chem00250_v2_01.aspx?p_level="+3;
            var aValue = System.OpenModal(fpath, 900, 600, 'resizable:yes;status:yes');
            if ((aValue != null) && (aValue[0] != "")) {
                txtManager3_pk.text = aValue[0];
                idID_Manager_l3.text = aValue[3];
                idName_Manager_l3.text = aValue[5];
            }
            break;                
    }
}

//------------------------------------------------------------  
function OnSearch(obj)
{
    obj.Call("SELECT");
}

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

function OnchangeMealType()
{
    datChangeMealType.Call();
}

function OnSetData(obj_grid, obj_n)
{
    var val_pk, val_name, col, col_nm;
    var ctrl;


    if (obj_n == "1") {
        val_pk = txtManager1_pk.text;
        val_name = idID_Manager_l1.text + "-" + idName_Manager_l1.text;
        col = c_app_l1_pk;
        col_nm = c_app_l1;
    }
    else if (obj_n == "2")
    {
        val_pk = txtManager2_pk.text;
        val_name = idID_Manager_l2.text + "-" + idName_Manager_l2.text;
        col = c_app_l2_pk;
        col_nm = c_app_l2;
    }
    else if (obj_n == "3")
    {
        val_pk = txtManager3_pk.text;
        val_name = idID_Manager_l3.text + "-" + idName_Manager_l3.text;
        col = c_app_l3_pk;
        col_nm = c_app_l3;
    }

    ctrl = obj_grid.GetGridControl();

    if (ctrl.SelectedRows > 0) {
        for (var i = 0 ; i < ctrl.SelectedRows ; i++) {
            var row = ctrl.SelectedRow(i);
            if (row > 0) {
                obj_grid.SetGridText(row, col, val_pk);
                obj_grid.SetGridText(row, col_nm, val_name);
            }
        }
    }
}
    //-------------------------------------------------------------------------------------------
function OnSave(obj) {
    datApprover_mapping.Call();
}
//-------------------------------------------------------------------------------------------
function OnDelete(obj) {
    if (confirm("Delete it?\nBạn muốn xóa?")) {
        obj.DeleteRow();
        datApprover_mapping.Call();
    }
}
</script>
<body>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datApprover_mapping" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="hr_sel_chem00250_v2" procedure="hr_upd_chem00250_v2" > 
                <input bind="idGrid"> 
                    <input bind="lstOrg" /> 
                    <input bind="lstWGroup" /> 
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    
                </input> 
                <output bind="idGrid"/>
            </dso> 
        </xml> 
</gw:data>

<!--------------------main table----------------------------------->


    <table name="Detail" id="Meal_check" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
     <tr style="width:100%;height:100%" valign="top">
        <td>
            <table width="100%" style="height:10%" border="0" cellspacing="1" cellpadding="1">
                <tr style="width:100%;height:0%" valign="top">
					    <td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td>
					    <td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td>
					    <td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td>
					    <td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td>
					    <td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td><td width = "2%"></td>
				</tr>
                <tr >
                    <td colspan=5 align=right style="width:10%;border:0" ><a title="Click here to show organization" onclick="OnShowPopup(1)" href="#tips" >Organization</a></td>
		            <td colspan=14 align=right style="width:30%;border:0"><gw:list  id="lstOrg" value="ALL"  maxlen = "100" styles='width:100%' onchange="" >
                        <data>
                            <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                        </data>
                        </gw:list>
                    </td>
                    <td colspan=4 align=right style="width:8%;border:0">Work Group</td>
		            <td colspan=9 align=right style="width:18%;border:0"><gw:list  id="lstWGroup" value="ALL"  maxlen = "100" styles='width:100%' >
                                <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM thr_work_group WHERE DEL_IF = 0 order by workgroup_nm")%>|ALL|Select All</data></gw:list>
                    </td>
                    <td colspan=5 align=right style="width:8%;border:0">Search by</td>
		            <td colspan=4 align=left style="width:8%;border:0"><gw:list  id="idSearch" value="1" styles="width:95%" onChange="">
                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		            <td colspan=5 align=left style="width:10%;border:0"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:90%" onenterkey="OnSearch(datApprover_mapping)" /></td>
		            
                    <td colspan=2 align=right style="width:8%;border:0"><gw:icon id="ibtnSearch" alt="Search" img="in" text="Search" onclick="OnSearch(datApprover_mapping)" /></td>
                    <td colspan=2 align=center style="width:8%;border:0"><gw:icon id="ibtnSave" alt="Save" img="in" text="Save" onclick="OnSave(idGrid)" /></td>
                    <td colspan=2 align=center style="width:8%;border:0"><gw:icon id="ibtnDelete" alt="Delete" img="in" text="Delete" onclick="OnDelete(idGrid)" /></td>
                    
                </tr>
                <tr >
                    <td colspan=5 style="border:0;" align="right" ><a title="Click here to show Approver Level 1" onclick="OnShowPopup(2)" href="#tips" >M L1</a></td>
                    <td colspan=3 style="border:0;" align="left" ><gw:textbox id="idID_Manager_l1" maxlen = "20" styles="width:99%" onenterkey="" /></td>
                    <td colspan=8 style="border:0;" align="left" ><gw:textbox id="idName_Manager_l1" maxlen = "50" styles="width:100%" onenterkey="" /></td>
                    <td colspan=1 style="border:0;" align="left" ><gw:icon id="ibtnSetL1" alt="Set Data" img="in" text="Set" onclick="OnSetData(idGrid,1)" /></td>
                    <td colspan=3 style="width:8%" align="right"><a title="Click here to show Approver Level 2" onclick="OnShowPopup(3)" href="#tips" >M L2</a></td>
                    <td colspan=3 align=right ><gw:textbox id="idID_Manager_l2" maxlen = "20" styles="width:99%" onenterkey="" /></td>
		            <td colspan=8 align=right ><gw:textbox id="idName_Manager_l2"  maxlen = "10" styles='width:100%' /></td>
                    <td colspan=1 style="border:0;" align="right" ><gw:icon id="ibtnSetL2" alt="Set Data" img="in" text="Set" onclick="OnSetData(idGrid,2)" /></td>

                    <td colspan=3 style="width:8%" align="right"><a title="Click here to show Approver Level 2" onclick="OnShowPopup(5)" href="#tips" >M L3</a></td>
                    <td colspan=3 align=right ><gw:textbox id="idID_Manager_l3" maxlen = "20" styles="width:99%" onenterkey="" /></td>
		            <td colspan=8 align=right ><gw:textbox id="idName_Manager_l3"  maxlen = "10" styles='width:100%' /></td>
                    <td colspan=1 style="border:0;" align="right" ><gw:icon id="ibtnSetL3" alt="Set Data" img="in" text="Set" onclick="OnSetData(idGrid,3)" /></td>

		            <td colspan=3 align=center ><gw:label id="idRecord" text="0 (s)" styles="width:100%;color:red" ></gw:label></td>
                    
              </tr>

            </table>
            <table cellspacing=0 cellpadding=0 style="height:90%" width=100% border="1">
                    <tr style="border:1;height:100%" valign="top">
                        <td  style="width:100%"> 
                            <gw:grid   
	                            id="idGrid"  
	                            header="_Manager_abs_pk|Organization|Work Group|Employee ID|Full Name|Approver Level 1|Approver Level 2|Approver Level 3|Remark|_Approver_l1_pk|_Approver_l2_pk|_Approver_l3_pk|_emp_pk"   
	                            format="0|0|0|0|0|0|0|0|0|0|0"  
	                            aligns="0|0|0|0|0|0|0|0|1|1|1"  
	                            defaults="|||||||||||"  
	                            editcol="0|0|0|0|0|0|1|1|1|1|0"  
	                            widths="0|2000|1500|1500|2500|3000|3000|2500|0|0|0"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
                                onafteredit=""
                                oncelldblclick="OnShowPopup(4)"
	                            /> 
                        </td>
                        
                    </tr>
               </table> 
        </td>
     </tr>
    </table>  

</body>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDept" styles="display:none"/>	
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtManager1_pk" styles="display:none"/>
    <gw:textbox id="txtManager2_pk" styles="display:none"/>
    <gw:textbox id="txtManager3_pk" styles="display:none"/>
    
   
</html>
