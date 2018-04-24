<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub
</script>
<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<script>
    var v_language = "<%=Session("SESSION_LANG")%>";
    var emp_pk_list;
    var check_init = 0;
    var flag_tab = 1;
    var rpt_no = 0;


    function BodyInit() {
        System.Translate(document);
        txtOrg_tmp_pk.text = "<%=Session("COMPANY_PK")%>";
        //btnSearch2.disabled = true;

    if (v_language != "ENG")
        System.Translate(document);



    /* su dung tren employee info
	*/
    txt_popup_yn.text = "<%=request.QueryString("p_popup_yn")%>";
    txt_popup_emppk.text = "<%=request.QueryString("p_emp_pk")%>";
    if (txt_popup_yn.text == 'y' && txt_popup_emppk.text != '') {
        idLeftDiv.style.display = "none";
        imgArrow.style.display = "none";
        //imgArrow.status = "collapse";
        //imgArrow.src = "../../../system/images/next_orange.gif";
    }
    /* end su dung tren employee info
	*/
    iduser_pk.text = "<%=session("USER_PK")%>";
	txtHr_level.text = "<%=session("HR_LEVEL")%>";


    //ChangeColorItem(lstOrg.GetControl());
        menu_id.text = System.Menu.GetMenuID();
        idGrid.GetGridControl().ScrollTrack = true;

        idRealation.GetGridControl().ScrollTrack = true;

        idRealation.GetGridControl().FrozenCols = 4;
        <%=ESysLib.SetGridColumnComboFormat("idRealation", 2, "select code,CODE_NM from vhr_hr_code where id='HR0024' order by code_nm")%>
        <%=ESysLib.SetGridColumnComboFormat("idGrid", 4, "select code,code_nm from vhr_hr_code where id='HR0009' order by code_nm ")%>;
        <%=ESysLib.SetGridColumnComboFormat("idGrid", 3, "select code,code_nm from vhr_hr_code where id='HR0007' order by code_nm ")%>;
        <%=ESysLib.SetGridColumnComboFormat("idGrid", 8, "select a.pk,a.org_nm from tes_tco_org a where a.del_if = 0")%>;
        <%=ESysLib.SetGridColumnComboFormat("idGrid", 9, "select a.pk,a.workgroup_nm from tes_thr_work_group a where a.del_if=0  order by a.workgroup_nm")%>;


}

//-----------------------------------------------

function ChangeColorItem(lstctl) {
    var slevel1, slevel2, slevel3, slevel4;
    for (var i = 0; i < lstctl.options.length; i++) {
        slevel1 = lstctl.options.item(i).text.substr(0, 1);
        slevel2 = lstctl.options.item(i).text.substr(0, 3);
        slevel3 = lstctl.options.item(i).text.substr(0, 5);
        slevel4 = lstctl.options.item(i).text.substr(0, 7);
        if (slevel4 != ".......") {
            if (slevel3 == ".....") {
                lstctl.options.item(i).style.color = "0066CC";
            }
            else {
                if (slevel2 == "...") {
                    lstctl.options.item(i).style.color = "FF4500";
                }
                else {
                    if (slevel1 == ".")
                        lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                }
            }
        }
    }
}

//-------------------------------

function OnDataReceive(obj) {

    if (obj.id == "datCheck_View") {
        if (txtFlag_View.text == 'Y') {
            idBtnNew.style.display = "none";
            idBtnSave.style.display = "none";
            idBtnDelete.style.display = "none";
        }

    }
    else if (obj.id == "query_Employee")
    {

        lblRecord2.text = idGrid.rows - 1 + " record(s).";
    }

    else if (obj.id == "find_Relation") {

        //alert(idGrid.rows-1);
        //if (idRealation.rows < 2) {
        //    alert('Người thân chưa có !! \n Vui lòng nhập mới ');
        //}
    }
    else if (obj.id == "datWorkGroup_info") {
       
        lstWGrp_Code.SetDataText(txtwg_tmp.text + "|ALL|Select All");
        lstWGrp_Code.value = "ALL";
        check_init = 1;
    }    
}
//------------------------------------------------
function OnChangeOrg() {
    txtOrg.text = lstOrg.value;


}
//----------------------------------------------------
function ChoseList_box(obj_list, value) {
    obj_list.SetDataText(value);
    obj = obj_list.GetControl()
    if (obj.options.length == 2)
        obj.options.selectedIndex = 0;
    else
        obj.options.selectedIndex = obj.options.length - 1;
}
//----------------------------------
//function OnShowPopup() {
//    var strcom;
//    var fpath = System.RootURL + "/form/ch/ae/chae00782_org.aspx?";
//    var obj = window.showModalDialog(fpath, this, 'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:' + window.event.screenX + ';dialogTop:' + window.event.screenX + ';edge:sunken;scroll:yes;unadorned:yes;help:no');
//    if (obj != null) {
//        lstOganization.value = obj;
//        onChange_org(1, lstOganization)
//        //txtorg_tmp.text = lstOganization.value;
//        //datWorkGroup_info.Call();

//    }
    //}



function onChange_org(tab, obj) {
    flag_tab = tab;
    txtorg_tmp.text = obj.value;

    alert(txtorg_tmp.text);
    datWorkGroup_info.Call();

}
//-----------------------------------------------
function OnToggle() {
    if (imgArrow.status == "expand") {
        idLeftDiv.style.display = "none";
        imgArrow.status = "collapse";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else {
        idLeftDiv.style.display = "";
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }

}
//------------------------------------------------
function OnSearch(obj) {
       
    //btnSearch2.disabled = false;
    switch (obj) {
        case 1:
            {
                query_Employee.Call("SELECT");
                idRealation.ClearData();
                break;
            }

        case 3:
            {
                if (check_init == 1) {
                    var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx";
                    var obj = System.OpenModal(fpath, 900, 600, 'resizable:yes;status:yes;');
                    if (obj != null) {
                        txtEmp_PK.text = obj[0];

                        datEmployee.Call("SELECT");
                    }
                }
                break;

            }
    }
    
}

function btnSearch_2() {
   

        if (idGrid.rows - 1 > 0) {
           
              //  ibtnAdd.SetEnable(true);
            txtEmpPK.text = idGrid.GetGridData(idGrid.row, 0);
            find_Relation.Call("SELECT");
            
        }
 
}

function OnAdd(obj) {
 
    
    

    switch (obj) {


        case 1:
            {
                alert('Nhập mới NV');
                var ctrl = idGrid.GetGridControl();
                idGrid.AddRow();
                ctrl.TopRow = ctrl.rows;
                break;
            }

        case 2:
            {
                var irow = idGrid.row;
                var emp_id = idGrid.GetGridData(irow, 1);
                var pk = idGrid.GetGridData(irow, 0);

                idRealation.AddRow();
                irow = idRealation.rows - 1;
                idRealation.SetGridText(irow, 1, emp_id);
                idRealation.SetGridText(irow, 7, pk);
                break;
            }
    }
        
}

function OnSave(obj) {
  


    
    switch (obj) {

       

        case 1:
            {
                // lay value text empid 
                //txtEmpTemp.text = idGrid.GetGridData(idGrid.row, 1);               
                query_Employee.Call();                                    
                break;
            }
        case 2:
            {
                find_Relation.Call();                
                break;
            }
    }

}

function OnDel(obj) {


    switch (obj) {
        case 1:
            {
                if (confirm("Do you want to delete?\nBạn đã chắc chắn xóa?"))
                    idGrid.DeleteRow();
                break;

            }
        case 2:
            {
                if (confirm("Do you want to delete?\nBạn đã chắc chắn xóa?"))
                    idRealation.DeleteRow();
                break;
            }

    }
}

   
</script>

<body >




    <gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="sp_pro_check_view"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
                </output>
            </dso> 
        </xml> 
</gw:data>
    
<gw:data id="query_Employee" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6,7,8,9" function="HR_SEL_CHAE00782_EMPLOYEE" procedure="HR_UPD_CHAE00782_EMPLOYEE"> 
                <input bind="idGrid" >
                   <input bind="lstOganization" /> 				   
                   <input bind="lstWGrp_Code" /> 
                   <input bind="lstNation2" /> 
                   <input bind="chkTemp" />
                   <input bind="txtEmpId2" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>



<gw:data id="find_Relation" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6,7" function="HR_SEL_CHAE00782_RELATION" procedure="HR_UPD_CHAE00782_RELATION"> 
                <input bind="idRealation" >
                   <input bind="txtEmpPK" /> 				  
                </input>
                <output  bind="idRealation" />
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_CHAE00782_sel_wg_role"  > 
                <input>
                    <input bind="txtorg_tmp" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>


    
<%--<gw:tab id="tabFamily"  border=1 style="width:100%;height:120%" onpageactivate="" onclick ="">
 
<form name ="Family" id="form2">--%>
<table id="family" border="1" width="100%" height="100%" cellpadding="0" cellspacing="0" >
<tr>
<td id="idLeftDiv" valign="top" width="30%" height="100%">
<table  cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td >
               <table width="100%" id="tblexp" style="height:100%" border=0 cellpadding="0" cellspacing="0">
					<tr width="100%">
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					</tr>	
                    
                    <tr>
                           <td colspan=100 style="width:100%;height:30%">
                           <table border="0">

                               <tr>
                                   <td colspan ="100" align="center" style="color:red;font:bolder"><h3>Employee Information</h3></td> 
                               </tr> 

                               <tr>                                  
                                   <td style="border:0" align ="right" colspan="20"><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips">Oganization</td>
                                   <td style="border:0" colspan="40">
                                       <gw:list id="lstOganization" value ="2" styles="color:blue;width:100" onchange="" maxlen="100">
                                           <datalist>
                                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tes_tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                           </datalist>

                                       </gw:list>
                                   </td>                                  
                                </tr>
                                   

                               <tr>
                                   <td colspan="20" align="right" style="border:0">Work Group</td>
                                   <td colspan="40" align="left" style="border:0">
                                        <gw:list  id="lstWGrp_Code" value='ALL' maxlen = "100" styles="color:blue;width:100" >
				                           <data><%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from tes_thr_work_group a where a.del_if=0  order by a.workgroup_nm")%>|ALL|Select All</data>
			                            </gw:list>
                                   </td>
                                </tr>
                               <tr>
                                   <td colspan="20" align="right" style="border:0">Nation</td>
                                   <td colspan="40"style="border:0">
                                       <gw:list id="lstNation2" value="ALL" maxlen="100" styles="color:blue;width:100">
                                           <data><%=ESysLib.SetListDataSQL("select a.CODE,a.CODE_NM from vhr_hr_code a where a.id = 'HR0009' ORDER BY a.CODE")%>|ALL|Select All</data>
                                       </gw:list>
                                   </td>
                               </tr>

                               <tr>
                                   <td style="border:0" align="right" colspan=20>Search by</td>
		                            <td colspan=40 style="border:0" maxlen="100">									
			                            <gw:list  id="chkTemp" value="2"  styles="color:blue;width:100%" onchange=""> 
					                        <data> LIST|1|Full Name|2|Emp ID</data> 
			                            </gw:list>
		                             </td>
		                            <td colspan=60 maxlen="100" style="border:0"><gw:textbox id="txtEmpID2" styles="color:blue;width:100%" value="" onenterkey ="OnSearch(1)"  /></td>
		                            
                                </tr>
                               <tr>
                                   <td colspan="90"></td>
                                   <td colspan="90"></td>
                                   <td colspan=4 style="border:0" align="right"><gw:imgBtn id="ibtnSearch"  alt="Search"  img="search" text="Search"  onclick="OnSearch(1)" /></td> 
                                  <%-- <td colspan=3 style="border:0" align="right" ><gw:imgBtn id="ibtnAddEmp" alt="Add" img="New" text="Search" onclick="OnAdd(1)" /></td>--%> 
                                   <td colspan="4" align="right" ><gw:imgBtn id="ibtnSaveEmp" alt="Save" img="Save" text="Save" onclick="OnSave(1)" /></td>
                                   <td colspan="2" align="right" ><gw:imgBtn id="ibtnDelete" alt="Delete" img="Delete" text="Delete" onclick="OnDel(1)" /></td>
                               </tr>
                               <tr>
                                   <td colspan="90" align="center"><gw:label id="lblRecord2"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                                   <td colspan="90"></td>
                                   <td colspan="4"></td>
                                   <td colspan="3"></td>
                                   <td colspan="2" align="right" ><gw:imgBtn id="ibtnReportSummary" alt="Report" img="Excel" text="Report" onclick="OnReport(1)" /></td>
                                   <td colspan="1" align="right" ><gw:imgBtn id="ibtnReportDetail" alt="Report" img="Excel" text="Report" onclick="OnReport(2)" /></td>
                               </tr>
                            </table>
                            </td>
                    </tr>

                    <tr>                    
		                <td colspan=100 style="width:100%;height:65%">
		               <table border=1 width=100% style="height:100%" cellspacing=0 border=0>
		                    <tr>
		                        <td colspan=100">
		                            <gw:grid
                                        id="idGrid"
                                        header="_PK|EMP_ID|FULL_NAME|SEX|NATION|TEL|JOIN_DT|BIRTH_DT|Oganization|WorkGroup"
                                        format="0|0|0|0|0|0|4|4|0|0"
                                        aligns="1|1|1|1|1|1|1|1|1|1"
                                        defaults="|||||||||"
                                        editcol="1|0|1|1|1|1|0|1|1|1"
                                        widths="1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"
                                        styles="width:100%;height:100%"
                                        sorting="T"
                                        onafteredit=""
                                        oncellclick=""
                                        acceptnulldate="T"
                                        onclick = "btnSearch_2()" />
                                    </td>
		                    </tr>
		               </table>
		            </td>
		        </tr>
                <tr>
                    <td colspan=100 style="width:100%;height:10%">
                        <%--<table border=0 width=100% style="height:100%" cellspacing=0 border=0>
                            <button id="btnSearch2" type="button" onclick="btnSearch_2()">Family Information</button>
                            </table>--%>
                    </td>
                </tr>
                </table>                                   
                </td>      
            </tr>         
    </table>
    </td>
    
    <td  id="idRightDiv" align="top" height="100%" colspan="100">
        
        <table border="1" width="100%" style="height: 100%" cellspacing="0" border="0" >   
            <tr width="100%" style ="height:0%">
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					</tr>	      
            

            <tr width="100%" style="height: 5%" cellspacing="0" border="0">
                
                <td colspan ="90" align="center" style="color:red;font:bolder"><h3>Family Information</h3></td> 
                <td colspan="5" align="right" ><gw:imgBtn id="ibtnAdd" alt="Add" img="New" text="Search" onclick="OnAdd(2)" /></td>
                <td colspan="3" align="right" ><gw:imgBtn id="ibtnSave" alt="Save" img="Save" text="Save" onclick="OnSave(2)" /></td>
                <td colspan="2" align="right" ><gw:imgBtn id="ibtnDelete" alt="Delete" img="Delete" text="Delete" onclick="OnDel(2)" /></td>
                
            </tr>
            <tr>
                
                

                <td colspan="100">
		                            <gw:grid
                                        id="idRealation"
                                        header="_PK|EMP_ID|TYPE|FULLNAME|JOB|BIRTHDAY|ADRESS|_EMP_PK"
                                        format="0|0|1|1|0|4|0|0"
                                        aligns="1|1|1|1|1|1|1|1"
                                        defaults="||||||||"
                                        editcol="0|0|1|1|1|1|1|0"
                                        widths="1500|1500|1500|1500|1500|1500|1500|1500"
                                        styles="width:100%;height:100%"
                                        sorting="T"
                                        onafteredit=""
                                        oncellclick=""
                                        acceptnulldate="T"
                                        oncelldblclick="" />
                                    </td>
            </tr>

        </table>
    </td>
    </tr>
    </table>
   <%--     </form>
    </gw:tab>--%>

    <!-------------------- -->
    

<!--------------------------------- -->

<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor:hand;position:absolute;left:0;top:0;" onclick="OnToggle()"  /> 
<gw:textbox id="txtEmpPK" styles="display:none"/>
<gw:textbox id="txtOrg" styles="display:none"/>	
<gw:textbox id="txtOrgData" styles="display:none"/>
<gw:textbox id="txtUpperOrg" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="menu_id" styles="display:none"/>

<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>

<gw:textbox id="txtOrg_tmp_pk" text="" styles="display:none"  />
<gw:textbox id="txt_popup_yn" styles="display:none"/>
<gw:textbox id="txt_popup_emppk" text="" styles="display:none"  />


<gw:textbox id="txtEmpTemp" styles="display:none"/>
<gw:textbox id="txtorg_tmp" text="" styles ="display:none" />
<gw:textbox id="txtwg_tmp" text="" styles ="display:none" />

 <gw:textbox id="txtComCodeID" styles="display:none"/>	
<gw:textbox id="txtFlag_View" styles="display:none"/>	
     
    
   
</body>
</html>
