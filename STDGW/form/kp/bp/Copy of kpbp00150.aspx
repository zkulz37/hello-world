<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Change Budget Period</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script>
var G1_PK                   =0,
    G1_WORKDATE             =1,
    G1_PERFORMPERDFR        =2,
    G1_PERFORMPERDTO        =3,
    G1_CHANGEREASON         =4,
    G1_PROJECTCODE          =5,
    G1_STATUS               =6;
    
//==========================================================================    
function BodyInit()
{
      OnAddNew();
      System.Translate(document);
      BindingDataList();
      OnChangeTab();
      
}  
//==========================================================================
function BindingDataList()
{
        data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.orderingconttypename  FROM ec111.tecps_orderingconttype a WHERE a.del_if = 0 order by a.pk desc")%>"; 
        lstOutOrdWk.SetDataText(data);
        data = "<%=ESysLib.SetListDataSQL("SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>"; 
        lstCurrency.SetDataText(data); 
} 
//==========================================================================
function OnAddNew()
{
    dat_kpbp00150.StatusInsert();
}
//==========================================================================
function AttachFiles()
    {
            if(txtMasterPK.text != '')
           { 
		
                    imgFile.MasterPK=txtMasterPK.text;
                    imgFile.ChangeImage();
		   
                    if( imgFile.oid == 0 )
                    {
                        return false;
                    }
                    else
                    {
						Grid_Attach.SetGridText( Grid_Attach.rows - 1, 3, txtMasterPK.text);   		
                        DSO_ATTACH_FILE.Call();
                    }
                    imgFile.oid= "";     
            } 
        else
        {
                alert('Please save data first!!');
        }     
}
//==========================================================================
function OnSearch(pos)
{
    switch(pos)
    {
        case 'grdSearch':
            dat_kpbp00150_1.Call("SELECT");
        break;
        case 'Detail':
            txtMasterPK.text=grdSearch.GetGridData(grdSearch.row,0);
            dat_kpbp00150.Call("SELECT");
        break;
    }
    
}
//==========================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'project':
		    var path = System.RootURL + '/form/kp/bp/kpbp00060_1.aspx';
		    var object = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
			    txtProject_Pk.text = object[0];
                txtProject_Cd.text = object[1];
                txtProject_Nm.text = object[2]; 
			    //OnSearch();
		    }
	    break;
	    case 'subcontractor':
            var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
            var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
            if ( object != null )
            {
                if (object[0] != 0)
                {
                    txtsubConTor.SetDataText(object[2]);//customer name
                    txtsubConTorPK.SetDataText(object[0]);//customer name
                }
            }
        break;   
        case 'currency':        
             var path = System.RootURL + "/form/gf/os/gfos00070_popup_1.aspx?code=ACAB0110";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
			 if (object != null )
             {
				 lstCurrency.SetDataText(object[1]);
			 }
        break;  
        case 'OutsideOrderWork':
             var path = System.RootURL + "/form/kp/bm/kpbm00010.aspx";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.orderingconttypename  FROM ec111.tecps_orderingconttype a WHERE a.del_if = 0 order by a.pk desc")%>"; 
             lstOutOrdWk.SetDataText(data);
        break; 
    }
    
}

//=========================================================================  
function OnAddRow()
{
    if(txtProject_Pk.text != '')
        { 
            grdDetail.AddRow();
            grdDetail.SetGridText(grdDetail.rows-1, G1_PROJECTCODE, txtProject_Cd.text) 
            grdDetail.SetGridText(grdDetail.rows-1, G1_STATUS,'N')
            grdDetail.SetGridText(grdDetail.rows-1, G1_PERFORMPERDFR,dtPeriod_Fr.value)
            grdDetail.SetGridText(grdDetail.rows-1, G1_PERFORMPERDTO,dtPeriod_To.value)
        }
        else
        {
            alert('Please select the Project first !!');
        }   
    
}
//========================================================================== 
function OnSave()
{
    
    dat_kpbp00150.Call();
}
//==========================================================================
function DeleteAtt()
{
    if(confirm('Do you want to delete selected file ?'))
			{
			     Grid_Attach.DeleteRow();
			     DSO_ATTACH_FILE.Call();
			}
}
//==========================================================================
function OnDelete()
{
    if ( txtMasterPK.text!="")
    {
        if(confirm("Are you sure to delete !!!"))
        {
            dat_kpbp00150.StatusDelete();
            dat_kpbp00150.Call();
        }
        
    }    
}
//==========================================================================
function OnChangeTab()
{ 
	switch(radTab.value)
	{
		case '1':
			Span3.style.color      = "red";   
			Span4.style.color      = ""; 
		break;		
		case '2' :
			Span3.style.color      = "";   
			Span4.style.color      = "red"; 
		break;        

		 
     }
}
//==========================================================================
function OnUnDelete() 
{
    grdDetail.UnDeleteRow();
}
//==========================================================================
function OnConfirm()
{
    if ( grdDetail.row > 0 )
    {
        var control = grdDetail.GetGridControl();
        for(i=0;i<control.SelectedRows;i++)
        {
            grdDetail.SetGridText( control.SelectedRow(i), G1_STATUS,'Y' ) ;
        }  
        OnSave();
    }    
}
//=========================================================================
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}
var flag="";
//========================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case'dat_kpbp00150':
            DSO_ATTACH_FILE.Call("SELECT");
        break;
    }
}
//========================================================================
function OnOpenFile()
{
        var img_pk = Grid_Attach.GetGridData(Grid_Attach.GetGridControl().row,2)	;
        var url = System.RootURL + "/system/binary/viewfile.aspx?img_pk=" + img_pk + "&table_name=tecps_substrp12000_file";	
        window.open(url);
}
//========================================================================
</script>

<body>
    <!------------------------------------------------------------------------------------------------------------------>
    <gw:data id="dat_kpbp00150" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35" function="ec111.sp_sel_kpbp00150" procedure="ec111.sp_upd_kpbp00150">
                <input>
                     <inout bind="txtMasterPK"  />
                     <inout bind="txtProject_Pk"  />
                     <inout bind="txtProject_Cd"  />
                     <inout bind="txtProject_Nm"  />
                     <inout bind="txtsubName"  />
                     
                     <inout bind="lstOutOrdWk"  />
                     <inout bind="txtsubConTorPK"  />
                     <inout bind="txtsubConTor"  />
                     <inout bind="txtHandover"  />
                     <inout bind="dtSubCont"  />
                     
                     <inout bind="dtSubContFr"  />
                     <inout bind="dtSubContTo"  />                     
                     <inout bind="txtAdvance"  />
                     <inout bind="txtProgress"  />
                     <inout bind="txtBalance"  />  
                                        
                     <inout bind="txtAdPayBond"  />
                     <inout bind="txtPerBond"  />
                     <inout bind="txtProviRate"  />                     
                     <inout bind="txtPerDay"  />
                     <inout bind="txtWarPeriod"  /> 
                                         
                     <inout bind="radTab"  />                   
					 <inout bind="lstCurrency"  />
                     <inout bind="txtBudgetAmt"  />                     
                     <inout bind="txtVat"  />                    
                     <inout bind="txtSupAmt"  />
                     
                     <inout bind="txtSubcontAmt"  />                  
   					 <inout bind="txtBudSubAmt"  />					 
                     <inout bind="txtWorkscope"  />                     
                     <inout bind="chkCont"  />
                     <inout bind="chkSubQuo"  />
                     
                     <inout bind="chkTechRev"  />
                     <inout bind="chkReqSub"  />
                     <inout bind="chkOrther"  />
                     <inout bind="txtOrther"  />
                     <inout bind="txtRemark"  /> 
                     
                     <inout bind="txtScale"  />
                </input>
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="dat_kpbp00150_1" onreceive="OnDataReceive(this)"> 
			<xml> 
				<dso id="1" type="grid"    function="ec111.sp_sel_kpbp00150_1"    > 
					<input bind="grdSearch">                    
						<input bind="dtFrom" /> 
						<input bind="dtTo" /> 
						<input bind="txtPONoSearch" /> 
					</input> 
					<output bind="grdSearch" /> 
				</dso> 
			</xml> 
     </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="DSO_ATTACH_FILE" onreceive="OnDataReceive(this)">
      <xml>
        <dso id="1" type="grid" parameter="2"  function="ec111.sp_sel_kpbp00150_3"  procedure="ec111.sp_upd_kpbp00150_3">
          <input bind="Grid_Attach" >
          <input bind="txtMasterPK" />
          </input>
          <output bind="Grid_Attach" />
        </dso>
      </xml>
    </gw:data>
    <!------------------------------------------------------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td style="width: 10%" align="right">
                            Date
                        </td>
                        <td style="width: 89%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 2%" align="right">
                        <td style="width: 10%; white-space: nowrap">
                            Project</td>
                        <td colspan="2">
                            <gw:textbox id="txtPONoSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|Contract name|Project|Contract Date' format='0|0|0|4'
                                aligns='0|0|0|0' check='|||' editcol='1|1|1|1' widths='1000|1000|1000|1000' sorting='T'
                                autosize='T' styles='width:100%; height:100%' oncellclick="OnSearch('Detail')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%" valign="top">
                <table cellpadding="1" cellspacing="0" style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%" style="background-color: CCFFFF">
                        <td style="width: 100%">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td style="width: 5%">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                    <td align="right" width="6%">
                                        <a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('project')">
                                            Project&nbsp;</a></td>
                                    <td width="20%">
                                        <gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' />
                                    </td>
                                    <td width="30%">
                                        <gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' />
                                    </td>
                                    <td width="">
                                        <gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" />
                                    </td>
                                    <td style="width: 5%">
                                    </td>
                                    <td style="width: 20%">
                                    </td>
                                    <td>
                                        <gw:imgbtn id="ibtnUpdte" img="search" alt="Search" onclick="OnSearch()" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="ibtnpdte" img="new" alt="New" onclick="OnAddNew()" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="ibtnUpdate" img="save" alt="Save" onclick="OnSave()" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="ibtUpdate" img="delete" alt="Delete" onclick="OnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 100%">
                            <table border="0" width="100%" height="100%" cellpadding="1" cellspacing="0">
                                <tr style="background-color: CCFFFF">
                                    <td height="21" width="126" align="right">
                                        Subcontract Name</td>
                                    <td height="21" width="326" colspan="4">
                                        <gw:textbox id="txtsubName" styles='width:100%' />
                                    </td>
                                    <td height="21" width="158" align="right">
                                        <a href="#" style="text-decoration: none" onclick="OnPopUp('OutsideOrderWork')">Outside
                                            Order Work</a>
                                    </td>
                                    <td height="21" width="317" colspan="3">
                                        <gw:list id="lstOutOrdWk" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="background-color: CCFFFF">
                                    <td height="21" width="126" align="right">
                                        <a href="#" style="text-decoration: none" onclick="OnPopUp('subcontractor')">Subcontractor</a></td>
                                    <td height="21" width="326" colspan="4">
                                        <gw:textbox id="txtsubConTorPK" styles='width:100%;display:none' />
                                        <gw:textbox id="txtsubConTor" styles='width:100%' readonly="T" />
                                    </td>
                                    <td height="21" width="158" align="right">
                                        Handover Condition</td>
                                    <td height="21" width="317" colspan="3">
                                        <gw:textbox id="txtHandover" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="background-color: CCFFFF">
                                    <td height="21" width="126" align="right">
                                        Subcontract Date</td>
                                    <td height="21" width="200" colspan="3">
                                        <gw:datebox id="dtSubCont" lang="1" styles='width:100%' />
                                    </td>
                                    <td height="19" width="126">
                                        &nbsp;</td>
                                    <td height="21" width="158" align="right">
                                        Subcontract Period</td>
                                    <td height="21" width="317" colspan="3">
                                        <gw:datebox id="dtSubContFr" lang="1" styles='width:100%' />
                                        ~
                                        <gw:datebox id="dtSubContTo" lang="1" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td height="67" width="126" rowspan="3" align="center">
                                        Payment Condition</td>
                                    <td height="21" width="58" align="right">
                                        Advance</td>
                                    <td height="21" width="121">
                                        <gw:textbox id="txtAdvance" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                    <td height="21" width="13">
                                        %</td>
                                    <td height="90" width="126" rowspan="4" align="center">
                                        Guarantee Condition</td>
                                    <td height="21" width="158" align="right">
                                        Advance Payment Bond</td>
                                    <td height="21" width="123">
                                        <gw:textbox id="txtAdPayBond" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                    <td height="21" width="188" colspan="2">
                                        %</td>
                                </tr>
                                <tr>
                                    <td height="21" width="58" align="right">
                                        Progress</td>
                                    <td height="21" width="121">
                                        <gw:textbox id="txtProgress" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                    <td height="21" width="13">
                                        %</td>
                                    <td height="21" width="158" align="right">
                                        Performance Bond</td>
                                    <td height="21" width="123">
                                        <gw:textbox id="txtPerBond" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                    <td height="21" width="188" colspan="2">
                                        %</td>
                                </tr>
                                <tr>
                                    <td height="21" width="58" align="right">
                                        Balance</td>
                                    <td height="21" width="121">
                                        <gw:textbox id="txtBalance" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                    <td height="21" width="13">
                                        %</td>
                                    <td height="21" width="158" align="right">
                                        Provision Rate</td>
                                    <td height="21" width="123">
                                        <gw:textbox id="txtProviRate" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                    <td height="21" width="188" colspan="2">
                                        %</td>
                                </tr>
                                <tr>
                                    <td height="21" width="126" align="right">
                                        Penalty for Delay</td>
                                    <td height="21" width="58" align="right">
                                        Per day</td>
                                    <td height="21" width="121">
                                        <gw:textbox id="txtPerDay" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                    <td height="21" width="13">
                                        %</td>
                                    <td height="21" width="158" align="right">
                                        Warranty Period</td>
                                    <td height="21" width="123">
                                        <gw:textbox id="txtWarPeriod" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                    <td height="21" width="188" colspan="2">
                                        Month</td>
                                </tr>
                                <tr>
                                    <td height="21" width="464" colspan="5" align="right">
                                        &nbsp;</td>
                                    <td height="21" width="158" align="right">
                                        Payment Guarantee Y/N</td>
                                    <td height="21" width="317" colspan="3">
                                        <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                                            <span value="1" id="Span3">Yes</span> 
								            <span value="2" id="Span4">No</span>
                                        </gw:radio>
                                    </td>
                                </tr>
                                <tr style="background-color: CCFFFF">
                                    <td height="21" width="126" align="right">
                                        <a href="#" style="text-decoration: none" onclick="OnPopUp('currency')">Currency</a>
                                    </td>
                                    <td height="21" width="200" colspan="3">
                                        <gw:list id="lstCurrency" styles='width:100%' />
                                    </td>
                                    <td height="21" width="126">
                                        &nbsp;</td>
                                    <td height="21" width="158" align="right">
                                        Budget Amt</td>
                                    <td height="21" width="123" align="right">
                                        <gw:textbox id="txtBudgetAmt" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                    <td height="21" width="87" align="right">
                                        VAT</td>
                                    <td height="21" width="95">
                                        <gw:textbox id="txtVat" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                </tr>
                                <tr style="background-color: CCFFFF">
                                    <td height="40" width="125" align="right">
                                        Supplied Amt</td>
                                    <td height="40" width="196" colspan="3">
                                        <gw:textbox id="txtSupAmt" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                    <td height="40" width="126">
                                        &nbsp;</td>
                                    <td height="40" width="158" align="right">
                                        Subcontrct Amt</td>
                                    <td height="40" width="123" align="right">
                                        <gw:textbox id="txtSubcontAmt" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                    <td height="40" width="87" align="right">
                                        Budget Amt-SubCont Amt</td>
                                    <td height="40" width="95">
                                        <gw:textbox id="txtBudSubAmt" styles='width:100%' type="number" format="###,###.#" />
                                    </td>
                                </tr>
                                <tr>
                                    <td height="36" width="125" align="right">
                                        Work Scope</td>
                                    <td height="36" width="816" colspan="8">
                                        <gw:textarea id="txtWorkscope" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="background-color: CCFFFF">
                                    <td height="31" width="125" align="right">
                                        Attack Document</td>
                                    <td height="31" width="808" colspan="8">
                                        <table border="0" width="100%" height="100%">
                                            <tr>
                                                <td height="23" width="40">
                                                    <gw:checkbox id="chkCont" value="F">Contract</gw:checkbox>
                                                </td>
                                                <td height="23" width="170">
                                                    <gw:checkbox id="chkSubQuo" value="F">Subcontractor's Quotation</gw:checkbox>
                                                </td>
                                                <td height="23" width="120">
                                                    <gw:checkbox id="chkTechRev" value="F">Technical Review</gw:checkbox>
                                                </td>
                                                <td height="23" width="160">
                                                    <gw:checkbox id="chkReqSub" value="F"> Request for Subcontract </gw:checkbox>
                                                </td>
                                                <td height="23" width="50">
                                                    <gw:checkbox id="chkOrther" value="F">Orther</gw:checkbox>
                                                </td>
                                                <td height="23" width="120">
                                                    <gw:textbox id="txtOrther" styles='width:100%' />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="44" width="125" rowspan="2" align="right">
                                        Attack File</td>
                                    <td height="60" width="715" colspan="7" rowspan="2">
                                        <gw:grid id="Grid_Attach" header="File Name|Size|_pk|_project_pk" format="0|0|0|0"
                                            aligns="0|0|0|0" defaults="|||" editcol="0|0|0|0" widths="6000|1000|0|0" styles="width:100%; height:100%"
                                            sorting="T" oncelldblclick="OnOpenFile()" />
                                    </td>
                                    <td height="21" width="95">
                                        <button id="Button3" onclick="AttachFiles()">
                                            Attack
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="21" width="95">
                                        <button id="Button4" onclick="DeleteAtt()">
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" width="125">
                                        <p align="right">
                                        Execution Scale</td>
                                    <td height="40" width="816" colspan="8">
                                        <gw:textarea id="txtScale" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td height="37" width="125">
                                        <p align="right">
                                        Remark</td>
                                    <td height="37" width="816" colspan="8">
                                        <gw:textarea id="txtRemark" styles='width:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
<gw:image id="imgFile" table_name="tecps_substrp12000_file" view="/binary/ViewFile.aspx"
    post="/binary/PostFile.aspx" styles="width:100;height:100;display:none" />
</html>
